package sdibt.group.service;

import java.util.List;

import sdibt.group.entity.SchoolBus;

/**
 * 校车业务逻辑接口层
 * @title ISchoolBusService.java
 * @author JacksonWang
 * @date 2018年11月3日 上午10:44:47
 * @package sdibt.group.service
 * @version 1.0
 *
 */
public interface ISchoolBusService {

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
	public boolean saveSchoolBus(SchoolBus schoolBus);

}
