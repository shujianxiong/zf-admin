/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.common.schedule.service;

import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePackItem;
import com.chinazhoufan.admin.modules.spm.service.ep.ExperiencePackItemService;
import com.chinazhoufan.admin.modules.sys.service.ConfigService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 每天零点更新体验包记录过期状态
 * @author 舒剑雄
 * @version 2017-08-31
 */
@Service
@Transactional(readOnly = false)
public class AutoUpdateExperiencePackItemService extends AbstractTaskListener {

	@Autowired
	private ExperiencePackItemService experiencePackItemService;
	@Autowired
	private MemberNotifyService memberNotifyService;

    public void doTask(TaskEvent event) {
    	System.out.println("doTask AutoUpdateExperiencePackItemService.doTask()");
    	// 查询所有超过可体验天数的体验包记录
		/*List<ExperiencePackItem>   experiencePackItemList =experiencePackItemService.findListOverdue();
		if(experiencePackItemList != null && experiencePackItemList.size()>0){
			for(ExperiencePackItem experiencePackItem : experiencePackItemList){
				// 新增会员消息
				memberNotifyService.createByNotifyCode(Notify.MSG_EXPERIENCE_OVERDUE, experiencePackItem.getMember());
			}
		}*/
		ExperiencePackItem experiencePackItem = new ExperiencePackItem();
		experiencePackItem.setStatus(ExperiencePackItem.NO_USE);
		//批量更新过期的体验包记录
		experiencePackItemService.updateBatch(experiencePackItem);

    }

}