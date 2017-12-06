/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.hrm.entity.ei;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.validation.constraints.NotNull;

/**
 * 员工信息表Entity
 * @author 陈适
 * @version 2015-12-08
 */
public class Employee extends DataEntity<Employee> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 用户ID
	private String nation;		// 民族
	private String politicalStatus;		// 政治面貌
	private String marriageStatus;		// 婚姻状况
	private String idCard1;		// 身份证号码
	private String sex;		// 性别
	private Date bornDate;		// 出生月日
	private String birthday;		// 生日
	private int age;		// 年龄
	private Area liveArea;		// 现居住地ID
	private String liveAreaDetail;		// 现居住地详情
	private String householdType;		// 户口性质
	private Area householdAddr;		// 户口所在地
	private String graduateCollege;		// 毕业院校
	private String professional;		// 专业
	private String degree;		// 学历
	private Date employedDate;		// 入职时间
	private String employedFileUrl1;		// 入职文件URL1
	private String employedFileUrl2;		// 入职文件URL2
	private String employedFileUrl3;		// 入职文件URL3
	private Date contractStartDate;		// 合同起始时间
	private Date probationDueDate;		// 试用期到期时间
	private Date contractDueDate;		// 合同到期时间(提前20天提醒)
	private int workAge;		// 工龄
	private String officeAddr;		// 办公地
	private Date insuranceDate;		// 保险日期
	private Area insuranceAddr;		// 保险地点
	private Date cpfDate;		// 公积金日期
	private Area cpfAddr;		// 公积金地点
	
	public Employee() {
		super();
	}

	public Employee(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Length(min=1, max=2, message="民族长度必须介于 1 和 2 之间")
	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}
	
	@Length(min=1, max=2, message="政治面貌长度必须介于 1 和 2 之间")
	public String getPoliticalStatus() {
		return politicalStatus;
	}

	public void setPoliticalStatus(String politicalStatus) {
		this.politicalStatus = politicalStatus;
	}
	
	@Length(min=1, max=2, message="婚姻状况长度必须介于 1 和 2 之间")
	public String getMarriageStatus() {
		return marriageStatus;
	}

	public void setMarriageStatus(String marriageStatus) {
		this.marriageStatus = marriageStatus;
	}
	
	@Length(min=1, max=50, message="身份证号码长度必须介于 1 和 50 之间")
	public String getIdCard1() {
		return idCard1;
	}

	public void setIdCard1(String idCard1) {
		this.idCard1 = idCard1;
	}
	
	@Length(min=1, max=2, message="性别长度必须介于 1 和 2 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	public Date getBornDate() {
		return bornDate;
	}

	public void setBornDate(Date bornDate) {
		this.bornDate = bornDate;
	}

	@Length(min=1, max=50, message="生日长度必须介于 1 和 50 之间")
	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	@Length(min=1, max=100, message="现居住地详情长度必须介于 1 和 100 之间")
	public String getLiveAreaDetail() {
		return liveAreaDetail;
	}

	public void setLiveAreaDetail(String liveAreaDetail) {
		this.liveAreaDetail = liveAreaDetail;
	}
	
	@Length(min=1, max=2, message="户口性质长度必须介于 1 和 2 之间")
	public String getHouseholdType() {
		return householdType;
	}

	public void setHouseholdType(String householdType) {
		this.householdType = householdType;
	}
	

	@Length(min=0, max=100, message="毕业院校长度必须介于 0 和 100 之间")
	public String getGraduateCollege() {
		return graduateCollege;
	}

	public void setGraduateCollege(String graduateCollege) {
		this.graduateCollege = graduateCollege;
	}
	
	@Length(min=0, max=50, message="专业长度必须介于 0 和 50 之间")
	public String getProfessional() {
		return professional;
	}

	public void setProfessional(String professional) {
		this.professional = professional;
	}
	
	@Length(min=0, max=2, message="学历长度必须介于 0 和 2 之间")
	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="入职时间不能为空")
	public Date getEmployedDate() {
		return employedDate;
	}

	public void setEmployedDate(Date employedDate) {
		this.employedDate = employedDate;
	}
	
	@Length(min=0, max=255, message="入职文件URL1长度必须介于 0 和 255 之间")
	public String getEmployedFileUrl1() {
		return employedFileUrl1;
	}

	public void setEmployedFileUrl1(String employedFileUrl1) {
		this.employedFileUrl1 = employedFileUrl1;
	}
	
	@Length(min=0, max=255, message="入职文件URL2长度必须介于 0 和 255 之间")
	public String getEmployedFileUrl2() {
		return employedFileUrl2;
	}

	public void setEmployedFileUrl2(String employedFileUrl2) {
		this.employedFileUrl2 = employedFileUrl2;
	}
	
	@Length(min=0, max=255, message="入职文件URL3长度必须介于 0 和 255 之间")
	public String getEmployedFileUrl3() {
		return employedFileUrl3;
	}

	public void setEmployedFileUrl3(String employedFileUrl3) {
		this.employedFileUrl3 = employedFileUrl3;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="合同起始时间不能为空")
	public Date getContractStartDate() {
		return contractStartDate;
	}

	public void setContractStartDate(Date contractStartDate) {
		this.contractStartDate = contractStartDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="试用期到期时间不能为空")
	public Date getProbationDueDate() {
		return probationDueDate;
	}

	public void setProbationDueDate(Date probationDueDate) {
		this.probationDueDate = probationDueDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="合同到期时间(提前20天提醒)不能为空")
	public Date getContractDueDate() {
		return contractDueDate;
	}

	public void setContractDueDate(Date contractDueDate) {
		this.contractDueDate = contractDueDate;
	}
	
	public int getWorkAge() {
		return workAge;
	}

	public void setWorkAge(int workAge) {
		this.workAge = workAge;
	}
	
	@Length(min=0, max=100, message="办公地长度必须介于 0 和 100 之间")
	public String getOfficeAddr() {
		return officeAddr;
	}

	public void setOfficeAddr(String officeAddr) {
		this.officeAddr = officeAddr;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getInsuranceDate() {
		return insuranceDate;
	}

	public void setInsuranceDate(Date insuranceDate) {
		this.insuranceDate = insuranceDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCpfDate() {
		return cpfDate;
	}

	public void setCpfDate(Date cpfDate) {
		this.cpfDate = cpfDate;
	}
	
	public Area getCpfAddr() {
		return cpfAddr;
	}

	public void setCpfAddr(Area cpfAddr) {
		this.cpfAddr = cpfAddr;
	}

	public Area getLiveArea() {
		return liveArea;
	}

	public void setLiveArea(Area liveArea) {
		this.liveArea = liveArea;
	}

	public Area getHouseholdAddr() {
		return householdAddr;
	}

	public void setHouseholdAddr(Area householdAddr) {
		this.householdAddr = householdAddr;
	}

	public Area getInsuranceAddr() {
		return insuranceAddr;
	}

	public void setInsuranceAddr(Area insuranceAddr) {
		this.insuranceAddr = insuranceAddr;
	}
}