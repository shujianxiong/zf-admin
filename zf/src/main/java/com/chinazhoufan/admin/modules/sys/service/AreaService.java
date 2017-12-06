/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.service.TreeService;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.modules.sys.dao.AreaDao;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.google.common.collect.Lists;

/**
 * 区域Service
 * @author ThinkGem
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class AreaService extends TreeService<AreaDao, Area> {
	
	@Autowired
	private RedisCacheService<String, List<Area>> areaRedisCacheService;

	/**
	 * 通过区域名称查询区域
	 * @param name
	 * @return
	 */
	public List<Area> findByName(String name){
		return dao.findByName(name);
	}
	
	public List<Area> findAll(){
		return dao.findAllList(new Area());
	}
	
	public List<Area> findAllList(Area area) {
		List<Area> list = (List<Area>) areaRedisCacheService.get(RedisCacheService.AREA_LIST_KEY);
		if (list == null || list.isEmpty()) {
			list = dao.findAllList(area);
			areaRedisCacheService.set(RedisCacheService.AREA_LIST_KEY, list, 60*30);
		}
		return list;
	}
	
	public Area get(String id) {
		List<Area> list = findAllList(new Area());
		for (Area area : list) {
			if (id.equals(area.getId())) {
				return area;
			}
		}
		return null;
	}
	
	/**
	 * 根据区域ID查询区域完整名称
	 * @param areaId
	 * @return
	 */
	public String getAreaFullName(String areaId) {
		Area area = get(areaId);
		String fullName = "";
		if (area != null && StringUtils.isNotBlank(area.getId())) {
			String[] parentIdArr = area.getParentIds().split(",");
			for (String parentId : parentIdArr) {
				if ("0".equals(parentId)||"1".equals(parentId)) { //过滤掉ID为“0”和“1”
					continue;
				}
				fullName+=get(parentId).getName();
			}
			fullName+=area.getName();
		}
		return fullName;
	}
	
	public Page<Area> findPageByType(Page<Area> page, Area entity) {
		entity.setPage(page);
		page.setList(dao.listByTypeOrPid(entity));
		return page;
	}
	
	
	/**
	 * 显示国省市数据，不包括区
	 * @return
	 */
	public List<Area> findWithOutDistrict(){
		return dao.findWithOutDistrict(new Area());
	}

	/**
	 * 根据父级ID获取子区域集合
	 * @param area
	 * @return
	 */
	public List<Area> listAreaByParentId(Area area) {
		return dao.listAreaByParentId(area);
	}
	
	/**
	 * 根据区域类型获取区域集合
	 * @param area
	 * @return
	 */
	public List<Area> listAreaByType(Area area) {
		return dao.listAreaByType(area);
	}
	
	
	@Transactional(readOnly = false)
	public void save(Area area) {
		super.save(area);
		areaRedisCacheService.del(RedisCacheService.AREA_LIST_KEY);
	}
	
	@Transactional(readOnly = false)
	public void delete(Area area) {
		super.delete(area);
		areaRedisCacheService.del(RedisCacheService.AREA_LIST_KEY);
	}

	public List<Area> findAllChildAreaById(String type, String areaId) {
		/**
		 * 1.当参数areaId为空则查询所有的省份
		 * 2.不为空则查询所有下一级子区域
		 */
		List<Area> list = Lists.newArrayList();
		list = dao.findAllChildAreaById(type,areaId);
		return list;
	}
	
	/**
	 * 前台查询配送区域
	 * @param area
	 * @return
	 */
	public List<Area> getForIndex(Area area) {
		return dao.getForIndex(area);
	}
	
	/**
	 * 区域数据Excel导入
	 * @param ei
	 */
	@Transactional(readOnly = false)
	public void importArea(ImportExcel ei) {
		Area area = null;
		Area countryArea = null;
		Area provinceArea = null;
		Area cityArea = null;
		for (int i = 0; i < ei.getLastDataRowNum(); i++) {
			Row row = ei.getRow(i);
			Object val_0 = ei.getCellValue(row, 0);
			Object val_1 = ei.getCellValue(row, 1);
			Object val_2 = ei.getCellValue(row, 2);
			Object val_3 = ei.getCellValue(row, 3);
			System.out.print(val_0+", "+val_1+", "+val_2+", "+val_3+", ");
			if(StringUtils.isNotBlank(val_0.toString())) {//国家  country
				String[] arr = val_0.toString().split("=");
				String code = arr[0];
				String name = arr[1];
				area = new Area();
				area.setCode(code);
				area.setName(name);
				area.setType(Area.TYPE_COUNTRY);
				area.setParent(new Area("0"));
//				area.setParentIds("0,");
				area.setId("1");
				area.setIsNewRecord(true);
				super.save(area);
				countryArea = area;
			} else if(StringUtils.isNotBlank(val_1.toString())) {//省  province
				String[] arr = val_1.toString().split("=");
				String code = arr[0];
				String name = arr[1];
				area = new Area();
				area.setCode(code);
				area.setName(name);
				area.setType(Area.TYPE_PROVINCE);
				area.setParent(countryArea);
//				area.setParentIds(countryArea.getId()+",");
				super.save(area);
				provinceArea = area;
			} else if(StringUtils.isNotBlank(val_2.toString())) {//市  city
				String[] arr = val_2.toString().split("=");
				String code = arr[0];
				String name = arr[1];
				area = new Area();
				area.setCode(code);
				area.setName(name);
				area.setType(Area.TYPE_CITY);
				area.setParent(provinceArea);
//				area.setParentIds(countryArea.getId()+","+provinceArea.getId()+",");
				super.save(area);
				cityArea = area;
			} else if(StringUtils.isNotBlank(val_3.toString())) {//区  district
				String[] arr = val_3.toString().split("=");
				String code = arr[0];
				String name = arr[1];
				area = new Area();
				area.setCode(code);
				area.setName(name);
				area.setType(Area.TYPE_DISTRICT);
				area.setParent(cityArea);
//				area.setParentIds(countryArea.getId()+","+provinceArea.getId()+","+cityArea.getId()+",");
				super.save(area);
			}
		}
	}
	
	
}
