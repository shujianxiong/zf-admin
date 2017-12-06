/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.dp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.dao.BasMissionDao;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchMissionDao;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchOrderDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchMission;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchOrder;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 调货单Service
 * @author 贾斌
 * @version 2016-03-16
 */
@Service
@Transactional(readOnly = true)
public class DispatchOrderService extends CrudService<DispatchOrderDao, DispatchOrder> {

	@Autowired
	private DispatchMissionDao dispatchMissionDao;
	@Autowired
	private BasMissionDao<DispatchMission> basMissionDao;
	public DispatchOrder get(String id) {
		return super.get(id);
	}
	
	public List<DispatchOrder> findList(DispatchOrder dispatchOrder) {
		return super.findList(dispatchOrder);
	}
	
	public Page<DispatchOrder> findPage(Page<DispatchOrder> page, DispatchOrder dispatchOrder) {
		return super.findPage(page, dispatchOrder);
	}
	
	public Page<DispatchOrder> findPageUser(Page<DispatchOrder> page, DispatchOrder dispatchOrder) {
		dispatchOrder.setOutUser(UserUtils.getUser());//根据系统当前的用户查询
		return super.findPage(page, dispatchOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(DispatchOrder dispatchOrder) {
		super.save(dispatchOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(DispatchOrder dispatchOrder) {
		super.delete(dispatchOrder);
	}
	
	public int getCompleteDispatchOrderByMissionId(String dispatchMissionId) {
		return dao.getCompleteDispatchOrderByMissionId(dispatchMissionId);
	}
	
	public DispatchOrder getDispatchOrderWithGoodsDetail(DispatchOrder dispatchOrder) {
		return dao.getDispatchOrderWithGoodsDetail(dispatchOrder);
	}
	
	
	//-----------------我的调拨单查询---------------------
	
	/**
	 * 调入
	 * @param dispatchOrder
	 * @return
	 */
	public Page<DispatchOrder> callInList(Page<DispatchOrder> page, DispatchOrder dispatchOrder) {
		DispatchMission dm = new DispatchMission();
		dm.setInUser(UserUtils.getUser());
		dispatchOrder.setDispatchMission(dm);
		dispatchOrder.setOrderStatus(DispatchOrder.ORDERSTATUS_WAITCALLIN);
		List<DispatchOrder> list =  dao.callInList(dispatchOrder);
		dispatchOrder.setPage(page);
		page.setList(list);
		return page;
	}
	
	/**
	 * 调出
	 * @param dispatchOrder
	 * @return
	 */
	public Page<DispatchOrder> callOutList(Page<DispatchOrder> page, DispatchOrder dispatchOrder) {
		dispatchOrder.setOutUser(UserUtils.getUser());//根据系统当前的用户查询
		List<DispatchOrder> list = dao.callOutList(dispatchOrder);
		dispatchOrder.setPage(page);
		page.setList(list);
		return page;
	}
	
	/**
	 * 待入库
	 * @param dispatchOrder
	 * @return
	 */
	public Page<DispatchOrder> pendingStockList(Page<DispatchOrder> page, DispatchOrder dispatchOrder) {
		DispatchMission dm = new DispatchMission();
		dm.setInUser(UserUtils.getUser());
		dispatchOrder.setDispatchMission(dm);
		dispatchOrder.setOrderStatus(DispatchOrder.ORDERSTATUS_PENDINGSTOCK);
		List<DispatchOrder> list =  dao.pendingStockList(dispatchOrder);
		dispatchOrder.setPage(page);
		page.setList(list);
		return page;
	}
		
	//-----------------我的调拨单查询---------------------
	
}