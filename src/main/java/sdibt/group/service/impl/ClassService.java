package sdibt.group.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import sdibt.group.dao.ClassDao;
import sdibt.group.entity.Grade;
import sdibt.group.service.IClassService;

/**
 * class业务逻辑层
 * @title ClassService.java
 * @author JacksonWang
 * @date 2018年11月4日 下午5:50:45
 * @package sdibt.group.service.impl
 * @version 1.0
 *
 */
@Service
public class ClassService implements IClassService {

	@Resource
	private ClassDao classDao;

	public void setClassDao(ClassDao classDao) {
		this.classDao = classDao;
	}

	/**
	 * 根据幼儿园id查询所有班级记录
	 * @param kindergartenId
	 * @return
	 */
	@Override
	public List<Map> listClass(int kindergartenId) {
		return this.classDao.listClass(kindergartenId);
	}

	/**
	 * 查询年级记录
	 * @return
	 */
	@Override
	public List<Grade> listGrade() {
		return this.classDao.listGrade();
	}

}
