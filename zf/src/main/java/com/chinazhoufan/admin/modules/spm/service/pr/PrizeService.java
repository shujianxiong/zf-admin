/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.pr;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.pr.PrizeDao;
import com.chinazhoufan.admin.modules.spm.entity.pr.Prize;

/**
 * 奖品表Service
 * @author liut
 * @version 2016-05-19
 */
@Service
@Transactional(readOnly = true)
public class PrizeService extends CrudService<PrizeDao, Prize> {

	public Prize get(String id) {
		return super.get(id);
	}
	
	public List<Prize> findList(Prize prize) {
		return super.findList(prize);
	}
	
	public Page<Prize> findPage(Page<Prize> page, Prize prize) {
		return super.findPage(page, prize);
	}
	
	@Transactional(readOnly = false)
	public void save(Prize prize) {
		super.save(prize);
	}
	
	@Transactional(readOnly = false)
	public void delete(Prize prize) {
		super.delete(prize);
	}
	
	@Transactional(readOnly = false)
	public void changeFlag(Prize prize) {
		prize.preUpdate();
		dao.update(prize);
	}
}