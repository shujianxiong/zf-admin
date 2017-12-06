/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.tn;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressNoSegment;

/**
 * 快递单号段表DAO接口
 * @author liut
 * @version 2017-05-22
 */
@MyBatisDao
public interface ExpressNoSegmentDao extends CrudDao<ExpressNoSegment> {
	
	/**
	 * 批量保存快递单号段
	 * @param list
	 */
	public void batchSaveExpressNoSegment(List<ExpressNoSegment> list);
	
    /**
     * 获取可使用的快递单号（寄出）
     * @param expressNoSegment
     * @return
     */
	public List<ExpressNoSegment> findOneExpressNo(ExpressNoSegment expressNoSegment);
	
	/**
	 * 根据快递单号和状态更新使用时间
	 * @param expressNoSegment
	 * @return
	 */
	public void updateByExpressNo(ExpressNoSegment expressNoSegment);
	
	
	
	
}