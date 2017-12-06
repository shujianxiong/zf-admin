/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.common.schedule.service;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;

/**
 * 已送达体验订单自动确认收货Service
 * @author 张金俊
 * @version 2017-08-21
 */
@Service
@Transactional(readOnly = false)
public class AutoReceiveService extends AbstractTaskListener {
	
	@Autowired
	private ExperienceOrderTaskService experienceOrderTaskService;
	@Autowired
	private MemberNotifyService memberNotifyService;

    public void doTask(TaskEvent event) {
    	
        System.out.println("doTask AutoReceiveService.doTask()");
		Calendar calendar = Calendar.getInstance();
        ExperienceOrder eoParam = new ExperienceOrder();
		eoParam.setStatusLogistical(ExperienceOrder.EXPRESS_SIGNED);
        // 查询所有已送达未确认收货的体验订单
 	   	List<ExperienceOrder> experienceOrderList = experienceOrderTaskService.findArrived(eoParam);
 	   	
    	if(experienceOrderList != null && experienceOrderList.size() != 0){
    		// 对所有已送达的体验订单进行确认收货，同时设置体验开始日期为当前日期
    		experienceOrderTaskService.updateArrivedToExperiencing(eoParam);
    		
    		for(ExperienceOrder eo : experienceOrderList){
    			// 新增会员消息
				Date expDate = eo.getRealExpDate();
				calendar.setTime(expDate);
				int month = calendar.get(Calendar.MONTH)+1;
				int day = calendar.get(Calendar.DAY_OF_MONTH);
				String experienceDaysStr = ConfigUtils.getConfig("experienceOrderExperienceDays").getConfigValue();	// 体验订单可体验时长（天）
				//Integer experienceDays = Integer.valueOf(experienceDaysStr);
				Integer experienceDays =eo.getExperienceDays() == null?Integer.valueOf(experienceDaysStr):eo.getExperienceDays();
				Date realExpEndDate = DateUtils.getDateOffset(expDate, 5, experienceDays-1);	// 体验结束日期
				calendar.setTime(realExpEndDate);
				int endMonth = calendar.get(Calendar.MONTH)+1;
				int endDay = calendar.get(Calendar.DAY_OF_MONTH);
				try {
					memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_RECEIVE_CONFIRM, eo.getMember(),eo.getOrderNo(),endMonth,endDay);
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
