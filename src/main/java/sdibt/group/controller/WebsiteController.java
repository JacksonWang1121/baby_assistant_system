package sdibt.group.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import sdibt.group.entity.Website;
import sdibt.group.service.IWebsiteService;
import sdibt.group.util.FileUtil;

/**
 * 微官网控制层
 * @title WebsiteController.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:31:58
 * @package sdibt.group.controller
 * @version 1.0
 *
 */
@Controller
@RequestMapping("/website")
public class WebsiteController {
	
	@Resource
	private IWebsiteService websiteService;
	//文件保存的目录
	private String dir = "images/website/";

	public void setWebsiteService(IWebsiteService websiteService) {
		this.websiteService = websiteService;
	}

	/**
	 * 查询微官网
	 */
	@RequestMapping("/findWebsite")
	@ResponseBody
	public Website findWebsite(HttpSession session) {
		int schoolId = (int) session.getAttribute("kindergartenId");
		System.out.println("WebsiteController::findWebsite-schoolId = "+schoolId);
		Website website = this.websiteService.findWebsite(schoolId);
		return website;
	}

	/**
	 * 录入微官网
	 */
	@RequestMapping("/saveWebsite")
	@ResponseBody
	public String saveWebsite(HttpServletRequest request, Website website, 
			@RequestParam(value = "schoolIntroPhoto", required = false) MultipartFile schoolIntroPhoto,
			@RequestParam(value = "certificatePhoto1", required = false) MultipartFile certificatePhoto1,
			@RequestParam(value = "certificatePhoto2", required = false) MultipartFile certificatePhoto2,
			@RequestParam(value = "certificatePhoto3", required = false) MultipartFile certificatePhoto3,
			@RequestParam(value = "teacherPhoto1", required = false) MultipartFile teacherPhoto1,
			@RequestParam(value = "teacherPhoto2", required = false) MultipartFile teacherPhoto2,
			@RequestParam(value = "teacherPhoto3", required = false) MultipartFile teacherPhoto3,
			@RequestParam(value = "stuWorkPhotos", required = false) MultipartFile[] stuWorkPhotos) {
		HttpSession session = request.getSession();
		int schoolId = (int) session.getAttribute("kindergartenId");
		website.setSchoolId(schoolId);
		System.out.println("File uploading...");
		//若没有文件上传，则报空指针异常
		if (schoolIntroPhoto != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, schoolIntroPhoto, dir);
			website.setSchoolIntroPicture(dir + fileName);
		}
		
		if (certificatePhoto1 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, certificatePhoto1, dir);
			website.setCertificatePicture1(dir + fileName);
		}
		
		if (certificatePhoto2 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, certificatePhoto2, dir);
			website.setCertificatePicture2(dir + fileName);
		}
		
		if (certificatePhoto3 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, certificatePhoto3, dir);
			website.setCertificatePicture3(dir + fileName);
		}
		
		if (teacherPhoto1 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, teacherPhoto1, dir);
			website.setTeacherPicture1(dir + fileName);
		}
		
		if (teacherPhoto2 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, teacherPhoto2, dir);
			website.setTeacherPicture2(dir + fileName);
		}
		
		if (teacherPhoto3 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, teacherPhoto3, dir);
			website.setTeacherPicture3(dir + fileName);
		}
		
		if (stuWorkPhotos != null) {
			String stuWorksStr = "";
			System.out.println("stuWorks = "+stuWorkPhotos.length);
			for (int i = 0; i < stuWorkPhotos.length; i++) {
				//上传文件
				String fileName = FileUtil.uploadFile(request, stuWorkPhotos[i], dir);
				if (i == 0 ) {
					stuWorksStr += dir + fileName;
				} else {
					stuWorksStr += ";"+dir + fileName;
				}
			}
			website.setStuWorks(stuWorksStr);
		}
		System.out.println("File upload over...");
		this.websiteService.saveWebsite(website);;
		return "true";
	}

	/**
	 * 修改微官网
	 */
	@RequestMapping("/updateWebsite")
	@ResponseBody
	public String updateWebsite(HttpServletRequest request, Website website, 
			@RequestParam(value = "schoolIntroPhoto", required = false) MultipartFile schoolIntroPhoto,
			@RequestParam(value = "certificatePhoto1", required = false) MultipartFile certificatePhoto1,
			@RequestParam(value = "certificatePhoto2", required = false) MultipartFile certificatePhoto2,
			@RequestParam(value = "certificatePhoto3", required = false) MultipartFile certificatePhoto3,
			@RequestParam(value = "teacherPhoto1", required = false) MultipartFile teacherPhoto1,
			@RequestParam(value = "teacherPhoto2", required = false) MultipartFile teacherPhoto2,
			@RequestParam(value = "teacherPhoto3", required = false) MultipartFile teacherPhoto3,
			@RequestParam(value = "stuWorkPhotos", required = false) MultipartFile[] stuWorkPhotos) {
		HttpSession session = request.getSession();
		int schoolId = (int) session.getAttribute("kindergartenId");
		website.setSchoolId(schoolId);
		System.out.println("File uploading...");
		//若旧数据中存在文件，则判断是否要删除
//		deleteAnFile(oldWebsite.getSchoolIntroPicture(), schoolIntroPicture.getOriginalFilename(), dir);
		//若没有文件上传，则报空指针异常
		if (schoolIntroPhoto != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, schoolIntroPhoto, dir);
			website.setSchoolIntroPicture(dir + fileName);
		}
		
		//若旧数据中存在文件，则判断是否要删除
