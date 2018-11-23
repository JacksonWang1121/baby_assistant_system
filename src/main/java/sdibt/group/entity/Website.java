package sdibt.group.entity;

import java.io.Serializable;

/**
 * 微官网实体类
 * @title Website.java
 * @author JacksonWang
 * @date 2018年9月19日 上午11:21:40
 * @package sdibt.group.entity
 * @version 1.0
 *
 */
public class Website implements Serializable {
	
	//主键
	private int id;
	//学校编号
	private int schoolId;
	//校园简介
	private String schoolIntro;
	//校园简介图片
	private String schoolIntroPicture;
	//证书名称
	private String certificateName1;
	//证书扫描件
	private String certificatePicture1;
	private String certificateName2;
	private String certificatePicture2;
	private String certificateName3;
	private String certificatePicture3;
	//教师简介
	private String teacherIntro1;
	//教师照片
	private String teacherPicture1;
	private String teacherIntro2;
	private String teacherPicture2;
	private String teacherIntro3;
	private String teacherPicture3;
	//学生作品
	private String stuWorks;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
	}
	public String getSchoolIntro() {
		return schoolIntro;
	}
	public void setSchoolIntro(String schoolIntro) {
		this.schoolIntro = schoolIntro;
	}
	public String getSchoolIntroPicture() {
		return schoolIntroPicture;
	}
	public void setSchoolIntroPicture(String schoolIntroPicture) {
		this.schoolIntroPicture = schoolIntroPicture;
	}
	public String getCertificateName1() {
		return certificateName1;
	}
	public void setCertificateName1(String certificateName1) {
		this.certificateName1 = certificateName1;
	}
	public String getCertificatePicture1() {
		return certificatePicture1;
	}
	public void setCertificatePicture1(String certificatePicture1) {
		this.certificatePicture1 = certificatePicture1;
	}
	public String getCertificateName2() {
		return certificateName2;
	}
	public void setCertificateName2(String certificateName2) {
		this.certificateName2 = certificateName2;
	}
	public String getCertificatePicture2() {
		return certificatePicture2;
	}
	public void setCertificatePicture2(String certificatePicture2) {
		this.certificatePicture2 = certificatePicture2;
	}
	public String getCertificateName3() {
		return certificateName3;
	}
	public void setCertificateName3(String certificateName3) {
		this.certificateName3 = certificateName3;
	}
	public String getCertificatePicture3() {
		return certificatePicture3;
	}
	public void setCertificatePicture3(String certificatePicture3) {
		this.certificatePicture3 = certificatePicture3;
	}
	public String getTeacherIntro1() {
		return teacherIntro1;
	}
	public void setTeacherIntro1(String teacherIntro1) {
		this.teacherIntro1 = teacherIntro1;
	}
	public String getTeacherPicture1() {
		return teacherPicture1;
	}
	public void setTeacherPicture1(String teacherPicture1) {
		this.teacherPicture1 = teacherPicture1;
	}
	public String getTeacherIntro2() {
		return teacherIntro2;
	}
	public void setTeacherIntro2(String teacherIntro2) {
		this.teacherIntro2 = teacherIntro2;
	}
	public String getTeacherPicture2() {
		return teacherPicture2;
	}
	public void setTeacherPicture2(String teacherPicture2) {
		this.teacherPicture2 = teacherPicture2;
	}
	public String getTeacherIntro3() {
		return teacherIntro3;
	}
	public void setTeacherIntro3(String teacherIntro3) {
		this.teacherIntro3 = teacherIntro3;
	}
	public String getTeacherPicture3() {
		return teacherPicture3;
	}
	public void setTeacherPicture3(String teacherPicture3) {
		this.teacherPicture3 = teacherPicture3;
	}
	public String getStuWorks() {
		return stuWorks;
	}
	public void setStuWorks(String stuWorks) {
		this.stuWorks = stuWorks;
	}

}
