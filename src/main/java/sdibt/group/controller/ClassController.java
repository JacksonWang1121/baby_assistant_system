package sdibt.group.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sdibt.group.entity.Grade;
import sdibt.group.entity.Class;
import sdibt.group.service.IClassService;
import sdibt.group.vo.PageVO;

/**
 * class业务流程层
 * @title ClassController.java
 * @author JacksonWang
 * @date 2018年11月4日 下午5:53:10
 * @package sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/class")
public class ClassController {

	@Resource
	private IClassService classService;

	public void setClassService(IClassService classService) {
		this.classService = classService;
	}

	/**
	 * 根据幼儿园id查询所有班级记录
	 * @param session
	 * @return
	 */
	@RequestMapping("/listClass")
	@ResponseBody
	public List<Map> listClass(HttpSession session) {
		//从session作用域中获取幼儿园id
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		return this.classService.listClass(kindergartenId);
	}
	/**
	 * 根据幼儿园id查询所有班级记录
	 * @param session
	 * @return
	 */
	@RequestMapping("/listClassByGradeId")
	@ResponseBody
	public List<Map> listClassByGradeId(HttpSession session,int gradeId) {
		//从session作用域中获取幼儿园id
		System.out.println(gradeId);
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		System.out.println(kindergartenId);
		return this.classService.listClassByGradeId(kindergartenId,gradeId);
	}
	/**
	 * 查询年级记录
	 * @return
	 */
	@RequestMapping("/listGrade")
	@ResponseBody
	public List<Grade> listGrade() {
		
		return this.classService.listGrade();
	}
	
	@RequestMapping("/listClasses")
	public String  listClasses(HttpSession session,Map map,HttpServletRequest req,String curPage, String pageSize) {
		//从session作用域中获取幼儿园id
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		
        int page,pageCount;
      //若curPage小于或等于0，则默认设置为1
      		if (curPage == null) {
      			page = 1;
      		}else{
      			page = Integer.valueOf(curPage);
      		}
      		//若pageSize小于或等于0，则默认设置为50
      		if (pageSize == null) {
      			pageCount =3;
      		}else{
      			pageCount = Integer.valueOf(pageSize);
      		}
      		System.out.println(curPage);
      		PageVO pv   = this.classService.listClasses(kindergartenId,page,pageCount);
    
      		map.put("pv", pv);
		return  "classMange";
	}
	
	@RequestMapping("/isExistsTeacherByClassId")
	@ResponseBody	
	public String isExistsTeacherByClassId(int classId){
		Map class1 = null;

	 class1=this.classService.isExistsTeacherByClassId(classId);

	if(class1==null){
		return  "null";
	}else{
		   String  username=(String) class1.get("real_name");
		   return  username;
	}

	  
	}
	@RequestMapping("/isExistClassName")
	@ResponseBody
	public boolean isExistClassName(String className){		
		boolean result=this.classService.isExistClassName(className);	
		return result;
	}
	@RequestMapping("/saveClass")
	@ResponseBody
	public boolean saveClass(Class class1,HttpSession session){		
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		boolean result=this.classService.saveClass(class1,kindergartenId);	
		return result;
	}
	
	@RequestMapping("/listClass11")
	@ResponseBody
	public PageVO  listClassess11(HttpSession session,Map map,HttpServletRequest req,String curPage, String pageSize) {
		//从session作用域中获取幼儿园id
		int kindergartenId = (int) session.getAttribute("kindergartenId");
        int page,pageCount;
      //若curPage小于或等于0，则默认设置为1
      		if (curPage == null) {
      			page = 1;
      		}else{
      			page = Integer.valueOf(curPage);
      		}
      		//若pageSize小于或等于0，则默认设置为50
      			pageCount =3;      	
      		System.out.println(curPage);
      		PageVO pv   = this.classService.listClasses(kindergartenId,page,pageCount);
    
      	
		return  pv;
	}
	

	@RequestMapping("/updateClass")
	@ResponseBody
	public Boolean updateClass(String className,String realName,int classId){
		System.out.println(className);
		System.out.println(classId);
		Boolean result=false;
		try {
			result=this.classService.updateClass(className,classId);
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println(result);
		return result;
	}
	

}
