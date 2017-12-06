/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service.ap;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bas.dao.BasMissionDao;
import com.chinazhoufan.admin.modules.bas.dao.ap.ApproveConfigDao;
import com.chinazhoufan.admin.modules.bas.entity.BasMission;
import com.chinazhoufan.admin.modules.bas.entity.ap.ApproveConfig;
import com.chinazhoufan.admin.modules.msg.dao.um.UmMessageDao;
import com.chinazhoufan.admin.modules.msg.entity.um.UmMessage;

/**
 * 审批设置Service
 * @author 贾斌
 * @version 2016-03-31
 */
@Service
@Transactional(readOnly = true)
public class ApproveConfigService extends CrudService<ApproveConfigDao, ApproveConfig> {

	@Autowired
	private ApproveConfigDao approveConfigDao;
	@Autowired
	private BasMissionDao basMissionDao;
	@Autowired
	private UmMessageDao umMessageDao;
	
	
	public ApproveConfig get(String id) {
		return super.get(id);
	}
	
	public ApproveConfig get(String businessType,String businessStatus) {
		return approveConfigDao.getByType(businessType,businessStatus);
	}
	
	public List<ApproveConfig> findList(ApproveConfig approveConfig) {
		return super.findList(approveConfig);
	}
	
	public Page<ApproveConfig> findPage(Page<ApproveConfig> page, ApproveConfig approveConfig) {
		return super.findPage(page, approveConfig);
	}
	
	@Transactional(readOnly = false)
	public void save(ApproveConfig approveConfig) {
		super.save(approveConfig);
	}
	
	@Transactional(readOnly = false)
	public int saveApproveConfig(ApproveConfig approveConfig) {
		int flag = 0;
		//审批业务类型，审批业务状态类型一致只允许添加一条记录，同一类型只允许一个人审批，不支持多人审批
		ApproveConfig ac = new ApproveConfig();
		ac.setBusinessType(approveConfig.getBusinessType());
		ac.setBusinessStatus(approveConfig.getBusinessStatus());
		List<ApproveConfig> list = dao.findList(ac);
		if(list != null && list.size() > 0) {
			ac = list.get(0);
			if(!ac.getId().equals(approveConfig.getId())) {
				flag = 1;
			}
		}
		if(flag == 0) {
			super.save(approveConfig);
		}
		return flag;
	}
	
	
	@Transactional(readOnly = false)
	public void delete(ApproveConfig approveConfig) {
		super.delete(approveConfig);
	}
	
	@Transactional(readOnly = false)
	public void updateFlag(ApproveConfig approveConfig) {
		approveConfigDao.updateFlag(approveConfig);
	}
	
	public boolean isOpen(ApproveConfig approveConfig){
		if(ApproveConfig.FALSE_FLAG.equals(approveConfig.getUsableFlag())){
			return false;
		}
		return true;
	}
	
	@Transactional(readOnly = false)
	public void saveBasMissionApprove(ApproveConfig approveConfig,BasMission basMission){
		//还未创建审核，创建审核
    	basMission.setApproveStatus(BasMission.APPROVESTATUS_WAIT);
    	basMission.setApproveUser(approveConfig.getApproveUser());
    	basMission.preUpdate();
    	basMissionDao.update(basMission);
	}
	
	@Transactional(readOnly = false)
	public void saveUmMessageApprove(ApproveConfig approveConfig,BasMission basMission) {
		//发出通知
    	UmMessage umMessage = new UmMessage();
    	umMessage.setCategory("2");
    	umMessage.setType("1");
    	umMessage.setTitle("任务"+basMission.getMissionCode()+"待审核");
    	umMessage.setContent("任务"+basMission.getMissionCode()+"待审核");
    	umMessage.setReceiveUser(approveConfig.getApproveUser());
    	umMessage.setStatus(UmMessage.STATUS_NOT_VIEWED);
    	umMessage.setPushTime(new Date());
    	umMessage.preInsert();
    	umMessageDao.insert(umMessage);
	}
	
	@Transactional(readOnly = false)
	public boolean isApproval(ApproveConfig approveConfig,BasMission basMission){
		if(BasMission.APPROVESTATUS_WAIT.equals(basMission.getApproveStatus())
        		|| BasMission.APPROVESTATUS_REFUSE.equals(basMission.getApproveStatus())){
        	//待审核,审核未通过，抛出异常
        	return false;
        }
		if(BasMission.APPROVESTATUS_SUCCESS.equals(basMission.getApproveStatus())){
        	//审核通过
        	return true;
        }
		return false;
	}
	
}