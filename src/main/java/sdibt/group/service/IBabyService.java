package sdibt.group.service;

import java.util.List;
import java.util.Map;

import sdibt.group.entity.Baby;
import sdibt.group.vo.PageVO;

/**
 * baby业务逻辑接口层
 * @title IBabyService.java
 * @author JacksonWang
 * @date 2018年10月30日 下午4:16:30
 * @package sdibt.group.service
 * @version 1.0
 *
 */
public interface IBabyService {

	/**
	 * 多条件分页查询所有符合条件的学生记录
	 * @param curPage
	 * @param pageSize
	 * @param conditions
	 * @return
	 */
	public PageVO listStudent(int curPage, int pageSize, Map conditions);

	/**
	 * 根据学号查询学生记录
	 * @param babyNo
	 * @return
	 */
	public Map findStudent(String babyNo);

	/**
	 * 根据班级id查询学生记录
	 * @param classId
	 * @return
	 */
	public List<Map> listStudentByClassId(int classId);

	/**
	 * 添加学生记录
	 * @param baby
	 * @param username 联系电话
	 */
	public boolean saveStudent(Baby baby, String username);

	/**
	 * 批量修改学生信息：毕业
	 * @param stuList
	 */
	public boolean updateBatchBaby(List<Integer> babyList);

	/**
	 * 修改宝宝信息
	 * @param baby
	 */
	public boolean updateBaby(Baby baby);

}
