/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.sl;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.emay.SendMsgUtil;
import com.chinazhoufan.admin.common.mpsdk4j.api.WechatAPIImpl;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.modules.crm.dao.sl.SmsLinkDao;
import com.chinazhoufan.admin.modules.crm.entity.sl.SmsLink;
import com.chinazhoufan.admin.modules.spm.dao.ss.SendSmsDao;
import com.chinazhoufan.admin.modules.spm.entity.ss.SendSms;
import com.chinazhoufan.mobile.wechat.web.WeiXinConfig;

/**
 * 短信链接模块Service
 * @author 舒剑雄
 * @version 2017-09-26
 */
@Service
@Transactional(readOnly = true)
public class SmsLinkService extends CrudService<SmsLinkDao, SmsLink> {

	@Autowired
	private SendSmsDao sendSmsDao;

	private static Integer MAX_SEND =200;//一次最大群发量

	private static String URL_PARAM ="?sms=";//一次最大群发量

	public SmsLink get(String id) {
		return super.get(id);
	}
	
	public List<SmsLink> findList(SmsLink smsLink) {
		return super.findList(smsLink);
	}
	
	public Page<SmsLink> findPage(Page<SmsLink> page, SmsLink smsLink) {
		return super.findPage(page, smsLink);
	}
	
	@Transactional(readOnly = false)
	public void save(SmsLink smsLink) {
		if(smsLink.getClickRate() == null){
			smsLink.setClickRate(0);
		}
		if(smsLink.getId().equals("")){
			//参数设置随机
			smsLink.setParameter(UUID.randomUUID().toString());
		}
		super.save(smsLink);
	}
	
	@Transactional(readOnly = false)
	public void delete(SmsLink smsLink) {
		super.delete(smsLink);
	}

	@Transactional(readOnly = false)
	public void send(SmsLink smsLink) {
		String content = smsLink.getContext();
		String link = smsLink.getLink()+URL_PARAM+smsLink.getParameter();//带参数的全链接
		//长连接转成短连接
		WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_S));

		String shortUrl = wechatAPIImpl.getShortUrl(link);
		//短信内容转换
		String message = String.format(content, shortUrl);
		if(smsLink.getMemberusercodes() != null && smsLink.getMemberusercodes().length > 0){
			try {
				String memberCodes = "";
				String newCodes = "";
				String result ="";
				String[] memberCodeList = smsLink.getMemberusercodes();
				if (memberCodeList.length > MAX_SEND) {
					for (int i = 0; i < memberCodeList.length; i++) {
						memberCodes = memberCodes + memberCodeList[i] + ",";
						newCodes = newCodes + memberCodeList[i] + ",";
						if ((i + 1) / MAX_SEND == 0) {
							result=SendMsgUtil.send(newCodes, message);
							newCodes = "";
						}
						if ((i + 1) >= memberCodeList.length) {
							result=SendMsgUtil.send(newCodes, message);
						}
					}
				} else {
					for (int i = 0; i < memberCodeList.length; i++) {
						memberCodes = memberCodes + memberCodeList[i] + ",";
					}
					result=SendMsgUtil.send(memberCodes, message);
				}
				logger.info("-----------------短信返回结果："+result);
				if(smsLink.getClickRate() == null){
					smsLink.setClickRate(0);
				}
				if(smsLink.getId() != null){
					SmsLink sms = get(smsLink.getId());
					String memCodes = sms.getMemberCodes()+memberCodes;
					smsLink.setMemberCodes(memCodes);
				}
				save(smsLink);
			}catch (IOException e){
				throw new ServiceException("短信发送失败!");
			}
		}

	}

	@Transactional(readOnly = false)
	public void importSendMsg(SmsLink smsLink, ImportExcel ei) {
		String content = smsLink.getContext();
		String link = smsLink.getLink()+URL_PARAM+smsLink.getParameter();//带参数的全链接
		WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_S));

		String shortUrl = wechatAPIImpl.getShortUrl(link);
		//短信内容转换
		String message = String.format(content, shortUrl);
		
			String result ="";
			String userPhones = "";
				for (int i = 0; i < ei.getLastDataRowNum(); i++) {
					Row row = ei.getRow(i);
					Object val_0 = ei.getCellValue(row, 0);
					if ((""+val_0).indexOf("E")!=-1 || (""+val_0).indexOf("e")!=-1 || (""+val_0).indexOf("+")!=-1) {
			            BigDecimal bd = new BigDecimal(""+val_0);
			            val_0 = bd.toPlainString();
			            
			        }else{
			        	val_0 = "" +  val_0;
			        }
					userPhones +=  val_0 + ",";
					if ((i + 1) / MAX_SEND == 0) {
						try {
							result=SendMsgUtil.send(val_0.toString(), message);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					if ((i + 1) >= ei.getLastDataRowNum()) {
						try {
							result=SendMsgUtil.send(val_0.toString(), message);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					SendSms sendSms = new SendSms();
					String phone = val_0.toString();
					sendSms.setContext(content);
					sendSms.setPhone(phone);
					sendSms.setSendTime(new Date());
					sendSms.setClickRate(0);
					sendSms.setParameter(UUID.randomUUID().toString());
						if ("0".equals(result)){
				             sendSms.setStatus(result);
				             sendSms.preInsert();
				             sendSmsDao.insert(sendSms);
						} else {
							 sendSms.preInsert();
							 sendSms.setStatus(result);
							 sendSmsDao.insert(sendSms);
						}
				}
			logger.info("-----------------短信返回结果："+result);
			if(smsLink.getClickRate() == null){
				smsLink.setClickRate(0);
			}
			if(smsLink.getId() != null){
				SmsLink sms = get(smsLink.getId());
				String memCodes = sms.getMemberCodes()+userPhones;
				smsLink.setMemberCodes(memCodes);
				smsLink.setType(sms.getType());
				smsLink.setActiveFlag(SmsLink.TRUE_FLAG);
			}
			save(smsLink);
		}
		
}