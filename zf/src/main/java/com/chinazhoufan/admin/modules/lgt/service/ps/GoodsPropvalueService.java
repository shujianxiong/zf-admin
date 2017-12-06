/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsPropvalueDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsProp;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodsPropvalue;

/**
 * 商品属性值表管理Service
 * @author 陈适
 * @version 2015-10-20
 */
@Service
@Transactional(readOnly = true)
public class GoodsPropvalueService extends CrudService<GoodsPropvalueDao, GoodsPropvalue> {

	@Autowired
	private GoodsPropvalueDao goodsPropvalueDao;
	
	
	public GoodsPropvalue get(String id) {
		return super.get(id);
	}
	
	/**
	 * 查询属性的所有属性值
	 */
	public List<GoodsPropvalue> findGoodsPropVal(String goodPropId){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("goodPropId", goodPropId);
		return goodsPropvalueDao.findGoodsPropVal(map);
	}
	
	public List<GoodsPropvalue> findList(GoodsPropvalue lgtPsGoodsPropvalue) {
		return super.findList(lgtPsGoodsPropvalue);
	}
	
	public Page<GoodsPropvalue> findPage(Page<GoodsPropvalue> page, GoodsPropvalue lgtPsGoodsPropvalue) {
		return super.findPage(page, lgtPsGoodsPropvalue);
	}
	
	@Transactional(readOnly = false)
	public void save(GoodsPropvalue lgtPsGoodsPropvalue) {
		super.save(lgtPsGoodsPropvalue);
	}
	
	@Transactional(readOnly = false)
	public void saveList(List<GoodsPropvalue> lgtPsGoodsPropvalue,GoodsProp prop) {
		for(GoodsPropvalue value : lgtPsGoodsPropvalue){
			value.setGoodsProp(prop);
			super.save(value);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(GoodsPropvalue lgtPsGoodsPropvalue) {
		super.delete(lgtPsGoodsPropvalue);
	}

	public void remove(String goodsPropId){
		goodsPropvalueDao.remove(goodsPropId);
	}
	
}