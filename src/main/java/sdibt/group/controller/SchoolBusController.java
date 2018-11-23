package sdibt.group.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sdibt.group.entity.SchoolBus;
import sdibt.group.service.ISchoolBusService;

/**
 * 校车业务逻辑层
 * @title WebsiteController.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:31:58
 * @package sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/schoolBus")
public class SchoolBusController {
	
	@Resource
	private ISchoolBusService schoolBusService;

	public void setSchoolBusService(ISchoolBusService schoolBusService) {
		this.schoolBusService = schoolBusService;
	}

	/**
	 * 查询校车记录
	 * @param session
	 * @return
	 */
	@RequestMapping("/listSchoolBusToPage")
	public String listSchoolBusToPage(HttpServletRequest request) {
		//获取session
		HttpSession session = request.getSession();
		//获取幼儿园编号
		int schoolId = (int) session.getAttribute("kindergartenId");
		//查询校车记录
		List<SchoolBus> buses = this.schoolBusService.listSchoolBus(schoolId);
		//将校车记录存放到request作用域中
		request.setAttribute("schoolBusList", buses);
		return "schoolBusManage";
	}

	/**
	 * 查询校车记录
	 * @param session
	 * @return
	 */
	@RequestMapping("/listSchoolBus")
	@ResponseBody
	public List<SchoolBus> listSchoolBus(HttpSession session) {
		//获取幼儿园编号
		int schoolId = (int) session.getAttribute("kindergartenId");
		//查询校车记录
		List<SchoolBus> buses = this.schoolBusService.listSchoolBus(schoolId);
		return buses;
	}

	/**
	 * 添加校车记录
	 */
	@RequestMapping("/saveSchoolBus")
	@ResponseBody
	public String saveSchoolBus(HttpSession session, SchoolBus schoolBus) {
		//获取幼儿园编号
		int schoolId = (int) session.getAttribute("kindergartenId");
		schoolBus.setSchoolId(schoolId);
		this.schoolBusService.saveSchoolBus(schoolBus);
		return "true";
	}

}
