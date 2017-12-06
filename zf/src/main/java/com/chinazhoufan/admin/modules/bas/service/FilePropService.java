/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.dao.FilePropDao;
import com.chinazhoufan.admin.modules.bas.entity.FileLibrary;
import com.chinazhoufan.admin.modules.bas.entity.FileProp;

/**
 * 图片属性表Service
 * @author 刘晓东
 * @version 2016-05-03
 */
@Service
@Transactional(readOnly = true)
public class FilePropService extends CrudService<FilePropDao, FileProp> {

	@Autowired
	private FilePropDao filePropDao;
	
	public FileProp get(String id) {
		return super.get(id);
	}
	
	public List<FileProp> findList(FileProp fileProp) {
		return super.findList(fileProp);
	}
	
	public Page<FileProp> findPage(Page<FileProp> page, FileProp fileProp) {
		return super.findPage(page, fileProp);
	}
	
	public List<FileProp> findListByLibraryId(String id){
		return filePropDao.findListByLibraryId(id);
	}
	
	@Transactional(readOnly = false)
	public void save(FileProp fileProp) {
		super.save(fileProp);
	}
	
	@Transactional(readOnly = false)
	public void delete(FileProp fileProp) {
		super.delete(fileProp);
	}
	
	@Transactional(readOnly = false)
	public void deleteByFileLibraryId(String id) {
		filePropDao.deleteByFileLibraryId(id);
	}
	
	@Transactional(readOnly = false)
	public void removeByFileLibraryId(String id){
		filePropDao.removeByFileLibraryId(id);
	}
	
	/**
	 * 默认执行保存操作，不会执行更新操作
	 * @param list
	 * @param fileLibrary
	 */
	@Transactional(readOnly = false)
	public void save(List<FileProp> list,FileLibrary fileLibrary){
		for (FileProp fileProp : list) {
			fileProp.setFileLibrary(fileLibrary);
			fileProp.preInsert();
			filePropDao.insert(fileProp);
		}
	}
}