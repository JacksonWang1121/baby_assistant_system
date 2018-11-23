package sdibt.group.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import sdibt.group.dao.WebsiteDao;
import sdibt.group.entity.Website;
import sdibt.group.service.IWebsiteService;
import sdibt.group.util.FileUtil;

/**
 * 微官网业务逻辑层
 * @title WebsiteService.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:20:29
 * @package sdibt.group.service.impl
 * @version 1.0
 *
 */
@Service
public class WebsiteService implements IWebsiteService {
	
	@Resource
	private WebsiteDao websiteDao;
	//文件保存的路径
	String filePath = FileUtil.httpFilePath;

	public WebsiteDao getWebsiteDao() {
		return websiteDao;
	}

	public void setWebsiteDao(WebsiteDao websiteDao) {
		this.websiteDao = websiteDao;
	}

	/**
	 * 查询微官网
	 */
	@Override
	public Website findWebsite(int schoolId) {
		//查询微官网
		Website website = this.websiteDao.findWebsite(schoolId);
		if (website != null) {
			//将各个图片路径补充完整
			if (website.getSchoolIntroPicture() != null) {
				website.setSchoolIntroPicture(filePath+website.getSchoolIntroPicture());
			}
			if (website.getCertificatePicture1() != null) {
				website.setCertificatePicture1(filePath+website.getCertificatePicture1());
			}
			if (website.getCertificatePicture2() != null) {
				website.setCertificatePicture2(filePath+website.getCertificatePicture2());
			}
			if (website.getCertificatePicture3() != null) {
				website.setCertificatePicture3(filePath+website.getCertificatePicture3());
			}
			if (website.getTeacherPicture1() != null) {
				website.setTeacherPicture1(filePath+website.getTeacherPicture1());
			}
			if (website.getTeacherPicture2() != null) {
				website.setTeacherPicture2(filePath+website.getTeacherPicture2());
			}
			if (website.getTeacherPicture3() != null) {
				website.setTeacherPicture3(filePath+website.getTeacherPicture3());
			}
			if (website.getStuWorks() != null) {
				String stuWorks = website.getStuWorks();
				stuWorks = filePath + stuWorks;
				website.setStuWorks(stuWorks.replace(";", ";"+filePath));
			}
		}
		return website;
	}

	/**
	 * 录入微官网
	 */
	@Override
	@Transactional
	public void saveWebsite(Website website) {
//		JSONObject json = (JSONObject) JSON.toJSON(website);
//		System.out.println("WebsiteController-saveWebsite = "+json.toString());
		this.websiteDao.saveWebsite(website);
	}

	/**
	 * 修改微官网
	 */
	@Override
	@Transactional
	public void updateWebsite(Website website) {
		this.websiteDao.updateWebsite(website);
	}

	@Override
	public Map viewWebsite(int schoolId) {
		return null;
	}

}
