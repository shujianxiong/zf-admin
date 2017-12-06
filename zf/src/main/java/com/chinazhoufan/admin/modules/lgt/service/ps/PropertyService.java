/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.CategoriesDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.PropertyDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.PropvalueDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Propvalue;
import com.chinazhoufan.admin.modules.lgt.utils.GoodsPropertyCacheUtil;

/**
 * 属性表Service
 * @author 张金俊
 * @version 2015-10-13
 */
@Service
@Transactional(readOnly = true)
public class PropertyService extends CrudService<PropertyDao, Property> {
	
	@Autowired
	private PropertyDao lgtPsPropertyDao;
	
	@Autowired
	private PropvalueDao lgtPsPropvalueDao;
	
	@Autowired
	private CategoriesDao lgtPsCategoryDao;

	public Property get(String id) {
		Property property=super.get(id);
		property.setCategoryList(lgtPsCategoryDao.findListByPropertyId(property));
		property.setPropvalueList(lgtPsPropvalueDao.findPropvaluesByPropertyId(property));
		
		return property;
	}
	
	public List<Property> findList(Property lgtPsProperty) {
		return super.findList(lgtPsProperty);
	}
	
	/**
	 * 判断当前分类下是否有相同的属性名
	 * @param lgtPsCategoryId
	 * @param propName
	 * @return
	 */
	public boolean findPropertyByPropNameisExist(String lgtPsCategoryId,String propName){
		
		return false;
	}
	
	public Page<Property> findPage(Page<Property> page, Property lgtPsProperty) {
		return super.findPage(page, lgtPsProperty);
	}
	
	@Transactional(readOnly = false)
	public void save(Property lgtPsProperty) {
		
		boolean newEntity = StringUtils.isBlank(lgtPsProperty.getId());
		// 更新数据
		if(StringUtils.isBlank(lgtPsProperty.getId())){
			lgtPsProperty.setIsNewRecord(true);	// 属性ID采用数据库自增方式
		}
		super.save(lgtPsProperty);
		
		
		// 删除属性和分类原有关联记录，先移除关联关系再保存新关联关系
		lgtPsPropertyDao.deleteCategoryProp(lgtPsProperty.getId());
		
		// 插入属性和分类关联记录
		for(Categories category : lgtPsProperty.getCategoryList()){
			lgtPsPropertyDao.insertCategoryProp(category.getId().trim(), lgtPsProperty.getId().trim());
		}
		
		if(newEntity){
			// 新增、插入属性值
			for(Propvalue propvalue : lgtPsProperty.getPropvalueList()){
				if(StringUtils.isBlank(propvalue.getPvalueName())
						|| StringUtils.isBlank(propvalue.getPvalueNickname()))
					continue;
				propvalue.setIsNewRecord(true);	// 属性值ID采用数据库自增方式
				propvalue.setProperty(lgtPsProperty);
				propvalue.preInsert();
				lgtPsPropvalueDao.insert(propvalue);
			}
		}else{
			// 修改、更新属性值
			for(Propvalue propvalue : lgtPsProperty.getPropvalueList()){
				if(StringUtils.isBlank(propvalue.getPvalueName())
						|| StringUtils.isBlank(propvalue.getPvalueNickname()))
					continue;
				// 判断新属性值是否已存在
				if(StringUtils.isBlank(propvalue.getId())){
					// 新增属性值
					propvalue.setIsNewRecord(true);		// 属性值ID采用数据库自增方式
					propvalue.setProperty(lgtPsProperty);
					propvalue.preInsert();
					lgtPsPropvalueDao.insert(propvalue);
				}else{
					// 更新属性值
					propvalue.preUpdate();
					lgtPsPropvalueDao.update(propvalue);
				}
			}
		}
		
		// 更新商品属性缓存
		GoodsPropertyCacheUtil.updatePropertyList();
	}
	
	@Transactional(readOnly = false)
	public void delete(Property lgtPsProperty) {
		super.delete(lgtPsProperty);
		// 更新商品属性缓存
		GoodsPropertyCacheUtil.updatePropertyList();
	}

	public List<Property> findCategoryById(String categoryId) {
		return null;
	}
	
	
	/**
	 * 查询所有属性（根据条件）for Api
	 * @param property
	 * @return
	 */
	public List<Property> findListData(Property property){
		return dao.findListData(property);
	}
	
	
	/**
	 * 根据是否筛选可用状态  列出所有属性及对应的属性值
	 * @param property
	 * @return
	 */
	public List<Property> listAllPropertyWithPropValueByFilterFlag(Property property) {
		return dao.listAllPropertyWithPropValueByFilterFlag(property);
	};
	
	
}