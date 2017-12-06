/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.service.ar;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.wcp.dao.ar.MsgRecordDao;
import com.chinazhoufan.admin.modules.wcp.entity.ar.MsgRecord;

/**
 * 消息发送记录Service
 * @author 张金俊
 * @version 2016-05-30
 */
@Service
@Transactional(readOnly = true)
public class MsgRecordService extends CrudService<MsgRecordDao, MsgRecord> {

	public MsgRecord get(String id) {
		return super.get(id);
	}
	
	public List<MsgRecord> findList(MsgRecord msgRecord) {
		return super.findList(msgRecord);
	}
	
	public Page<MsgRecord> findPage(Page<MsgRecord> page, MsgRecord msgRecord) {
		return super.findPage(page, msgRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(MsgRecord msgRecord) {
		super.save(msgRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(MsgRecord msgRecord) {
		super.delete(msgRecord);
	}
	
}