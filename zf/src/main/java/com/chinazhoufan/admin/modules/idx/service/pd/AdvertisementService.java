/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.pd;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.pd.Advertisement;
import com.chinazhoufan.admin.modules.idx.dao.pd.AdvertisementDao;

/**
 * 广告Service
 * @author 张金俊
 * @version 2016-08-12
 */
@Service
@Transactional(readOnly = true)
public class AdvertisementService extends CrudService<AdvertisementDao, Advertisement> {

	public Advertisement get(String id) {
		return super.get(id);
	}
	
	public List<Advertisement> findList(Advertisement advertisement) {
		return super.findList(advertisement);
	}
	
	public Page<Advertisement> findPage(Page<Advertisement> page, Advertisement advertisement) {
		return super.findPage(page, advertisement);
	}
	
	@Transactional(readOnly = false)
	public void save(Advertisement advertisement) {
		super.save(advertisement);
	}
	
	@Transactional(readOnly = false)
	public void delete(Advertisement advertisement) {
		super.delete(advertisement);
	}
	
}