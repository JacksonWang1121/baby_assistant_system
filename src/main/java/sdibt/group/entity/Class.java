package sdibt.group.entity;

import java.io.Serializable;
/**
 * 
 * Title:Class
 * @author hanfangfang
 * date:2018年9月18日 上午10:14:26
 * package:org.sdibt.group.entity
 * version 1.0
 */
public class Class implements Serializable{
	//班级主键id
	private int classId;
	//用户主键id
	private int userId;
	//年级主键id
	private int gradeId;
	//幼儿园主键id
	private int kindergartenId;
	//班级名称
	private String className;
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public int getClassId() {
		return classId;
	}
	public void setClassId(int classId) {
		this.classId = classId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getGradeId() {
		return gradeId;
	}
	public void setGradeId(int gradeId) {
		this.gradeId = gradeId;
	}
	public int getKindergartenId() {
		return kindergartenId;
	}
	public void setKindergartenId(int kindergartenId) {
		this.kindergartenId = kindergartenId;
	}

	
}
