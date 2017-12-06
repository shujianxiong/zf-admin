/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ip;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.lgt.dao.ip.InventoryMissionDao;
import com.chinazhoufan.admin.modules.lgt.dao.ip.InventoryRecordDao;
import com.chinazhoufan.admin.modules.lgt.entity.ip.InventoryMission;
import com.chinazhoufan.admin.modules.lgt.entity.ip.InventoryRecord;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareplaceService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 盘点任务Service
 * @author 张金俊
 * @version 2016-03-17
 */
@Service
@Transactional(readOnly = true)
public class InventoryMissionService extends CrudService<InventoryMissionDao, InventoryMission> {

	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private InventoryRecordDao inventoryRecordDao;
	@Autowired
	private WareplaceService wareplaceService;
	
	public InventoryMission get(String id) {
		return super.get(id);
	}
	
	/**
	 * 查询盘点任务详细数据（包含盘点任务数据、盘点明细记录数据及相关数据）
	 * @param id
	 * @return
	 */
	public InventoryMission getInfo(String id) {
		return dao.getInfo(id, null);
	}
	
	/**
	 * 查询（当前登录人的）盘点任务详细数据（包含盘点任务数据、盘点明细记录数据及相关数据）<过滤盘点人非该登录人的明细>
	 * @param id
	 * @return
	 */
	public InventoryMission getInfoForCurrent(String id) {
		String inventoryUserId = UserUtils.getUser().getId();
		return dao.getInfo(id, inventoryUserId);
	}
	
	public List<InventoryMission> findList(InventoryMission inventoryMission) {
		return super.findList(inventoryMission);
	}
	
	public Page<InventoryMission> findPage(Page<InventoryMission> page, InventoryMission inventoryMission) {
		return super.findPage(page, inventoryMission);
	}
	
	/**
	 * 查询（当前登录人的）非新建状态的盘点任务<包含的明细中盘点人有该登录人>
	 * @param page
	 * @param inventoryMission
	 * @return
	 */
	public Page<InventoryMission> findPageNotNewForCurrent(Page<InventoryMission> page, InventoryMission inventoryMission) {
		inventoryMission.setPage(page);
		String inventoryUserId = UserUtils.getUser().getId();
		if(StringUtils.isEmpty(inventoryUserId)){
			page.setList(new ArrayList<InventoryMission>());
		}else{
			page.setList(dao.findPageNotNewForInventoryUser(inventoryMission, inventoryUserId));			
		}
		return page;
	}
	
	/**
	 * 新增or保存盘点任务及盘点明细
	 * @param submitType 保存类型（save：保存	submit：提交）
	 * @param inventoryMission
	 */
	@Transactional(readOnly = false)
	public void save(String submitType, InventoryMission inventoryMission) {
		if(StringUtils.isEmpty(inventoryMission.getId())){
			// 新增盘点任务
			inventoryMission.setBatchNo(codeGeneratorService.generateCode("lgt_ip_inventory_mission_batchno"));
		}
		if("save".equals(submitType)){
			inventoryMission.setStatus(InventoryMission.STATUS_NEW);			// 任务新建				
		}else {
			inventoryMission.setStatus(InventoryMission.STATUS_INVENTORYING);	// 任务盘点中
			inventoryMission.setStartTime(new Date());
		}
		super.save(inventoryMission);
		
		// 新增or更新盘点明细
		for (InventoryRecord inventoryRecord : inventoryMission.getInventoryRecordList()){
			if (StringUtils.isBlank(inventoryRecord.getId())){
				// 新增
				inventoryRecord.setInventoryMission(inventoryMission);
				if("save".equals(submitType)){
					inventoryRecord.setStatus(InventoryRecord.STATUS_NEW);			// 新建明细记录					
				}else {
					inventoryRecord.setStatus(InventoryRecord.STATUS_INVENTORYING);	// 明细盘点中	
					// 锁定货位
					inventoryRecord.getWareplace().setLockFlag("1");
					wareplaceService.updateLockFlag(inventoryRecord.getWareplace());
				}
				// 实时获取货位对应存货数量
				Integer systemNum = wareplaceService.findProductsCountByWareplaceId(inventoryRecord.getWareplace().getId());
				inventoryRecord.setSystemNum(systemNum);
				inventoryRecord.preInsert();
				inventoryRecordDao.insert(inventoryRecord);
			}else{
				if (InventoryRecord.DEL_FLAG_NORMAL.equals(inventoryRecord.getDelFlag())){
					// 更新
					if("save".equals(submitType)){
						inventoryRecord.setStatus(InventoryRecord.STATUS_NEW);			// 新建明细记录					
					}else {
						inventoryRecord.setStatus(InventoryRecord.STATUS_INVENTORYING);	// 明细盘点中
						// 锁定货位
						inventoryRecord.getWareplace().setLockFlag(Wareplace.LOCKFLAG_LOCKED);
						wareplaceService.updateLockFlag(inventoryRecord.getWareplace());
					}
					inventoryRecord.preUpdate();
					inventoryRecordDao.update(inventoryRecord);
				}else{
					// （物理）删除盘点记录
					inventoryRecordDao.remove(inventoryRecord);
				}
			}
		}
	}
	
