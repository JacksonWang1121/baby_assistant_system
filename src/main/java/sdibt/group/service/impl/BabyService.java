package sdibt.group.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sdibt.group.dao.BabyDao;
import sdibt.group.dao.UserDao;
import sdibt.group.entity.Baby;
import sdibt.group.entity.User;
import sdibt.group.service.IBabyService;
import sdibt.group.util.PasswordHelper;
import sdibt.group.vo.PageVO;

@Service
public class BabyService implements IBabyService {

	@Resource
	private BabyDao babyDao;
	@Resource
	private UserDao userDao;

	public void setBabyDao(BabyDao babyDao) {
		this.babyDao = babyDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	/**
	 * 多条件分页查询所有符合条件的学生记录
	 * @param curPage
	 * @param pageSize
	 * @param conditions
	 * @return
	 */
	@Override
	public PageVO listStudent(int curPage, int pageSize, Map conditions) {
		PageVO pv = new PageVO();
		//获取开始条数startPage
		int startPage = (curPage-1)*pageSize;
		//获取所有场次的数量
		int count = this.babyDao.listStudentToCount(conditions);
		//获取总页数
		int total = ((count%pageSize>0)&&(count/pageSize>=0))?(count/pageSize+1):(count/pageSize);
		//将以上信息写入pv中
		pv.setCurPage(curPage);
		pv.setPages(total);
		pv.setPageSize(pageSize);
		pv.setTotal(count);
		
		//查询数据库
		List<Map> stuList = null;
		//若count为空，则忽略分页查询
		if (count > 0) {
			conditions.put("startPage", startPage);
			conditions.put("pageSize", pageSize);
			stuList = this.babyDao.listStudent(conditions);
		}
		//将数据存储到pv中
		pv.setData(stuList);
		return pv;
	}

	/**
	 * 根据学号查询学生记录
	 * @param babyNo
	 * @return
	 */
	@Override
	public Map findStudent(String babyNo) {
		return this.babyDao.findStudent(babyNo);
	}

	/**
	 * 根据班级id查询学生记录
	 * @param classId
	 * @return
	 */
	@Override
	public List<Map> listStudentByClassId(int classId) {
		return this.babyDao.listStudentByClassId(classId);
	}

	/**
	 * 添加学生记录
	 * @param baby
	 */
	@Transactional
	@Override
	public boolean saveStudent(Baby baby, String username) {
		/*
		 * 注册家长信息
		 */
		//创建用户
		User user = new User();
		user.setUsername(username);
		//用户可用
		user.setLocked(false);
		//首次登录状态设置为0
		user.setFirstLoginStatus(0);
		//获取密码
		String password = buildPassword();
		user.setPassword(password);
		//密码加密
		PasswordHelper helper = new PasswordHelper();
		helper.encryptPassword(user);
		//添加家长记录
		this.userDao.saveUser(user);
		//根据账号查询该家长的id
		User parent = this.userDao.findByUsername(username);
		//若家长记录添加成功,则添加宝宝信息
		if (parent != null) {
			//入园时间
			Date date = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String enterDate = format.format(date);
			//默认设置
			baby.setUserId(parent.getId());
			baby.setEnterDate(enterDate);
			//若班级id存在，则分班状态为1，即待分班
			if (baby.getClassId() <= 0) {
				baby.setApplyStatus("1");
			} else {
				baby.setApplyStatus("0");
			}
			baby.setBabyStatus("1");
			int count = this.babyDao.saveBabyInfo(baby);
			if (count == 1) {
				//发送一条带有账号和初始密码的短信
				return true;
			}
		}
		return false;
	}

	/**
	 * 随机生成6位数字字符串
	 * @return
	 */
	private String buildPassword() {
		StringBuilder builder = new StringBuilder();
		//随机函数循环生成随机数
		Random rand = new Random();
		for (int i = 0; i < 6; i++) {
			//随机生成0-9之间的整数值
			int num = rand.nextInt(10);
			//数值拼接成字符串
			builder.append(String.valueOf(num));
		}
		return builder.toString();
	}

	/**
	 * 批量修改学生信息：毕业
	 * @param stuList
	 */
	@Transactional
	@Override
	public boolean updateBatchBaby(List<Integer> babyList) {
		int count = this.babyDao.updateBatchBaby(babyList);
		if (count == babyList.size()) {
			return true;
		}
		return false;
	}

	/**
	 * 修改宝宝信息
	 * @param baby
	 */
	@Transactional
	@Override
	public boolean updateBaby(Baby baby) {
		int count = this.babyDao.updateBaby(baby);
		if (count == 1) {
			return true;
		}
		return false;
	}

}
