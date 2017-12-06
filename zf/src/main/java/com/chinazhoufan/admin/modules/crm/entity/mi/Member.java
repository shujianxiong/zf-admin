/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.entity.mi;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.common.utils.excel.annotation.ExcelField;

/**
 * 会员Entity
 * @author 贾斌（张金俊）
 * @version 2015-10-20（2016-12-03）
 */
public class Member extends DataEntity<Member> {
	
	private static final long serialVersionUID = 1L;
	private String usercode;		// 会员账号（手机号）
	private String wechatCode;		// 会员微信账号
	private String wechatOpenid;	// 会员微信OpenID
	private String memberCode;		// 会员编号
	private String level;			// 会员级别
	private String type;			// 会员类型
	private String password;		// 会员密码
	private String passwordPay;		// 会员支付密码
	
	private String nickname;		// 昵称
	private String gravatar;		// 头像
	private String sex;				// 性别
	private String birthday;		// 生日
	private String age;				// 年龄
	private String job;				// 职业
	private String income;			// 收入区间
	private String sign;			// 个性签名
	private String mobile;			// 联系电话
	private String email;			// 电子邮箱
	private String name;			// 姓名
	private String idCard;			// 身份证
	private String company;			// 工作单位
	private String registerPlatform;// 注册来源（微信端/网页端）
	private Date   registerTime;	// 注册时间
	private Member recommendMember;	// 推荐会员
	
	private String memberStatus;		// 会员状态（2注销、1正常等）
	private String usercodeStatus;		// 账号状态（1正常、2冻结、3限制等）
	private String blackwhiteStatus;	// 黑白名单状态（1正常、2白、3黑、4风险）
	private String blackwhiteRemark;	// 黑白名单备注

	private String arrearageRemark;			// 会员信誉

	private Integer point;			// 会员积分
	private Integer levelPoint;		// 会员等级分
	private Integer credit;			// 会员信誉

	/***************************************** 自定义查询条件属性  ******************************************/
	private Date beginRegisterTime; // 注册开始时间
	private Date endRegisterTime; 	// 注册结束时间
	
	/******************************************** 自定义常量  *********************************************/
	// 会员编号生成码
	public static final String GENERATECODE_MEMBERCODE = "crm_mi_memberNO";
	// 验证注册密码的数字字母组合正则表达式
	public static final String PASSWORD_REGULAR ="^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}$";

	private String smsFlag;//发送短信标志
	private String[] sendUserCodes ;//已发送会员短信集合

	private String[] openIds ;//已注册会员openids集合
	// 会员级别 crm_mi_member_level
	public static final String LEVEL_YJ			= "1";	// 银级
	public static final String LEVEL_JJ			= "2";	// 金级
	public static final String LEVEL_BJJ		= "3";	// 白金级
	public static final String LEVEL_ZS			= "4";	// 钻石级
	public static final String LEVEL_ZZ			= "5";	// 至尊级
	// 会员类型 crm_mi_member_type
	public static final String TYPE_FREE		= "1";	// 免费会员
	public static final String TYPE_MONTH		= "2";	// 月会员
	public static final String TYPE_QUARTER		= "3";	// 季会员
	public static final String TYPE_HALF_YEAR	= "4";	// 半年会员
	public static final String TYPE_YEAR		= "5";	// 年会员
	// 性别
	public static final String SEX_MALE				= "1";	// 男性
	public static final String SEX_FEMALE			= "2";	// 女性
	// 职业 crm_mi_member_job
	public static final String JOB_					= "1";	// 
	// 收入区间 crm_mi_member_income
	public static final String INCOME_				= "1";	// 
	// 注册来源 crm_mi_member_registerPlatform
	public static final String REGISTERPLATFORM_WC 	= "WC";	// 微信端
	public static final String REGISTERPLATFORM_WEB	= "WEB";// 网页端
	// 会员状态 crm_mi_member_memberStatus
	public static final String MEMBERSTATUS_ENABLE 		= "1"; 	// 启用
	public static final String MEMBERSTATUS_DISABLE 	= "2"; 	// 停用
	// 账号状态 crm_mi_member_usercodeStatus
	public static final String USERCODESTATUS_NORMAL 	= "1";	// 正常
	public static final String USERCODESTATUS_FREEZE 	= "2";	// 冻结
	public static final String USERCODESTATUS_LIMIT	 	= "3";	// 限制
	// 黑白名单状态 crm_mi_member_blackwhiteStatus
	public static final String BLACKWHITESTATUS_NORMAL	= "1";	// 正常
	public static final String BLACKWHITESTATUS_WHITE 	= "2";	// 白名单顾客
	public static final String BLACKWHITESTATUS_BLACK	= "3";	// 黑名单顾客
	public static final String BLACKWHITESTATUS_DANGER	= "4";	// 风险顾客
	// 会员等级分对应级别 crm_mi_member_levelPoint
	public static final String LEVELPOINT_YJ			= "100";	// 银级
	public static final String LEVELPOINT_JJ			= "200";	// 金级
	public static final String LEVELPOINT_BJ			= "500";	// 白金级
	
	
	//统计新增会员数据
	private String count;   //用于新增会员数据统计 2017-03-04
	
	
	/** 构造 */
	public Member() {
		super();
	}

