package sdibt.group.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import sdibt.group.entity.Permission;
import sdibt.group.entity.User;

public interface IUserService {

	/**
	 * 根据用户查询用户记录
	 * @param username
	 * @return
	 */
	public User findByUsername(String username);

	/**
	 * 根据用户名查询该用户的角色记录
	 * @param username
	 * @return
	 */
	public Set<String> findRoles(String username);

	/**
	 * 根据用户名查询该用户的角色记录
	 * @param username
	 * @return
	 */
	public Map findRoleByUsername(String username);

    /**
     * 根据用户名查询用户信息
     * @param username
     * @return
     */
    public Map findUserByName(String username);
    
    /**
     * 查询所有用户
     * @return
     */
    public List<Map> listUsers();

    /**
     * 根据用户名查询该用户的权限
     * @param username
     * @return
     */
    public Set<String> findPermissions(String username);

    /**
     * 根据用户名查询该用户的权限
     * @param username
     * @return
     */
    public Set<Permission> findPermissionsObject(String username);

    /**
     * 添加用户记录
     * @param user
     */
    public void saveUser(User user);

}
