package sdibt.group.dao;

import java.util.List;
import java.util.Map;

import sdibt.group.entity.Grade;

/**
 * class数据访问接口层
 * @title ClassDao.java
 * @author JacksonWang
 * @date 2018年11月4日 下午5:46:47
 * @package sdibt.group.dao
 * @version 1.0
 *
 */
public interface ClassDao {

	/**
	 * 根据幼儿园id查询所有班级记录
	 * @param kindergartenId
	 * @return
	 */
	public List<Map> listClass(int kindergartenId);

	/**
	 * 查询年级记录
	 * @return
	 */
	public List<Grade> listGrade();

}