	/**
	 * 保存盘点任务及盘点明细（执行）
	 * @param inventoryMission
	 */
	@Transactional(readOnly = false)
	public void saveExe(InventoryMission inventoryMission) {
		for(InventoryRecord inventoryRecordTemp : inventoryMission.getInventoryRecordList()){
			if(inventoryRecordTemp.getInventoryNum()!=null){
				// 更新盘点明细
				InventoryRecord inventoryRecord = inventoryRecordDao.get(inventoryRecordTemp.getId());
				inventoryRecord.setInventoryNum(inventoryRecordTemp.getInventoryNum());
				inventoryRecord.setInventoryRemarks(inventoryRecordTemp.getInventoryRemarks());
				inventoryRecord.setStatus(InventoryRecord.STATUS_FINISHED);
				if(inventoryRecord.getInventoryNum()==inventoryRecord.getSystemNum()){
					inventoryRecord.setResultType(InventoryRecord.RESULTTYPE_NORMAL);
				}else if(inventoryRecord.getInventoryNum()<inventoryRecord.getSystemNum()){
					inventoryRecord.setResultType(InventoryRecord.RESULTTYPE_LESS);
				}else {
					inventoryRecord.setResultType(InventoryRecord.RESULTTYPE_MORE);
				}
				inventoryRecord.preUpdate();
				inventoryRecordDao.update(inventoryRecord);
				// 解锁货位
				inventoryRecord.getWareplace().setLockFlag(Wareplace.LOCKFLAG_UNLOCKED);
				wareplaceService.updateLockFlag(inventoryRecord.getWareplace());
			}
		}
		
		// 判断盘点任务是否完成
		InventoryRecord irParam = new InventoryRecord();
		irParam.setInventoryMission(inventoryMission);
		List<InventoryRecord> inventoryRecordList = inventoryRecordDao.findList(irParam);
		boolean allRecordFinishedFlag = true;		// （任务所有明细）盘点完成标记
		boolean resultTypeNormalFlag = true;		// （任务所有明细）盘点结果标记
		for(InventoryRecord inventoryRecordTemp : inventoryRecordList){
			if(!InventoryRecord.STATUS_FINISHED.equals(inventoryRecordTemp.getStatus())){
				allRecordFinishedFlag = false;
			}
			if(!InventoryRecord.RESULTTYPE_NORMAL.equals(inventoryRecordTemp.getResultType())){
				resultTypeNormalFlag = false;
			}
		}
		if(allRecordFinishedFlag){
			// 更新任务状态及盘点结果
			inventoryMission.setStatus(InventoryMission.STATUS_FINISHED);
			if(resultTypeNormalFlag){
				inventoryMission.setResultType(InventoryMission.RESULTTYPE_NORMAL);
			}else{
				inventoryMission.setResultType(InventoryMission.RESULTTYPE_EXCEPTION);
			}
			inventoryMission.setEndTime(new Date());
			inventoryMission.preUpdate();
			dao.update(inventoryMission);
		}
	}
	
	/**
	 * （物理）删除盘点任务及任务下明细记录
	 */
	@Transactional(readOnly = false)
	public void delete(InventoryMission inventoryMission) {
		// 物理删除盘点任务
		dao.remove(inventoryMission);
		// 物理删除盘点明细记录
		inventoryRecordDao.removeByInventoryMissionId(inventoryMission.getId());
	}
	
}