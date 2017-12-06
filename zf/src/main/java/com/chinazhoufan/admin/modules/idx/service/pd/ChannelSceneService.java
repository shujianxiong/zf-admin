/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.pd;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.pd.ChannelScene;
import com.chinazhoufan.admin.modules.idx.dao.pd.ChannelSceneDao;

/**
 * 频道场景关联Service
 * @author liuxiaodong
 * @version 2017-09-21
 */
@Service
@Transactional(readOnly = true)
public class ChannelSceneService extends CrudService<ChannelSceneDao, ChannelScene> {

	public ChannelScene get(String id) {
		return super.get(id);
	}
	
	public List<ChannelScene> findList(ChannelScene channelScene) {
		return super.findList(channelScene);
	}
	
	public Page<ChannelScene> findPage(Page<ChannelScene> page, ChannelScene channelScene) {
		return super.findPage(page, channelScene);
	}
	
	@Transactional(readOnly = false)
	public void save(ChannelScene channelScene) {
		super.save(channelScene);
	}
	
	@Transactional(readOnly = false)
	public void delete(ChannelScene channelScene) {
		super.delete(channelScene);
	}
	
}