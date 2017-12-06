/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.ol;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 拣货单DAO接口
 * @author 张金俊
 * @version 2017-04-12
 */
@MyBatisDao
public interface PickOrderDao extends CrudDao<PickOrder> {
	
	/**
	 * 列出打包待接单的拣货单列表（拣货人不为空、打包人为空）
	 * @param pickOrder
	 * @return
	 */
	public List<PickOrder> listForPackageToGet(PickOrder pickOrder);
	
	
	/**
	 * 根据打包人（当前用户）列出该打包人的拣货单
	 * @param pickOrder
	 * @return
	 */
	public List<PickOrder> listForPackage(PickOrder pickOrder);
	
	
	/**
	 * 根据拣货人统计该拣货人还未拣货完成的拣货单数量
	 * @param pickOrder
	 * @return
	 */
	public Integer countUnCompletePickWithPickBy(PickOrder pickOrder);
	
	
	/**
	 * 根据拣货单ID获取拣货任务明细，按照货位显示
	 * @param pickOrder
	 * @return
	 */
	public List<Produce> getMissionDetailByPickOrder(PickOrder pickOrder);

	
	/**
	 * 根据托盘编码获取最近一次的关联拣货单正在使用的记录
	 * @param pickOrder
	 * @return
	 */
	public PickOrder findPickOrderByPlateNo(PickOrder pickOrder);
	
	
	public PickOrder getDetailWithSendOrder(PickOrder pickOrder);

	PickOrder findPickOrderByPlateNo(Map<String, Object> map);
}