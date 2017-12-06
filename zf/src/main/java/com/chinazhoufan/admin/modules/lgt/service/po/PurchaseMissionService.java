/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.po;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseMissionDao;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseMissionDetailDao;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseOrderDao;
import com.chinazhoufan.admin.modules.lgt.dao.po.PurchaseProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseMission;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseMissionDetail;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduce;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 采购任务Service
 * @author 张金俊
 * @version 2016-03-31
 */
@Service
@Transactional(readOnly = true)
public class PurchaseMissionService extends CrudService<PurchaseMissionDao, PurchaseMission> {
	
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private PurchaseMissionDetailDao purchaseMissionDetailDao;
	@Autowired
	private PurchaseOrderDao purchaseOrderDao;
	@Autowired
	private PurchaseProduceDao purchaseProduceDao;
	

	public PurchaseMission get(String id) {
		return super.get(id);
	}
	
	/**
	 * 查询采购任务及任务明细
	 */
	public PurchaseMission getWithDetail(String id) {
		return dao.getWithDetail(id);
	}
	
	/**
	 * 查询采购任务及订单明细
	 */
	public PurchaseMission getWithOrder(String id) {
		return dao.getWithOrder(id);
	}
	
	public List<PurchaseMission> findList(PurchaseMission purchaseMission) {
		return super.findList(purchaseMission);
	}
	
	public Page<PurchaseMission> findPage(Page<PurchaseMission> page, PurchaseMission purchaseMission) {
		return super.findPage(page, purchaseMission);
	}
	
	/**
	 * （采购任务列表）
	 * 保存采购任务
	 * @param purchaseMission
	 */
	@Transactional(readOnly = false)
	public void save(PurchaseMission purchaseMission) {
		purchaseMission.setMissionStatus(PurchaseMission.MISSIONSTATUS_NEW);
		if(purchaseMission.getIsNewRecord()){
			purchaseMission.setBatchNo(codeGeneratorService.generateCode(PurchaseMission.GENERATECODE_BATCHNO));
		}
		super.save(purchaseMission);
		
		List<PurchaseMissionDetail> detailList = purchaseMission.getDetailList();
		for(PurchaseMissionDetail detail : detailList){
			if (StringUtils.isBlank(detail.getId())){
				// 新增
				detail.setPurchaseMission(purchaseMission);
				detail.preInsert();
				purchaseMissionDetailDao.insert(detail);
			}else {
				if(PurchaseMissionDetail.DEL_FLAG_NORMAL.equals(detail.getDelFlag())){
					// 更新
					detail.setPurchaseMission(purchaseMission);
					detail.preUpdate();
					purchaseMissionDetailDao.update(detail);
				}else{
					// （物理）删除
					purchaseMissionDetailDao.remove(detail);
				}
			}
		}
	}
	
	/**
	 * （采购任务列表）
	 * 提交采购任务--待审批
	 * @param purchaseMission
	 */
	@Transactional(readOnly = false)
	public void submit(PurchaseMission purchaseMission) {
		purchaseMission.setMissionStatus(PurchaseMission.MISSIONSTATUS_WAITCHECK);
		purchaseMission.preUpdate();
		dao.update(purchaseMission);
	}
	
	
	/**
	 * （采购任务分单）
	 * 采购任务分单：根据页面提交数据，更新采购任务，生成采购订单&采购产品
	 * @param purchaseMission
	 * PS：	实际完成时间应<=要求完成时间。
	 */
	@Transactional(readOnly = false)
	public void splitSave(PurchaseMission purchaseMission) {
		// 更新采购任务
		purchaseMission.setMissionStatus(PurchaseMission.MISSIONSTATUS_PURCHASING);	// 采购中
		purchaseMission.preUpdate();
		dao.update(purchaseMission);
		
		// 保存采购订单
		for(PurchaseOrder purchaseOrder : purchaseMission.getOrderList()){
//			// 将要求时间设置为所选日期当天的“23:59:59”。实际完成时间应<=要求完成时间。
//			Date requiredTimeParam = purchaseOrder.getRequiredTime();
//			Date requiredTime = null;
//			SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
//			SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//			String requiredTimeStr = sdfDate.format(requiredTimeParam) + " 23:59:59";
//			try {
//				requiredTime = sdfTime.parse(requiredTimeStr);
//			} catch (ParseException e) {
//				e.printStackTrace();
//				throw new ServiceException("日期格式化异常！");
//			}
//			purchaseOrder.setRequiredTime(requiredTime);
			purchaseOrder.setPurchaseMission(purchaseMission);
			purchaseOrder.setOrderNo(codeGeneratorService.generateCode(PurchaseOrder.GENERATECODE_ORDERNO));
			purchaseOrder.setOrderStatus(PurchaseOrder.ORDERSTATUS_SUBMITED);		//待接单
			purchaseOrder.preInsert();
			purchaseOrderDao.insert(purchaseOrder);
			
			// 保存采购产品
			for(PurchaseProduce purchaseProduce : purchaseOrder.getPurchaseProduceList()){
				purchaseProduce.setPurchaseOrder(purchaseOrder);
				purchaseProduce.setRealityNum(0);
				purchaseProduce.preInsert();
				purchaseProduceDao.insert(purchaseProduce);
			}
		}
	}

	/**
	 * （物理）删除采购任务<及任务下采购任务产品>
	 */
	@Transactional(readOnly = false)
	public void delete(PurchaseMission purchaseMission) {
		dao.remove(purchaseMission);
		purchaseMissionDetailDao.removeByPurchaseMissionId(purchaseMission.getId());
	}

	/**
	 * 保存审批结果
	 * @param purchaseMission    设定文件
	 * @throws
	 */
	@Transactional(readOnly = false)
	public void saveCheckResult(PurchaseMission purchaseMission) {
		if("1".equals(purchaseMission.getMissionStatus())) {//审批通过
			purchaseMission.setMissionStatus(PurchaseMission.MISSIONSTATUS_SUBMIT);//已发布
		} else if("0".equals(purchaseMission.getMissionStatus())) {//审批拒绝
			purchaseMission.setMissionStatus(PurchaseMission.MISSIONSTATUS_NEW);
		}
		purchaseMission.preUpdate();
		purchaseMission.setCheckBy(UserUtils.getUser());
		purchaseMission.setCheckTime(new Date());
		dao.saveCheckResult(purchaseMission);
	}


	/**
	 * 更新备注
	 * @param purchaseMission    设定文件
	 * @throws
	 */
	@Transactional(readOnly = false)
	public void updateRemarks(PurchaseMission purchaseMission) {
		purchaseMission.preUpdate();
		dao.updateRemarks(purchaseMission);
	}
}