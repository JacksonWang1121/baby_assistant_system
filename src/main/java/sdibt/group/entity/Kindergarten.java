package sdibt.group.entity;

/**
 * 幼儿园信息实体类
 * @title Kindergarten.java
 * @author JacksonWang
 * @date 2018年9月27日 上午11:30:26
 * @package org.sdibt.group.entity
 * @version 1.0
 *
 */
public class Kindergarten {

	private int id;
	private String name;
	private String description;
	private String address;
	private String telephone;
	private String picture;
	private String registeredDate;
	private int principalId;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getRegisteredDate() {
		return registeredDate;
	}
	public void setRegisteredDate(String registeredDate) {
		this.registeredDate = registeredDate;
	}
	public int getPrincipalId() {
		return principalId;
	}
	public void setPrincipalId(int principalId) {
		this.principalId = principalId;
	}

}
