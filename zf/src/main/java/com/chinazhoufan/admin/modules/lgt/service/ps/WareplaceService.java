/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.bas.entity.ScanCode;
import com.chinazhoufan.admin.modules.bas.service.ScanCodeService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WareplaceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;

/**
 * 货位列表Service
 * @author 贾斌
 * @version 2015-10-13
 */
@Service
@Transactional(readOnly = true)
public class WareplaceService extends CrudService<WareplaceDao, Wareplace> {

	@Autowired
	private WareplaceDao wareplaceDao;
	@Autowired
	private ScanCodeService scanCodeService;

	@Autowired
	private CodeGeneratorService codeGeneratorService;
	
	
	public Wareplace get(String id) {
		return super.get(id);
	}
	
	/**
	 * （在正常货架中）根据仓库、存放产品查询货位信息
	 * @param warehouseId	仓库ID
	 * @param produceId		产品ID
	 * @return
	 */
	public Wareplace getNormalByProduceId(String warehouseId, String produceId){
		return dao.getNormalByProduceId(warehouseId, produceId);
	}

	/**
	 * （在正常货架中）根据仓库、货架分类查询第一个空货位信息(同时锁定该货位)
	 * @param warehouseId	仓库ID
	 * @param categoryId	分类ID
	 * @return
	 */
	public Wareplace getNormalFirstEmptyForUpdate(String warehouseId, String categoryId){
		return dao.getNormalFirstEmptyForUpdate(warehouseId, categoryId);
	}

	/**
	 * 根据电子码查询货位信息（包含货位所属货柜、区域、仓库信息）
	 * @param scanCode	电子码
	 * @return
	 */
	public Wareplace getByScanCode(String scanCode){
		return dao.getByScanCode(scanCode);
	}
	
	public List<Wareplace> findList(Wareplace wareplace) {
		return super.findList(wareplace);
	}
	
	public List<Wareplace> findList() {
		return wareplaceDao.findAllList(new Wareplace());
	}
	
	/**
	 * 查询未存货、未锁定、已启用的所有货位
	 * @param wareplace
	 * @return
	 */
	public List<Wareplace> findListEmpty(Wareplace wareplace) {
		return dao.findListEmpty(wareplace);
	}
	
	public Page<Wareplace> findPage(Page<Wareplace> page, Wareplace wareplace) {
		return super.findPage(page, wareplace);
	}
	
	/**
	 * 根据仓库数据或产品ID，获取货位数据 json方法
	 * @param wareplace
	 * @return
	 */
	public List<Wareplace> findWareplaceListByProduceAndPosition(Wareplace wareplace){
		return wareplaceDao.findWareplaceListByProduceAndPosition(wareplace);
	}
	
	/**
	 * 更新货位锁定状态
	 * @param wareplace.id			要更新的货位ID
	 * @param wareplace.lockFlag	锁定状态
	 * @param wareplace.updateBy	更新者
	 * @param wareplace.updateDate	更新时间
	 */
	public void updateLockFlag(Wareplace wareplace){
		wareplace.preUpdate();
		wareplaceDao.updateLockFlag(wareplace);
	}
	
	/**
	 * 查询货位存储货品数量（包含正常在库的、出入库锁定中的、体验中的等状态的所有货品）
	 * @param wareplaceId
	 * @return Integer
	 */
	public Integer findProductsCountByWareplaceId(String wareplaceId){
		return wareplaceDao.findProductsCountByWareplaceId(wareplaceId);
	}
	
	@Transactional(readOnly = false)
	public void save(Wareplace wareplace) {
		if(StringUtils.isBlank(wareplace.getId())) {
			//编码生成器生成电子码
			wareplace.setScanCode(codeGeneratorService.generateCode("lgt_ps_wareplace_scanCode"));
		}

		super.save(wareplace);
	}
	
	@Transactional(readOnly = false)
	public void delete(Wareplace wareplace) {
		super.delete(wareplace);
	}

	@Transactional(readOnly = false)
	public void update(Wareplace wareplace) {
		wareplace.preUpdate();
		dao.update(wareplace);
	}
	
	
	/**
	 * 根据分类获取可用的仓库货位
	 * @param categoryId
	 * @return
	 */
	public Wareplace getAvaliableWareplaceByCategory(String categoryId) {
		return dao.getAvaliableWareplaceByCategory(categoryId);
	}
	
	
	
}