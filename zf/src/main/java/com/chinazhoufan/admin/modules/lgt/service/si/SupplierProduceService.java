/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.si;

import java.math.BigDecimal;
import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.si.SupplierProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierProduce;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProduceService;

/**
 * 供应商产品表Service
 * @author liut
 * @version 2016-11-21
 */
@Service
@Transactional(readOnly = true)
public class SupplierProduceService extends CrudService<SupplierProduceDao, SupplierProduce> {

	@Autowired
	private ProduceService produceService;
	
	public SupplierProduce get(String id) {
		return super.get(id);
	}
	
	public List<SupplierProduce> findList(SupplierProduce supplierProduce) {
		return super.findList(supplierProduce);
	}
	
	public Page<SupplierProduce> findPage(Page<SupplierProduce> page, SupplierProduce supplierProduce) {
		return super.findPage(page, supplierProduce);
	}
	
	@Transactional(readOnly = false)
	public void save(SupplierProduce supplierProduce) {
		
		String supplierId = supplierProduce.getSupplier().getId();
		String goodsId = supplierProduce.getGoods().getId();
		
		dao.deleteSupplierProduceBySupplierAndGoods(supplierId, goodsId);
		
		List<SupplierProduce> spList = supplierProduce.getSpList();
		if(spList.size() > 0) {
			for(SupplierProduce sp : spList) {
				if(sp != null && sp.getProduce() != null && StringUtils.isNotBlank(sp.getProduce().getId())) {
					sp.setGoods(supplierProduce.getGoods());
					sp.setWorkFee(supplierProduce.getWorkFee());
					
					sp.setGoodsFactoryCode(supplierProduce.getGoods().getFactoryCode());
					
					sp.setElectrolyticGoldColour(supplierProduce.getElectrolyticGoldColour());
					sp.setElectrolyticGoldCrafts(supplierProduce.getElectrolyticGoldCrafts());
					sp.setElectrolyticGoldPrice(supplierProduce.getElectrolyticGoldPrice());
					sp.setElectrolyticGoldThickness(supplierProduce.getElectrolyticGoldThickness());
					
					sp.setTempletFee(supplierProduce.getTempletFee());
					sp.setId(supplierProduce.getId());
					sp.setSupplier(supplierProduce.getSupplier());
					sp.setId(supplierProduce.getId());
					super.save(sp);
					
					//同步更新产品
					Produce produce = produceService.get(sp.getProduce());
					if(sp.getPricePurchaseMax() != null && sp.getPricePurchaseMax().compareTo(produce.getPricePurchase()) > 0) {
						produce.setPricePurchase(sp.getPricePurchaseMax());
						produce.setPriceOperation(sp.getPricePurchaseMax().setScale(0, BigDecimal.ROUND_UP));//运算成本价
						produce.setPriceSrc(produce.getPriceOperation().multiply(produce.getRatioOperation()));
						produceService.update(produce);
					}
				}
			}
		}
	}
	
	
	@Transactional(readOnly = false)
	public void saveOnly(SupplierProduce supplierProduce) {
		super.save(supplierProduce);
	}
	
	@Transactional(readOnly = false)
	public void delete(SupplierProduce supplierProduce) {
		super.delete(supplierProduce);
	}
	
	@Transactional(readOnly = false)
	public void deleteBySupplierAndGoods(String supplierId, String goodsId) {
		dao.deleteSupplierProduceBySupplierAndGoods(supplierId, goodsId);
	}
	
	
	/**
	 * 根据供应商获取对应的产品供货价信息
	 * @param supplierId
	 * @return    设定文件
	 * @throws
	 */
	public List<SupplierProduce> listSupplierProduceBySupplierAndGoods(String supplierId, String goodsId) {
		return dao.listSupplierProduceBySupplierAndGoods(supplierId, goodsId);
	}
	
	
	/**
	 * 根据供应商和产品来更新供应商产品金工石及其他信息
	 * @param supplierProduce    设定文件
	 * @throws
	 */
	public void updateBySupplierAndProduce(SupplierProduce supplierProduce) {
		dao.updateBySupplierAndProduce(supplierProduce);
	}
	
	
	/**
	 * 根据商品获取
	 * @param goodsId
	 * @return    设定文件
	 * @throws
	 */
	public List<Supplier> listSupplierByGoods(@Param("goodsId")String goodsId) {
		return dao.listSupplierByGoods(goodsId);
	}
	
	/**
	 * 查询供应商产品最新（updateDate最晚）的一条记录
	 * @param produceId
	 * @return
	 */
	public SupplierProduce getLastestOne(String produceId) {
		return dao.getLastestOne(produceId);
	}
}