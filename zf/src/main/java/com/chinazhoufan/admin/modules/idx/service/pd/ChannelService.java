/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.pd;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.pd.Channel;
import com.chinazhoufan.admin.modules.idx.entity.pd.ChannelScene;
import com.chinazhoufan.admin.modules.idx.dao.pd.ChannelDao;

/**
 * 频道Service
 * @author 张金俊
 * @version 2016-08-12
 */
@Service
@Transactional(readOnly = true)
public class ChannelService extends CrudService<ChannelDao, Channel> {

	@Autowired
	ChannelSceneService channelSceneService;
	
	public Channel get(String id) {
		return super.get(id);
	}
	
	public List<Channel> findList(Channel channel) {
		return super.findList(channel);
	}
	
	public Page<Channel> findPage(Page<Channel> page, Channel channel) {
		return super.findPage(page, channel);
	}
	
	@Transactional(readOnly = false)
	public void save(Channel channel) {
		super.save(channel);
		//保存关联场景
		if(!channel.getChannelSceneList().isEmpty()){
			for (ChannelScene channelScene : channel.getChannelSceneList()) {
				if (channelScene!=null) {
					if(ChannelScene.TRUE_FLAG.equals(channelScene.getUsableFlag())){
						channelScene.setChannel(channel);
						channelSceneService.save(channelScene);
					}else {
						channelSceneService.delete(channelScene);
					}
				}
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Channel channel) {
		super.delete(channel);
	}

	public Channel getDetail(String id) {
		return dao.getDetail(id);
	}
	
}