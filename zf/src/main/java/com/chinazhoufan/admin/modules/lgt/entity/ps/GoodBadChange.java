/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import java.math.BigDecimal;
import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 好坏货调动表Entity
 * @author liuxiaodong
 * @version 2017-11-02
 */
public class GoodBadChange extends DataEntity<GoodBadChange> {
	
	private static final long serialVersionUID = 1L;
	private Product product;		// 货品ID
	private BigDecimal assessmentAmount;		// 定损金额
	private String photo;		// 图片
	private Wareplace preWareplace;		// 调前货位编号
	private Wareplace postWareplace;		// 调后货位编号
	private String reasonType;		// 变动原因类型
	private User personLiable;		// 责任人
	private User checkBy;           //审批人           
	private Date checkTime  ;       //审批时间        
	private String checkRemarks    ;  //审批备注        
	private String status;       // 状态   
	
	public static final String STATUS_TO_CHECK    = "1";			// 待审核
	public static final String STATUS_PASS        = "2";			// 审核通过
	public static final String STATUS_REFUSED     = "3";			// 审核拒绝
	
	private Date beginCreateDate;	// 开始时间
	private Date endCreateDate;	// 结束时间

	public GoodBadChange() {
		super();
	}

	public GoodBadChange(String id){
		super(id);
	}


	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public BigDecimal getAssessmentAmount() {
		return assessmentAmount;
	}

	public void setAssessmentAmount(BigDecimal assessmentAmount) {
		this.assessmentAmount = assessmentAmount;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Wareplace getPreWareplace() {
		return preWareplace;
	}

	public void setPreWareplace(Wareplace preWareplace) {
		this.preWareplace = preWareplace;
	}

	public Wareplace getPostWareplace() {
		return postWareplace;
	}

	public void setPostWareplace(Wareplace postWareplace) {
		this.postWareplace = postWareplace;
	}

	public String getReasonType() {
		return reasonType;
	}

	public void setReasonType(String reasonType) {
		this.reasonType = reasonType;
	}

	public User getPersonLiable() {
		return personLiable;
	}

	public void setPersonLiable(User personLiable) {
		this.personLiable = personLiable;
	}


	public User getCheckBy() {
		return checkBy;
	}

	public void setCheckBy(User checkBy) {
		this.checkBy = checkBy;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getCheckRemarks() {
		return checkRemarks;
	}

	public void setCheckRemarks(String checkRemarks) {
		this.checkRemarks = checkRemarks;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
	
}