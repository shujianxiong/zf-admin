/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.msg.service.um;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.msg.dao.um.MessageConfigDao;
import com.chinazhoufan.admin.modules.msg.entity.um.MessageConfig;

/**
 * 员工消息发送设置Service
 * @author 刘晓东
 * @version 2015-12-11
 */
@Service
@Transactional(readOnly = true)
public class MessageConfigService extends CrudService<MessageConfigDao, MessageConfig> {

	public MessageConfig get(String id) {
		return super.get(id);
	}
	
	public List<MessageConfig> findList(MessageConfig messageConfig) {
		return super.findList(messageConfig);
	}
	
	public Page<MessageConfig> findPage(Page<MessageConfig> page, MessageConfig messageConfig) {
		return super.findPage(page, messageConfig);
	}
	
	@Transactional(readOnly = false)
	public void save(MessageConfig messageConfig) {
		super.save(messageConfig);
	}
	
	@Transactional(readOnly = false)
	public void delete(MessageConfig messageConfig) {
		super.delete(messageConfig);
	}

	@Transactional(readOnly = false)
	public void enable(MessageConfig messageConfig) {
		messageConfig.setUsableFlag(MessageConfig.TRUE_FLAG);
		messageConfig.preUpdate();
		dao.update(messageConfig);
	}

	@Transactional(readOnly = false)
	public void disable(MessageConfig messageConfig) {
		messageConfig.setUsableFlag(MessageConfig.FALSE_FLAG);
		messageConfig.preUpdate();
		dao.update(messageConfig);
	}
	
}