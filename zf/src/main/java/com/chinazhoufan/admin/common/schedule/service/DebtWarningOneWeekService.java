package com.chinazhoufan.admin.common.schedule.service;

import java.io.IOException;
import java.util.List;

import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;


/**
 * 欠款七天警告Service
 * @author liuxiaodong
 * @date 2017-10-18
 */
@Service
@Transactional(readOnly=false)
public class DebtWarningOneWeekService extends AbstractTaskListener {
	
	@Autowired
	private ExperienceOrderTaskService experienceOrderTaskService;
	@Autowired
	private MemberNotifyService memberNotifyService;
	
	
	@Override
	public void doTask(TaskEvent event) {
		List<ExperienceOrder> list = experienceOrderTaskService.findOneWeekDebt();
		for (ExperienceOrder eo : list) {
			try {
				memberNotifyService.createByNotifyCode(Notify.MSG_DEBT_WARNING_ONE_WEEK, eo.getMember(), eo.getOrderNo());
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
