/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.index.modules.usercenter.web;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.utils.Md5;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookBalance;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.bb.BankbookBalanceService;
import com.chinazhoufan.admin.modules.crm.service.cl.GoodsCollectService;
import com.chinazhoufan.admin.modules.crm.service.cl.GoodsViewService;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.lgt.service.bs.DesignerService;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodsService;
import com.chinazhoufan.admin.modules.sys.utils.MemberUtils;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.chinazhoufan.mobile.index.modules.usercenter.vo.MyCenterVO;

/**
 * 用户个人中心Controller
 * @author 贾斌
 * @version 2016-01-12
 */
@Controller
@RequestMapping(value = "${mobileIndexPath}/member")
public class WapMyController extends BaseController {

	@Autowired
	private MemberService wapMemberService;
	@Autowired
	private DesignerService designerService;
	@Autowired
	private GoodsCollectService goodsCollectService;
	@Autowired
	private GoodsViewService goodsViewService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private BankbookBalanceService bankbookBalanceService;
	/**
	 * 系统消息公用方法
	 * messageNum：(系统消息+新闻通知+物流助手)
	 * @return
	 */
	private int getMessageCenter(HttpServletRequest request){
		return 0;
	}
	
	
	@RequestMapping(value = "center")
	public String myCenter(Model model, HttpServletRequest request){
		try {
			Member member = MemberUtils.getMember(request);
			//消息提醒
			int messageNum = getMessageCenter(request);
			
			MyCenterVO centerVO = new MyCenterVO(member, messageNum);
			model.addAttribute("centerVO", centerVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "mobile/wechat/myCenter/myPage/myPage";
	}
	
	/**
	 * 我的资产
	 * @return
	 */
	@RequestMapping(value = "myAssets")
	public String myAssets(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		
		int point = member.getPoint() == null ? 0 : member.getPoint().intValue();
		BankbookBalance bankbookBalance = bankbookBalanceService.getByMemberId(member.getId());
		MyCenterVO centerVO = null;
		if(bankbookBalance != null){
			centerVO = new MyCenterVO(member, point, 
										bankbookBalance.getUsableBalance(), bankbookBalance.getFrozenBalance());
		}else{
			BigDecimal b1 = new BigDecimal("0.00");
			centerVO = new MyCenterVO(member, point, b1, b1);
		}
		
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/myAssets/myAssets";
	}
	
	/**
	 * 账户明细
	 * @return
	 */
	@RequestMapping(value = "billDetail")
	public String billDetail() {
		return "mobile/wechat/myCenter/myAssets/billDetail/billDetail";
	}
	
	
	/**
	 * 积分兑换
	 * @return
	 */
	@RequestMapping(value = "integralExchange")
	public String integralExchange() {
		return "mobile/wechat/myCenter/myAssets/integral/integralExchange/integralExchange";
	}
	
	/**
	 * 积分明细
	 * @return
	 */
	@RequestMapping(value = "integral")
	public String integral() {
		return "mobile/wechat/myCenter/myAssets/integral/integral";
	}
	
	/**
	 * 用户地址列表页面
	 * @return
	 */
	@RequestMapping(value = "addressList")
	public String addressList() {
		
		return "mobile/wechat/address/address";
	}
	
	/**
	 * 跳转到地址添加页面
	 * @return
	 */
	@RequestMapping(value = "addressSave")
	public String addressSave() {
		return "mobile/wechat/address/address";
	}
	
	/**
	 * 跳转到地址修改页面
	 * @return
	 */
	@RequestMapping(value = "addressEdit")
	public String addressEdit() {
		return "mobile/wechat/address/address";
	}
	
	
	/**
	 * 个人设置
	 * @return
	 */
	@RequestMapping(value = "mySetting")
	public String mySetting(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		//消息提醒
		int messageNum = getMessageCenter(request);
		MyCenterVO centerVO = new MyCenterVO(member, messageNum);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/mySetting/mySetting";
	}
	
	/**
	 * 个人资料设置
	 * @return
	 */
	@RequestMapping(value = "personalDataSetting")
	public String personalDataSetting(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		//消息提醒
		int messageNum = getMessageCenter(request);
		MyCenterVO centerVO = new MyCenterVO(member, messageNum);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/mySetting/personalDataSetting/personalDataSetting";
	}
	
	/**
	 * 个人资料设置-修改昵称跳转页面
	 * @return
	 */
	@RequestMapping(value = "nicknameSetting")
	public String nicknameSetting(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		MyCenterVO centerVO = new MyCenterVO(member);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/mySetting/personalDataSetting/nicknameSetting/nicknameSetting";
	}
	
	/**
	 * 个人资料设置-填写身高跳转页面
	 * @return
	 */
	@RequestMapping(value = "heightSetting")
	public String heightSetting(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		MyCenterVO centerVO = new MyCenterVO(member);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/mySetting/personalDataSetting/heightSetting/heightSetting";
	}
	
	/**
	 * 账户与安全
	 * @return
	 */
	@RequestMapping(value = "accountSecurity")
	public String accountSecurity() {
		return "mobile/wechat/myCenter/mySetting/accountSecurity/accountSecurity";
	}
	
	/**
	 * 账户与安全-请完善身份信息
	 * @return
	 */
	@RequestMapping(value = "finishInformation")
	public String finishInformation(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		MyCenterVO centerVO = new MyCenterVO(member);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/mySetting/accountSecurity/finishInformation/finishInformation";
	}
	
	
	
	/**
	 * 账户与安全-修改手机号
	 * @return
	 */
	@RequestMapping(value = "modifyCellphone")
	public String modifyCellphone() {
		return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/modifyCellphone";
	}
	
	/**
	 * 账户与安全-验证手机
	 * @return
	 */
	@RequestMapping(value = "verifyCellphone")
	public String verifyCellphone(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		MyCenterVO centerVO = new MyCenterVO(member);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/verifyCellphone";
	}
	
	
	/**
	 * 系统消息管理
	 * @return
	 */
	@RequestMapping(value = "newsManagement")
	public String newsManagement() {
		return "mobile/wechat/myCenter/newsManagement/newsManagement";
	}
	
	/**
	 * 系统消息列表
	 * @return
	 */
	@RequestMapping(value = "systemInform/{status}")
	public String systemInform(@PathVariable("status")String status,Model model) {
		model.addAttribute("status", status);
		return "mobile/wechat/myCenter/newsManagement/systemInform";
	}
	
	
	/**
	 * 通用设置 (备注：缺少页面)
	 * @return
	 */
	@RequestMapping(value = "myScanRecord4")
	public String myScanRecord4() {
		return "mobile/wechat/myCenter/scanRecord/scanRecord";
	}
	
	/**
	 * 我的身份二维码(备注：二维码需要动态生成，暂时用静态图片代替需完善)
	 * @return
	 */
	@RequestMapping(value = "myBarcode")
	public String myBarcode(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		MyCenterVO centerVO = new MyCenterVO(member);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/mySetting/personalDataSetting/my2DBarcode/my2DBarcode";
	}

	
	
	/**
	 * 意见反馈
	 * @return
	 */
	@RequestMapping(value = "feedback")
	public String feedback(Model model) {
		return "mobile/wechat/myCenter/helpCenter/feedback/feedback";
	}
	
	/**
	 * 待收货人信息管理
	 * @return
	 */
	@RequestMapping(value = "insteadReceivingList")
	public String insteadReceivingList() {
		return "mobile/wechat/myCenter/mySetting/insteadReceiving/insteadReceiving";
	}
	
	/**
	 * 待收货人信息添加
	 * @return
	 */
	@RequestMapping(value = "insteadReceiveInfoSave")
	public String insteadReceiveInfoSave() {
		return "mobile/wechat/myCenter/mySetting/insteadReceiving/insteadReceiveInfo/insteadReceiveInfo";
	}
	
	/**
	 * 待收货人信息修改
	 * id : 待收货人Id
	 * @return
	 */
	@RequestMapping(value = "insteadReceiverModifyEdit/{id}")
	public String insteadReceiverModifyEdit(@PathVariable("id")String id,Model model) {
		return "mobile/wechat/myCenter/mySetting/insteadReceiving/insteadReceiverModify/insteadReceiverModify";
	}
	
	
	/**
	 * 浏览记录
	 * goodsStatus:0默认是查看所有浏览过的商品,3只查看没有下架的商品,2编辑状态
	 * @return
	 */
	@RequestMapping(value = "myScanRecord/{goodsStatus}")
	public String myScanRecord(@PathVariable("goodsStatus")String goodsStatus,Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		//看过的商品数量
//		int goodsViewNum = goodsViewService.getCountByMember(member);
		MyCenterVO centerVO = new MyCenterVO(member, 0);
		model.addAttribute("centerVO", centerVO);
		model.addAttribute("goodsStatus", goodsStatus);
		return "mobile/wechat/myCenter/scanRecord/scanRecord";
	}
	
	
	/**
	 * 我的收藏
	 * @return
	 */
	@RequestMapping(value = "myRecord")
	public String myRecord(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		//收藏的商品数量
		int goodsNum = goodsCollectService.getCountByMember(member);
//		int fanNum = fanCollectService.getCountByMember(member);
		MyCenterVO centerVO = new MyCenterVO(member,goodsNum);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/myCenter/myRecord/myRecord";
	}
	
	
	public static void main(String[] args) {
		String  a = ",";
		System.out.println(a.substring(1));
	}
	
	
	/********修改密码******/
	/**
	 * 跳转到用户修改密码页面
	 * @return
	 */
	@RequestMapping(value = "smsModifiedPassword")
	public String smsModifiedPassword(Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		MyCenterVO centerVO = new MyCenterVO(member);
		model.addAttribute("centerVO", centerVO);
		return "mobile/wechat/loginRegist/modifiedPassword";
	}
	
	/**
	 * 跳转到修改密码二级页面
	 * @param phone 手机号码
	 * @param smsCode	验证码
	 * @return
	 */
	@RequestMapping(value = "modifiedPassword")
	public String modifiedPassword(String phone,String smsCode,Model model, HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		MyCenterVO centerVO = new MyCenterVO(member);
		model.addAttribute("centerVO", centerVO);
		//参数检测
		if(StringUtils.isBlank(phone)||StringUtils.isBlank(smsCode)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "mobile/wechat/loginRegist/modifiedPassword";
		}
		//暂时使用123456作为短信验证码
		String sms="123456";
		if(!smsCode.equals(sms)){
			model.addAttribute("echos",new Echos(Constants.SMSCODE_ERROR));
			return "mobile/wechat/loginRegist/modifiedPassword";
		}
		//查询手机号是否已经注册
		Member userCode= wapMemberService.getByUserCodeOpenId(phone);
		if(userCode == null){
			model.addAttribute("echos",new Echos(Constants.USERCODE_LENGTH_NULL));
			return "mobile/wechat/loginRegist/regist";
		}
		return "mobile/wechat/loginRegist/editPassword";
	}
	
	
	/**
	 * 修改密码
	 * @param phone 手机号
	 * @param pwd	新密码
	 * @param repwd	确认密码
	 * @return
	 */
	@RequestMapping(value = "doModifiedPassword")
	public String doModifiedPassword(String phone,String pwd,String rePwd,Model model,HttpServletRequest request) {
		try {
			Member member = MemberUtils.getMember(request);
			MyCenterVO centerVO = new MyCenterVO(member);
			model.addAttribute("centerVO", centerVO);
			//参数检测
			if(StringUtils.isBlank(phone)||StringUtils.isBlank(pwd)||StringUtils.isBlank(rePwd)){
				model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
				return "mobile/wechat/loginRegist/editPassword";
			}
			//检测密码是否数字和字母组合且不得低于六位
			if(!pwd.matches(Member.PASSWORD_REGULAR)){
				model.addAttribute("echos",new Echos(Constants.REPWD_LENGTH_ERROR));
				return "mobile/wechat/loginRegist/editPassword";
			}
			//格式检测
			if(!pwd.equals(rePwd)){
				model.addAttribute("echos",new Echos(Constants.REPWD_ERROR));
				return "mobile/wechat/loginRegist/editPassword";
			}
			//密码格式：长度6位，字母+数字
			Member members= wapMemberService.getByUserCodeOpenId(phone);
			members.setPassword(Md5.toMd5(Md5.toMd5(pwd)));
			wapMemberService.save(members);
			
		} catch (Exception e) {
			model.addAttribute("echos",new Echos(Constants.MESSAGE));
			return "mobile/wechat/loginRegist/modifiedPassword";
		}
		//修改成功跳转到登录页面验证登录
		request.getSession().removeAttribute("member");
		model.addAttribute("echos",new Echos(Constants.EDIT_PASSWORD_SUCCESS));
		return "mobile/wechat/loginRegist/login";
	}
	
	
	/**
	 * 修改手机号码
	 * @param 
	 * phone : 手机号
	 * smsCode : 验证码
	 * @return
	 */
	@RequestMapping(value = "doVerifyCellphone")
	public String doVerifyCellphone(String phone,String smsCode,Model model,HttpServletRequest request) {
		Member member = MemberUtils.getMember(request);
		MyCenterVO centerVO = new MyCenterVO(member);
		model.addAttribute("centerVO", centerVO);
		//参数检测
		if(StringUtils.isBlank(phone)||StringUtils.isBlank(smsCode)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/verifyCellphone";
		}
		//暂时使用123456作为短信验证码
		String sms="123456";
		if(!smsCode.equals(sms)){
			model.addAttribute("echos",new Echos(Constants.SMSCODE_ERROR));
			return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/verifyCellphone";
		}
		//验证手机号是否存在
		Member members= wapMemberService.getByUserCodeOpenId(phone);
		if(members == null){
			model.addAttribute("echos",new Echos(Constants.USERCODE_LENGTH_NULL));
			return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/verifyCellphone";
		}
		return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/resetCellphone";
	}
	
	
	/**
	 * 修改手机号码-保存新手机号
	 * @param 
	 * phone ：手机号
	 * smsCode:验证码
	 * @return
	 */
	@RequestMapping(value = "doResetCellphone")
	public String doResetCellphone(String phone,String smsCode,Model model,HttpServletRequest request) {
		model.addAttribute("phone",phone);
		//参数检测
		if(StringUtils.isBlank(phone) || StringUtils.isBlank(smsCode)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/resetCellphone";
		}
		//暂时使用123456作为短信验证码
		String sms="123456";
		if(!smsCode.equals(sms)){
			model.addAttribute("echos",new Echos(Constants.SMSCODE_ERROR));
			return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/resetCellphone";
		}
		Member members= wapMemberService.getByUserCodeOpenId(phone);
		if(members != null){
			model.addAttribute("echos",new Echos(Constants.MOBILE_EXIST));
			return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/resetCellphone";
		}
		Member member = MemberUtils.getMember(request);
		member.setMobile(phone);
		wapMemberService.save(member);
		return "mobile/wechat/myCenter/mySetting/accountSecurity/modifyCellphone/successModified";
	}
	
	/**
	 * 修改昵称方法
	 * @param nickName ： 昵称
	 * @return
	 */
	@RequestMapping(value = "doNickNameSetting")
	public String doNickNameSetting(String nickName,Model model, HttpServletRequest request){
		//参数检测
		if(StringUtils.isBlank(nickName)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "redirect:"+Global.getMobileIndexPath()+"/member/nicknameSetting";
		}
		Member member = MemberUtils.getMember(request);
		member.setNickname(nickName);
		wapMemberService.save(member);
		return "redirect:"+Global.getMobileIndexPath()+"/member/personalDataSetting";
	}
	/**
	 * 修改身高方法
	 * @param height ： 身高
	 * @return
	 */
	@RequestMapping(value = "doHeightSetting")
	public String doHeightSetting(String height,Model model, HttpServletRequest request){
		//参数检测
		if(StringUtils.isBlank(height)){
			model.addAttribute("echos",new Echos(Constants.PARAMETER_ISNULL));
			return "redirect:"+Global.getMobileIndexPath()+"/member/heightSetting";
		}
		Member member = MemberUtils.getMember(request);
		wapMemberService.save(member);
		return "redirect:"+Global.getMobileIndexPath()+"/member/personalDataSetting";
	}
	
	
}