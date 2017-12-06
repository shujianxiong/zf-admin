/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.gd;

import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.dao.gd.CollocationGroupDao;
import com.chinazhoufan.admin.modules.idx.entity.gd.Collocation;
import com.chinazhoufan.admin.modules.idx.entity.gd.CollocationGroup;
import com.chinazhoufan.admin.modules.idx.entity.gd.GroupGoods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;

/**
 * 搭配分组Service
 * @author liut
 * @version 2017-03-15
 */
@Service
@Transactional(readOnly = true)
public class CollocationGroupService extends CrudService<CollocationGroupDao, CollocationGroup> {

	@Autowired
	private GroupGoodsService groupGoodsService;
	
	public CollocationGroup get(String id) {
		return super.get(id);
	}
	
	public List<CollocationGroup> findList(CollocationGroup collocationGroup) {
		return super.findList(collocationGroup);
	}
	
	public Page<CollocationGroup> findPage(Page<CollocationGroup> page, CollocationGroup collocationGroup) {
		return super.findPage(page, collocationGroup);
	}
	
	@Transactional(readOnly = false)
	public void save(CollocationGroup collocationGroup) {
		String ids = collocationGroup.getRelatGoodIds();
		if(StringUtils.isBlank(ids) && "1".equals(collocationGroup.getUsableFlag())) {
			throw new ServiceException("失败：该分组搭配没有选择商品，不能启用！");
		}
		super.save(collocationGroup);
		//先删除分组搭配相关联的分组商品
		groupGoodsService.deleteByCollocationGroup(collocationGroup.getId());
		//再添加
		if(!StringUtils.isBlank(ids)) {
			String[] idsArr = ids.split(",");
			GroupGoods gg = null;
			for(String id : idsArr) {
				String [] idArr = id.split("=");
				gg = new GroupGoods();
				gg.setCollocation(collocationGroup.getCollocation());
				gg.setGoods(new Goods(idArr[0]));
				gg.setOrderNo(Integer.valueOf(idArr[1]+""));
				gg.setGroup(collocationGroup);
				groupGoodsService.save(gg);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(CollocationGroup collocationGroup) {
		//先删除分组搭配相关联的分组商品
		groupGoodsService.deleteByCollocationGroup(collocationGroup.getId());
		super.delete(collocationGroup);
	}
	
	
	/**
	 * 获取搭配分组，同时带出分组商品
	 * @param collocationGroup
	 * @return    设定文件
	 * @throws
	 */
	public CollocationGroup getCollocationWithGroupGoods(CollocationGroup collocationGroup) {
		return dao.getCollocationWithGroupGoods(collocationGroup);
	}
	
	/**
	 * 根据搭配ID，删除对应的分组信息及相关商品信息
	 * @param collocationId    设定文件
	 * @throws
	 */
	public void  deleteGroupByCollocation(String collocationId) {
		groupGoodsService.deleteByCollocation(collocationId);
		CollocationGroup cg = new CollocationGroup();
		Collocation c = new Collocation(collocationId);
		cg.setCollocation(c);
		dao.deleteGroupByCollocation(cg);
	}
	/**
	 * 根据搭配ID，修改启用禁用状态
	 * @throws
	 */
	@Transactional(readOnly = false)
	public void  updateUsable(CollocationGroup collocationGroup) {
		CollocationGroup collocationGroupWithDetail = getCollocationWithGroupGoods(collocationGroup);
		String ids = collocationGroupWithDetail.getGgList().size()>0?"yes":null;
		if(StringUtils.isBlank(ids) && "1".equals(collocationGroup.getUsableFlag())) {
			throw new ServiceException("失败：该分组搭配没有选择商品，不能启用！");
		}
		dao.updateUsable(collocationGroup);
	}
	
}