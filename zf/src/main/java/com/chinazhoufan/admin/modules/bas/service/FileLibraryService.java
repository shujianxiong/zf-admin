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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.dao.FileLibraryDao;
import com.chinazhoufan.admin.modules.bas.entity.FileLibrary;

/**
 * 图片库Service
 * @author 刘晓东
 * @version 2016-05-03
 */
@Service
@Transactional(readOnly = true)
public class FileLibraryService extends CrudService<FileLibraryDao, FileLibrary> {
	
	@Autowired
	private FileLibraryDao fileLibraryDao;
	
	@Autowired
	private FilePropService filePropService;
	
	public FileLibrary get(String id) {
		return super.get(id);
	}
	
	public FileLibrary find(String id) {
		return fileLibraryDao.find(id);
	}
	
	/**
	 * 根据图片ID查询图片信息、图片属性信息
	 * @param id 图片ID
	 * @return
	 */
	public FileLibrary getFileAndPropertyById(String id){
		return dao.findFileAndPropertyById(id);
	}
	
	public List<FileLibrary> findList(FileLibrary fileLibrary) {
		return super.findList(fileLibrary);
	}
	
	public Page<FileLibrary> findPage(Page<FileLibrary> page, FileLibrary fileLibrary) {
		return super.findPage(page, fileLibrary);
	}
	
	@Transactional(readOnly = false)
	public void save(FileLibrary fileLibrary) {
		//清除以前的关联
		filePropService.removeByFileLibraryId(fileLibrary.getId());
		
		//以单张图的形式保存图片
		FileLibrary fileLibraryNew=null;
		String[] urls=fileLibrary.getFileUrl().split("\\|");
		if(!StringUtils.isBlank(fileLibrary.getId())){
			delete(fileLibrary);
		}
		for(int i=0;i<urls.length;i++){
			if(StringUtils.isBlank(urls[i]))
				continue;
			fileLibraryNew=new FileLibrary();
			fileLibraryNew.setName(fileLibrary.getName());
			fileLibraryNew.setBrand(fileLibrary.getBrand());
			fileLibraryNew.setCategory(fileLibrary.getCategory());
			fileLibraryNew.setDesigner(fileLibrary.getDesigner());
			fileLibraryNew.setGoods(fileLibrary.getGoods());
			fileLibraryNew.setFileUrl(urls[i]);
			fileLibraryNew.setSupplier(fileLibrary.getSupplier());
			fileLibraryNew.setType(fileLibrary.getType());
			fileLibraryNew.setFileDir(fileLibrary.getFileDir());
			super.save(fileLibraryNew);
			filePropService.save(fileLibrary.getFileProps(), fileLibraryNew);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(FileLibrary fileLibrary) {
		super.delete(fileLibrary);
		filePropService.deleteByFileLibraryId(fileLibrary.getId());
	}
	
	@Transactional(readOnly = false)
	public void delete(String[] fileLibrarys) {
		for (String id : fileLibrarys) {
			super.delete(new FileLibrary(id));
			filePropService.deleteByFileLibraryId(id);
		}
	}
	
	public List<FileLibrary> findByFileUrl(String fileUrl){
		return dao.findByFileUrl(fileUrl);
	}
	
}