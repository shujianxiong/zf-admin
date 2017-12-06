package com.chinazhoufan.mobile.wechat.web;

import java.util.List;

import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.sl.SmsLinkService;
import com.chinazhoufan.admin.modules.spm.entity.ep.InvitationDetail;
import com.chinazhoufan.admin.modules.spm.service.ep.InvitationDetailService;
import com.chinazhoufan.admin.modules.spm.service.ep.InvitationService;
import com.chinazhoufan.admin.modules.spm.service.zi.QrCodeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.mpsdk4j.core.WechatHandler;
import com.chinazhoufan.admin.common.mpsdk4j.vo.event.BasicEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.event.CustomServiceEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.event.LocationEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.event.MenuEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.event.ScanCodeEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.event.ScanEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.event.SendLocationInfoEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.event.SendPhotosEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.BasicMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.ImageMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.LinkMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.LocationMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.TextMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.VideoMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.VoiceMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.push.SentAllJobEvent;
import com.chinazhoufan.admin.common.mpsdk4j.vo.push.SentTmlJobEvent;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.wcp.entity.ar.AutoReply;
import com.chinazhoufan.admin.modules.wcp.service.ar.AutoReplyService;
import com.chinazhoufan.admin.modules.wcp.service.su.SubscribeRecordService;
import com.chinazhoufan.mobile.wechat.service.WeiXinService;

@Service
@Transactional(readOnly = true)
public class WeiXinResponse implements WechatHandler{

	/**
	 * 日志对象
	 */
	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private WeiXinService weiXinService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private SubscribeRecordService subscribeRecordService;
	@Autowired
	private AutoReplyService autoReplyService;

	@Autowired
	private InvitationService invitationService;
	@Autowired
	private QrCodeService qrCodeService;

	@Autowired
	private InvitationDetailService invitationDetailService;
	public static final String AUTO_REPLY_DEFAULT_TEXT 			= "您发送的内容系统无法识别，您可以发送'周范'试试看哦！";	// 未找到设定的自动回复时的回复内容
	public static final String AUTO_REPLY_DEFAULT_CODE 			= "replyDefault";					// 未识别出事件类型的自动回复
	public static final String AUTO_REPLY_DEFAULT_TEXT_CODE 	= "replyDefaultText";				// 文字类型的自动回复
	public static final String AUTO_REPLY_SUBSCRIBE 			= "replySubscribe";					// 关注公众号后的自动回复
	
	
	@Override
	@Transactional(readOnly = false)
	public BasicMsg defMsg(BasicMsg msg) {
		// 收到新消息，且事件未识别出事件类型，保存（用户）消息发送记录
		weiXinService.saveMsgRecordForSend(msg);
		
		// 返回默认内容
		AutoReply ar = new AutoReply("", AUTO_REPLY_DEFAULT_CODE);
		AutoReply autoReply = autoReplyService.getActivityByCode(ar);
		if(autoReply == null){
			autoReply = new AutoReply();
			autoReply.setContentType(AutoReply.CONTENT_TYPE_TEXT);
			autoReply.setText(AUTO_REPLY_DEFAULT_TEXT);
		}
		// 根据用户发送的消息、对应的系统自动回复消息，封装回复对象
		BasicMsg replyMsg = weiXinService.packageReplyMsgByAutoReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		// 保存（系统）消息回复记录
		weiXinService.saveMsgRecordForReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		
		return replyMsg;
	}

