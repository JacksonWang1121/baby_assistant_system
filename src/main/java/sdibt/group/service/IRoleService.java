package sdibt.group.service;

import java.util.List;
import java.util.Map;

public interface IRoleService {

	/**
	 * 查询所有角色
	 * @return
	 */
	public List<Map> listRoles();
	
	/**
	 * 根据ID查询角色信息
	 * @return
	 */
	public Map findRoleById(int id);
	
	/**
	 * 添加角色
	 * @param role
	 */
	public void saveRole(Map role);
	
	/**
	 * 删除角色
	 * @param role
	 */
	public void deleteRole(int id);
	
	/**
	 * 修改角色
	 * @param role
	 */
	public void updateRole(Map role);

	/**
	 * 用户绑定角色
	 * @param map
	 */
	public void bindRole(Map map);

}
