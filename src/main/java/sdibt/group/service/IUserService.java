package sdibt.group.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import sdibt.group.entity.Permission;
import sdibt.group.entity.User;
import sdibt.group.vo.PageVO;

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
     */
    public void saveUser(User user);

	public boolean principalRegister(User user, String kindergartenName);

	public boolean teacherRegister(User user, int classId);

	public boolean isExistUsername(String username);

	public PageVO listTeacher(int kindergartenId, int page, int pageCount);

	public PageVO listPrincipal(int page, int pageSize);

	public boolean updateTeacher(User user);

	public boolean updatePrincipal(User user);

	public List<Map> countSex(int kindergartenId);



}