	@Override
	public BasicMsg defEvent(BasicEvent event) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	@Transactional(readOnly = false)
	public BasicMsg text(TextMsg msg) {
		weiXinService.saveMsgRecordForSend(msg);
		
		// 智能回复检测
		AutoReply autoReply;
		AutoReply ar = new AutoReply(msg.getContent(), "");
		String mpId = msg.getToUserName();//公众号id
		if(WeiXinConfig.D_S_MP_ID.equals(mpId)){
			ar.setMp(AutoReply.MP_ZB);
		}else if(WeiXinConfig.D_A_MP_ID.equals(mpId)){
			ar.setMp(AutoReply.MP_ZFS);
		}
		List<AutoReply> autoReplyList = autoReplyService.getActivityByKeywords(ar);
		if(autoReplyList!=null && autoReplyList.size()!=0){
			autoReply = autoReplyList.get(0);
		}else{
			ar = new AutoReply("", AUTO_REPLY_DEFAULT_CODE);
			autoReply = autoReplyService.getActivityByCode(ar);
			if(autoReply == null){
				autoReply = new AutoReply();
				autoReply.setContentType(AutoReply.CONTENT_TYPE_TEXT);
				autoReply.setText(AUTO_REPLY_DEFAULT_TEXT);				
			}
		}
		// 根据用户发送的消息、对应的系统自动回复消息，封装回复对象
		BasicMsg replyMsg = weiXinService.packageReplyMsgByAutoReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		// 保存（系统）消息回复记录
		weiXinService.saveMsgRecordForReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		
		return replyMsg;
	}

	@Override
	@Transactional(readOnly = false)
	public BasicMsg image(ImageMsg msg) {
		// 收到新消息，且事件未识别出事件类型，保存（用户）消息发送记录
		weiXinService.saveMsgRecordForSend(msg);
		
		// 返回默认内容
		AutoReply ar = new AutoReply("", AUTO_REPLY_DEFAULT_CODE);
		AutoReply autoReply = autoReplyService.getActivityByCode(ar);
		if(autoReply == null){
			autoReply = new AutoReply();
			autoReply.setContentType(AutoReply.CONTENT_TYPE_TEXT);
			autoReply.setText(AUTO_REPLY_DEFAULT_TEXT);
		}
		// 根据用户发送的消息、对应的系统自动回复消息，封装回复对象
		BasicMsg replyMsg = weiXinService.packageReplyMsgByAutoReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		// 保存（系统）消息回复记录
		weiXinService.saveMsgRecordForReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		
		return replyMsg;
	}

	@Override
	@Transactional(readOnly = false)
	public BasicMsg voice(VoiceMsg msg) {
		// 收到新消息，且事件未识别出事件类型，保存（用户）消息发送记录
		weiXinService.saveMsgRecordForSend(msg);
		
		// 返回默认内容
		AutoReply ar = new AutoReply("", AUTO_REPLY_DEFAULT_CODE);
		AutoReply autoReply = autoReplyService.getActivityByCode(ar);
		if(autoReply == null){
			autoReply = new AutoReply();
			autoReply.setContentType(AutoReply.CONTENT_TYPE_TEXT);
			autoReply.setText(AUTO_REPLY_DEFAULT_TEXT);
		}
		// 根据用户发送的消息、对应的系统自动回复消息，封装回复对象
		BasicMsg replyMsg = weiXinService.packageReplyMsgByAutoReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		// 保存（系统）消息回复记录
		weiXinService.saveMsgRecordForReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		
		return replyMsg;
	}

	@Override
	@Transactional(readOnly = false)
	public BasicMsg video(VideoMsg msg) {
		// 收到新消息，且事件未识别出事件类型，保存（用户）消息发送记录
		weiXinService.saveMsgRecordForSend(msg);
		
		// 返回默认内容
		AutoReply ar = new AutoReply("", AUTO_REPLY_DEFAULT_CODE);
		AutoReply autoReply = autoReplyService.getActivityByCode(ar);
		if(autoReply == null){
			autoReply = new AutoReply();
			autoReply.setContentType(AutoReply.CONTENT_TYPE_TEXT);
			autoReply.setText(AUTO_REPLY_DEFAULT_TEXT);
		}
		// 根据用户发送的消息、对应的系统自动回复消息，封装回复对象
		BasicMsg replyMsg = weiXinService.packageReplyMsgByAutoReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		// 保存（系统）消息回复记录
		weiXinService.saveMsgRecordForReply(msg.getFromUserName(), msg.getToUserName(), autoReply);
		
		return replyMsg;
	}

