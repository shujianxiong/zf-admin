/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.ep;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePack;

/**
 * 体验包DAO接口
 * @author 舒剑雄
 * @version 2017-08-30
 */
@MyBatisDao
public interface ExperiencePackDao extends CrudDao<ExperiencePack> {

    ExperiencePack getOneByType(ExperiencePack experiencePack);
	
}