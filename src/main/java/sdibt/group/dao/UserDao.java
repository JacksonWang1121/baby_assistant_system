package sdibt.group.dao;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import sdibt.group.entity.Permission;
import sdibt.group.entity.User;
 
public interface UserDao {

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

	public int principalRegister(User user);

	public int teacherRegister(User user);
	public int queryUserIdByUsername(String username);

	public User isExistUsername(String username);

	public List<Map> listTeacher(@Param("beginIndex")int beginIndex,@Param("pageSize")int pageSize);

	public List<Map> listPrincipal(@Param("beginIndex")int beginIndex,@Param("pageSize")int pageSize);

	public int countTeacher(int kindergartenId);

	public boolean updateTeacher(User user);

	public int countPrincipal();

	public boolean updatePrincipal(User user);

	public List<Map> countSex(int kindergartenId);
}
