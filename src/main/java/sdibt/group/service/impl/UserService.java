package sdibt.group.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sdibt.group.dao.ClassDao;
import sdibt.group.dao.KindergartenDao;
import sdibt.group.dao.RoleDao;
import sdibt.group.dao.UserDao;
import sdibt.group.entity.Kindergarten;
import sdibt.group.entity.Permission;
import sdibt.group.entity.Role;
import sdibt.group.entity.User;
import sdibt.group.service.IUserService;
import sdibt.group.util.PasswordHelper;
import sdibt.group.vo.PageVO;
@Service("userService")
public class UserService implements IUserService {


	@Resource
	private UserDao userDao;
	@Resource
	private  RoleDao roleDao;
	@Resource
	private KindergartenDao kindergartenDao;
	@Resource
	private ClassDao classDao;
	public ClassDao getClassDao() {
		return classDao;
	}

	public void setClassDao(ClassDao classDao) {
		this.classDao = classDao;
	}

	public KindergartenDao getKindergartenDao() {
		return kindergartenDao;
	}

	public void setKindergartenDao(KindergartenDao kindergartenDao) {
		this.kindergartenDao = kindergartenDao;
	}

	public RoleDao getRoleDao() {
		return roleDao;
	}

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	 
	  /**
     * 根据用户名查找用户
     * @param username
     * @return
     */
	@Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    /**
     * 根据用户名查找其角色
     * @param username
     * @return
     */
	@Override
    public Set<String> findRoles(String username) {
        return userDao.findRoles(username);
    }

	/**
	 * 根据用户名查询该用户的角色记录
	 * @param username
	 * @return
	 */
	@Override
	public Map findRoleByUsername(String username) {
		return this.userDao.findRoleByUsername(username);
	}

    /**
     * 根据用户名查询用户信息
     * @param username
     * @return
     */
	@Override
    public Map findUserByName(String username) {
        return userDao.findUserByName(username);
    }

    /**
     * 根据用户名查找其权限
     * @param username
     * @return
     */
    public Set<String> findPermissions(String username) {
        return userDao.findPermissions(username);
    }

	@Override
	public Set<Permission> findPermissionsObject(String username) {
		return userDao.findPermissionsObject(username);
	}

    /**
     * 查询所有用户
     * @return
     */
	@Override
    public List<Map> listUsers() {
    	return this.userDao.listUsers();
    }

	/**
     * 添加用户记录
     * @param user
     */
	@Override
	public void saveUser(User user) {
		this.userDao.saveUser(user);
	}
	/**
     * 鏌ョ湅鎵嬫満鍙锋槸鍚﹀凡缁忓瓨鍦?
     * @return
     */
	@Override
	public boolean isExistUsername(String username) {
		// TODO Auto-generated method stub
		User user=this.userDao.isExistUsername(username);
		if(user!=null){
			return true;
		}
		return false;
	}
	  /**
     * 鍥暱娉ㄥ唽
     * @return
     */
	@Override
	public boolean principalRegister(User user, String kindergartenName) {
		// TODO Auto-generated method stub
		String username=user.getUsername();
		int i=this.userDao.principalRegister(user);
		int userId=this.userDao.queryUserIdByUsername(username);
		if(i==1){
			Role role=new Role();
			role.setRoleId(3);
			role.setUserId(userId);
			int n=this.roleDao.saveUserRole(role);
			if(n==1){
				Kindergarten  kindergarten=new Kindergarten();
				SimpleDateFormat  simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
				String registeredDate=simpleDateFormat.format(new Date());
				String name=kindergartenName;
				int principalId=userId;
				kindergarten.setName(kindergartenName);
				kindergarten.setPrincipalId(principalId);
				kindergarten.setRegisteredDate(registeredDate);
				
				int k=this.kindergartenDao.saveKindergarten(kindergarten);
				
			}
			
			
			return true;
		}else{
			return false;	
		}
		
	}

	@Override
	public boolean teacherRegister(User user, int classId) {
		// TODO Auto-generated method stub
		int n = 0;
		String username=user.getUsername();
		PasswordHelper passwordHelper=new PasswordHelper();
		passwordHelper.encryptPassword(user);
		int result=this.userDao.teacherRegister(user);
		if(result==1){
			int userId=this.userDao.queryUserIdByUsername(username);
			Role role=new Role();
			role.setRoleId(2);
			role.setUserId(userId);
			n=this.roleDao.saveUserRole(role);
			int k=this.classDao.updateClassInfo(classId, userId);
		}
		if(n==0){
			return false;
		}else{
			return true;
		}
	
	}

	@Override
	public PageVO listTeacher(int kindergartenId,int curPage, int pageSize) {
		// TODO Auto-generated method stub
		PageVO pv = new PageVO();
		int total=this.userDao.countTeacher(kindergartenId);

		int  pages;
		if(total%pageSize==0){
			pages=total/pageSize;
		}else{
			pages=total/pageSize+1;
		}
		 int  beginIndex=(curPage-1)*pageSize;
		List<Map>  teachers=this.userDao.listTeacher(beginIndex,pageSize);
		pv.setData(teachers);
		pv.setPages(pages);
		pv.setPageSize(pageSize);
		pv.setCurPage(curPage);

		return pv;
	}

	@Override
	public PageVO listPrincipal(int curPage, int pageSize){
		// TODO Auto-generated method stub
		PageVO pv = new PageVO();
		int total=this.userDao.countPrincipal();

		int  pages;
		if(total%pageSize==0){
			pages=total/pageSize;
		}else{
			pages=total/pageSize+1;
		}
		 int  beginIndex=(curPage-1)*pageSize;
		 if(curPage==pages){
			 pageSize=total-(curPage-1)*pageSize;
		 }
		List<Map> principals=this.userDao.listPrincipal(beginIndex,pageSize);
		pv.setData(principals);
		pv.setPages(pages);
		pv.setPageSize(pageSize);
		pv.setCurPage(curPage);
		return pv;
	}

	@Override
	public boolean updateTeacher(User user) {
		// TODO Auto-generated method stub
		boolean result=this.userDao.updateTeacher(user);
		return result;
	}
	@Override
	public boolean updatePrincipal(User user) {
		// TODO Auto-generated method stub
		boolean result=this.userDao.updatePrincipal(user);
		return result;
	}

	@Override
	public List<Map> countSex(int kindergartenId) {
		// TODO Auto-generated method stub
		 List<Map>  result=this.userDao.countSex(kindergartenId);
		return result;
	}
}
