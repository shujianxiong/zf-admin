/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.entity.sa;

import java.util.Date;
import java.util.Map;
import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 服务申请Entity
 * @author 张金俊
 * @version 2017-08-14
 */
public class ServiceApply extends DataEntity<ServiceApply> {
	
	private static final long serialVersionUID = 1L;
	private String no;					// 服务单编号
	private String orderType;			// 来源订单类型
	private String orderId;				// 来源订单ID
	private String orderProduceId;		// 来源订单产品ID
	private Integer orderProduceNum;    // 来源订单产品数量
	private String status;				// 状态（待处理/已处理）
	private String applyByType;			// 申请人类型（员工/会员）
	private String applyById;			// 申请人ID
	private String applyTimeType;		// 申请时机类型（发货前/收货前/体验中）
	private String applyDealType;		// 申请处理类型（取消订单/免责）
	private String applyReasonType;		// 申请原因类型（下错订单/库存缺货/质量/功能）
	private String applyRemarks;		// 申请原因说明
	private String applyPhotos;			// 申请原因凭证
	private User dealBy;				// 处理人
	private String dealReasonType;		// 处理原因类型（质量/功能）
	private String dealResultType;		// 处理结果类型（通过/拒绝）
	private Date dealTime;				// 处理时间
	private String dealRemarks;			// 处理备注
	/******************************************** 自定义变量  *********************************************/
	private String orderNo;				// 来源订单编号
	private ExperienceOrder experienceOrder;

	private Integer experienceNum;

	private Integer buyNum;

	private Integer applyNum;//用户售后次数（待收货状态下申请售后的订单数）

	private Integer applyCancelNum;//订单取消次数（待发货状态下申请售后的订单数）

	private Map<String,Integer> damageTypeNumMap;

	private String membercode;				// 用户账号
	
	private String memberStatus;                 //会员状态
	
	private Produce produce;
	// 来源订单
	/******************************************** 自定义常量  *********************************************/
	public static final String GENERATECODE_NO = "ser_sa_service_apply_no";	// 获取服务申请编号 字段
	// 来源订单类型 bus_order_type：枚举类OrderType
	
	// 状态 ser_sa_service_apply_status
	public static final String STATUS_TO_DEAL		= "1";	// 待处理
	public static final String STATUS_DEALED		= "2";	// 已处理
	// 申请人类型 operater_type
	public static final String ABT_MEMBER			= "M";	// 会员
	public static final String ABT_USER				= "U";	// 员工
	public static final String ABT_SYSTEM			= "S";	// 系统
	// 申请时机类型 ser_sa_service_apply_applyTimeType
	public static final String ATT_BEFORE_SEND		= "1";	// 发货前
	public static final String ATT_BEFORE_RECEIVE	= "2";	// 收货前
	public static final String ATT_EXPERIENCING		= "3";	// 体验中
	// 申请处理类型 ser_sa_service_apply_applyDealType
	public static final String ADT_CANCEL			= "1";	// 取消订单
	public static final String ADT_RELIEF			= "2";	// 免责
	public static final String ADT_DUTY				= "3";	// 担责
	// 申请原因类型 ser_sa_service_apply_applyReasonType
	public static final String ART_WRONG_ORDER		= "M11";// 下错订单（M会员 1取消订单 1因为下错订单）
	public static final String ART_NOT_WANT			= "M12";// 我不想要了（M会员 1取消订单 2我不想要了）
	public static final String ART_OTHER			= "M13";// 其他（M会员 1取消订单 3其他）
	public static final String ART_PRODUCT_LACK		= "U12";// 库存缺货（U员工 1取消订单 2因为库存缺货）
	//public static final String ART_BROKEN_LIGHT		= "M21";// 商品轻微损坏
	//public static final String ART_BROKEN_SERIOUS	= "M22";// 商品严重损坏
	public static final String ART_PRODUCE_WRONG	= "M23";// 商品错发
	public static final String ART_PRODUCE_LEAK		= "M24";// 商品漏发
	public static final String ART_ALL_LOST 			= "M31";// 商品全部遗失
	public static final String ART_BROKEN 			= "M32";// 商品损坏
	public static final String ART_PART_LOST 			= "M33";// 商品部分遗失
	public static final String ORDER_NO_PAY 			= "M34";// 预约订单延期未付尾款
	// 处理原因类型 （同申请原因类型）
	// 处理结果类型 ser_sa_service_apply_dealResultType
	public static final String DRT_PASS				= "1";	// 通过
	public static final String DRT_REFUSE			= "2";	// 拒绝
	
	
	public ServiceApply() {
		super();
	}

	public ServiceApply(String id){
		super(id);
	}

	
	
