/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduct;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpChange;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodBadChange;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodBadChangeDao;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.mobile.wechat.service.pay.config.OrderType;

/**
 * 好坏货调动表Service
 * @author liuxiaodong
 * @version 2017-11-02
 */
@Service
@Transactional(readOnly = true)
public class GoodBadChangeService extends CrudService<GoodBadChangeDao, GoodBadChange> {

	@Autowired
	ProductService productService;
	@Autowired
	ProductWpChangeService productWpChangeService;
	@Autowired
	WhProduceService whProduceService;
	@Autowired
	WareplaceService wareplaceService;

	public GoodBadChange get(String id) {
		return super.get(id);
	}
	
	public List<GoodBadChange> findList(GoodBadChange goodBadChange) {
		return super.findList(goodBadChange);
	}
	
	public Page<GoodBadChange> findPage(Page<GoodBadChange> page, GoodBadChange goodBadChange) {
		return super.findPage(page, goodBadChange);
	}
	
	@Transactional(readOnly = false)
	public void save(GoodBadChange goodBadChange) {
		if (StringUtils.isBlank(goodBadChange.getProduct().getCode())){
			throw new ServiceException("操作失败，货品编码不得为空！");
		}
		Product product = productService.getByCode(goodBadChange.getProduct().getCode());
		if (Product.STATUS_NORMAL.equals(product.getStatus()) || Product.STATUS_LOCKED.equals(product.getStatus())){
			String stockType = null;
			goodBadChange.setPostWareplace(wareplaceService.get(goodBadChange.getPostWareplace()));
			goodBadChange.setProduct(product);
			goodBadChange.setPreWareplace(product.getWareplace());
			goodBadChange.setStatus(GoodBadChange.STATUS_TO_CHECK);
			super.save(goodBadChange);
			/**变更货品状态**/
			if (Product.STATUS_NORMAL.equals(product.getStatus())){
				product.setStatus(Product.STATUS_LOCKED);
				stockType = "D";
			}else if(Product.STATUS_LOCKED.equals(product.getStatus())){
				product.setStatus(Product.STATUS_NORMAL);
				stockType = "A";
			}
			product.setWareplace(goodBadChange.getPostWareplace());
			productService.update(product);
			/**保存货品货位调整记录**/
			ProductWpChange productWpChange = new ProductWpChange();
			productWpChange.setProduct(product);
			productWpChange.setPreWareplace(goodBadChange.getPreWareplace());
			productWpChange.setPostWareplace(goodBadChange.getPostWareplace());
			productWpChange.setPreHoldUser(product.getHoldUser());
			productWpChange.setPostHoldUser(product.getHoldUser());
			productWpChange.setReasonType(ProductWpChange.REASONTYPE_U_BAD_GOOD);
			productWpChangeService.save(productWpChange);
			/**变更库存**/
			if ("D".equals(stockType)){
				whProduceService.updateWhProduceStock(goodBadChange.getPreWareplace().getWarecounter().getWarearea().getWarehouse().getId(), product.getProduce().getId(),
						stockType,1,null,0,null,0);
                whProduceService.updateWhProduceStock(goodBadChange.getPostWareplace().getWarecounter().getWarearea().getWarehouse().getId(), product.getProduce().getId(),
                        null,0,"A",1,null,0);
			}else if("A".equals(stockType)){
				whProduceService.updateWhProduceStock(goodBadChange.getPostWareplace().getWarecounter().getWarearea().getWarehouse().getId(), product.getProduce().getId(),
						stockType,1,null,0,null,0);
                whProduceService.updateWhProduceStock(goodBadChange.getPreWareplace().getWarecounter().getWarearea().getWarehouse().getId(), product.getProduce().getId(),
                        null,0,"D",1,null,0);
			}
		}else {
			throw new ServiceException("操作失败，货品状态不为正常或锁定");
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(GoodBadChange goodBadChange) {
		super.delete(goodBadChange);
	}

	@Transactional(readOnly = false)
	public void auditGoodBadChange(GoodBadChange goodBadChange) {
		goodBadChange.setCheckBy(UserUtils.getUser());
		goodBadChange.setCheckTime(new Date());
		goodBadChange.setRemarks(goodBadChange.getRemarks());
		goodBadChange.setStatus(goodBadChange.getStatus());
		super.save(goodBadChange);
	}

		@Transactional(readOnly = false)
		public boolean batchAudit(String id ,String status) {
			GoodBadChange goodBadChange = this.get(id);

			// 1.更新发货单状态（发货完成）、发货时间
			goodBadChange.setCheckBy(UserUtils.getUser());
			goodBadChange.setCheckTime(new Date());
			goodBadChange.setRemarks(goodBadChange.getRemarks());
			goodBadChange.setStatus(status);
			super.save(goodBadChange);
			return true;
		}
}