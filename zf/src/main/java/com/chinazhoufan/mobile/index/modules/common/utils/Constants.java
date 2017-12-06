package com.chinazhoufan.mobile.index.modules.common.utils;

/**
 * 状态码
 * @author 杨晓辉
 * 2015-12-29
 */
public class Constants {
	
	/**全局性状态码  取值范围 0-99**/
	public static final int MESSAGE = 3;//出错提示
	public static final int NO_MESSAGE = 2;//查询数据为空提示消息
	public static final int SUCCESS = 1;//成功
	public static final int ERROR = 0;//失败
	public static final int NO_GOODSTYPE = 5;	//查询商品分类为空
	public static final int NO_GOODIS = 6;	//商品id不能为空
	public static final int NOT_LOGIN = 21;	//没有登录
	public static final int PARAMETER_ERROR = 22;	//参数出错缺少方法名参数
	public static final int PARAMETER_MISSED = 15;	//缺少方法名参数
	public static final int PARAMETER_ISNULL = 16;	//参数为空
	
	/**业务类状态码 取值范围 200-599**/
	public static final int USERCODE_ERROR=201;//前台用户帐号密码不正确
	public static final int USERCODE_EXIST=202;//账户已经存在
	public static final int SMSCODE_ERROR=203;//短信验证码验证错误
	public static final int REPWD_ERROR=204;//两次密码验证错误
	public static final int REPWD_LENGTH_ERROR=205;//密码长度验证错误
	public static final int USERCODE_LENGTH_NULL=206;//手机号不存在
	public static final int OLD_PASSWORD_ERROR=207;//用户修改密码时验证原密码错误
	public static final int EDIT_PASSWORD_SUCCESS = 208;//密码修改，找回密码成功提示用户需要再次登录
	public static final int ATTENTIONI_IS_NO = 209; //不存在关注的人物
	public static final int IDCARD_UPLOAD_NULL = 210;//身份证照片上传为空
	public static final int IDCARD_COMPLETE = 211;//身份信息已提交过
	public static final int IDCARD_FORMAT_ERROR = 212;//身份证号格式不正确
	public static final int MOBILE_EXIST = 213;//该手机号已经绑定
	public static final int ACCOUNTS_FREEZE = 214;//该账号已被冻结
	public static final int ACCOUNTS_LIMIT = 215;//该账号已被限制登陆
	
	public static final int OPENID_ERROR = 217;//用户微信Openid异常
	public static final int SUBSCRIBE_CANCEL_ERROR = 218;//用户微信退订未能获取到订阅记录
	public static final int WECHATRECORD_SAVE_ERROR = 219;//保存用户聊天记录未能获取到用户
	public static final int SUBSCRIBE_REGISTER_ERROR = 220;//用户订阅注册未能获取到用户的OpenId
	
	public static final int INVITECODE_ERROR = 230;		// 该邀请码不存在或不在活动时间内
	public static final int INVITECODE_UNMATCH = 231;	// 该邀请码不适合当前活动
	
	/**质检单业务代码*/
	public static final int QUALITYCHECKORDER_NO = 251;	//质检单不存在
	public static final int QUALITYCHECKORDER_OVER = 252;	//质检单已完成
	
	public static final int ADMIN_PAGESIZE = 10;	//管理端分页pagesize
}