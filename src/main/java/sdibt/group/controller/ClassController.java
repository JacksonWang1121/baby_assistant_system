package sdibt.group.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sdibt.group.entity.Grade;
import sdibt.group.service.IClassService;

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
	 * 查询年级记录
	 * @return
	 */
	@RequestMapping("/listGrade")
	@ResponseBody
	public List<Grade> listGrade() {
		return this.classService.listGrade();
	}

}