	@Override
	public BasicMsg shortVideo(VideoMsg msg) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BasicMsg location(LocationMsg msg) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BasicMsg link(LinkMsg msg) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BasicMsg eClick(MenuEvent event) {
		//用户点击自定义菜单
		String key = event.getEventKey();
		//获取菜单标记
		AutoReply ar = new AutoReply("", key);
		AutoReply autoReply = autoReplyService.getActivityByCode(ar);
		if(autoReply == null){
			autoReply = new AutoReply();
			autoReply.setContentType(AutoReply.CONTENT_TYPE_TEXT);
			autoReply.setText(AUTO_REPLY_DEFAULT_TEXT);
		}
		// 根据用户发送的消息、对应的系统自动回复消息，封装回复对象
		BasicMsg replyMsg = weiXinService.packageReplyMsgByAutoReply(event.getFromUserName(), event.getToUserName(), autoReply);
		//记录菜单点击类型
		return replyMsg;
	}

	@Override
	public void eView(MenuEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	@Transactional(readOnly = false)
	public BasicMsg eSub(BasicEvent event) {
		//用户关注更新邀请人数
		if(event !=null &&event.getEventKey() != null){
			String[] eventStr =event.getEventKey().split("_");
			if(eventStr.length>1){
				if(eventStr[1] != null){
					//根据邀请人openId获取用户信息
					Member member = memberService.get(eventStr[1]);
					if(member != null){

						//添加邀请人记录
						InvitationDetail invitationDetail = new InvitationDetail();
						invitationDetail.setMember(member);
						invitationDetail.setInvitederOpenid(event.getFromUserName());
						List<InvitationDetail> invitationDetails = invitationDetailService.findList(invitationDetail);
						if(invitationDetails == null || invitationDetails.size() == 0){
							//用户被邀请过，不做更新
							invitationDetailService.save(invitationDetail);
							//更新邀请人数
							invitationService.updateByWxShare(member.getId());
						}

					}else{
						//如果不是邀请关注，则判断成用户来源关注，更新用户来源
						qrCodeService.updateByRandomCode(event.getFromUserName(),eventStr[1]);
					}
				}else{
					logger.info("no get [{}]member!",event.getEventKey());
				}
			}

		}
		// 新用户订阅，新增用户订阅记录
		subscribeRecordService.saveByOpenid(event.getToUserName(), event.getFromUserName());

//		// 判断用户是否已是会员，不是则注册为会员（关注不再自动注册 2016-06-01）
//		memberService.saveMemberByOpenid(event.getFromUserName());
		
		// 返回订阅时内容
		AutoReply ar = new AutoReply("", AUTO_REPLY_SUBSCRIBE);
		AutoReply autoReply = autoReplyService.getActivityByCode(ar);
		if(autoReply == null){
			autoReply = new AutoReply();
			autoReply.setContentType(AutoReply.CONTENT_TYPE_TEXT);
			autoReply.setText(AUTO_REPLY_DEFAULT_TEXT);
		}
		// 根据用户发送的消息、对应的系统自动回复消息，封装回复对象
		BasicMsg replyMsg = weiXinService.packageReplyMsgByAutoReply(event.getFromUserName(), event.getToUserName(), autoReply);
		// 保存（系统）消息回复记录
		weiXinService.saveMsgRecordForReply(event.getFromUserName(), event.getToUserName(), autoReply);
		
		return replyMsg;
	}
	
	@Override
	@Transactional(readOnly = false)
	public void eUnSub(BasicEvent event) {
		// 用户退订，查找最后一条订阅记录（应为未退订状态，即退订时间为空），并更新退订时间字段
		subscribeRecordService.cancelByOpenid(event.getToUserName(), event.getFromUserName());
	}

	@Override
	public BasicMsg eScan(ScanEvent event) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void eLocation(LocationEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public BasicMsg eScanCodePush(ScanCodeEvent event) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BasicMsg eScanCodeWait(ScanCodeEvent event) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BasicMsg ePicSysPhoto(SendPhotosEvent event) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BasicMsg ePicPhotoOrAlbum(SendPhotosEvent event) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BasicMsg ePicWeixin(SendPhotosEvent event) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BasicMsg eLocationSelect(SendLocationInfoEvent event) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void eSentTmplJobFinish(SentTmlJobEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void eSentAllJobFinish(SentAllJobEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void eCreateKfSession(CustomServiceEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void eCloseKfSession(CustomServiceEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void eSwitchKfSession(CustomServiceEvent event) {
		// TODO Auto-generated method stub
		
	}
	
}
