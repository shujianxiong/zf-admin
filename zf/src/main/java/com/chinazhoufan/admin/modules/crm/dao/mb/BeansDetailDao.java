/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.mb;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.mb.BeansDetail;
import org.apache.ibatis.annotations.Param;

/**
 * 会员魅力豆流水DAO接口
 * @author 张金俊
 * @version 2017-08-03
 */
@MyBatisDao
public interface BeansDetailDao extends CrudDao<BeansDetail> {


    /**
     * 根据操作类型和来源业务编号查询最后一条魅力豆流水记录
     * @param changeType 操作类型
     * @param operateSourceNo   来源业务编号
     * @return
     */
    public BeansDetail getByChangeTypeAndUniqueNo(@Param("changeType") String changeType, @Param("operateSourceNo") String operateSourceNo);

    /**
     * 根据会员ID查询会员最后一条魅力豆流水记录
     * @param memberId 会员ID
     * @return
     */
    public BeansDetail getLastByMemberId(String memberId);

    /**
     * 查询魅力豆流水总数量（所有）
     * @return
     */
    public Integer getItemsCountTotal();
	
}