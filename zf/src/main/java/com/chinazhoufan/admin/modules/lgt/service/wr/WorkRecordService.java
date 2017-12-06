package com.chinazhoufan.admin.modules.lgt.service.wr;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.wr.WorkRecordDao;
import com.chinazhoufan.admin.modules.lgt.entity.wr.WorkRecord;

@Service
@Transactional(readOnly = true)
public class WorkRecordService extends CrudService<WorkRecordDao, WorkRecord> {

	public List<WorkRecord> findList(WorkRecord workRecord) {
		return super.findList(workRecord);
	}

}