/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ol;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.*;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpChangeService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WhProduceService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.dao.ol.ReturnProductDao;

import javax.jws.soap.SOAPBinding;

/**
 * 退货货品Service
 * @author 张金俊
 * @version 2017-04-19
 */
@Service
@Transactional(readOnly = true)
public class ReturnProductService extends CrudService<ReturnProductDao, ReturnProduct> {
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductWpIoService productWpIoService;

	@Autowired
	private WhProduceService whProduceService;

	@Autowired
	private ReturnProduceService returnProduceService;
	@Autowired
	private ReturnOrderService returnOrderService;

	public ReturnProduct get(String id) {
		return super.get(id);
	}

	public ReturnProduct getDetail(String id) {
		return dao.getDetail(id);
	}
	
	public List<ReturnProduct> findList(ReturnProduct returnProduct) {
		return super.findList(returnProduct);
	}

	public List<ReturnProduct> findListByReturnOrderId(ReturnProduct returnProduct) {
		return dao.findListByReturnOrderId(returnProduct);
	}
	public Page<ReturnProduct> findPage(Page<ReturnProduct> page, ReturnProduct returnProduct) {
		return super.findPage(page, returnProduct);
	}
	
	@Transactional(readOnly = false)
	public void save(ReturnProduct returnProduct) {
		//损坏图片保存货品表中
		Product pro = new Product();
		pro.setBrokenPhoto(returnProduct.getBrokenPhotos());
		pro.setId(returnProduct.getProduct().getId());
		pro.setUpdateBy(UserUtils.getUser());
		pro.setUpdateDate(new Date());
		productService.updateSingle(pro);
		super.save(returnProduct);
	}
	
	@Transactional(readOnly = false)
	public void delete(ReturnProduct returnProduct) {
		super.delete(returnProduct);
	}
	
	/**
	 * 根据ID变更退货货品的状态
	 * @param returnProduct
	 */
	@Transactional(readOnly = false)
	public void updateStatusById(ReturnProduct returnProduct) {
		returnProduct.preUpdate();
		dao.updateStatusById(returnProduct);
	}
	
	

