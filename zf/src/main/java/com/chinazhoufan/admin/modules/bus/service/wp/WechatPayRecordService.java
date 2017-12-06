/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.wp;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayRecord;
import com.chinazhoufan.admin.modules.bus.dao.wp.WechatPayRecordDao;

/**
 * 微信支付记录Service
 * @author 张金俊
 * @version 2017-05-12
 */
@Service
@Transactional(readOnly = true)
public class WechatPayRecordService extends CrudService<WechatPayRecordDao, WechatPayRecord> {

	public WechatPayRecord get(String id) {
		return super.get(id);
	}
	
	public List<WechatPayRecord> findList(WechatPayRecord wechatPayRecord) {
		return super.findList(wechatPayRecord);
	}
	
	public Page<WechatPayRecord> findPage(Page<WechatPayRecord> page, WechatPayRecord wechatPayRecord) {
		return super.findPage(page, wechatPayRecord);
	}
	
	public Page<WechatPayRecord> findRefundPage(Page<WechatPayRecord> page, WechatPayRecord wechatPayRecord) {
		wechatPayRecord.setPage(page);
		page.setList(dao.findRefundList(wechatPayRecord));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(WechatPayRecord wechatPayRecord) {
		super.save(wechatPayRecord);
	}
	
	/**
	 * 执行人工退款
	 * @param wechatPayRecord
	 */
	@Transactional(readOnly = false)
	public void refundSave(WechatPayRecord wechatPayRecord) {
		wechatPayRecord.setRefundArtificialStatus(WechatPayRecord.STATUS_ARTI_SUCCESS);	// 人工退款状态：已完成
		wechatPayRecord.setRefundArtificialTime(new Date());
		super.save(wechatPayRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(WechatPayRecord wechatPayRecord) {
		super.delete(wechatPayRecord);
	}
	
}