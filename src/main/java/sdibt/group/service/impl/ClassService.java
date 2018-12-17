package sdibt.group.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import sdibt.group.dao.ClassDao;
import sdibt.group.entity.Grade;
import sdibt.group.entity.Class;
import sdibt.group.service.IClassService;
import sdibt.group.vo.PageVO;

/**
 * class业务逻辑层
 * @title ClassService.java
 * @author JacksonWang
 * @date 2018年11月4日 下午5:50:45
 * @package sdibt.group.service.impl
 * @version 1.0
 *
 */
@Service
public class ClassService implements IClassService {

	@Resource
	private ClassDao classDao;

	public void setClassDao(ClassDao classDao) {
		this.classDao = classDao;
	}

	/**
	 * 根据幼儿园id查询所有班级记录
	 * @param kindergartenId
	 * @return
	 */
	@Override
	public List<Map> listClass(int kindergartenId) {
		return this.classDao.listClass(kindergartenId);
	}

	/**
	 * 查询年级记录
	 * @return
	 */
	@Override
	public List<Grade> listGrade() {
		return this.classDao.listGrade();
	}

	@Override
	public List<Map> listClassByGradeId(int kindergartenId, int gradeId) {
		// TODO Auto-generated method stub

		List<Map>  classes=this.classDao.listClassByGradeId(kindergartenId,gradeId);

		return classes;
	}

	@Override
	public Map isExistsTeacherByClassId(int classId) {
		// TODO Auto-generated method stub(
		Map class1=this.classDao.isExistsTeacherByClassId(classId);	
		return class1;
	}

	@Override
	public PageVO listClasses(int kindergartenId, int curPage, int pageSize) {
		// TODO Auto-generated method stub
		PageVO pv = new PageVO();
	    //用户总数
        int total = this.classDao.listClassCountByKindergartenId(kindergartenId);
        //一共多少页
        int pages = total % pageSize == 0 ? total / pageSize : total / pageSize + 1;
        //本页起始用户序号
        int beginIndex = (curPage - 1) * pageSize;
        //本页末尾用户序号的下一个
        List<Map> class1=this.classDao.listClasses(kindergartenId,beginIndex,pageSize);	

        /*map.put("totalUsers", totalCount);
        map.put("usersPerPage", pageCount);
        map.put("totalPages", totalPages);
        map.put("beginIndex", beginIndex);
        map.put("endIndex", totalCount);
        map.put("page", page);	*/	
        pv.setCurPage(curPage);
        pv.setPageSize(pageSize);
        pv.setTotal(total);
        pv.setPages(pages);
        pv.setData(class1);
		return pv;
		
	}

	@Override
	public boolean isExistClassName(String className) {
		// TODO Auto-generated method stub
		boolean result=false;
		Class class1=this.classDao.isExistClassName(className);
		if(class1!=null){
			result=true;
		}
		return result;
	}

	@Override
	public boolean saveClass(Class class1,int kindergartenId) {
		// TODO Auto-generated method stub
	
		
		  class1.setKindergartenId(kindergartenId);
		int i=this.classDao.saveClass(class1);
		if(i==1){
			return true;
		}else{
			return false;
		}
		
	} 
	
	@Override
	public Boolean updateClass(String className,int classId) {
		boolean result;
		// TODO Auto-generated method stub
		int i=this.classDao.updateClass(className,classId);
		if(i==1){
			result=true;
		}else{
			
			result=false;
		}
		return result;
	} 


}
