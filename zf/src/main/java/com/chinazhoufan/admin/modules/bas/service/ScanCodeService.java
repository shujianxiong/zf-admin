/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.entity.ScanCode;
import com.chinazhoufan.admin.modules.bas.dao.ScanCodeDao;
import com.google.common.collect.Lists;

/**
 * 扫描电子码Service
 * @author 张金俊
 * @version 2016-11-16
 */
@Service
@Transactional(readOnly = true)
public class ScanCodeService extends CrudService<ScanCodeDao, ScanCode> {

	public ScanCode get(String id) {
		return super.get(id);
	}
	
	/**
	 * 获取电子码表最后一条记录（同时锁定电子码表）
	 * @return
	 */
	public ScanCode getLastForUpdate() {
		return dao.getLastForUpdate();
	}
	
	/**
	 * 通过code查询电子码记录
	 * @param code
	 * @return
	 */
	public ScanCode getByCode(String code) {
		return dao.getByCode(code);
	}
	
	public List<ScanCode> findList(ScanCode scanCode) {
		return super.findList(scanCode);
	}
	
	public Page<ScanCode> findPage(Page<ScanCode> page, ScanCode scanCode) {
		return super.findPage(page, scanCode);
	}
	
	@Transactional(readOnly = false)
	public void save(ScanCode scanCode) {
		super.save(scanCode);
	}
	
	@Transactional(readOnly = false)
	public void delete(ScanCode scanCode) {
		super.delete(scanCode);
	}
	
	
	/**
	 * 新增自定义个货位电子码（货位电子码从200001开始）
	 */
	@Transactional(readOnly = false)
	public String addProductScanCode(int targetNum){
		Integer startCode = 200001;
		ScanCode lastScanCode = dao.getScanCodeLastByType(ScanCode.TYPE_WAREPLACE);
		if(lastScanCode != null){
			startCode = Integer.valueOf(lastScanCode.getCode()) + 1;
		}
		List<String> codes = Lists.newArrayList();
		for(Integer i=startCode; i<(startCode+targetNum); i++){
			ScanCode wareplaceScanCode = new ScanCode();
			wareplaceScanCode.setCode(i);
			wareplaceScanCode.setType(ScanCode.TYPE_WAREPLACE);
			save(wareplaceScanCode);
			codes.add(i.toString());
		}
		return StringUtils.join(codes.toArray(), ",");
	}
	
	
	
	/**
	 * 根据类型自定义电子码
	 */
	@Transactional(readOnly = false)
	public String getNextScanCodeByType(String type){
		Integer startCode = 100001;
		ScanCode lastScanCode = dao.getScanCodeLastByType(type);
		if(lastScanCode != null){
			startCode = Integer.valueOf(lastScanCode.getCode()) + 1;
			ScanCode scode = new ScanCode();
			scode.setCode(startCode);
			scode.setType(type);
			save(scode);
		}
		return startCode+"";
	}
	
	
	
}