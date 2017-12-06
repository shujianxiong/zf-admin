package com.chinazhoufan.mobile.wechat.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.mpsdk4j.vo.api.Menu;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.Article;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.BasicMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.ImageMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.NewsMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.TextMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.VideoMsg;
import com.chinazhoufan.admin.common.mpsdk4j.vo.message.VoiceMsg;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ArticleMsg;
import com.chinazhoufan.admin.modules.wcp.entity.ar.AutoReply;
import com.chinazhoufan.admin.modules.wcp.entity.ar.MsgRecord;
import com.chinazhoufan.admin.modules.wcp.service.ar.MsgRecordService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;

@Service
@Transactional(readOnly = true)
public class WeiXinService {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private MsgRecordService msgRecordService;
	
	public static final String PROGRAM_PUBLIC_PATH 		= Global.getConfig("qiniu.website");	// 项目外网路径（用于拼接图片地址）

	
	/**
	 * 创建菜单
	 * @param menu
	 * @return
	 */
	public String createMenu(Menu menu) {
		return null;
	};
	
	/**
	 * 根据用户发送的消息、对应的系统自动回复消息，封装回复对象
	 * @param fromUserName	用户openid
	 * @param toUserName	公众号id
	 * @param autoReply		系统设置的自动回复消息
	 * @return
	 */
	public BasicMsg packageReplyMsgByAutoReply(String fromUserName, String toUserName, AutoReply autoReply){
		// 根据自动回复的回复内容类型，封装要返回的回复消息
		switch (autoReply.getContentType()) {
		case AutoReply.CONTENT_TYPE_TEXT:
			// 回复内容类型：文字
			TextMsg textMsg = new TextMsg();
			textMsg.setFromUserName(fromUserName);
			textMsg.setToUserName(toUserName);
			textMsg.setContent(autoReply.getText().replace("'", "\""));
			return textMsg;
		case AutoReply.CONTENT_TYPE_IMG:
			// 回复内容类型：图片
			ImageMsg imageMsg = new ImageMsg();
			imageMsg.setFromUserName(fromUserName);
			imageMsg.setToUserName(toUserName);
			imageMsg.setMediaId(autoReply.getImage());
			return imageMsg;
		case AutoReply.CONTENT_TYPE_VOICE:
			// 回复内容类型：音频
			VoiceMsg voiceMsg = new VoiceMsg();
			voiceMsg.setFromUserName(fromUserName);
			voiceMsg.setToUserName(toUserName);
			voiceMsg.setMediaId(autoReply.getVoice());
			return voiceMsg;
		case AutoReply.CONTENT_TYPE_VIDEO:
			// 回复内容类型：视频
			VideoMsg videoMsg = new VideoMsg();
			videoMsg.setFromUserName(fromUserName);
			videoMsg.setToUserName(toUserName);
			videoMsg.setMediaId(autoReply.getVideo());
			videoMsg.setTitle(autoReply.getName());
			videoMsg.setDescription(autoReply.getRemarks());
			return videoMsg;
		case AutoReply.CONTENT_TYPE_NEWS:
			// 回复内容类型：图文
			NewsMsg newsMsg = new NewsMsg();
			newsMsg.setFromUserName(fromUserName);
			newsMsg.setToUserName(toUserName);
			List<Article> articleList = new ArrayList<Article>();
			for(ArticleMsg articleMsg : autoReply.getArticleMsgList()){
				Article article = new Article();
				article.setTitle(articleMsg.getTitle());
				article.setDescription(articleMsg.getDescription());
				article.setPicUrl(PROGRAM_PUBLIC_PATH + articleMsg.getPic());
				article.setUrl(articleMsg.getLinkUrl());
				articleList.add(article);
			}
			newsMsg.setArticles(articleList);
			return newsMsg;
		default:
			return null;
		}
	}
	
	/**
	 * 保存用户发送过来的消息记录
	 * @param msg
	 */
	@Transactional(readOnly = false)
	public void saveMsgRecordForSend(BasicMsg msg){
		Member member = memberService.getByOpenid(msg.getFromUserName());
		if(member==null){
			logger.error("[error code "+Constants.WECHATRECORD_SAVE_ERROR+"]", "保存用户聊天记录未能获取到用户");
			return;
		}
		MsgRecord msgRecord = new MsgRecord();
		msgRecord.setPlatformType(MsgRecord.PLATFORMTYPE_WC);
		msgRecord.setSendType(MsgRecord.SENDTYPE_SEND);
		msgRecord.setReplyType(null);
		msgRecord.setFromUserName(msg.getFromUserName());
		msgRecord.setFromUserId(member.getId());
		msgRecord.setToUserName(msg.getToUserName());
		msgRecord.setToUserId(null);
		
		if(msg instanceof TextMsg){
			msgRecord.setContentType(AutoReply.CONTENT_TYPE_TEXT);
			msgRecord.setContent(((TextMsg)msg).getContent());
		}else if(msg instanceof ImageMsg){
			msgRecord.setContentType(AutoReply.CONTENT_TYPE_IMG);
			msgRecord.setContent(((ImageMsg)msg).getPicUrl());
		}else if(msg instanceof VoiceMsg){
			msgRecord.setContentType(AutoReply.CONTENT_TYPE_VOICE);
			msgRecord.setContent(((VoiceMsg)msg).getMediaId());
		}else if(msg instanceof VideoMsg){
			msgRecord.setContentType(AutoReply.CONTENT_TYPE_VIDEO);
			msgRecord.setContent(((VideoMsg)msg).getMediaId());
		}else {
			msgRecord.setContentType(AutoReply.CONTENT_TYPE_UNDEFINED);
			msgRecord.setContent(null);
		}
		msgRecordService.save(msgRecord);
	}
	
	
	/**
	 * 保存（系统）回复的消息记录
	 * @param fromUserName	用户openid
	 * @param toUserName	公众号id
	 * @param autoReply		系统回复信息
	 */
	@Transactional(readOnly = false)
	public void saveMsgRecordForReply(String fromUserName, String toUserName, AutoReply autoReply){
		MsgRecord msgRecord = new MsgRecord();
		msgRecord.setPlatformType(MsgRecord.PLATFORMTYPE_WC);
		msgRecord.setSendType(MsgRecord.SENDTYPE_REPLY);
		msgRecord.setReplyType(MsgRecord.REPLYTYPE_S);
		msgRecord.setFromUserName(toUserName);		// 发送人微信ID，为用户发送消息的接收方（公众号ID）
		msgRecord.setFromUserId(null);
		msgRecord.setToUserName(fromUserName);		// 接收人微信ID，为用户openid
		Member member = memberService.getByOpenid(fromUserName);
		msgRecord.setToUserId(member!=null ? member.getId() : null);
		msgRecord.setContentType(AutoReply.CONTENT_TYPE_TEXT);
		
		switch (autoReply.getContentType()) {
		case AutoReply.CONTENT_TYPE_TEXT:
			// 回复内容类型：文字
			msgRecord.setContent(autoReply.getText());
			break;
		case AutoReply.CONTENT_TYPE_IMG:
			// 回复内容类型：图片
			msgRecord.setContent(PROGRAM_PUBLIC_PATH + autoReply.getImage());
			break;
		default:
			break;
		}
		
		msgRecord.setAutoReply(autoReply);
		msgRecordService.save(msgRecord);
	}
}
