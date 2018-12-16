package sdibt.group.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import sdibt.group.entity.Class;
import sdibt.group.entity.Grade;

/**
 * class数据访问接口层
 * @title ClassDao.java
 * @author JacksonWang
 * @date 2018年11月4日 下午5:46:47
 * @package sdibt.group.dao
 * @version 1.0
 *
 */
public interface ClassDao {

	/**
	 * 根据幼儿园id查询所有班级记录
	 * @param kindergartenId
	 * @return
	 */
	public List<Map> listClass(int kindergartenId);

	/**
	 * 查询年级记录
	 * @return
	 */
	public List<Grade> listGrade();

	

	public List<Map> listClassByGradeId(@Param("kindergartenId")int kindergartenId,@Param("gradeId") int gradeId);

	public Map isExistsTeacherByClassId(int classId);

	public List<Map> listClasses(@Param("kindergartenId")int kindergartenId,@Param("beginIndex") int beginIndex, @Param("pageSize")int pageSize);

	public Class isExistClassName(String className);

	public int saveClass(Class class1);

	public int listClassCountByKindergartenId(int kindergartenId);

	public int updateClass(@Param("className")String className, @Param("classId") int classId);

}
