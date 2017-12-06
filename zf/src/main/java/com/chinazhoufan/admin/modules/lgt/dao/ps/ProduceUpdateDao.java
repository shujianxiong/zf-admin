/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.dao.ps;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProduceUpdate;

/**
 * 产品更新审批DAO接口
 * @author liut
 * @version 2017-03-22
 */
@MyBatisDao
public interface ProduceUpdateDao extends CrudDao<ProduceUpdate> {
	
	public List<ProduceUpdate> findUnOkList(ProduceUpdate produceUpdate);
	
}