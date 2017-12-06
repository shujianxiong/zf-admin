/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.mb;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 会员魅力豆流水Entity
 * @author 张金俊
 * @version 2017-08-03
 */
public class BeansDetail extends DataEntity<BeansDetail> {
	
	private static final long serialVersionUID = 1L;
	private Integer itemNo;				// 流水号
	private Beans beans;				// 魅力豆账户
	private String changeType;			// 变动类型（增/减）
	private Integer num;				// 变动数量
	private Integer historyBeans;		// 变动后历史魅力豆
	private Integer currentBeans;		// 变动后当前魅力豆
	private String changeReasonType;	// 变动原因
	private Integer preItemNo;			// 上一次流水号
	private Integer preHistoryBeans;	// 上一次历史魅力豆
	private Integer preCurrentBeans;	// 上一次当前魅力豆
	private String operateSourceNo;		// 来源业务编号
	
	/******************************************** 自定义常量  *********************************************/
	// 变动类型 add_decrease
	public static final String CHANGETYPE_ADD		= "A";	// 增加
	public static final String CHANGETYPE_DECREASE	= "D";	// 减少
	// 变动原因 crm_mb_beans_detail_changeReasonType
	public static final String CRT_A_REGISTER		= "A1";	// 注册
	public static final String CRT_A_INFORMATION	= "A2";	// 完善个人信息
	public static final String CRT_A_EXPERIENCE		= "A3";	// 体验
	public static final String CRT_A_BUY			= "A4";	// 购买
	public static final String CRT_A_SHARE			= "A5";	// 分享
	public static final String CRT_A_COMMENT		= "A6";	// 评论
	public static final String CRT_D_SETTLEMENT_DEC	= "D1";	// 结算抵扣
	// 操作者类型 operater_type
	public static final String OPERATERTYPE_MEMBER	= "M";	// 会员
	public static final String OPERATERTYPE_USER	= "U";	// 员工
	public static final String OPERATERTYPE_SYSTEM	= "S";	// 系统
	
	
	
	public BeansDetail() {
		super();
	}

	public BeansDetail(String id){
		super(id);
	}
	
	
	@NotNull(message="变动数量不能为空")
	public Integer getItemNo() {
		return itemNo;
	}

	public void setItemNo(Integer itemNo) {
		this.itemNo = itemNo;
	}

	public Beans getBeans() {
		return beans;
	}

	public void setBeans(Beans beans) {
		this.beans = beans;
	}
	@NotNull(message="变动数量不能为空")
	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}
	@NotNull(message="变动后历史魅力豆不能为空")
	public Integer getHistoryBeans() {
		return historyBeans;
	}

	public void setHistoryBeans(Integer historyBeans) {
		this.historyBeans = historyBeans;
	}

	@NotNull(message="变动后当前魅力豆不能为空")
	public Integer getCurrentBeans() {
		return currentBeans;
	}

	public void setCurrentBeans(Integer currentBeans) {
		this.currentBeans = currentBeans;
	}

	@NotNull(message="变动后当前魅力豆不能为空")


	public Integer getPreItemNo() {
		return preItemNo;
	}

	public void setPreItemNo(Integer preItemNo) {
		this.preItemNo = preItemNo;
	}

	public Integer getPreHistoryBeans() {
		return preHistoryBeans;
	}

	public void setPreHistoryBeans(Integer preHistoryBeans) {
		this.preHistoryBeans = preHistoryBeans;
	}

	public Integer getPreCurrentBeans() {
		return preCurrentBeans;
	}

	public void setPreCurrentBeans(Integer preCurrentBeans) {
		this.preCurrentBeans = preCurrentBeans;
	}


	@Length(min=1, max=10, message="变动原因长度必须介于 1 和 10 之间")
	public String getChangeReasonType() {
		return changeReasonType;
	}

	public void setChangeReasonType(String changeReasonType) {
		this.changeReasonType = changeReasonType;
	}
	
	@Length(min=0, max=64, message="来源业务编号长度必须介于 0 和 64 之间")
	public String getOperateSourceNo() {
		return operateSourceNo;
	}

	public void setOperateSourceNo(String operateSourceNo) {
		this.operateSourceNo = operateSourceNo;
	}
	@Length(min = 1, max = 10, message = "变动类型长度必须介于 1 和 10 之间")
	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}
}