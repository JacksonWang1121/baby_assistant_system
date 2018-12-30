package sdibt.group.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sdibt.group.dao.SchoolBusDao;
import sdibt.group.entity.SchoolBus;
import sdibt.group.service.ISchoolBusService;

@Service
public class SchoolBusService implements ISchoolBusService {

	@Resource
	private SchoolBusDao schoolBusDao;

	public void setSchoolBusDao(SchoolBusDao schoolBusDao) {
		this.schoolBusDao = schoolBusDao;
	}

	/**
	 * 根据幼儿园编号查询所有校车的记录
	 * @param schoolId
	 * @return
	 */
	@Override
	public List<SchoolBus> listSchoolBus(int schoolId) {
		return this.schoolBusDao.listSchoolBus(schoolId);
	}

	/**
	 * 添加校车记录
	 * @param schoolBus
	 */
	@Transactional
	@Override
	public boolean saveSchoolBus(SchoolBus schoolBus) {
		int count = this.schoolBusDao.saveSchoolBus(schoolBus);
		if (count == 1) {
			return true;
		}
		return false;
	}

}
