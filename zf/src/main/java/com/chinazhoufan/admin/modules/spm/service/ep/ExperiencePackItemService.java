/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ep;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePackItem;
import com.chinazhoufan.admin.modules.spm.dao.ep.ExperiencePackItemDao;

/**
 * 体验包体验记录Service
 * @author 舒剑雄
 * @version 2017-08-31
 */
@Service
@Transactional(readOnly = true)
public class ExperiencePackItemService extends CrudService<ExperiencePackItemDao, ExperiencePackItem> {

	public ExperiencePackItem get(String id) {
		return super.get(id);
	}
	
	public List<ExperiencePackItem> findList(ExperiencePackItem experiencePackItem) {
		return super.findList(experiencePackItem);
	}
	
	public Page<ExperiencePackItem> findPage(Page<ExperiencePackItem> page, ExperiencePackItem experiencePackItem) {
		return super.findPage(page, experiencePackItem);
	}
	
	@Transactional(readOnly = false)
	public void save(ExperiencePackItem experiencePackItem) {
		super.save(experiencePackItem);
	}
	
	@Transactional(readOnly = false)
	public void delete(ExperiencePackItem experiencePackItem) {
		super.delete(experiencePackItem);
	}

	public ExperiencePackItem getByMemberAndType(Map<String, Object> map){
		return dao.getByMemberAndType(map);
	}

	public List<ExperiencePackItem> findListOverdue() {
		return dao.findListOverdue();
	}
	@Transactional(readOnly = false)
	public void updateBatch(ExperiencePackItem experiencePackItem){
		experiencePackItem.setUpdateDate(new Date());
		experiencePackItem.setUpdateBy(UserUtils.getUser());
		dao.updateBatch(experiencePackItem);
	}

	public ExperiencePackItem getByMember(String memberId) {
		Map<String,	Object> map = Maps.newHashMap();
		map.put("memberId", memberId);
		map.put("status", ExperiencePackItem.CAN_USE);
		return dao.getByMember(map);
	}
	public ExperiencePackItem getByEp(Date orderTime ,String experiencePackId) {
		Map<String,	Object> map = Maps.newHashMap();
		map.put("experiencePackId", experiencePackId);
		map.put("status", ExperiencePackItem.CAN_USE);
		map.put("orderTime", orderTime);
		return dao.getByEp(map);
	}
}