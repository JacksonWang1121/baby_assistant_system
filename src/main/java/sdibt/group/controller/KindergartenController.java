package sdibt.group.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import sdibt.group.entity.Kindergarten;
import sdibt.group.entity.User;
import sdibt.group.service.IKindergartenService;
import sdibt.group.util.FileUtil;

/**
 * kindergarten业务流程层
 * @title KindergartenController.java
 * @author JacksonWang
 * @date 2018年11月6日 下午10:56:56
 * @package sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/kindergarten")
public class KindergartenController {

	@Resource
	private IKindergartenService  kindergartenService;

	public void setKindergartenService(IKindergartenService kindergartenService) {
		this.kindergartenService = kindergartenService;
	}

	/**
	 * 根据园长id查询幼儿园记录
	 * @param session
	 * @return
	 */
	@RequestMapping("/findKindergarten")
	@ResponseBody
	public Kindergarten findKindergarten(HttpSession session) {
		User user = (User) session.getAttribute("user");
		int principalId = Integer.parseInt(user.getId()+"");
		Kindergarten kindergarten = this.kindergartenService.findKindergarten(principalId);
		return kindergarten;
	}

	/**
	 * 查询所有省份记录
	 * @return
	 */
	@RequestMapping("/listProvince")
	@ResponseBody
	public List<Map> listProvince() {
		return this.kindergartenService.listProvince();
	}

	/**
	 * 根据省份id查询该省的城市记录
	 * @param provinceId
	 * @return
	 */
	@RequestMapping("/listCity")
	@ResponseBody
	public List<Map> listCity(String provinceId) {
		if (provinceId == null) {
			return null;
		}
		return this.kindergartenService.listCity(provinceId);
	}

	/**
	 * 根据城市id查询该市的县区记录
	 * @param cityId
	 * @return
	 */
	@RequestMapping("/listArea")
	@ResponseBody
	public List<Map> listArea(String cityId) {
		if (cityId == null) {
			return null;
		}
		return this.kindergartenService.listArea(cityId);
	}

	/**
	 * 修改幼儿园记录
	 * @param kindergarten
	 */
	@RequestMapping("/updateKindergarten")
	@ResponseBody
	public String updateKindergarten(HttpServletRequest request, Kindergarten kindergarten,
			String province, String city, String area, String street, MultipartFile photo) {
		HttpSession session = request.getSession();
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		kindergarten.setId(kindergartenId);
		if (photo != null) {
			String fileName = FileUtil.uploadFile(request, photo, "images/kindergarten");
			kindergarten.setPicture("images/kindergarten/"+fileName);
		}
		kindergarten.setAddress(province+","+city+","+area+","+street);
		boolean isUpdate = this.kindergartenService.updateKindergarten(kindergarten);
		if (isUpdate) {
			return "true";
		}
		return "false";
	}

}
