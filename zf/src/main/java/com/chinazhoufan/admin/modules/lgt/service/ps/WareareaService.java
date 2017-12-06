/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WareareaDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarecounterDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warearea;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warecounter;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 仓库区域管理Service
 * @author 贾斌
 * @version 2015-10-13
 */
@Service
@Transactional(readOnly = true)
public class WareareaService extends CrudService<WareareaDao, Warearea> {

	@Autowired
	private WareareaDao wareareaDao;
	@Autowired
	WareplaceService wareplaceService;
	@Autowired
	WarecounterDao warecounterDao;
	
	public Warearea get(String id) {
		return super.get(id);
	}
	
	public List<Warearea> findList(Warearea warearea) {
		return super.findList(warearea);
	}
	
	public List<Warearea> findList() {
		return wareareaDao.findAllList(new Warearea());
	}
	
	public Page<Warearea> findPage(Page<Warearea> page, Warearea warearea) {
		return super.findPage(page, warearea);
	}
	
	@Transactional(readOnly = false)
	public void save(Warearea warearea) {
		super.save(warearea);
	}
	
	@Transactional(readOnly = false)
	public void delete(Warearea warearea) {
		super.delete(warearea);
	}

	@Transactional(readOnly=false)
	public void batchSetWarecounterAndWareplace(Warearea warearea,
			int horizontalNum, int verticalNum, int wareplaceNum) {
		Warecounter warecounter = null;
		Wareplace wareplace = null;
		String code = "";
		for (int i = 1; i <= verticalNum; i++) {
			if (i>9) {
				code=""+i;
			}else {
				code="0"+i;
			}
			for (int j = 1; j <= horizontalNum; j++) {
				code += "0"+j;
				warecounter = new Warecounter(warearea, code, Warecounter.TRUE_FLAG);
				warecounter.preInsert();
				for (char k = 'A'; k < 'A'+wareplaceNum; k++) {
					wareplace = new Wareplace(warecounter, String.valueOf(k),Wareplace.FALSE_FLAG , Wareplace.TRUE_FLAG);
					wareplaceService.save(wareplace);
				}
				warecounterDao.insert(warecounter);
				if (i>9) {
					code=""+i;
				}else {
					code="0"+i;
				}
			}
		}
		
	}
	
}