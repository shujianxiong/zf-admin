/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.sys.entity.User;

/**
 * 货品货位变动记录Entity
 * @author 陈适
 * @version 2015-12-04
 */
public class ProductWpChange extends DataEntity<ProductWpChange> {
	
	private static final long serialVersionUID = 1L;
	private Product product;		// 货品ID
	private Wareplace preWareplace;	// 调出货位编号
	private User preHoldUser;		// 调出持有人编号
	private Wareplace postWareplace;// 调入货位编号
	private User postHoldUser;		// 调入持有人编号
	private String reasonType;		// 变动原因类型
	
	/******************************* 自定义查询对象  ********************************/
	private Date beginTime;			// 开始创建时间
	private Date endTime;			// 结束创建时间
	private String scanCode;        //货位唯一码
	/********************************* 自定义常量  *********************************/
	// 变动原因类型 [lgt_ps_product_wp_change_reasonType]
	public static final String REASONTYPE_U_INVENTORY			= "U1";	// 盘点修正
	public static final String REASONTYPE_U_WAREPLACE_CHANGE	= "U2";	// 货位调整
	public static final String REASONTYPE_U_HOLDUSER_ADD		= "U3";	// 追加持有
	public static final String REASONTYPE_U_BAD_GOOD		= "U4";	// 好坏货调整
	public static final String REASONTYPE_S_OUT					= "S1";	// 货品出库
	public static final String REASONTYPE_S_HANDLE_PACKAGE		= "S1";	// 配货接手
	public static final String REASONTYPE_S_HANDLE_DELIVER		= "S1";	// 发货接手
	public static final String REASONTYPE_S_HANDLE_RECEIVE		= "S1";	// 回货接手
	public static final String REASONTYPE_S_HANDLE_DISASSEMBLE	= "S1";	// 拆包接手
	public static final String REASONTYPE_S_HANDLE_IN			= "S1";	// 入库接手
	public static final String REASONTYPE_S_IN					= "S1";	// 货品入库
	public static final String REASONTYPE_S_HANDLE_REPAIR		= "S1";	// 维修接手
	
	// 货品货位调整调后位置类型 [lgt_ps_product_wp_change_postType]
	public static final String POSTTYPE_WAREPLACE	= "wareplace";	// 调整到货位
	public static final String POSTTYPE_HOLDUSER	= "holduser";	// 调整到持有人
	
	// 货品货位变动失败可能的异常类型 <ProductWpChangeService.updateProductPosition()方法抛出>
	public static final String FAIL_PRODUCT_UNEXIST			= "productUnexist";			// 货品货位调整异常，要变动的货品不存在
	public static final String FAIL_PREWAREPLACE_USELESS	= "preWareplaceUseless";	// 货品货位调整异常，货品调出货位未启用，不能调出
	public static final String FAIL_PREWAREPLACE_LOCKED		= "preWareplaceLocked";		// 货品货位调整异常，货品调出货位已锁定，不能调出
	public static final String FAIL_POSTWAREPLACE_USELESS	= "postWareplaceUseless";	// 货品货位调整异常，货品调入货位未启用，不能调入
	public static final String FAIL_POSTWAREPLACE_LOCKED	= "postWareplaceLocked";	// 货品货位调整异常，货品调入货位已锁定，不能调入
	public static final String FAIL_POSTWAREPLACE_OCCUPIED	= "postWareplaceOccupied";	// 货品货位调整异常，货品调入货位已存放其他产品类型的货品
	
	
	public ProductWpChange() {
		super();
	}

	public ProductWpChange(String id){
		super(id);
	}

	/**
	 * 货品货位调整构造方法
	 * @param product 		调整货品
	 * @param preWareplace	调前货位
	 * @param preHoldUser	调前持有人
	 * @param postWareplace	调后货位
	 * @param postHoldUser	调后持有人
	 * @param changeUser	调整员工
	 * @param changeTime	调整时间
	 */
	public ProductWpChange(Product product, Wareplace preWareplace, User preHoldUser,
			Wareplace postWareplace, User postHoldUser, User changeUser, Date changeTime) {
		this.product = product;
		this.preWareplace = preWareplace;
		this.preHoldUser = preHoldUser;
		this.postWareplace = postWareplace;
		this.postHoldUser = postHoldUser;
	}

	
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Wareplace getPreWareplace() {
		return preWareplace;
	}

	public void setPreWareplace(Wareplace preWareplace) {
		this.preWareplace = preWareplace;
	}

	public User getPreHoldUser() {
		return preHoldUser;
	}

	public void setPreHoldUser(User preHoldUser) {
		this.preHoldUser = preHoldUser;
	}

	public Wareplace getPostWareplace() {
		return postWareplace;
	}

	public void setPostWareplace(Wareplace postWareplace) {
		this.postWareplace = postWareplace;
	}

	public User getPostHoldUser() {
		return postHoldUser;
	}

	public void setPostHoldUser(User postHoldUser) {
		this.postHoldUser = postHoldUser;
	}
	
	@Length(min=0, max=2, message="调货原因类型长度必须介于 0 和 2 之间")
	public String getReasonType() {
		return reasonType;
	}

	public void setReasonType(String reasonType) {
		this.reasonType = reasonType;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getScanCode() {
		return scanCode;
	}

	public void setScanCode(String scanCode) {
		this.scanCode = scanCode;
	}
	
}