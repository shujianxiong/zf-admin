package com.chinazhoufan.admim.test;

import java.util.List;

import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderTaskService;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.admin.test.service.Test1;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Description:
 * User: sxj
 * Date: 2017/8/22
 * Time: 15:34
 * Copyright:周范科技 Copyright (c) 2017
 */
@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = {"classpath:spring-context.xml","classpath:spring-context-jedis.xml","classpath:spring-context-shiro.xml"})classpath*:/spring-context*.xml
@ContextConfiguration(locations = {"classpath*:/spring-context*.xml"})
public class TestDemo {

    @Autowired
    private Test1 test1;
    @Autowired
    private ExperienceOrderTaskService experienceOrderTaskService;

    @Test
    public void selectUserTest() {
    	
    	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>JUnit selectUserTest");
    	
    	ExperienceOrder eoParam = new ExperienceOrder();
        // 体验订单正常体验天数
        eoParam.setExperienceDays(Integer.valueOf(ConfigUtils.getConfig(ExperienceOrder.CONFIG_EXPERIENCEDAYS).getConfigValue()));
        // 体验期剩余天数
        eoParam.setParamDays(1);
        // 查询所有在正常体验天数基础上剩余paramDays天的体验订单
 	   	List<ExperienceOrder> experienceOrderList = experienceOrderTaskService.findByRemainDays(eoParam);
    	System.out.println(experienceOrderList == null ? "null" : experienceOrderList.size());
    }

}
