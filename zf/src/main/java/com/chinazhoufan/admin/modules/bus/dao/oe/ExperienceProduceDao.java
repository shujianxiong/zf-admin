/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.oe;

import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import org.apache.ibatis.annotations.Param;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceProduce;

/**
 * 体验产品DAO接口
 * @author 张金俊
 * @version 2017-04-12
 */
@MyBatisDao
public interface ExperienceProduceDao extends CrudDao<ExperienceProduce> {

	void updateByExperienceOrderAndProduce(Map<String, Object> map);

	List<ExperienceProduce> getByExperienceOrder(@Param("experienceOrderId")String experienceOrderId);

	List<ExperienceProduce> getByProduceId(@Param("produceId")String produceId);

	void updateStatus(ExperienceProduce experienceProduce);

	void updateBuyNumByExperienceOrderAndProduce(Map<String, Object> map);

	void updateChangeNumByExperienceOrderAndProduce(Map<String, Object> map);
}