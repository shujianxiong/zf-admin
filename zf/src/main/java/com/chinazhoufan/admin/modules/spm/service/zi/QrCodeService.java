/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.zi;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import com.chinazhoufan.admin.common.mpsdk4j.api.WechatAPIImpl;
import com.chinazhoufan.admin.common.mpsdk4j.vo.api.QRTicket;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.mobile.wechat.web.WeiXinConfig;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.zi.QrCode;
import com.chinazhoufan.admin.modules.spm.dao.zi.QrCodeDao;

/**
 * 二维码管理配置Service
 * @author 舒剑雄
 * @version 2017-09-25
 */
@Service
@Transactional(readOnly = true)
public class QrCodeService extends CrudService<QrCodeDao, QrCode> {

	private  static  String qrBaseUrl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=";

	public QrCode get(String id) {
		return super.get(id);
	}
	
	public List<QrCode> findList(QrCode qrCode) {
		return super.findList(qrCode);
	}
	
	public Page<QrCode> findPage(Page<QrCode> page, QrCode qrCode) {
		return super.findPage(page, qrCode);
	}
	
	@Transactional(readOnly = false)
	public void save(QrCode qrCode) {
		if(qrCode.getId() == null || qrCode.getId().equals("")){
			//新增二维码配置
			WechatAPIImpl wechatAPIImpl=WechatAPIImpl.create(WeiXinConfig.getAccountConfig(WeiXinConfig.ACCOUNT_D_S));
			//参数设置随机
			qrCode.setRandomCode(UUID.randomUUID().toString());
			QRTicket qrTicket = wechatAPIImpl.createQR(qrCode.getRandomCode(),0);
			qrCode.setActiveFlag("1");
			qrCode.setFollowTimes(0);
			try {
				if(qrTicket != null){
					String ticket = java.net.URLEncoder.encode(qrTicket.getTicket(),"UTF-8");
					qrCode.setQrCode(qrBaseUrl+ticket);
					super.save(qrCode);
				}
			}catch (IOException e){
				throw new ServiceException("进行UrlEncode返回说明错误！");
			}

		}else{
			super.save(qrCode);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(QrCode qrCode) {
		super.delete(qrCode);
	}

	@Transactional(readOnly = false)
	public void updateByRandomCode(String openId , String randomCode) {
		openId = openId+",";
		dao.updateByRandomCode(openId,randomCode);
	}
	
}