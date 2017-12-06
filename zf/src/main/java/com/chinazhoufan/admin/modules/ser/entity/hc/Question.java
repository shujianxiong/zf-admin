/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.entity.hc;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 帮助中心问题Entity
 * @author 张金俊
 * @version 2017-07-31
 */
public class Question extends DataEntity<Question> {
	
	private static final long serialVersionUID = 1L;
	private String type;		// 类型
	private String name;		// 名称
	private String question;	// 问题
	private String answer;		// 答案
	private Integer orderNo;	// 排列序号

	/******************************************** 自定义常量  *********************************************/
	// 问题类型 ser_hc_question_type
	public static final String TYPE_REGISTER	= "register";	// 注册登录
	public static final String TYPE_SECURITY	= "security";	// 安全防诈骗
	public static final String TYPE_ORDER		= "order";		// 订单问题
	public static final String TYPE_PAY			= "pay";		// 支付问题
	public static final String TYPE_SERVICE		= "service";	// 售后问题
	public static final String TYPE_ACTIVITY	= "activity";	// 平台活动
	
	
	public Question() {
		super();
	}

	public Question(String id){
		super(id);
	}

	
	@Length(min=1, max=100, message="类型长度必须介于 1 和 100 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=200, message="问题长度必须介于 1 和 200 之间")
	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}
	
	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	@Length(min=0, max=11, message="排列序号长度必须介于 0 和 11 之间")
	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	
}