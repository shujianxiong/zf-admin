/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.sr;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.sr.RegisterShareTempDao;
import com.chinazhoufan.admin.modules.spm.entity.sr.RegisterShareTemp;

/**
 * 注册分享模板Service
 * @author 刘晓东
 * @version 2015-11-06
 */
@Service
@Transactional(readOnly = true)
public class RegisterShareTempService extends CrudService<RegisterShareTempDao, RegisterShareTemp> {

	public RegisterShareTemp get(String id) {
		return super.get(id);
	}
	
	public List<RegisterShareTemp> findList(RegisterShareTemp registerShareTemp) {
		return super.findList(registerShareTemp);
	}
	
	public Page<RegisterShareTemp> findPage(Page<RegisterShareTemp> page, RegisterShareTemp registerShareTemp) {
		return super.findPage(page, registerShareTemp);
	}
	
	@Transactional(readOnly = false)
	public void save(RegisterShareTemp registerShareTemp) {
//		super.save(registerShareTemp);
		
		
		if (registerShareTemp.getIsNewRecord()){
			//生成时模板状态默认为新建
			registerShareTemp.setTempStatus(RegisterShareTemp.TEMPSTATUS_NEW);
			
			registerShareTemp.preInsert();
			dao.insert(registerShareTemp);
		}else{
			registerShareTemp.preUpdate();
			dao.update(registerShareTemp);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(RegisterShareTemp registerShareTemp) {
		super.delete(registerShareTemp);
	}
	
	@Transactional(readOnly = false)
	public int enable(RegisterShareTemp registerShareTemp){
		/**
		 * 首先判断当前是否已有启用状态的，有则关闭所有启用的
		 */
		int cnt = dao.count();
		if (cnt > 0) {
			dao.updateDisabled();
		}
		return cnt;
	}

	/**
	 * 注册模板状态更新
	 * @param registerShareTempOld
	 */
	@Transactional(readOnly = false)
	public void update(RegisterShareTemp registerShareTemp) {
		registerShareTemp.preUpdate();
		dao.update(registerShareTemp);
	}
}