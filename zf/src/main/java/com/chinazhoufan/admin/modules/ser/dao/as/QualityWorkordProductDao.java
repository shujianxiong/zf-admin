/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.dao.as;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.ser.entity.as.QualityWorkordProduct;

import java.util.List;

/**
 * 质检工单货品表DAO接口
 * @author 舒剑雄
 * @version 2017-10-13
 */
@MyBatisDao
public interface QualityWorkordProductDao extends CrudDao<QualityWorkordProduct> {

    public List<QualityWorkordProduct> findListByQualityWorkorderId(QualityWorkordProduct qualityWorkordProduct);

}