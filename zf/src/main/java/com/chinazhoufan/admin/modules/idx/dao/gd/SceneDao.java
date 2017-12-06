/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.dao.gd;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.idx.entity.gd.Scene;

/**
 * 场景DAO接口
 * @author liut
 * @version 2017-03-15
 */
@MyBatisDao
public interface SceneDao extends CrudDao<Scene> {

	/**
	 * 获取父场景
	 * @param scene
	 * @return    设定文件
	 * @throws
	 */
	public List<Scene> findParentList(Scene scene);
	
	/**
	 * 获取子场景
	 * @param scene
	 * @return    设定文件
	 * @throws
	 */
	public List<Scene> findSubList(Scene scene);
	
	/**
	 * 统计该场景关联场景及搭配的数据集合
	 * @param scene
	 * @return    设定文件
	 * @throws
	 */
	public Integer countInUsedScene(Scene scene);
	
}