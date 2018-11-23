package sdibt.group.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sdibt.group.dao.UserDao;
import sdibt.group.entity.Permission;
import sdibt.group.entity.User;
import sdibt.group.service.IUserService;
@Service("userService")
public class UserService implements IUserService {

	@Resource
	private UserDao userDao;

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

}
