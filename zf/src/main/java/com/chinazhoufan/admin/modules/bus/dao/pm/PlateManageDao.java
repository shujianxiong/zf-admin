/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.dao.pm;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bus.entity.pm.PlateManage;

import java.util.List;
import java.util.Map;

/**
 * 托盘管理DAO接口
 * @author liuxiaodong
 * @version 2017-10-27
 */
@MyBatisDao
public interface PlateManageDao extends CrudDao<PlateManage> {

    List<PlateManage> findUsableList(PlateManage plateManage);

    PlateManage getByPlateNo(Map<String, Object> map);
}