	public Member(String id){
		super(id);
	}
	
	
	/** 方法 */
	@NotBlank(message = "会员账号不能为空")
	@Length(min=0, max=50, message="会员账号长度必须介于 0 和 50 之间")
	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	
	@Length(min=0, max=50, message="会员微信账号长度必须介于 0 和 50 之间")
	public String getWechatCode() {
		return wechatCode;
	}

	public void setWechatCode(String wechatCode) {
		this.wechatCode = wechatCode;
	}

	@Length(min=0, max=50, message="会员微信OpenID必须介于 0 和 50 之间")
	public String getWechatOpenid() {
		return wechatOpenid;
	}

	public void setWechatOpenid(String wechatOpenid) {
		this.wechatOpenid = wechatOpenid;
	}

	@NotBlank(message = "会员编号不能为空")
	@Length(min=0, max=64, message="会员编号长度必须介于 0 和 64 之间")
	public String getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	
	@Length(min=1, max=2, message="会员级别长度必须介于 1 和 2 之间")
	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
	
	@Length(min=1, max=2, message="会员类型长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Length(min=0, max=50, message="会员密码长度必须介于 0 和 50 之间")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	@Length(min=0, max=50, message="会员支付密码长度必须介于 0 和 50 之间")
	public String getPasswordPay() {
		return passwordPay;
	}

	public void setPasswordPay(String passwordPay) {
		this.passwordPay = passwordPay;
	}
	
	@Length(min=1, max=50, message="会员昵称长度必须介于 1 和 50 之间")
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	@Length(min=0, max=255, message="头像长度必须介于 0 和 255 之间")
	public String getGravatar() {
		return gravatar;
	}

	public void setGravatar(String gravatar) {
		this.gravatar = gravatar;
	}
	
	@Length(min=1, max=1, message="性别长度必须介于 1 和 1 之间")
	public String getSex() {
		return sex;
	}
	
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@Length(min=0, max=50, message="生日长度必须介于 0 和 50 之间")
	public String getBirthday() {
		return birthday;
	}
	
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=11, message="年龄长度必须介于 0 和 11 之间")
	public String getAge() {
		return age;
	}
	
	public String getSign() {
		return sign;
	}
	
	public void setSign(String sign) {
		this.sign = sign;
	}
	
