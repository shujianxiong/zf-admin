/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.List;
import java.util.Set;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.chinazhoufan.admin.common.persistence.BaseEntity;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.CategoriesDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.utils.GoodsPropertyCacheUtil;
import com.google.common.collect.Lists;

/**
 * 商品分类管理Service
 * @author 杨晓辉
 * @version 2015-10-12
 */
@Service
@Transactional(readOnly = true)
public class CategoriesService extends CrudService<CategoriesDao, Categories> {

	
	public Categories get(String id) {
		return super.get(id);
	}
	
	public List<Categories> findListByPropertyId(String propertyId){
		return dao.findListByPropertyId(new Property(propertyId));
	}
	
	public List<Categories> findListBySearch(Categories lgtPsCategory) {
		return dao.findListBySearch(lgtPsCategory);
	} 
	
	public List<Categories> findList(Categories lgtPsCategory) {
		return dao.findListBySearch(lgtPsCategory);
	}
	
	public List<Categories> findList() {
		return dao.findAllList(new Categories());
	}
	
	public Page<Categories> findPage(Page<Categories> page, Categories lgtPsCategory) {
		return super.findPage(page, lgtPsCategory);
	}
	
	@Transactional(readOnly = false)
	public void save(Categories lgtPsCategory) {
		
		
		
		lgtPsCategory.setParent(this.get(lgtPsCategory.getParent().getId()));
		
		// 获取修改前的parentIds，用于更新子节点的parentIds
		String oldParentIds = lgtPsCategory.getAllParentId();
		
		// 如果有父节点追加父节点到父节点串
		if(lgtPsCategory.getParent()!=null&&!StringUtils.isBlank(lgtPsCategory.getParent().getId()))
			lgtPsCategory.setAllParentId(lgtPsCategory.getParent().getAllParentId()+lgtPsCategory.getParent().getId()+",");

		
		// 保存或更新实体
		if (StringUtils.isBlank(lgtPsCategory.getId())){
			lgtPsCategory.setIsNewRecord(true);	// 属性ID采用数据库自增方式
		}
		super.save(lgtPsCategory);
		
		// 更新子节点 parentIds
		Categories l = new Categories();
		l.setAllParentId("%,"+lgtPsCategory.getId()+",%");
		List<Categories> list = dao.findByParentIdsLike(l);
		for (Categories e : list){
			e.setAllParentId(e.getAllParentId().replace(oldParentIds, lgtPsCategory.getAllParentId()));
			dao.updateParentIds(e);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(Categories category) {
		super.delete(category);
		List<Categories> list = findChildListById(category);
		for(Categories c: list){
			delete(c);
		}
	}
	/**
	 * 根据id 查询 下面一级的子分类
	 * @param category
	 * @return
	 */
	private List<Categories> findChildListById(Categories category) {
		return dao.findChildListById(category);
	}

	public List<Categories> findByParentIdsLike(Categories categories){
		return dao.findByParentIdsLike(categories);
	}

	/**
	 * 
	 * @param set 分类id集合
	 * @return
	 */
	public List<Categories> findCategiryByIds(Set<String> set) {
		if(!set.isEmpty()){
			List<Categories> result = dao.findCategiryByIds(set,BaseEntity.DEL_FLAG_NORMAL);
			setPropertyAndValue(result);
			return result;
		}else{
			return Lists.newArrayList();
		}
	}
	
	//给分类里面的属性 属性值 根据对应id 赋值
	private void setPropertyAndValue(List<Categories> result){
		List<Property> temps = null;
		List<Property> allProperty = Lists.newArrayList();
		for(Categories c : result){
			List<Property> list = Lists.newArrayList();
			temps = GoodsPropertyCacheUtil.getPropertyByCategoryId(c.getId());
			for(Property p : temps){
				//属性过滤 如果在某个分类下面存在属性或者存在同名属性那么就过滤
				if(!p.getPropvalueList().isEmpty() && !allProperty.contains(p) && !checkPropertyName(allProperty, p)){
					list.add(p);
					allProperty.add(p);
				}
			}
			c.setLgtPsPropertyList(list);
		}
	}
	
	/**
	 * 判断属性名是否有重复的
	 * @return
	 */
	private boolean checkPropertyName(List<Property> allProperty, Property p){
		for(Property property : allProperty){
			if(property.getPropName().equals(p.getPropName())){
				return true;
			}
		}
		return false;
	}
	
	
}