//		deleteAnFile(oldWebsite.getCertificatePicture1(), certificatePicture1.getOriginalFilename(), dir);
		if (certificatePhoto1 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, certificatePhoto1, dir);
			website.setCertificatePicture1(dir + fileName);
		}
		
		//若旧数据中存在文件，则判断是否要删除
//		deleteAnFile(oldWebsite.getCertificatePicture2(), certificatePicture3.getOriginalFilename(), dir);
		if (certificatePhoto2 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, certificatePhoto2, dir);
			website.setCertificatePicture2(dir + fileName);
		}
		
		//若旧数据中存在文件，则判断是否要删除
//		deleteAnFile(oldWebsite.getCertificatePicture3(), certificatePicture3.getOriginalFilename(), dir);
		if (certificatePhoto3 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, certificatePhoto3, dir);
			website.setCertificatePicture3(dir + fileName);
		}
		
		//若旧数据中存在文件，则判断是否要删除
//		deleteAnFile(oldWebsite.getTeacherPicture1(), teacherPicture1.getOriginalFilename(), dir);
		if (teacherPhoto1 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, teacherPhoto1, dir);
			website.setTeacherPicture1(dir + fileName);
		}
		
		//若旧数据中存在文件，则判断是否要删除
//		deleteAnFile(oldWebsite.getTeacherPicture2(), teacherPicture2.getOriginalFilename(), dir);
		if (teacherPhoto2 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, teacherPhoto2, dir);
			website.setTeacherPicture2(dir + fileName);
		}
		
		//若旧数据中存在文件，则判断是否要删除
//		deleteAnFile(oldWebsite.getTeacherPicture3(), teacherPicture3.getOriginalFilename(), dir);
		if (teacherPhoto3 != null) {
			//上传文件
			String fileName = FileUtil.uploadFile(request, teacherPhoto3, dir);
			website.setTeacherPicture3(dir + fileName);
		}

		/*
		 * 删除多文件的情况：
		 * 若以前上传过文件，现在没上传，则删除旧数据中的所有文件
		 * 若以前上传过文件，现在也上传了文件，且两次上传的文件（名称、数量等方面）不一样，则删除旧数据中的所有文件
		 */
		/*if (oldWebsite.getStuWorks() != null) {
			for (int i = 0; i < stuWorks.length; i++) {
				if ((stuWorks==null) || (!oldWebsite.getStuWorks().contains(stuWorks[i].getOriginalFilename()))) {
					String[] works = oldWebsite.getStuWorks().split(";");
					for (int j = 0; j < works.length; j++) {
						FileUtil.deleteFile(works[j], dir);
					}
					break;
				}
			}
		}*/
		if (stuWorkPhotos != null) {
			//将上传的所有文件名拼接成一个字符串，中间用";"隔开
			String stuWorksStr = "";
			System.out.println("stuWorks = "+stuWorkPhotos.length);
			for (int i = 0; i < stuWorkPhotos.length; i++) {
				//上传文件
				String fileName = FileUtil.uploadFile(request, stuWorkPhotos[i], dir);
				if (i == 0 ) {
					stuWorksStr += dir + fileName;
				} else {
					stuWorksStr += ";"+dir + fileName;
				}
			}
			website.setStuWorks(stuWorksStr);
		}
		
		System.out.println("File upload over...");
		this.websiteService.updateWebsite(website);
		return "true";
	}
	
	/**
	 * 删除单文件
	 * @param oldFileName-旧数据中的文件
	 * @param fileName-新上传的文件的名称
	 * @param dir-要保存的目录
	 */
	private void deleteAnFile(String oldFileName, String fileName, String dir) {
		/*
		 * 执行删除单文件命令的两种情况：
		 * 若以前上传过文件，现在没上传，则删除旧文件
		 * 若以前上传过文件，现在也上传了文件，且两次上传的文件不一样，则删除旧文件
		 */
		//以前上传了文件
		if (oldFileName != null) {
			System.err.println("Judging of deleting file ("+oldFileName+")");
			//现在上传或未上传文件
			if ((fileName==null) || (!oldFileName.equals(fileName))) {
				FileUtil.deleteFile(oldFileName, dir);
			}
		}
	}

}
