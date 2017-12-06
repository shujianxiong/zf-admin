/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.sr;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.sr.RedpacketShareTempDao;
import com.chinazhoufan.admin.modules.spm.entity.sr.RedpacketShareTemp;
/**
 * 红包分享模板Service
 * @author 刘晓东
 * @version 2015-11-06
 */
@Service
@Transactional(readOnly = true)
public class RedpacketShareTempService extends CrudService<RedpacketShareTempDao, RedpacketShareTemp> {

	public RedpacketShareTemp get(String id) {
		return super.get(id);
	}
	
	public List<RedpacketShareTemp> findList(RedpacketShareTemp redpacketShareTemp) {
		return super.findList(redpacketShareTemp);
	}
	
	public Page<RedpacketShareTemp> findPage(Page<RedpacketShareTemp> page, RedpacketShareTemp redpacketShareTemp) {
		return super.findPage(page, redpacketShareTemp);
	}
	
	@Transactional(readOnly = false)
	public void save(RedpacketShareTemp redpacketShareTemp) {
		
		if (redpacketShareTemp.getIsNewRecord()){
			//生成时模板使用状态默认为新建
			redpacketShareTemp.setTempStatus(RedpacketShareTemp.AMOUNTTYPE_NEW);
			redpacketShareTemp.preInsert();
			dao.insert(redpacketShareTemp);
		}else{
			redpacketShareTemp.preUpdate();
			dao.update(redpacketShareTemp);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(RedpacketShareTemp redpacketShareTemp) {
		super.delete(redpacketShareTemp);
	}
	
	@Transactional(readOnly = false)
	public int enable(RedpacketShareTemp redpacketShareTemp){
		/**
		 * 首先判断当前是否已有启用状态的，有则先关闭启用的，无则直接启用
		 */
		int cnt = dao.count();
		if (cnt > 0) {
			dao.updateDisabled();
		}
		return cnt;
	}

	/**
	 * 红包模板状态更新
	 * @param redpacketShareTempOld
	 */
	@Transactional(readOnly = false)
	public void update(RedpacketShareTemp redpacketShareTemp) {
		redpacketShareTemp.preUpdate();
		dao.update(redpacketShareTemp);
	}
	
}