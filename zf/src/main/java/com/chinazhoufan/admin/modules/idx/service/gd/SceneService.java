/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.gd;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.gd.Scene;
import com.chinazhoufan.admin.modules.idx.dao.gd.SceneDao;

/**
 * 场景Service
 * @author liut
 * @version 2017-03-15
 */
@Service
@Transactional(readOnly = true)
public class SceneService extends CrudService<SceneDao, Scene> {

	public Scene get(String id) {
		return super.get(id);
	}
	
	public List<Scene> findList(Scene scene) {
		return super.findList(scene);
	}
	
	public Page<Scene> findParentPage(Page<Scene> page, Scene scene) {
		scene.setPage(page);
		page.setList(dao.findParentList(scene));
		return page;
	}
	
	public List<Scene> findParentList(Scene scene) {
		return dao.findParentList(scene);
	}
	
	public List<Scene> findSubList(Scene scene) {
		return dao.findSubList(scene);
	}
	 
	public Page<Scene> findPage(Page<Scene> page, Scene scene) {
		return super.findPage(page, scene);
	}
	
	@Transactional(readOnly = false)
	public void save(Scene scene) {
		super.save(scene);
	}
	
	@Transactional(readOnly = false)
	public void delete(Scene scene) {
		super.delete(scene);
	}
	
	@Transactional(readOnly = false)
	public Integer deleteByScene(Scene scene) {
		//判断场景是否有关联的子场景及相关的搭配，如果有提示不能删除
		Integer count = dao.countInUsedScene(scene);
		if(count == 0) {
			super.delete(scene);
		}
		return count;
	}

	public List<Scene> findUsableParentList() {
		Scene scene = new Scene();
		scene.setUsableFlag(Scene.TRUE_FLAG);
		return dao.findParentList(scene);
	}
	
	public List<Scene> findUsableSubList() {
		Scene scene = new Scene();
		scene.setUsableFlag(Scene.TRUE_FLAG);
		return dao.findSubList(scene);
	}

	public Page<Scene> findSubPage(Page<Scene> page, Scene scene) {
		scene.setPage(page);
		scene.setUsableFlag(Scene.TRUE_FLAG);
		page.setList(findSubList(scene));
		return page;
	}
}