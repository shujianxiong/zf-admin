/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service.pv;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.entity.pv.PvRecord;
import com.chinazhoufan.admin.modules.bas.dao.pv.PvRecordDao;

/**
 * 页面访问记录Service
 * @author liut
 * @version 2017-03-03
 */
@Service
@Transactional(readOnly = true)
public class PvRecordService extends CrudService<PvRecordDao, PvRecord> {

	public PvRecord get(String id) {
		return super.get(id);
	}
	
	public List<PvRecord> findList(PvRecord pvRecord) {
		return super.findList(pvRecord);
	}
	
	public Page<PvRecord> findPage(Page<PvRecord> page, PvRecord pvRecord) {
		return super.findPage(page, pvRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(PvRecord pvRecord) {
		super.save(pvRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(PvRecord pvRecord) {
		super.delete(pvRecord);
	}
	
	
	/**
	 * 根据页面类型统计浏览量
	 * @param pvRecord
	 * @return    设定文件
	 * @throws
	 */
	public List<PvRecord> statPageViewByPageType(PvRecord pvRecord) {
		return dao.statPageViewByPageType(pvRecord);
	};
	
	public List<PvRecordStat> drawPageViewByPageType(PvRecord pvRecord) {
		List<PvRecord> list = dao.statPageViewByPageType(pvRecord);
		List<PvRecordStat> statList = new ArrayList<PvRecordStat>(list.size());
		PvRecordStat stat = null;
		String[] colorArr = new String[]{"#3c8dbc", "#ffcc99", "#00c0ef", "#66cc33", "#cc9900", "#9900cc"};
		int i = 0;
		for(PvRecord pr : list) {
			stat = new PvRecordStat();
			stat.label = pr.getPageType();
			stat.data = pr.getCount()+"";
			if(i <= list.size()-1) {
				stat.color = colorArr[i];
			} else {
				stat.color = "white";
			}
			statList.add(stat);
			i++;
		}
		return statList;
	};
	
}