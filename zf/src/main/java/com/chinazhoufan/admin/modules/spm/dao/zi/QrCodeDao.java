/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.dao.zi;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.spm.entity.zi.QrCode;
import org.apache.ibatis.annotations.Param;

/**
 * 二维码管理配置DAO接口
 * @author 舒剑雄
 * @version 2017-09-25
 */
@MyBatisDao
public interface QrCodeDao extends CrudDao<QrCode> {

    void updateByRandomCode(@Param("openId") String openId,@Param("randomCode") String randomCode);
	
}