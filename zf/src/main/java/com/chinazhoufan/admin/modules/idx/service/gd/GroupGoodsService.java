/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.gd;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.dao.gd.GroupGoodsDao;
import com.chinazhoufan.admin.modules.idx.entity.gd.Collocation;
import com.chinazhoufan.admin.modules.idx.entity.gd.CollocationGroup;
import com.chinazhoufan.admin.modules.idx.entity.gd.GroupGoods;

/**
 * 搭配分组商品Service
 * @author liut
 * @version 2017-03-15
 */
@Service
@Transactional(readOnly = true)
public class GroupGoodsService extends CrudService<GroupGoodsDao, GroupGoods> {

	public GroupGoods get(String id) {
		return super.get(id);
	}
	
	public List<GroupGoods> findList(GroupGoods groupGoods) {
		return super.findList(groupGoods);
	}
	
	public Page<GroupGoods> findPage(Page<GroupGoods> page, GroupGoods groupGoods) {
		return super.findPage(page, groupGoods);
	}
	
	@Transactional(readOnly = false)
	public void save(GroupGoods groupGoods) {
		super.save(groupGoods);
	}
	
	@Transactional(readOnly = false)
	public void delete(GroupGoods groupGoods) {
		super.delete(groupGoods);
	}
	
	/**
	 * 根据搭配分组ID，删除对应的分组商品
	 * @param collocationGroupId    设定文件
	 * @throws
	 */
	public void deleteByCollocationGroup(String collocationGroupId) {
		GroupGoods gg = new GroupGoods();
		CollocationGroup cg = new CollocationGroup(collocationGroupId);
		gg.setGroup(cg);
		dao.deleteByCollocationGroup(gg);
	}
	
	/**
	 * 根据搭配ID，删除对应的分组商品
	 * @param collocationGroupId    设定文件
	 * @throws
	 */
	public void deleteByCollocation(String collocationId) {
		GroupGoods gg = new GroupGoods();
		Collocation c = new Collocation(collocationId);
		gg.setCollocation(c);
		dao.deleteByCollocation(gg);
	}
}