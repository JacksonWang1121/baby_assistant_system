package sdibt.group.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sdibt.group.dao.KindergartenDao;
import sdibt.group.entity.Kindergarten;
import sdibt.group.service.IKindergartenService;
import sdibt.group.util.FileUtil;

/**
 * 幼儿园业务逻辑层
 * @title KindergartenService.java
 * @author JacksonWang
 * @date 2018年9月27日 下午2:38:15
 * @package org.sdibt.group.service.impl
 * @version 1.0
 *
 */
@Service
public class KindergartenService implements IKindergartenService {

	@Resource
	private KindergartenDao kindergartenDao;
	//文件http访问路径
	private String filePath = FileUtil.httpFilePath;

	public void setKindergartenDao(KindergartenDao kindergartenDao) {
		this.kindergartenDao = kindergartenDao;
	}

	/**
	 * 根据园长id查询幼儿园记录
	 * @param schoolId
	 * @return
	 */
	@Override
	public Kindergarten findKindergarten(int principalId) {
		Kindergarten kindergarten = this.kindergartenDao.findKindergarten(principalId);
		if (kindergarten != null) {
			if (kindergarten.getPicture() != null) {
				kindergarten.setPicture(filePath+kindergarten.getPicture());
			}
		}
		return kindergarten;
	}

	/**
	 * 查询所有省份记录
	 * @return
	 */
	@Override
	public List<Map> listProvince() {
		return this.kindergartenDao.listProvince();
	}

	/**
	 * 根据省份id查询该省的城市记录
	 * @param provinceId
	 * @return
	 */
	@Override
	public List<Map> listCity(String provinceId) {
		return this.kindergartenDao.listCity(provinceId);
	}

	/**
	 * 根据城市id查询该市的县区记录
	 * @param cityId
	 * @return
	 */
	@Override
	public List<Map> listArea(String cityId) {
		return this.kindergartenDao.listArea(cityId);
	}

	/**
	 * 修改幼儿园记录
	 * @param kindergarten
	 */
	@Transactional
	@Override
	public boolean updateKindergarten(Kindergarten kindergarten) {
		int count = this.kindergartenDao.updateKindergarten(kindergarten);
		if (count == 1) {
			return true;
		}
		return false;
	}

}
