/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.service.as;

import java.util.List;

import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkordProduct;
import com.chinazhoufan.admin.modules.ser.dao.as.QualityWorkordProductDao;

/**
 * 质检工单货品表Service
 * @author 舒剑雄
 * @version 2017-10-13
 */
@Service
@Transactional(readOnly = true)
public class QualityWorkordProductService extends CrudService<QualityWorkordProductDao, QualityWorkordProduct> {

	public QualityWorkordProduct get(String id) {
		return super.get(id);
	}
	
	public List<QualityWorkordProduct> findList(QualityWorkordProduct qualityWorkordProduct) {
		return super.findList(qualityWorkordProduct);
	}
	
	public Page<QualityWorkordProduct> findPage(Page<QualityWorkordProduct> page, QualityWorkordProduct qualityWorkordProduct) {
		return super.findPage(page, qualityWorkordProduct);
	}
	
	@Transactional(readOnly = false)
	public void save(QualityWorkordProduct qualityWorkordProduct) {
		super.save(qualityWorkordProduct);
	}
	
	@Transactional(readOnly = false)
	public void delete(QualityWorkordProduct qualityWorkordProduct) {
		super.delete(qualityWorkordProduct);
	}

	/**
	 * 批量更新质检货品数据
	 */
	@Transactional(readOnly = false)
	public void batchSave(List<QualityWorkordProduct> qualityWorkordProducts) {
		for(QualityWorkordProduct qualityWorkordProduct :qualityWorkordProducts){
			//更新退货货品
			save(qualityWorkordProduct);
		}
	}
	public List<QualityWorkordProduct> findListByQualityWorkorderId(QualityWorkordProduct qualityWorkordProduct) {
		return dao.findListByQualityWorkorderId(qualityWorkordProduct);
	}
	
}