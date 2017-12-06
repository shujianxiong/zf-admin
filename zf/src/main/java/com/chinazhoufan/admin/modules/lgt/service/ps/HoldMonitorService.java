/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.lgt.dao.ps.HoldMonitorDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.HoldMonitorDetailDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.HoldMonitor;
import com.chinazhoufan.admin.modules.lgt.entity.ps.HoldMonitorDetail;

/**
 * 货品持有监控管理Service
 * @author 刘晓东
 * @version 2015-10-15
 */
@Service
@Transactional(readOnly = true)
public class HoldMonitorService extends CrudService<HoldMonitorDao, HoldMonitor> {

	@Autowired
	private HoldMonitorDetailDao holdMonitorDetailDao;
	
	public HoldMonitor get(String id) {
		HoldMonitor holdMonitor = super.get(id);
		holdMonitor.setHoldMonitorDetailList(holdMonitorDetailDao.findList(new HoldMonitorDetail(holdMonitor)));
		return holdMonitor;
	}
	
	public List<HoldMonitor> findList(HoldMonitor holdMonitor) {
		return super.findList(holdMonitor);
	}
	
	public Page<HoldMonitor> findPage(Page<HoldMonitor> page, HoldMonitor holdMonitor) {
		return super.findPage(page, holdMonitor);
	}
	
	@Transactional(readOnly = false)
	public void save(HoldMonitor holdMonitor) {
		super.save(holdMonitor);
		for (HoldMonitorDetail holdMonitorDetail : holdMonitor.getHoldMonitorDetailList()){
			if (holdMonitorDetail.getId() == null){
				continue;
			}
			if (holdMonitorDetail.DEL_FLAG_NORMAL.equals(holdMonitorDetail.getDelFlag())){
				if (StringUtils.isBlank(holdMonitorDetail.getId())){
					holdMonitorDetail.setHoldMonitor(holdMonitor);
					holdMonitorDetail.preInsert();
					holdMonitorDetailDao.insert(holdMonitorDetail);
				}else{
					holdMonitorDetail.preUpdate();
					holdMonitorDetailDao.update(holdMonitorDetail);
				}
			}else{
				holdMonitorDetailDao.delete(holdMonitorDetail);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(HoldMonitor holdMonitor) {
		super.delete(holdMonitor);
		holdMonitorDetailDao.delete(new HoldMonitorDetail(holdMonitor));
	}
	
}