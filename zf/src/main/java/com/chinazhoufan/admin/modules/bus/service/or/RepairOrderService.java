/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.or;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.dao.or.RepairOrderDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.entity.or.RepairOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProductService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.api.common.service.ServiceException;

/**
 * 货品维修单Service
 * @author 张金俊
 * @version 2016-11-19
 */
@Service
@Transactional(readOnly = true)
public class RepairOrderService extends CrudService<RepairOrderDao, RepairOrder> {

	@Autowired
	private ReturnOrderService returnOrderService;
	@Autowired
	private ReturnProductService returnProductService;
	@Autowired
	private ProductService productService;
	
	public RepairOrder get(String id) {
		return super.get(id);
	}
	
	public List<RepairOrder> findList(RepairOrder repairOrder) {
		return super.findList(repairOrder);
	}
	
	public Page<RepairOrder> findPage(Page<RepairOrder> page, RepairOrder repairOrder) {
		return super.findPage(page, repairOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(RepairOrder repairOrder) {
		super.save(repairOrder);
	}
	
	@Transactional(readOnly = false)
	public void delete(RepairOrder repairOrder) {
		super.delete(repairOrder);
	}
	
	/**
	 * 保存退货货品的维修登记信息，来源是退货单关联的退货货品
	 * @param repairOrder
	 */
	@Transactional(readOnly = false)
	public void saveReturnProductRepairRegister(RepairOrder repairOrder) {
		Product product = productService.findByBarCode(repairOrder.getProduct().getCode());
		if(product == null) {
			throw new ServiceException("输入的货品编码不正确，系统中找不到对应的记录，请核查!");
		}
		
		repairOrder.setApplyBy(UserUtils.getUser());
		repairOrder.setApplyTime(new Date());
		repairOrder.setApplyType(RepairOrder.DEALTYPE_SELF_REPAIR);//默认维修
		repairOrder.setDealType(RepairOrder.DEALTYPE_SELF_REPAIR);//默认维修
		repairOrder.setStatus(RepairOrder.STATUS_WAIT_REPAIR);
		super.save(repairOrder);
		
		// 变更退货货品的质检状态
		/*ReturnProduct returnProduct = new ReturnProduct();
		returnProduct.setProduct(repairOrder.getProduct());
//		returnProduct.setStatus(ReturnProduct.CHECK_READY);
//		returnProduct.setPreStatus(ReturnProduct.CHECK_WAIT);
		returnProductService.updateStatusByProductAndStatus(returnProduct);
		
		//如果这个退货单对应的退货货品都已经质检过了，那么退货单状态从待质检变更为待结算
		
		ReturnOrder returnOrder = new ReturnOrder(repairOrder.getBussinessId());
		
		returnProduct = new ReturnProduct();
//		returnProduct.setStatus(ReturnProduct.CHECK_WAIT);
		returnProduct.setReturnOrder(returnOrder);
		Integer c = returnProductService.countWaitCheckReturnProduct(returnProduct);
		if(c == 0) {
			returnOrder.setStatus(ReturnOrder.STATUS_TOACCOUNT);
			returnOrderService.updateStatusById(returnOrder);
		}*/
		
	}
	
}