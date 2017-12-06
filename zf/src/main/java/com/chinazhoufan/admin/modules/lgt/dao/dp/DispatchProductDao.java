/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.dp;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.dp.DispatchProduct;

/**
 * 调货货品DAO接口
 * @author 刘晓东
 * @version 2015-10-21
 */
@MyBatisDao
public interface DispatchProductDao extends CrudDao<DispatchProduct> {
	public DispatchProduct getProduceId(String id);
	public void saveProduct(DispatchProduct lgtPsDispatchProduct);
	
	/**
	 * 通过调货产品记录id获取采购货品记录
	 * @param dispatchProduceId 产品记录id
	 * @return 对应的调货货品记录
	 */
	public List<DispatchProduct> findListByDispatchProduceId(String dispatchProduceId);
	
	/**
	 * 根据调货产品单ID物理删除与之相关联的调货货品数据，便于更正调货货品选错的现象
	 * @param delFlag
	 * @param dispatchProduceId
	 */
	public void removeDispatchProductByDispatchProduceId(@Param("dispatchProduceId")String dispatchProduceId);
}