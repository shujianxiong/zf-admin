/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.wp;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatRefundRecord;
import com.chinazhoufan.admin.modules.bus.dao.wp.WechatRefundRecordDao;

/**
 * 微信退款记录Service
 * @author 舒剑雄
 * @version 2017-09-06
 */
@Service
@Transactional(readOnly = true)
public class WechatRefundRecordService extends CrudService<WechatRefundRecordDao, WechatRefundRecord> {

	public WechatRefundRecord get(String id) {
		return super.get(id);
	}
	
	public List<WechatRefundRecord> findList(WechatRefundRecord wechatRefundRecord) {
		return super.findList(wechatRefundRecord);
	}
	
	public Page<WechatRefundRecord> findPage(Page<WechatRefundRecord> page, WechatRefundRecord wechatRefundRecord) {
		return super.findPage(page, wechatRefundRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(WechatRefundRecord wechatRefundRecord) {
		super.save(wechatRefundRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(WechatRefundRecord wechatRefundRecord) {
		super.delete(wechatRefundRecord);
	}
	
}