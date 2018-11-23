package sdibt.group.entity;

import java.io.Serializable;
/**
 * 
 * Title:Baby
 * @author hanfangfang
 * date:2018年8月29日 下午4:55:49
 * package:org.sdibt.group.entity
 * version 1.0
 */
public class Baby implements Serializable{
	//宝宝主键id
	private int babyId;
	//班级主键id
	private int classId;
	//年级主键id
	private int gradeId;
	//幼儿园主键id
	private int kindergartenId;
	//用户主键id
	private Long userId;
	//宝宝学号
	private String babyNo;
	//宝宝姓名
	private String babyName;
	//宝宝性别
	private String sex;
	//宝宝生日
	private String birthday;
	//宝宝头像
	private String babyIcon;
	//与宝宝的关系
	private String relationship;
	//入园时间
	private String enterDate;
	//分班状态
	private String applyStatus;
	//付款状态
	private String payStatus;
	//付款状态
	private String babyStatus;

	public int getBabyId() {
		return babyId;
	}
	public void setBabyId(int babyId) {
		this.babyId = babyId;
	}
	public int getClassId() {
		return classId;
	}
	public void setClassId(int classId) {
		this.classId = classId;
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
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getBabyNo() {
		return babyNo;
	}
	public void setBabyNo(String babyNo) {
		this.babyNo = babyNo;
	}
	public String getBabyName() {
		return babyName;
	}
	public void setBabyName(String babyName) {
		this.babyName = babyName;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getBabyIcon() {
		return babyIcon;
	}
	public void setBabyIcon(String babyIcon) {
		this.babyIcon = babyIcon;
	}
	public String getRelationship() {
		return relationship;
	}
	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}
	public String getEnterDate() {
		return enterDate;
	}
	public void setEnterDate(String enterDate) {
		this.enterDate = enterDate;
	}
	public String getApplyStatus() {
		return applyStatus;
	}
	public void setApplyStatus(String applyStatus) {
		this.applyStatus = applyStatus;
	}
	public String getPayStatus() {
		return payStatus;
	}
	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}
	public String getBabyStatus() {
		return babyStatus;
	}
	public void setBabyStatus(String babyStatus) {
		this.babyStatus = babyStatus;
	}
}