	/**
	 * 根据退货货品中的货品ID变更退货货品的状态
	 * @param returnProduct
	 */
	@Transactional(readOnly = false)
	public void updateStatusByProductAndStatus(ReturnProduct returnProduct) {
		returnProduct.preUpdate();
		dao.updateStatusByProductAndStatus(returnProduct);
	}
	
	
	/**
	 * 根据退货单物流单号变更退货货品的状态
	 * @param returnProduct
	 */
	@Transactional(readOnly = false)
	public void updateStatusByExpressNo(ReturnProduct returnProduct) {
		returnProduct.preUpdate();
		dao.updateStatusById(returnProduct);
	}
	
	
	/**
	 * 根据退货单ID和退货货品为质检状态，统计同退货单中其他退货货品待质检的数量
	 * @param returnProduct
	 * @return
	 */
	public Integer countWaitCheckReturnProduct(ReturnProduct returnProduct) {
		return dao.countWaitCheckReturnProduct(returnProduct);
	}
	/**
	 * 批量更新货品数据
	 */
	@Transactional(readOnly = false)
	public void batchSave(List<ReturnProduct> returnProducts) {
		for(ReturnProduct returnProduct :returnProducts){
			//更新退货货品入库状态
			returnProduct.setInStatus(ReturnProduct.STATUS_TOWARE);
			returnProduct.setQualityTime(new Date());
			if(returnProduct.getDecMoney() != null){
				returnProduct.setDecMoney(returnProduct.getDecMoney().setScale(2, BigDecimal.ROUND_HALF_UP));
			}
			returnProduct.preUpdate();
			dao.update(returnProduct);
		}
	}
	/**
	 * 添加入库货品，待入库=》入库中
	 *
	 */
	@Transactional(readOnly = false)
	public void savePro(String code) {
		ReturnProduct returnProduct =dao.findByProductCode(code);
		//检查入库状态，并更新货品入库状态
		if(returnProduct == null ){
			throw new ServiceException("失败：根据货品code未找到对应回货货品！");
		}
		if(ReturnProduct.STATUS_TOWARE.equals(returnProduct.getInStatus())){
			returnProduct.setInStatus(ReturnProduct.STATUS_WARE);
			returnProduct.setInBy(UserUtils.getUser());
			returnProduct.setInStartTime(new Date());
			dao.update(returnProduct);
		}else{
			throw new ServiceException("失败：该退货货品"+code+"不是待入库状态，请核对！");
		}
	}
	/**
	 * 入库回货货品
	 * 对于货品货位操作，是基于此货品损坏的，如果有损坏则可填货位，如果正常则货位不可填，默认值为空
	 */
	@Transactional(readOnly = false)
	public void inWarehouse(ReturnProduct returnProduct) {
		//更新货品入库状态,并更新货品的货位
		returnProduct.setInStatus(ReturnProduct.STATUS_FINISH);
		returnProduct.setInEndTime(new Date());
		returnProduct.setInBy(UserUtils.getUser());
		returnProduct.setInStartTime(new Date());
		returnProduct.setUpdateBy(UserUtils.getUser());
		returnProduct.setUpdateDate(new Date());
		Product pro = productService.get(returnProduct.getProduct());
		//如果有轻微损坏以上的货品，则如坏货区
		if (returnProduct.getDamageType() != null && ReturnProduct.Dt_2.equals(returnProduct.getDamageType()) || ReturnProduct.Dt_3.equals(returnProduct.getDamageType())) {
			// 设置货品出入库记录
			ProductWpIo productWpIo = new ProductWpIo();
			productWpIo.setProduct(pro);
			productWpIo.setIoType(ProductWpIo.IOTYPE_IN);
			productWpIo.setInStatus(ProductWpIo.INSTATUS_LOCKED);//不合格的，货品状态为锁定
			productWpIo.setInType(ProductWpIo.INTYPE_BROKEN_STOCK);
			//货品所属供应商
			productWpIo.setSupplier(pro.getSupplier());

			// 设置入库类型为“退货入库”
			productWpIo.setIoReasonType(ProductWpIo.IOREASIONTYPE_IN_RETURN);
			productWpIo.setIoUser(UserUtils.getUser());
			productWpIo.setIoTime(new Date());
			ReturnOrder returnOrder = returnOrderService.get(returnProduct.getReturnOrder().getId());
			if(returnOrder == null ){
				throw new ServiceException("失败：获取不到来源单号，请核对！");
			}
			productWpIo.setIoBusinessorderId(returnOrder.getOrderNo());
			// 货品入库
			productWpIoService.productInSave(productWpIo);
			//回货品更新
			dao.update(returnProduct);
		}else{
			//更新货品状态
			pro.setStatus(Product.STATUS_NORMAL);
			pro.setUpdateDate(new Date());
			pro.setUpdateBy(UserUtils.getUser());
			productService.updateSingle(pro);
			//更新库存
			ReturnProduce returnProduce = returnProduceService.get(returnProduct.getReturnProduce().getId());
			Produce produce = new Produce();
			produce.setId(returnProduce.getProduce().getId());
			WhProduce whProduce =whProduceService.getByProduce(produce);
			if(whProduce !=null){
				whProduceService.updateWhProduceStock(whProduce.getWarehouse().getId(),produce.getId(),"A",1,"D",1, "D", 0);
			}
			//回货品更新
			pro.setFullWareplace(pro.getWareplace().getWarecounter().getWarearea().getWarehouse().getCode()+"_"+pro.getWareplace().getWarecounter().getWarearea().getCode()+"_"+pro.getWareplace().getWarecounter().getCode()+"_"+pro.getWareplace().getCode());
			returnProduct.setInWareplace(pro.getFullWareplace());
			dao.update(returnProduct);
		}

	}
	public List<ReturnProduct> getByReturnOrder(String returnOrderId){
		return dao.getByReturnOrder(returnOrderId);
	}
	/**
	 * 统计质检有损坏的产品的回货单数
	 */
	public List<String> getDamageCount(ReturnProduct returnProduct){
		List<ReturnProduct> returnProductList = dao.getDamageCount(returnProduct);
		List<String> returnOrderIds = new ArrayList<>();
		List<String> orderIds = new ArrayList<>();
		if(returnProductList != null && returnProductList.size() >0){
			for (ReturnProduct temp :returnProductList){
				returnOrderIds.add(temp.getReturnOrder().getId());
			}
		}
		if(returnOrderIds.size() > 0){
			orderIds = returnOrderService.getReturnOrderByIds(returnOrderIds);
		}
		return  orderIds;
	}

	/**
	 * 货品批量入库
	 * @param ids
	 */
	@Transactional(readOnly = false)
	public void batchInWarehouse(String[] ids) {
		for (String id : ids){
			inWarehouse(get(id));
		}

	}

	/**
	 * 根据会员id及损坏类型统计
	 * @param memberId
	 * @param breakdownType
	 * @return
	 */
	public int countByMemberAndBreakdownType(String memberId, String breakdownType){
		Map<String, Object> map = Maps.newHashMap();
		map.put("memberId", memberId);
		map.put("breakdownType", breakdownType);
		return dao.countByMemberAndBreakdownType(map);
	}


}