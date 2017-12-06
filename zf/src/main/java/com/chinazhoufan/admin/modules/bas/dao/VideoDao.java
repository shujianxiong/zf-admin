package com.chinazhoufan.admin.modules.bas.dao;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.bas.entity.Video;

@MyBatisDao
public interface VideoDao extends CrudDao<Video> {

	Video getByCode(String code);

}
