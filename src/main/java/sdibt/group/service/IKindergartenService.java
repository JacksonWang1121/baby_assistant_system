package sdibt.group.service;

import java.util.List;
import java.util.Map;

import sdibt.group.entity.Kindergarten;

/**
 * 幼儿园业务逻辑接口层
 * @title IKindergartenService.java
 * @author JacksonWang
 * @date 2018年9月27日 下午2:39:40
 * @package org.sdibt.group.service
 * @version 1.0
 *
 */
public interface IKindergartenService {

	/**
	 * 根据园长id查询幼儿园记录
	 * @param schoolId
	 * @return
	 */
	public Kindergarten findKindergarten(int principalId);

	/**
	 * 查询所有省份记录
	 * @return
	 */
	public List<Map> listProvince();

	/**
	 * 根据省份id查询该省的城市记录
	 * @param provinceId
	 * @return
	 */
	public List<Map> listCity(String provinceId);

	/**
	 * 根据城市id查询该市的县区记录
	 * @param cityId
	 * @return
	 */
	public List<Map> listArea(String cityId);

	/**
	 * 修改幼儿园记录
	 * @param kindergarten
	 */
	public boolean updateKindergarten(Kindergarten kindergarten);

}
