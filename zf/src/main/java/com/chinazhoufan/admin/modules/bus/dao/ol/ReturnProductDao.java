/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ol;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 退货货品DAO接口
 * @author 张金俊
 * @version 2017-04-19
 */
@MyBatisDao
public interface ReturnProductDao extends CrudDao<ReturnProduct> {
	
	
	/**
	 * 根据ID变更退货货品的状态
	 * @param returnProduct
	 */
	public void updateStatusById(ReturnProduct returnProduct);
	
	
	/**
	 * 根据退货货品中的货品ID变更退货货品的状态
	 * @param returnProduct
	 * @param status
	 */
	public void updateStatusByProductAndStatus(ReturnProduct returnProduct);
	
	
	/**
	 * 根据退货单物流单号变更退货货品的状态为待质检
	 * @param returnProduct
	 */
	public void updateStatusByExpressNo(ReturnProduct returnProduct);

	/**
	 * 根据退货单ID和退货货品为质检状态，统计同退货单中其他退货货品待质检的数量
	 * @param returnProduct
	 * @return
	 */
	public Integer countWaitCheckReturnProduct(ReturnProduct returnProduct);


	/**
	 * 根据退货单ID获取退货货品
	 * @param returnProduct
	 */
	public List<ReturnProduct> findListByReturnOrderId(ReturnProduct returnProduct);

	/**
	 * 根据货品编码获取退货货品
	 * @param code
	 */
	public ReturnProduct findByProductCode(@Param("code")String code);

	/**
	 * 根据退货单获取退货货品
	 * @param returnOrderId
	 */
	public List<ReturnProduct> getByReturnOrder(@Param("returnOrderId")String returnOrderId);

	/**
	 * 统计质检有损坏的产品的回货单数
	 * @param returnProduct
	 */
	public List<ReturnProduct> getDamageCount(ReturnProduct returnProduct);

	public ReturnProduct getDetail(@Param("id") String id);

    int countByMemberAndBreakdownType(Map<String, Object> map);
}