package com.chinazhoufan.admin.common.schedule;

import com.chinazhoufan.admin.common.schedule.service.*;
import com.zf.quartzSDK.event.TaskSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Description:
 * User: sxj
 * Date: 2017/8/8
 * Time: 9:54
 * Copyright:周范科技 Copyright (c) 2017
 */
@Controller
public class TaskController {

    @Autowired
    TaskSource taskSource;

    @Autowired
    AutoBuyService butoBuyService;
    @Autowired
    AutoCancelAppointOrderService autoCancelAppointOrderService;
    @Autowired
    AutoReceiveService autoReceiveService;
    @Autowired
    NotifyPastOneDayService notifyPastOneDayService;
    @Autowired
    NotifyRemainOneDayService notifyRemainOneDayService;
    @Autowired
    AutoUpdateExperiencePackItemService autoUpdateExperiencePackItemService;
    @Autowired
    AutoUpdateProductService autoUpdateProductService;
    @Autowired
    ExperienceRemindService experienceRemindService;
    @Autowired
    DebtWarningOneDayService debtWarningOneDayService;
    @Autowired
    DebtWarningOneWeekService debtWarningOneWeekService;
    @Autowired
    AppointOrderPayService appointOrderPayService;
    /*@Autowired
    AutoSettleService autoSettleService;*/
    

    /**
     * taskId=14	:每天执行，00:00:00
     * taskId=11	:每天执行，01:00:00
     * taskId=12    :每天执行，07:00:00
     * taskId=13	:每天执行，08:00:00
     * @param taskId
     * @param taskResultId
     * @return
     */
    @RequestMapping(value="/doTask",method= RequestMethod.GET)
    @ResponseBody
    public String doTask(int taskId, int taskResultId) {
        System.out.println("doTask taskId="+taskId);
        butoBuyService.setTaskId("11");
        autoCancelAppointOrderService.setTaskId("12");
        autoReceiveService.setTaskId("12");
        notifyPastOneDayService.setTaskId("12");
        notifyRemainOneDayService.setTaskId("12");
        //autoSettleService.setTaskId("12");
        autoUpdateExperiencePackItemService.setTaskId("14");
        autoUpdateProductService.setTaskId("14");
        experienceRemindService.setTaskId("13");
        debtWarningOneDayService.setTaskId("13");
        debtWarningOneWeekService.setTaskId("13");
        appointOrderPayService.setTaskId("13");
        taskSource.addTaskListener(butoBuyService);
        taskSource.addTaskListener(autoCancelAppointOrderService);
        taskSource.addTaskListener(autoReceiveService);
        taskSource.addTaskListener(notifyPastOneDayService);
        taskSource.addTaskListener(notifyRemainOneDayService);
        taskSource.addTaskListener(autoUpdateExperiencePackItemService);
        taskSource.addTaskListener(autoUpdateProductService);
        taskSource.addTaskListener(experienceRemindService);
        taskSource.addTaskListener(debtWarningOneDayService);
        taskSource.addTaskListener(debtWarningOneWeekService);
        taskSource.addTaskListener(appointOrderPayService);
        taskSource.doTask(String.valueOf(taskId),String.valueOf(taskResultId));
        return "SUCCESS";
    }
}
