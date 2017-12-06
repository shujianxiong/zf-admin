/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.pm;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.pm.PlateManage;
import com.chinazhoufan.admin.modules.bus.dao.pm.PlateManageDao;

/**
 * 托盘管理Service
 * @author liuxiaodong
 * @version 2017-10-27
 */
@Service
@Transactional(readOnly = true)
public class PlateManageService extends CrudService<PlateManageDao, PlateManage> {

	public PlateManage get(String id) {
		return super.get(id);
	}
	
	public List<PlateManage> findList(PlateManage plateManage) {
		return super.findList(plateManage);
	}
	
	public Page<PlateManage> findPage(Page<PlateManage> page, PlateManage plateManage) {
		return super.findPage(page, plateManage);
	}
	
	@Transactional(readOnly = false)
	public void save(PlateManage plateManage) {
		if (StringUtils.isBlank(plateManage.getId())){
			PlateManage plateManageExist = getByPlateNo(plateManage.getPlateNo(), false);
			if (plateManageExist !=null){
				throw new ServiceException("操作失败，当前托盘号已存在记录！");
			}
		}
		super.save(plateManage);
	}
	
	@Transactional(readOnly = false)
	public void delete(PlateManage plateManage) {
		if (PlateManage.FALSE_FLAG.equals(plateManage.getPlateStatus())&&PlateManage.FALSE_FLAG.equals(plateManage.getPlateUsed())){
			super.delete(plateManage);
		}else {
			throw new ServiceException("托盘状态错误，请核实！");
		}
	}


	/**
	 * 查询二十条可用的数据
	 * @param plateManage
	 * @return
	 */
    public List<PlateManage> findUsableList(PlateManage plateManage) {
    	return dao.findUsableList(plateManage);

    }

	/**
	 * 根据托盘号查询托盘
	 * @param plateNo
	 * @param usableFlag 当前是否可用
	 */
	public PlateManage getByPlateNo(String plateNo, boolean usableFlag){
		Map<String, Object> map = Maps.newHashMap();
		if (usableFlag){
			map.put("usable", PlateManage.TRUE_FLAG);
			map.put("inUse", PlateManage.FALSE_FLAG);
		}
		map.put("plateNo", plateNo);
		map.put("DEL_FLAG_NORMAL", PlateManage.DEL_FLAG_NORMAL);
		return dao.getByPlateNo(map);
	}

	/**
	 * 根据托盘号查询托盘
	 * @param plateNo
	 */
	public PlateManage getInUseByPlateNo(String plateNo){
		Map<String, Object> map = Maps.newHashMap();
		map.put("usable", PlateManage.TRUE_FLAG);
		map.put("inUse", PlateManage.TRUE_FLAG);
		map.put("plateNo", plateNo);
		map.put("DEL_FLAG_NORMAL", PlateManage.DEL_FLAG_NORMAL);
		return dao.getByPlateNo(map);
	}

}