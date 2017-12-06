/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.wp;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.wp.WechatPayConfig;
import com.chinazhoufan.admin.modules.bus.dao.wp.WechatPayConfigDao;

/**
 * 微信支付配置表Service
 * @author liut
 * @version 2017-05-08
 */
@Service
@Transactional(readOnly = true)
public class WechatPayConfigService extends CrudService<WechatPayConfigDao, WechatPayConfig> {

	public WechatPayConfig get(String id) {
		return super.get(id);
	}
	
	public List<WechatPayConfig> findList(WechatPayConfig wechatPayConfig) {
		return super.findList(wechatPayConfig);
	}
	
	public Page<WechatPayConfig> findPage(Page<WechatPayConfig> page, WechatPayConfig wechatPayConfig) {
		return super.findPage(page, wechatPayConfig);
	}
	
	@Transactional(readOnly = false)
	public void save(WechatPayConfig wechatPayConfig) {
		super.save(wechatPayConfig);
	}
	
	@Transactional(readOnly = false)
	public void delete(WechatPayConfig wechatPayConfig) {
		super.delete(wechatPayConfig);
	}
	
}