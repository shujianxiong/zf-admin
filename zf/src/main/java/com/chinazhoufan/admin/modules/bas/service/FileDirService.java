/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service;


import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.TreeService;
import com.chinazhoufan.admin.modules.bas.dao.FileDirDao;
import com.chinazhoufan.admin.modules.bas.entity.FileDir;

/**
 * 文件目录Service
 * @Date 2016年10月26日 下午2:59:03
 */
@Service
@Transactional(readOnly = true)
public class FileDirService extends TreeService<FileDirDao, FileDir> {

	@Transactional(readOnly = false)
	public void save(FileDir entity) {
		super.save(entity);
	}

	@Override
	public FileDir get(String id) {
		return super.get(id);
	}

	@Override
	public FileDir get(FileDir entity) {
		return super.get(entity);
	}

	@Override
	public List<FileDir> findList(FileDir entity) {
		return super.findList(entity);
	}

	@Override
	public Page<FileDir> findPage(Page<FileDir> page, FileDir entity) {
		return super.findPage(page, entity);
	}

	@Transactional(readOnly = false)
	public void delete(FileDir entity) {
		super.delete(entity);
	}

	public List<FileDir> findAll() {
		return super.findList(new FileDir());
	}
	
	public List<FileDir> findPublicList() {
		FileDir fileDir = new FileDir();
		fileDir.setType(FileDir.TYPE_PUBLIC);
		return super.findList(fileDir);
	}
	
	@Transactional(readOnly = false)
	public void updateType(FileDir entity) {
		dao.updateType(entity);
	}
	
	public boolean getUniqueByCode(String code) {
		int c = dao.getUniqueByCode(code);
		return c == 0 ? true : false;
	}
	
	public FileDir findFileDirByCode(String code){
		return dao.findFileDirByCode(code);
	}
}
