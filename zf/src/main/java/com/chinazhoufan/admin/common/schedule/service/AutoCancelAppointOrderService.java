/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.common.schedule.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.ser.entity.sa.ServiceApply;
import com.chinazhoufan.admin.modules.ser.service.sa.ServiceApplyService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;

/**
 * 取消到达预约体验日期还未支付尾款的预约体验订单，向会员发送提示消息Service
 * @author 张金俊
 * @version 2017-08-21
 */
@Service
@Transactional(readOnly = false)
public class AutoCancelAppointOrderService extends AbstractTaskListener {

	@Autowired
	private ExperienceOrderTaskService experienceOrderTaskService;
	@Autowired
	private ServiceApplyService serviceApplyService;

	@Autowired
	private CodeGeneratorService codeGeneratorService;

    public void doTask(TaskEvent event) {
    	
        System.out.println("doTask AutoCancelAppointOrderService.doTask()");
        
        ExperienceOrder eoParam = new ExperienceOrder();
        eoParam.setCloseTime(new Date());
        eoParam.setUpdateDate(new Date());
        // 查询所有到达预约体验日期、还未支付尾款的预约体验订单
 	   	List<ExperienceOrder> experienceOrderList = experienceOrderTaskService.findAppointToClose(eoParam);
 	   	
    	if(experienceOrderList != null && experienceOrderList.size() != 0){
    		// 取消所有到达预约体验日期、已到货还未支付尾款的预约体验订单
    		//experienceOrderTaskService.updateAppointToClose(eoParam);
			for(ExperienceOrder experienceOrder : experienceOrderList){
				//生成服务申请单
				ServiceApply serviceApply = new ServiceApply();
				serviceApply.setNo(codeGeneratorService.generateCode(ServiceApply.GENERATECODE_NO));
				serviceApply.setOrderId(experienceOrder.getId());
				serviceApply.setOrderType(experienceOrder.getType());
				serviceApply.setOrderNo(experienceOrder.getOrderNo());
				serviceApply.setStatus(ServiceApply.STATUS_TO_DEAL);
				serviceApply.setApplyByType(ServiceApply.ABT_SYSTEM);
				serviceApply.setApplyById(UserUtils.getAdmin().getId());
				serviceApply.setApplyTimeType(ServiceApply.ATT_BEFORE_SEND);
				serviceApply.setApplyDealType(ServiceApply.ADT_CANCEL);
				serviceApply.setApplyReasonType(ServiceApply.ORDER_NO_PAY);
				serviceApply.setApplyRemarks("用户预约订单未在规定时间付尾款");
				//根据体验单查询未处理的延期的服务申请单,如果已经存在，则不新增
				List<ServiceApply> serviceApplyList = serviceApplyService.findList(serviceApply);
				if(serviceApplyList == null || serviceApplyList.size() == 0 ){
					serviceApplyService.save(serviceApply);
				}
			}

    	}
    }

}
