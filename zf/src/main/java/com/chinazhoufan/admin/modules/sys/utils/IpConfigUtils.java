package com.chinazhoufan.admin.modules.sys.utils;

import java.util.List;
import java.util.Set;

import com.chinazhoufan.admin.common.utils.CacheUtils;
import com.chinazhoufan.admin.common.utils.SpringContextHolder;
import com.chinazhoufan.admin.modules.sys.dao.IpConfigDao;
import com.chinazhoufan.admin.modules.sys.entity.IpConfig;
import com.google.common.collect.Sets;

public class IpConfigUtils {

	private static IpConfigDao ipConfigDao = SpringContextHolder.getBean(IpConfigDao.class);
	public static final String IP_CACHE = "ipCache";
	public static final String KEY = "ipKey";
	
	
	/**
	 * 判断是否存在白名单IP
	 * @param ip
	 * @return
	 */
	public static boolean checkIp(String ip){
		Set<IpConfig> ipConfigs  = getIpConfigs();
		if(null == ipConfigs)
			return false;
		for(IpConfig ipConfig : ipConfigs){
			if(ipConfig.getIp().equals(ip)){
				return true;
			}
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
	public static Set<IpConfig> getIpConfigs(){
		Set<IpConfig> ipConfigs = (Set<IpConfig>) CacheUtils.get(IP_CACHE, KEY);
		if(null == ipConfigs || ipConfigs.size() == 0){
			List<IpConfig>  list = ipConfigDao.findList(new IpConfig("1")); // 在使用的
			ipConfigs = Sets.newConcurrentHashSet(list);
			if (ipConfigs == null){
				return null;
			}
			CacheUtils.put(IP_CACHE, KEY, ipConfigs);
		}
		return ipConfigs;
	}
	
	/**
	 * 更新缓存
	 * @param ipConfig
	 */
	public static void addIpConfig(IpConfig ipConfig){
		Set<IpConfig> ipConfigs = (Set<IpConfig>) CacheUtils.get(IP_CACHE, KEY);
		if(null != ipConfigs){
			ipConfigs.add(ipConfig);
		}
		CacheUtils.put(IP_CACHE, KEY, ipConfigs);
	}
	
	/**
	 * 根据ip地址比对是否更新
	 * @param ipConfig
	 */
	public static void updateIpConfig(IpConfig ipConfig){
		Set<IpConfig> ipConfigs = (Set<IpConfig>) CacheUtils.get(IP_CACHE, KEY);
		if(null != ipConfigs){
			for(IpConfig ipConf : ipConfigs){
				if(ipConfig.getIp().equals(ipConfig.getIp())){
					ipConfigs.remove(ipConf);
					ipConfigs.add(ipConfig);
					break;
				}
			}
			CacheUtils.put(IP_CACHE, KEY, ipConfigs);
		}
	}

	@SuppressWarnings("unchecked")
	public static void deleteIpConfig(IpConfig ipConfig){
		Set<IpConfig> ipConfigs = (Set<IpConfig>) CacheUtils.get(IP_CACHE, KEY);
		if(null != ipConfigs && ipConfigs.size() > 0){
			for(IpConfig ips : ipConfigs){
				if(ipConfig.getId().equals(ipConfig.getId())){
					ipConfigs.remove(ips);
					break;
				}
			}
			CacheUtils.put(IP_CACHE, KEY, ipConfigs);
		}
	}
}
