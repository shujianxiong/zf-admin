/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.common.schedule.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;

/**
 * 超出正常体验期一天的体验订单，向会员发送提示消息Service
 * @author 张金俊
 * @version 2017-08-21
 */
@Service
@Transactional(readOnly = false)
public class NotifyPastOneDayService extends AbstractTaskListener {

	public static final Integer PAST_DAYS = 1;	// 体验期超期天数
	
	@Autowired
	private ExperienceOrderTaskService experienceOrderTaskService;
	@Autowired
	private MemberNotifyService memberNotifyService;

    public void doTask(TaskEvent event) {
    	
        System.out.println("doTask NotifyPastOneDayService.doTask()");
        
        ExperienceOrder eoParam = new ExperienceOrder();
        // 体验订单正常体验天数
        eoParam.setExperienceDays(Integer.valueOf(ConfigUtils.getConfig(ExperienceOrder.CONFIG_EXPERIENCEDAYS).getConfigValue()));
        // 体验期超期天数
        eoParam.setParamDays(PAST_DAYS);
        // 查询所有在正常体验天数基础上超出paramDays天的体验订单
 	   	List<ExperienceOrder> experienceOrderList = experienceOrderTaskService.findByPastDays(eoParam);
 	   	
    	if(experienceOrderList != null && experienceOrderList.size() != 0){
    		for(ExperienceOrder eo : experienceOrderList){
    			// 新增会员消息
    			try {
					memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_NOTIFY_PAST_1, eo.getMember(),eo.getOrderNo());
				} catch (ServiceException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    		}
    	}
    }

}
