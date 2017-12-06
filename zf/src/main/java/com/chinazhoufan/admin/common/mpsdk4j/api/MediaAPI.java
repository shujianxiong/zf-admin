package com.chinazhoufan.admin.common.mpsdk4j.api;

import java.io.File;

import com.chinazhoufan.admin.common.mpsdk4j.exception.WechatApiException;
import com.chinazhoufan.admin.common.mpsdk4j.vo.api.Media;

/**
 * 微信多媒体数据接口
 * 
 * @author 凡梦星尘(elkan1788@gmail.com)
 * @since 2.0
 */
public interface MediaAPI {

    // 上传多媒体 https://api.weixin.qq.com/cgi-bin/media/upload?access_token=ACCESS_TOKEN&type=TYPE
    String upload_media = "/material/add_material?access_token=%s&type=%s";

    // 下载多媒体 
    String get_media = "/media/get?access_token=%s&media_id=%s";
    
    // 获取多媒体列表  https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token=ACCESS_TOKEN
    String get_media_list = "/material/batchget_material?access_token=%s";
    //新增永久图文素材
    String add_media = "/material/add_news?access_token=%s";
    //修改永久图文素材
    String update_media = "/material/update_news?access_token=%s";

    //删除永久图文素材
    String del_media = "/material/del_material?access_token=%s";

    String up_message_img = "/media/uploadimg?access_token=%s";

    /**
     * 上传多媒体文件
     * 
     * <pre/>
     * 上传的临时多媒体文件有格式和大小限制,如下:
     * <li/>
     * 图片(image): 1M,支持JPG格式
     * <li/>
     * 语音(voice):2M,播放长度不超过60s,支持AMR\MP3格式
     * <li/>
     * 视频(video):10MB,支持MP4格式
     * <li/>
     * 缩略图(thumb):64KB,支持JPG格式
     * 
     * <pre/>
     * 媒体文件在后台保存时间为3天,即3天后media_id失效。
     * 
     * @param type
     *            多媒体类型 {@link com.chinazhoufan.admin.common.mpsdk4j.common.MediaType}
     * @param media
     *            多媒体文件
     * @return 实体{@link Media}
     */
    Media upMedia(String type, File media);

    /**
     * 下载多媒体文件
     * 
     * @param mediaId
     *            媒体文件ID
     * @return {@link File}
     */
    File dlMedia(String mediaId);
    
    /**
     * 获取多媒体素材列表
     * @param type
     * 			      多媒体类型 {@link com.chinazhoufan.admin.common.mpsdk4j.common.MediaType}  
     * @param pageNo
     *            页码
     * @param pageSize
     *            分页长度
     * @return
     */
    String findMedias(String type,String pageNo,String pageSize) throws WechatApiException;
}
