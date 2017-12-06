/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.wp;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPrepayRecord;
import com.chinazhoufan.admin.modules.bus.dao.wp.WechatPrepayRecordDao;

/**
 * 微信预支付记录Service
 * @author 张金俊
 * @version 2017-05-26
 */
@Service
@Transactional(readOnly = true)
public class WechatPrepayRecordService extends CrudService<WechatPrepayRecordDao, WechatPrepayRecord> {

	public WechatPrepayRecord get(String id) {
		return super.get(id);
	}
	
	public List<WechatPrepayRecord> findList(WechatPrepayRecord wechatPrepayRecord) {
		return super.findList(wechatPrepayRecord);
	}
	
	public Page<WechatPrepayRecord> findPage(Page<WechatPrepayRecord> page, WechatPrepayRecord wechatPrepayRecord) {
		return super.findPage(page, wechatPrepayRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(WechatPrepayRecord wechatPrepayRecord) {
		super.save(wechatPrepayRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(WechatPrepayRecord wechatPrepayRecord) {
		super.delete(wechatPrepayRecord);
	}
	
}