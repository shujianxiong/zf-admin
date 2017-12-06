/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ep;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePackItem;

import java.util.List;
import java.util.Map;

/**
 * 体验包体验记录DAO接口
 * @author 舒剑雄
 * @version 2017-08-31
 */
@MyBatisDao
public interface ExperiencePackItemDao extends CrudDao<ExperiencePackItem> {

    ExperiencePackItem getByMemberAndType(Map<String, Object> map);

    /**
     * 查询所有超过可体验天数的体验包记录
     */
	List<ExperiencePackItem>  findListOverdue();
    /**
     * 批量更新过期的体验包记录
     */
	void updateBatch(ExperiencePackItem experiencePackItem);

    ExperiencePackItem getByMember(Map<String, Object> map);

    ExperiencePackItem getByEp(Map<String, Object> map);
}