/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.common.persistence;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.utils.IdGen;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 数据Entity类
 * @author ThinkGem
 * @version 2014-05-16
 */
public abstract class DataEntity<T> extends BaseEntity<T> {

	private static final long serialVersionUID = 1L;
	
	protected String remarks;	// 备注
	protected User createBy;	// 创建者
	protected Date createDate;	// 创建日期
	protected User updateBy;	// 更新者
	protected Date updateDate;	// 更新日期
	protected String delFlag; 	// 删除标记（0：正常；1：删除；2：审核）
	
	/**查询条件封装**/
	protected SearchParameter searchParameter;//查询参数
	
	public DataEntity() {
		super();
		searchParameter=new SearchParameter();
		this.delFlag = DEL_FLAG_NORMAL;
	}
	
	public DataEntity(String id) {
		super(id);
	}
	
	/**
	 * 插入之前执行方法，需要手动调用
	 */
	@Override
	public void preInsert(){
		// 不限制ID为UUID，调用setIsNewRecord(true)使用自定义ID
		if (!this.isNewRecord){
			setId(IdGen.uuid());
		}
		
		if(this.createBy == null) {
			User user = UserUtils.getUser();
			if (StringUtils.isNotBlank(user.getId())){
				this.updateBy = user;
				this.createBy = user;
			}else{//陈适添加
				user = UserUtils.getAdmin();
				this.updateBy = user;
				this.createBy = user;
			}
		}
		setUpdateDate(new Date());
		setCreateDate(getUpdateDate());
	}
	
	/**
	 * 带操作人参数的插入前置方法
	 * @param user
	 */
	public void preInsert(User user){
		// 不限制ID为UUID，调用setIsNewRecord()使用自定义ID
		if (!this.isNewRecord){
			setId(IdGen.uuid());
		}
		this.updateBy = user;
		this.createBy = user;
		setUpdateDate(new Date());
		setCreateDate(getUpdateDate());
	}
	
	/**
	 * 更新之前执行方法，需要手动调用
	 */
	@Override
	public void preUpdate(){
		
		if(this.updateBy == null) {
			User user = UserUtils.getUser();
			if (StringUtils.isNotBlank(user.getId())){
				this.updateBy = user;
			}else{//张金俊添加
				this.updateBy = UserUtils.getAdmin();
			}
		} 
		setUpdateDate(new Date());
		
	}
	
	/**
	 * 带操作人参数的更新前置方法
	 * @param user
	 */
	public void preUpdate(User user){
		this.updateBy = user;
		setUpdateDate(new Date());
	}
	
	@Length(min=0, max=255)
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	

	@JsonIgnore
	public User getCreateBy() {
		return createBy;
	}

	public void setCreateBy(User createBy) {
		this.createBy = createBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@JsonIgnore
	public User getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(User updateBy) {
		this.updateBy = updateBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@JsonIgnore
	@Length(min=1, max=1)
	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public SearchParameter getSearchParameter() {
		return searchParameter;
	}

	public void setSearchParameter(SearchParameter searchParameter) {
		this.searchParameter = searchParameter;
	}

}
