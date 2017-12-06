/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.TreeDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {

	/**
	 * 通过区域名称查询区域
	 * @param name
	 * @return
	 */
	public List<Area> findByName(String name);
	
	public List<Area> findAllChildAreaById(@Param("type")String type, @Param("areaId")String areaId);
	
	/**
	 * 前台查询配送区域
	 * @param area
	 * @return
	 */
	public List<Area> getForIndex(Area area);
	
	/**
	 * 显示国省市数据，不包括区
	 * @param area
	 * @return
	 */
	public List<Area> findWithOutDistrict(Area area);
	
	/**
	 * 根据父级ID获取子区域集合
	 * @param area
	 * @return
	 */
	public List<Area> listAreaByParentId(Area area);
	 
	/**
	 * 根据区域类型获取区域集合
	 * @param area
	 * @return
	 */
	public List<Area> listAreaByType(Area area);
	
	/**
	 * 列表显示所有区数据
	 * @param area
	 * @return
	 */
	public List<Area> listByTypeOrPid(Area area);
	
	
	
	
}
