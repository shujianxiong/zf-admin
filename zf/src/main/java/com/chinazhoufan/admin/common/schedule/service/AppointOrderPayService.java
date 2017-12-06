package com.chinazhoufan.admin.common.schedule.service;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.zf.quartzSDK.event.TaskEvent;
import com.zf.quartzSDK.listener.AbstractTaskListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;

/**
 * 预约订单尾款支付提醒定时任务
 * @author liuxiaodong
 * @date 2017-11-10
 */
@Service
@Transactional(readOnly = false)
public class AppointOrderPayService extends AbstractTaskListener {

    @Autowired
    private ExperienceOrderTaskService experienceOrderTaskService;
    @Autowired
    private MemberNotifyService memberNotifyService;

    @Override
    public void doTask(TaskEvent event) {
        ExperienceOrder eoParam = new ExperienceOrder();
        // 查询所有到达预约体验日期前一天,还未支付尾款的预约体验订单
        List<ExperienceOrder> experienceOrderList = experienceOrderTaskService.findAppointPay(eoParam);
        if(experienceOrderList != null && experienceOrderList.size() != 0){
            for(ExperienceOrder eo : experienceOrderList){
                // 新增会员消息
                try {
                    memberNotifyService.createByNotifyCode(Notify.MSG_APPOINTORDER_GET_STOCK, eo.getMember(), eo.getOrderNo());
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
