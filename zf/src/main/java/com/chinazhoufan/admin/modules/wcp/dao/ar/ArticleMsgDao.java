/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.dao.ar;

import com.chinazhoufan.admin.common.mpsdk4j.vo.api.MediaTemp;
import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ArticleMsg;
import com.chinazhoufan.admin.modules.wcp.entity.ar.AutoReply;
import org.apache.ibatis.annotations.Param;

/**
 * 图文消息表DAO接口
 * @author liut
 * @version 2016-05-25
 */
@MyBatisDao
public interface ArticleMsgDao extends CrudDao<ArticleMsg> {

    /**
     * 根据图文素材Id和消息位置index修改图文消息
     * @param articleMsg
     * @return
     */
    public void updateByMedia(ArticleMsg articleMsg);

    /**
     * 根据图文素材Id删除图文素材
     * @param mediaId
     * @return
     */
    public void deleteByMediaId(@Param("mediaId")String mediaId);

    /**
     * 根据图文素材Id和消息位置index获取图文消息
     * @param articleMsg
     * @return
     */
    public ArticleMsg getByMedia(ArticleMsg articleMsg);
	
}