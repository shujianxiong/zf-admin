/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.common.schedule.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.modules.bus.entity.ob.BuyOrder;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;
import com.chinazhoufan.admin.modules.bus.service.ob.BuyOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.sys.service.ConfigService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;

/**
 * 每天上午10点
 * 超过最长体验期的订单自动转购买Service
 * @author 张金俊
 * @version 2017-08-22
 */
@Service
@Transactional(readOnly = false)
public class AutoBuyService extends AbstractTaskListener {

	@Autowired
	private ExperienceOrderTaskService experienceOrderTaskService;
	@Autowired
	private ConfigService configService;
	@Autowired
	private MemberNotifyService memberNotifyService;
	@Autowired
	private BuyOrderService buyOrderService;

    public void doTask(TaskEvent event) {
    	
    	System.out.println("doTask AutoBuyService.doTask()");
		Calendar cal = Calendar.getInstance();
		Date today = new Date();


		// 查询所有超过可体验天数最大值的体验订单
        ExperienceOrder eoParam = new ExperienceOrder();
 	   	List<ExperienceOrder> experienceOrderList = experienceOrderTaskService.findExpired(eoParam);
    	if(experienceOrderList != null && experienceOrderList.size() != 0){
    		for(ExperienceOrder eo : experienceOrderList){
				if(eo.getExperienceTime() == null ){
					eoParam.setExperienceDaysMax(Integer.valueOf(ConfigUtils.getConfig(ExperienceOrder.CONFIG_EXPERIENCEDAYS).getConfigValue())
							+ Integer.valueOf(ConfigUtils.getConfig(ExperienceOrder.CONFIG_DELAYABLEDAYS).getConfigValue()));

				}else{
					eoParam.setExperienceDaysMax(eo.getExperienceTime()
							+ Integer.valueOf(ConfigUtils.getConfig(ExperienceOrder.CONFIG_DELAYABLEDAYS).getConfigValue()));
				}
				if(eo.getRealExpDate() == null)
					continue;
				cal.setTime(eo.getRealExpDate());
				cal.add(Calendar.DAY_OF_MONTH, eoParam.getExperienceDaysMax());
				if(today.getTime() < cal.getTime().getTime())
					continue;
    			//非全款押金不做自动转购买操作,过滤非全款押金
				/*if("1".equals(eo.getZmxyFlag())){
					experienceOrderList.remove(eo);
				}*/
    			// 对超过最长体验期的订单自动转购买
				eo.setIsAutoBuy("true");
    			BuyOrder buyOrder = experienceOrderTaskService.updateExpiredToBuyAuto(eo);
				buyOrder = buyOrderService.get(buyOrder);
    			// 新增会员消息
    			try {
					memberNotifyService.createByNotifyCode(Notify.MSG_ORDER_EXPIRED_BUY_AUTO, eo.getMember(), eo.getOrderNo(), buyOrder.getMoneyTotal() == null?0:buyOrder.getMoneyTotal());
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