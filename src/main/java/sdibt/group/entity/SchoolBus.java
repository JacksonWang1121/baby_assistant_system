package sdibt.group.entity;

/**
 * 校车实体类
 * @title SchoolBus.java
 * @author JacksonWang
 * @date 2018年11月3日 上午9:59:06
 * @package sdibt.group.entity
 * @version 1.0
 *
 */
public class SchoolBus {

	//主键
	private int id;
	//幼儿园编号
	private int schoolId;
	//校车名称
	private String busName;
	//车牌号码
	private String busPlate;
	//司机
	private String driver;
	//司机联系电话
	private String driverTel;
	//可用状态
	private String busStatus;

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
	public String getBusName() {
		return busName;
	}
	public void setBusName(String busName) {
		this.busName = busName;
	}
	public String getBusPlate() {
		return busPlate;
	}
	public void setBusPlate(String busPlate) {
		this.busPlate = busPlate;
	}
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getDriverTel() {
		return driverTel;
	}
	public void setDriverTel(String driverTel) {
		this.driverTel = driverTel;
	}
	public String getBusStatus() {
		return busStatus;
	}
	public void setBusStatus(String busStatus) {
		this.busStatus = busStatus;
	}

}
