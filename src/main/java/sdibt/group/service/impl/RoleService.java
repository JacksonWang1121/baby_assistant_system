package sdibt.group.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sdibt.group.dao.RoleDao;
import sdibt.group.service.IRoleService;

@Service
public class RoleService implements IRoleService {

	@Resource
	private RoleDao roleDao;

	public RoleDao getRoleDao() {
		return roleDao;
	}

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	/**
	 * 查询所有角色
	 */
	@Override
	public List<Map> listRoles() {
		return this.roleDao.listRoles();
	}

	/**
	 * 根据ID查询角色信息
	 */
	@Override
	public Map findRoleById(int id) {
		return this.roleDao.findRoleById(id);
	}

	/**
	 * 添加角色
	 */
	@Override
	@Transactional
	public void saveRole(Map role) {
		this.roleDao.saveRole(role);
	}

	/**
	 * 删除角色
	 */
	@Override
	@Transactional
	public void deleteRole(int id) {
		this.roleDao.deleteRole(id);
	}

	/**
	 * 修改角色
	 */
	@Override
	@Transactional
	public void updateRole(Map role) {
		this.roleDao.updateRole(role);
	}

	/**
	 * 用户绑定角色
	 * @param map
	 */
	@Override
	@Transactional
	public void bindRole(Map map) {
		this.roleDao.bindRole(map);
	}

}
