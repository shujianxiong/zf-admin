/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.fd;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.spm.entity.fd.FreeDeposit;
import com.chinazhoufan.admin.modules.spm.dao.fd.FreeDepositDao;

/**
 * 免押金活动配置表Service
 * @author liuxiaodong
 * @version 2017-10-15
 */
@Service
@Transactional(readOnly = true)
public class FreeDepositService extends CrudService<FreeDepositDao, FreeDeposit> {

	public FreeDeposit get(String id) {
		return super.get(id);
	}
	
	public List<FreeDeposit> findList(FreeDeposit freeDeposit) {
		return super.findList(freeDeposit);
	}
	
	public Page<FreeDeposit> findPage(Page<FreeDeposit> page, FreeDeposit freeDeposit) {
		return super.findPage(page, freeDeposit);
	}
	
	@Transactional(readOnly = false)
	public void save(FreeDeposit freeDeposit) {
		if (countByStartTime(freeDeposit) > 0&&FreeDeposit.TRUE_FLAG.equals(freeDeposit.getActiveFlag())) {
			throw new ServiceException("操作失败，当前时间段已存在启用的记录！");
		}
		if (StringUtils.isBlank(freeDeposit.getId())) {
			freeDeposit.setSurplusPlaces(freeDeposit.getPlaces());
			freeDeposit.setRegisterNum(0);
		}
		super.save(freeDeposit);
	}
	
	@Transactional(readOnly = false)
	public void delete(FreeDeposit freeDeposit) {
		super.delete(freeDeposit);
	}
	
	private int countByStartTime(FreeDeposit freeDeposit) {
		return dao.countByStartTime(freeDeposit);
	}
}