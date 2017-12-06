package com.chinazhoufan.admin.common.schedule.service;

import java.io.IOException;
import java.util.List;

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
 * 每天上午10点
 * 提醒注册超过十天未体验用户下单Service
 */
@Service
@Transactional(readOnly=false)
public class ExperienceRemindService extends AbstractTaskListener {

	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberNotifyService memberNotifyService;
	
	
	@Override
	public void doTask(TaskEvent event) {
		List<Member> list = memberService.findExperienceRemindList();
		for (Member member : list) {
			try {
				memberNotifyService.createByNotifyCode(Notify.MSG_EXPERIENCE_REMIND, member);
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
