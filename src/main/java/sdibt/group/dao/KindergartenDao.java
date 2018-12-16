package sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import sdibt.group.entity.Kindergarten;

/**
 * 幼儿园数据操作接口层
 * @title WebsiteDao.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:22:07
 * @package sdibt.group.dao
 * @version 1.0
 *
 */
public interface KindergartenDao {
	
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
	public void updateKindergarten(Kindergarten kindergarten);




	public int saveKindergarten(Kindergarten kindergarten);


}
