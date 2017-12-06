/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.mb;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.mb.BeansTemp;

/**
 * 会员魅力豆临时条目DAO接口
 * @author 张金俊
 * @version 2017-08-04
 */
@MyBatisDao
public interface BeansTempDao extends CrudDao<BeansTemp> {


    /**张金俊
     * 根据资金账户ID查询其审核通过的存折条目总数量
     * @param beansId
     * @return
     */
    public Integer getTempsPassedCountByBeansId(String beansId);
}