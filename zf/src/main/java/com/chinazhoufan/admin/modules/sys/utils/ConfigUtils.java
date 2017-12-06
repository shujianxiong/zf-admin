/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.utils;

import java.util.Map;

import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.utils.JsonUtils;
import com.chinazhoufan.admin.common.utils.SpringContextHolder;
import com.chinazhoufan.admin.modules.sys.dao.ConfigDao;
import com.chinazhoufan.admin.modules.sys.entity.Config;
import com.google.common.collect.Maps;

/**
 * 业务参数工具类（张金俊）
 * @author ThinkGem
 * @version 2013-5-29（2016-12-05 修改为取redis缓存或数据库）
 */
public class ConfigUtils {
	
	private static ConfigDao configDao = SpringContextHolder.getBean(ConfigDao.class);
	private static RedisCacheService<String,Map<String, String>> configMapRedisCacheService = SpringContextHolder.getBean(RedisCacheService.class);

	public static final String CONFIG_WEIGHT_FLOAT_PERMIT = "weightFloatPermit ";	// config编码：克重允许浮动大小
	
	/**
	 * 根据业务参数编码获取对应的业务参数
	 * @param code
	 * @return
	 */
	public static Config getConfig(String code){
		// 从REDIS缓存中取业务编码集合
		Map<String, String> configMap = configMapRedisCacheService.get(RedisCacheService.CONFIG_MAP_KEY);			
		
		if (configMap == null){
			// 缓存中无数据，则从数据库中查询所有业务参数，并缓存
			configMap = Maps.newHashMap();
			for (Config config : configDao.findAllList(new Config())){
				configMap.put(config.getCode(), JsonUtils.toJson(config, Config.class));
			}
			configMapRedisCacheService.set(RedisCacheService.CONFIG_MAP_KEY, configMap);
		}else {
			if (configMap.get(code) == null) {
				// 缓存中有数据，但无当前编码对应数据，则从数据库中查询当前编码数据并添加到缓存
				for (Config config : configDao.findAllList(new Config())){
					if (config.getCode().equals(code)) {
						configMap.put(config.getCode(), JsonUtils.toJson(config, Config.class));
						break;
					}else {
						continue;
					}
				}
				configMapRedisCacheService.set(RedisCacheService.CONFIG_MAP_KEY, configMap);
			}
		}
		
		Config config = (Config)JsonUtils.fromJson(configMap.get(code), Config.class);
		return config != null ? config : new Config();
	}
}
