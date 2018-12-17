package sdibt.group.service;

import java.util.List;
import java.util.Map;

import sdibt.group.entity.Class;
import sdibt.group.entity.Grade;
import sdibt.group.vo.PageVO;

/**
 * class业务逻辑接口层
 * @title IClassService.java
 * @author JacksonWang
 * @date 2018年11月4日 下午5:49:19
 * @package sdibt.group.service
 * @version 1.0
 *
 */
public interface IClassService {

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

	public List<Map> listClassByGradeId(int kindergartenId, int gradeId);

	public Map isExistsTeacherByClassId(int classId);

	public PageVO listClasses(int kindergartenId, int page, int pageCount);

	public boolean isExistClassName(String className);

	public boolean saveClass(Class class1, int kindergartenId);

	public Boolean updateClass(String className, int classId);

}
