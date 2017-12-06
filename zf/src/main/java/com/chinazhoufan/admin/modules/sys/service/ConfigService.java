/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.sys.dao.ConfigDao;
import com.chinazhoufan.admin.modules.sys.entity.Config;

/**
 * 系统业务参数表Service
 * @author 刘晓东
 * @version 2015-12-21
 */
@Service
@Transactional(readOnly = true)
public class ConfigService extends CrudService<ConfigDao, Config> {

	@Autowired
	private RedisCacheService<String,Map<String,Config>> configRedisCacheService;
	
	public Config get(String id) {
		return super.get(id);
	}
	
	public List<Config> findList(Config config) {
		return super.findList(config);
	}
	
	public Page<Config> findPage(Page<Config> page, Config config) {
		return super.findPage(page, config);
	}
	
	@Transactional(readOnly = false)
	public void save(Config config) {
		super.save(config);
		// 更新config后清除Config的redis缓存
		if(configRedisCacheService.exists(RedisCacheService.CONFIG_MAP_KEY)){
			configRedisCacheService.del(RedisCacheService.CONFIG_MAP_KEY);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Config config) {
		super.delete(config);
	}
	
	public Config  getConfigByCode(Config config) {
		List<Config> list = dao.getConfigByCode(config);
		return list.isEmpty()? null: list.get(0);
	}
	
	
}