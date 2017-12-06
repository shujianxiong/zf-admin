package com.chinazhoufan.admin.modules.lgt.utils;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.chinazhoufan.admin.common.utils.CacheUtils;
import com.chinazhoufan.admin.common.utils.SpringContextHolder;
import com.chinazhoufan.admin.modules.lgt.dao.ps.PropertyDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Property;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Propvalue;
import com.google.common.collect.Lists;

/**
 * 属性缓存暂未做属性变更缓存维护 10.19
 * 属性缓存已做属性变更缓存维护 16.04.18
 * @author jinjun
 *
 */
public class GoodsPropertyCacheUtil {
	
	private static PropertyDao lgtPsPropertyDao = SpringContextHolder.getBean(PropertyDao.class);

	public static final String CACHE_GOODS_PROPERTY_MAP = "goodsPropertyCache";
	
	
	
	/**
	 * 更新商品属性缓存
	 * @return
	 */
	public static void updatePropertyList(){
		CacheUtils.remove(CACHE_GOODS_PROPERTY_MAP);
		List<Property> propertyList = lgtPsPropertyDao.findPropertyAll(Property.DEL_FLAG_NORMAL, Propvalue.DEL_FLAG_NORMAL);
		//对分类属性进行排序
		for(Property lgtPsProperty : propertyList){
			Collections.sort(lgtPsProperty.getPropvalueList(), new Comparator<Object>() {
			      @Override
			      public int compare(Object o1, Object o2) {
			    	  Propvalue v1=(Propvalue)o1;
			    	  Propvalue v2=(Propvalue)o2;
			    	  return v2.getPvalueName().compareTo(v1.getPvalueName());
			      }
			});
		}
		CacheUtils.put(CACHE_GOODS_PROPERTY_MAP, propertyList);
	}
	
	/**
	 * 获得商品属性缓存,如果缓存不存在则从数据库获取并保存到缓存
	 * @return
	 */
	public static List<Property> getPropertyList(){
		if (CacheUtils.get(CACHE_GOODS_PROPERTY_MAP) == null){
			updatePropertyList();
		}
		@SuppressWarnings("unchecked")
		List<Property> propertyList = (List<Property>)CacheUtils.get(CACHE_GOODS_PROPERTY_MAP);
		return  propertyList;
	}
	
	/**
	 * 获得分类下对应的属性
	 * @param categoryId
	 * @return
	 */
	public static List<Property> getPropertyByCategoryId(String categoryId){
		List<Property> list=Lists.newArrayList();
		for (Property property : getPropertyList()) {
			for(Categories category:property.getCategoryList()){
				if(category.getId().equals(categoryId)){
					list.add(property);
					//break;
				}
			}
		}
		return list;
	}
	
	/**
	 * 获得属性值
	 * @param propvalueId
	 * @return
	 */
	public static Propvalue getPropvalueByPropvalueId(String propvalueId){
		for (Property property : getPropertyList()) {
			for(Propvalue p:property.getPropvalueList()){
				if(p.getId().equals(propvalueId)){
					return p;
				}
			}
		}
		return null;
	}
	
	/**
	 * 根据属性id 获取属性对象
	 * @param propertyId
	 * @return
	 */
	public static Property getProperty(String propertyId){
		for (Property property : getPropertyList()) {
			if(property.getId().equals(propertyId)){
				return property;
			}
		}
		return null;
	}
}
