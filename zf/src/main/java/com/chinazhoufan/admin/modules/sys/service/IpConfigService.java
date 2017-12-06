/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.sys.dao.IpConfigDao;
import com.chinazhoufan.admin.modules.sys.entity.IpConfig;
import com.chinazhoufan.admin.modules.sys.utils.IpConfigUtils;

/**
 * IP白名单管理Service
 * @author 陈适
 * @version 2015-11-20
 */
@Service
@Transactional(readOnly = true)
public class IpConfigService extends CrudService<IpConfigDao, IpConfig> {

	public IpConfig get(String id) {
		return super.get(id);
	}
	
	public List<IpConfig> findList(IpConfig ipConfig) {
		return super.findList(ipConfig);
	}
	
	public Page<IpConfig> findPage(Page<IpConfig> page, IpConfig ipConfig) {
		return super.findPage(page, ipConfig);
	}
	
	@Transactional(readOnly = false)
	public void save(IpConfig ipConfig) {
		if (StringUtils.isBlank(ipConfig.getId())){
			ipConfig.preInsert();
			dao.insert(ipConfig);
			IpConfigUtils.addIpConfig(ipConfig);
		}else{
			dao.update(ipConfig);
			if(IpConfig.TRUE_FLAG.equals( ipConfig.getActiveFlag())){  //启用就更新缓存   关闭就删除缓存
				IpConfigUtils.updateIpConfig(ipConfig);
			}else {
				IpConfigUtils.deleteIpConfig(ipConfig);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(IpConfig ipConfig) {
		super.delete(ipConfig);
		IpConfigUtils.deleteIpConfig(ipConfig);
	}

	@Transactional(readOnly = false)
	public void update(IpConfig ipConfig) {
		ipConfig.preUpdate();
		dao.update(ipConfig);
	}
	
	public boolean getUniqueByIP(String ip) {
		int c = dao.getUniqueByIP(ip);
		return c == 0 ? true : false;
	}
	
}