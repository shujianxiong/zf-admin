/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.pj;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bus.entity.pj.ProduceJudgePhoto;
import com.chinazhoufan.admin.modules.bus.dao.pj.ProduceJudgePhotoDao;

/**
 * 产品评价图片Service
 * @author liut
 * @version 2017-07-28
 */
@Service
@Transactional(readOnly = true)
public class ProduceJudgePhotoService extends CrudService<ProduceJudgePhotoDao, ProduceJudgePhoto> {

	public ProduceJudgePhoto get(String id) {
		return super.get(id);
	}
	
	public List<ProduceJudgePhoto> findList(ProduceJudgePhoto produceJudgePhoto) {
		return super.findList(produceJudgePhoto);
	}
	
	public Page<ProduceJudgePhoto> findPage(Page<ProduceJudgePhoto> page, ProduceJudgePhoto produceJudgePhoto) {
		return super.findPage(page, produceJudgePhoto);
	}
	
	@Transactional(readOnly = false)
	public void save(ProduceJudgePhoto produceJudgePhoto) {
		super.save(produceJudgePhoto);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProduceJudgePhoto produceJudgePhoto) {
		super.delete(produceJudgePhoto);
	}
	
}