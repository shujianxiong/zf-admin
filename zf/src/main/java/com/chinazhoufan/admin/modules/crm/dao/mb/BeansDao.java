/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.mb;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.bb.BankbookBalance;
import com.chinazhoufan.admin.modules.crm.entity.mb.Beans;

/**
 * 会员魅力豆DAO接口
 * @author 张金俊
 * @version 2017-08-03
 */
@MyBatisDao
public interface BeansDao extends CrudDao<Beans> {
    /**
     * 通过会员ID获取会员魅力豆账户余额记录
     * @param memberId
     * @return
     */
    public Beans getByMemberId(String memberId);

    /**
     * 通过会员ID获取会员魅力豆账户余额记录（同时锁定魅力豆账户余额表）
     * @param memberId
     * @return
     */
    public Beans getByMemberIdForUpdate(String memberId);
}