	@Length(min=1, max=64, message="服务单编号长度必须介于 1 和 64 之间")
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}
	
	@Length(min=1, max=2, message="来源订单类型长度必须介于 1 和 2 之间")
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	@Length(min=1, max=64, message="来源订单ID长度必须介于 1 和 64 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=0, max=64, message="来源订单产品ID长度必须介于 0 和 64 之间")
	public String getOrderProduceId() {
		return orderProduceId;
	}

	public void setOrderProduceId(String orderProduceId) {
		this.orderProduceId = orderProduceId;
	}
	
	@Length(min=1, max=2, message="状态（待处理/已处理）长度必须介于 1 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getApplyByType() {
		return applyByType;
	}

	public void setApplyByType(String applyByType) {
		this.applyByType = applyByType;
	}

	public String getApplyById() {
		return applyById;
	}

	public void setApplyById(String applyById) {
		this.applyById = applyById;
	}

	@Length(min=1, max=2, message="申请时机类型（出库前/收货前/体验中）长度必须介于 1 和 2 之间")
	public String getApplyTimeType() {
		return applyTimeType;
	}

	public void setApplyTimeType(String applyTimeType) {
		this.applyTimeType = applyTimeType;
	}
	
	@Length(min=1, max=10, message="申请处理类型（取消订单/免责）长度必须介于 1 和 10 之间")
	public String getApplyDealType() {
		return applyDealType;
	}

	public void setApplyDealType(String applyDealType) {
		this.applyDealType = applyDealType;
	}
	
	@Length(min=1, max=2, message="申请原因类型（下错单/质量/功能）长度必须介于 1 和 2 之间")
	public String getApplyReasonType() {
		return applyReasonType;
	}

	public void setApplyReasonType(String applyReasonType) {
		this.applyReasonType = applyReasonType;
	}
	
	@Length(min=0, max=200, message="申请原因说明长度必须介于 0 和 200 之间")
	public String getApplyRemarks() {
		return applyRemarks;
	}

	public void setApplyRemarks(String applyRemarks) {
		this.applyRemarks = applyRemarks;
	}
	
	@Length(min=0, max=2000, message="申请原因凭证长度必须介于 0 和 2000 之间")
	public String getApplyPhotos() {
		return applyPhotos;
	}

	public void setApplyPhotos(String applyPhotos) {
		this.applyPhotos = applyPhotos;
	}
	
	@Length(min=0, max=64, message="处理人长度必须介于 0 和 64 之间")
	public User getDealBy() {
		return dealBy;
	}

	public void setDealBy(User dealBy) {
		this.dealBy = dealBy;
	}
	
	@Length(min=0, max=2, message="处理原因类型（质量/功能）长度必须介于 0 和 2 之间")
	public String getDealReasonType() {
		return dealReasonType;
	}

	public void setDealReasonType(String dealReasonType) {
		this.dealReasonType = dealReasonType;
	}
	
	public String getDealResultType() {
		return dealResultType;
	}

	public void setDealResultType(String dealResultType) {
		this.dealResultType = dealResultType;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDealTime() {
		return dealTime;
	}

	public void setDealTime(Date dealTime) {
		this.dealTime = dealTime;
	}
	
	@Length(min=0, max=255, message="处理备注长度必须介于 0 和 255 之间")
	public String getDealRemarks() {
		return dealRemarks;
	}

	public void setDealRemarks(String dealRemarks) {
		this.dealRemarks = dealRemarks;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public ExperienceOrder getExperienceOrder() {
		return experienceOrder;
	}

	public void setExperienceOrder(ExperienceOrder experienceOrder) {
		this.experienceOrder = experienceOrder;
	}

	public Integer getExperienceNum() {
		return experienceNum;
	}

	public void setExperienceNum(Integer experienceNum) {
		this.experienceNum = experienceNum;
	}

	public Integer getBuyNum() {
		return buyNum;
	}

	public void setBuyNum(Integer buyNum) {
		this.buyNum = buyNum;
	}

	public Integer getApplyNum() {
		return applyNum;
	}

	public void setApplyNum(Integer applyNum) {
		this.applyNum = applyNum;
	}

	public Integer getApplyCancelNum() {
		return applyCancelNum;
	}

	public void setApplyCancelNum(Integer applyCancelNum) {
		this.applyCancelNum = applyCancelNum;
	}

	public Map<String, Integer> getDamageTypeNumMap() {
		return damageTypeNumMap;
	}

	public void setDamageTypeNumMap(Map<String, Integer> damageTypeNumMap) {
		this.damageTypeNumMap = damageTypeNumMap;
	}

	public Integer getOrderProduceNum() {
		return orderProduceNum;
	}

	public void setOrderProduceNum(Integer orderProduceNum) {
		this.orderProduceNum = orderProduceNum;
	}

	public String getMembercode() {
		return membercode;
	}

	public void setMembercode(String membercode) {
		this.membercode = membercode;
	}

	public String getMemberStatus() {
		return memberStatus;
	}

	public void setMemberStatus(String memberStatus) {
		this.memberStatus = memberStatus;
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}
	
}