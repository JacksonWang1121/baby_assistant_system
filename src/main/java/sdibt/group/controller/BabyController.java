package sdibt.group.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;

import sdibt.group.entity.Baby;
import sdibt.group.service.IBabyService;
import sdibt.group.util.JsonUtil;
import sdibt.group.vo.PageVO;

/**
 * baby业务流程层
 * @title BabyController.java
 * @author JacksonWang
 * @date 2018年10月30日 下午4:40:29
 * @package sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/baby")
public class BabyController {
	
	@Resource
	private IBabyService babyService;
	
	public void setBabyService(IBabyService babyService) {
		this.babyService = babyService;
	}

	/**
	 * 多条件分页查询所有符合条件的学生记录
	 * @param curPage
	 * @param pageSize
	 * @param babyName
	 * @param classId
	 * @param enterDate
	 * @param payStatus
	 * @return
	 */
	@RequestMapping("/listStudent")
	public String listStudent(HttpServletRequest request, String curPage, String pageSize,
			String babyName, String cls, String enterDate, String payStatus) {
		System.out.println("cls = "+cls);
		//若curPage小于或等于0，则默认设置为1
		if (curPage == null) {
			curPage = "1";
		}
		//若pageSize小于或等于0，则默认设置为50
		if (pageSize == null) {
			pageSize = "50";
		}
		/*
		 * 空处理
		 */
		if ("".equals(babyName)) {
			babyName = null;
		}
		if ("".equals(enterDate)) {
			enterDate = null;
		}
		if ("".equals(payStatus)) {
			payStatus = null;
		}
		//班级信息
		String gradeName = null;
		String classId = null;
		String className = null;
		//若选择了班级，则分割cls
		if (cls != null) {
			if (!"".equals(cls)) {
				String[] split = cls.split(",");
				gradeName = split[0];
				classId = split[1];
				className = split[2];
			}
		}
		Map conditions = new HashMap();
		conditions.put("babyName", babyName);
		conditions.put("enterDate", enterDate);
		conditions.put("payStatus", payStatus);
		conditions.put("classId", classId);
		PageVO pv = this.babyService.listStudent(Integer.parseInt(curPage), Integer.parseInt(pageSize), conditions);
		request.setAttribute("pv", pv);
		request.setAttribute("gradeName", gradeName);
		request.setAttribute("className", className);
		request.setAttribute("conditions", conditions);
		return "studentManage";
	}

	/**
	 * 根据学号查询学生记录
	 * @param babyNo
	 * @return
	 */
	@RequestMapping("/findStudent")
	@ResponseBody
	public Map findStudent(String babyNo) {
		return this.babyService.findStudent(babyNo);
	}

	/**
	 * 根据班级id查询学生记录
	 * @param classId
	 * @return
	 */
	@RequestMapping("/listStudentByClassId")
	public String listStudentByClassId(HttpServletRequest request, String oldClass) {
		System.out.println("oldClass = "+oldClass);
		if (oldClass != null) {
			String[] split = oldClass.split(",");
			int classId = Integer.parseInt(split[1]);
			List<Map> stuList = this.babyService.listStudentByClassId(classId);
			request.setAttribute("oldClass", oldClass);
			request.setAttribute("oldClassName", split[2]);
			request.setAttribute("stuList", stuList);
		}
		return "enrollmentManage";
	}

	/**
	 * 添加学生记录
	 * @param session
	 * @param baby
	 * @param username 联系电话
	 * @return
	 */
	@RequestMapping("/saveStudent")
	@ResponseBody
	public String saveStudent(HttpSession session, Baby baby, String username) {
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		//宝宝记录绑定幼儿园id
		baby.setKindergartenId(kindergartenId);
		boolean isSave = this.babyService.saveStudent(baby,username);
		if (isSave) {
			return "true";
		}
		return "false";
	}

	/**
	 * 学生管理：已缴费
	 * @param babyId
	 * @return
	 */
	@RequestMapping("/hasPaid")
	public String hasPaid(int babyId) {
		Baby baby = new Baby();
		baby.setBabyId(babyId);
		//classId此处可以设置为任意负数
		//用于执行dml语句时，不会将Baby实体类中int类型默认的属性值（默认为0）更新到数据库中
		baby.setClassId(-1);
		baby.setPayStatus("1");
		this.babyService.updateBaby(baby);
		return "forward:/baby/listStudent";
	}

	/**
	 * 升学报名
	 * @param stuId
	 * @param newClass
	 * @return
	 */
	@RequestMapping("/enrollmentApplication")
	@ResponseBody
	public String enrollmentApplication(HttpServletRequest request) {
		try {
			//获取页面传来的json字符串数据
			String json = JsonUtil.getRequestJsonString(request);
			System.out.println(json);
			//将json格式字符串转为list集合
			List<Baby> babyList = (List<Baby>) JSONArray.parseArray(json, Baby.class);
			//遍历list集合
			for (Baby baby : babyList) {
				//执行修改命令
				this.babyService.updateBaby(baby);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "true";
	}

	/**
	 * 毕业离校
	 * @param stuId
	 * @param newClass
	 * @return
	 */
	@RequestMapping("/graduation")
	@ResponseBody
	public String graduation(HttpServletRequest request) {
		try {
			//获取页面传来的json字符串数据
			String json = JsonUtil.getRequestJsonString(request);
			System.out.println(json);
			//将json格式字符串转为list集合
			List<Integer> babyList = (List<Integer>) JSONArray.parseArray(json, Integer.class);
			boolean isGraduate = this.babyService.updateBatchBaby(babyList);
			if (isGraduate) {
				return "true";
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "false";
	}

	/**
	 * 退学
	 * @param stuId
	 * @param newClass
	 * @return
	 */
	@RequestMapping("/quitSchool")
	public String quitSchool(String babyId) {
		Baby baby = new Baby();
		baby.setBabyId(Integer.parseInt(babyId));
		baby.setBabyNo("");
		baby.setEnterDate("");
		baby.setKindergartenId(0);
		baby.setGradeId(0);
		baby.setClassId(0);
		baby.setBabyStatus("0");
		this.babyService.updateBaby(baby);
		return "forward:/baby/listStudent";
	}

}