	@Length(min=0, max=50, message="联系电话长度必须介于 0 和 50 之间")
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Length(min=0, max=100, message="电子邮箱长度必须介于 0 和 100 之间")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	@Length(min=1, max=50, message="姓名长度必须介于 1 和 50 之间")
	public String getName() {
		return name;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
	@Length(min=0, max=50, message="身份证长度必须介于 0 和 50 之间")
	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	
	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
	
	@NotBlank(message = "注册来源不能为空")
	@Length(min=1, max=2, message="注册来源长度必须介于 1 和 2 之间")
	public String getRegisterPlatform() {
		return registerPlatform;
	}
	
	public void setRegisterPlatform(String registerPlatform) {
		this.registerPlatform = registerPlatform;
	}
	
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="注册时间不能为空")
	@ExcelField(title="注册时间", align=2, sort=1)
	public Date getRegisterTime() {
		return registerTime;
	}
	
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	
	@Length(min=0, max=64, message="推荐人长度必须介于 0 和 64 之间")
	public Member getRecommendMember() {
		return recommendMember;
	}
	
	public void setRecommendMember(Member recommendMember) {
		this.recommendMember = recommendMember;
	}

	@NotBlank(message = "会员状态不能为空")
	@Length(min=1, max=2, message="会员状态长度必须介于 1 和 2 之间")
	public String getMemberStatus() {
		return memberStatus;
	}

	public void setMemberStatus(String memberStatus) {
		this.memberStatus = memberStatus;
	}
	
	@NotBlank(message = "账号状态不能为空")
	@Length(min=1, max=2, message="账号状态长度必须介于 1 和 2 之间")
	public String getUsercodeStatus() {
		return usercodeStatus;
	}

	public void setUsercodeStatus(String usercodeStatus) {
		this.usercodeStatus = usercodeStatus;
	}

	@NotBlank(message = "黑名单状态不能为空")
	@Length(min=1, max=2, message="黑白名单状态长度必须介于 1 和 2 之间")
	public String getBlackwhiteStatus() {
		return blackwhiteStatus;
	}

	public void setBlackwhiteStatus(String blackwhiteStatus) {
		this.blackwhiteStatus = blackwhiteStatus;
	}

	@Length(min=0, max=255, message="黑名单备注长度必须介于 0 和 255 之间")
	public String getBlackwhiteRemark() {
		return blackwhiteRemark;
	}

	public void setBlackwhiteRemark(String blackwhiteRemark) {
		this.blackwhiteRemark = blackwhiteRemark;
	}

	public Integer getPoint() {
		return point;
	}

	public void setPoint(Integer point) {
		this.point = point;
	}
	
	public Integer getLevelPoint() {
		return levelPoint;
	}

	public void setLevelPoint(Integer levelPoint) {
		this.levelPoint = levelPoint;
	}

	public Integer getCredit() {
		return credit;
	}

	public void setCredit(Integer credit) {
		this.credit = credit;
	}

	// 查询属性字段
	public Date getBeginRegisterTime() {
		return beginRegisterTime;
	}

	public void setBeginRegisterTime(Date beginRegisterTime) {
		this.beginRegisterTime = beginRegisterTime;
	}

	public Date getEndRegisterTime() {
		return endRegisterTime;
	}

	public void setEndRegisterTime(Date endRegisterTime) {
		this.endRegisterTime = endRegisterTime;
	}

	@ExcelField(title="新增人数", align=2,sort=5)
	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getIncome() {
		return income;
	}

	public void setIncome(String income) {
		this.income = income;
	}

	public String getSmsFlag() {
		return smsFlag;
	}

	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}

	public String[] getSendUserCodes() {
		return sendUserCodes;
	}

	public void setSendUserCodes(String[] sendUserCodes) {
		this.sendUserCodes = sendUserCodes;
	}

	public String[] getOpenIds() {
		return openIds;
	}

	public void setOpenIds(String[] openIds) {
		this.openIds = openIds;
	}

	public String getArrearageRemark() {
		return arrearageRemark;
	}

	public void setArrearageRemark(String arrearageRemark) {
		this.arrearageRemark = arrearageRemark;
	}
}