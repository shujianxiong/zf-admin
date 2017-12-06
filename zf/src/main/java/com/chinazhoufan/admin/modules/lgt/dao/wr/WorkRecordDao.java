package com.chinazhoufan.admin.modules.lgt.dao.wr;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.lgt.entity.wr.WorkRecord;

import java.util.List;

@MyBatisDao
public interface WorkRecordDao extends CrudDao<WorkRecord> {

	//工作人员工作记录统计
	public List<WorkRecord> Statistics(WorkRecord workRecord);
}