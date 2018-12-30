package sdibt.group.dao;

import java.util.List;
import java.util.Map;

import sdibt.group.entity.Baby;

/**
 * baby数据访问层
 * @title BabyDao.java
 * @author JacksonWang
 * @date 2018年10月30日 下午4:14:58
 * @package sdibt.group.dao
 * @version 1.0
 *
 */
public interface BabyDao {

	/**
	 * 统计所有符合条件的学生记录的数量
	 * @param conditions
	 * @return
	 */
	public int listStudentToCount(Map conditions);

	/**
	 * 多条件分页查询所有符合条件的学生记录
	 * @param curPage
	 * @param pageSize
	 * @param conditions
	 * @return
	 */
	public List<Map> listStudent(Map conditions);

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
	 */
	public int saveBabyInfo(Baby baby);

	/**
	 * 批量修改学生信息：毕业
	 * @param stuList
	 */
	public int updateBatchBaby(List<Integer> babyList);

	/**
	 * 修改宝宝信息
	 * @param baby
	 */
	public int updateBaby(Baby baby);

}
