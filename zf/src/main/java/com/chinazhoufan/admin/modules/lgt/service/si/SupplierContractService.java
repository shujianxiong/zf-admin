/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.si;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.entity.FileLibrary;
import com.chinazhoufan.admin.modules.bas.service.FileLibraryService;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.lgt.dao.si.SupplierContractDao;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierContract;

/**
 * 供应商合同Service
 * @author liut
 * @version 2016-04-29
 */
@Service
@Transactional(readOnly = true)
public class SupplierContractService extends CrudService<SupplierContractDao, SupplierContract> {

	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private FileLibraryService fileLibraryService;
	
	public SupplierContract get(String id) {
		return super.get(id);
	}
	
	public List<SupplierContract> findList(SupplierContract supplierContract) {
		return super.findList(supplierContract);
	}
	
	public Page<SupplierContract> findPage(Page<SupplierContract> page, SupplierContract supplierContract) {
		return super.findPage(page, supplierContract);
	}
	
	@Transactional(readOnly = false)
	public void save(SupplierContract supplierContract) {
		if(supplierContract.getIsNewRecord() && StringUtils.isBlank(supplierContract.getContractNo())) {
			supplierContract.setContractNo(codeGeneratorService.generateCode(SupplierContract.GENERATECODE_BATCHNO));
		}
		if(StringUtils.isBlank(supplierContract.getId())) {
			List<FileLibrary> fileList = fileLibraryService.findByFileUrl(supplierContract.getFileUrl());
			if(fileList != null && fileList.size() > 0) {
				supplierContract.setFileLibrary(fileList.get(0));
			}
		}
		super.save(supplierContract);
	}
	
	@Transactional(readOnly = false)
	public void delete(SupplierContract supplierContract) {
		super.delete(supplierContract);
	}
	
}