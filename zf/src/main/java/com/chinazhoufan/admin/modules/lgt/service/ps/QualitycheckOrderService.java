/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.lgt.dao.dp.DispatchOrderDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.QualitycheckDetailDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.QualitycheckOrderDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckDetail;
import com.chinazhoufan.admin.modules.lgt.entity.ps.QualitycheckOrder;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 货品质检单管理Service
 * @author 刘晓东
 * @version 2015-10-13
 */
@Service
@Transactional(readOnly = true)
public class QualitycheckOrderService extends CrudService<QualitycheckOrderDao, QualitycheckOrder> {

	@Autowired
	private QualitycheckDetailDao qualitycheckDetailDao;
	@Autowired
	private DispatchOrderDao dispatchOrderDao;
	
	public QualitycheckOrder get(String id) {
		QualitycheckOrder qualitycheckOrder = super.get(id);
		qualitycheckOrder.setQualitycheckDetailList(qualitycheckDetailDao.findList(new QualitycheckDetail(qualitycheckOrder)));
		return qualitycheckOrder;
	}
	
	public List<QualitycheckOrder> findList(QualitycheckOrder qualitycheckOrder) {
		return super.findList(qualitycheckOrder);
	}
	
	public List<QualitycheckOrder> findList() {
		// 详情界面调用
		return super.findList(new QualitycheckOrder());
	}
	
	public Page<QualitycheckOrder> findPage(Page<QualitycheckOrder> page, QualitycheckOrder qualitycheckOrder) {
		return super.findPage(page, qualitycheckOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(QualitycheckOrder qualitycheckOrder) {
		
		//质检结果打上完成时间
		if (qualitycheckOrder.getQcResult() != null && !qualitycheckOrder.getQcResult().equals("")) {
			qualitycheckOrder.setFinishTime(new Date());
			qualitycheckOrder.setQcStatus(QualitycheckOrder.QCSTATUS_OVER);
		}
		super.save(qualitycheckOrder);
		for (QualitycheckDetail qualitycheckDetail : qualitycheckOrder.getQualitycheckDetailList()){
			if (qualitycheckDetail.getId() == null){
				continue;
			}
			if (QualitycheckDetail.DEL_FLAG_NORMAL.equals(qualitycheckDetail.getDelFlag())){
				if (StringUtils.isBlank(qualitycheckDetail.getId())){
					qualitycheckDetail.setQualitycheckOrder(qualitycheckOrder);
					qualitycheckDetail.preInsert();
					qualitycheckDetailDao.insert(qualitycheckDetail);
				}else{
					qualitycheckDetail.preUpdate();
					qualitycheckDetailDao.update(qualitycheckDetail);
				}
			}else{
				qualitycheckDetailDao.delete(qualitycheckDetail);
			}
		}
		
		//TODO LT  质检完成后，需要同步更新调货单的状态，而且质检的下一步是入库，入库需要选择仓库，货架，货位的，同时变更持有人，同时状态变更为已完成
		DispatchOrder dispatchOrder = dispatchOrderDao.get(qualitycheckOrder.getQcBusinessId());
		dispatchOrder.setOrderStatus(DispatchOrder.ORDERSTATUS_PENDINGSTOCK);//质检完成，待入库
		dispatchOrder.preUpdate();
		dispatchOrderDao.update(dispatchOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(QualitycheckOrder qualitycheckOrder) {
		super.delete(qualitycheckOrder);
		qualitycheckDetailDao.delete(new QualitycheckDetail(qualitycheckOrder));
	}

	@Transactional(readOnly = false)
	public void qualityStart(QualitycheckOrder qualitycheckOrder) {
		qualitycheckOrder.setQcUser(UserUtils.getUser());
		qualitycheckOrder.setQcStatus(QualitycheckOrder.QCSTATUS_ING);
		qualitycheckOrder.setQcTime(new Date());
		dao.qualityStart(qualitycheckOrder);
	}
	
	
	
}