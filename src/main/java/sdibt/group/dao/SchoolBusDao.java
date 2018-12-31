package sdibt.group.dao;

import java.util.List;

import sdibt.group.entity.SchoolBus;

/**
 * 校车数据访问接口层
 * @title SchoolBusDao.java
 * @author JacksonWang
 * @date 2018年11月3日 上午10:41:42
 * @package sdibt.group.dao
 * @version 1.0
 *
 */
public interface SchoolBusDao {

	/**
	 * 根据幼儿园编号查询所有校车的记录
	 * @param schoolId
	 * @return
	 */
	public List<SchoolBus> listSchoolBus(int schoolId);

	/**
	 * 添加校车记录
	 * @param schoolBus
	 */
	public int saveSchoolBus(SchoolBus schoolBus);

}
