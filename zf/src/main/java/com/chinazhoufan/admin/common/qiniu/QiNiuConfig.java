package com.chinazhoufan.admin.common.qiniu;

import org.apache.commons.lang3.StringUtils;

import com.qiniu.storage.BucketManager;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;

/**
 * @author  杨晓辉
 * @date 创建时间：2016年9月28日 下午3:42:42 
 * @version 2.0.0 
 */
public class QiNiuConfig {
	
	private String accessKey="gd4g3rAzjeRcNCqPwd0fJ_7Wbjw1fDOnXuQx6i5E";	// 七牛云存储AK
	private String secretKey="PmnWc4Q6NOMEqFuqrd8GyD9V3-uoq5c-MZYN2-Pk";	// 七牛云SK
	
	public static String bucketName="zfimags";									// 上传空间  zfimages为默认的存储空间
	private Auth auth;														// 密钥配置
	private UploadManager uploadManager;									// 上传对象
	private BucketManager bucketManager;									// 管理对象
	
	private static QiNiuConfig qiNiuConfig;
	
	
	private QiNiuConfig(){
		
	}
	
	/**
	 * 配置七牛云
	 * @return
	 */
	public static QiNiuConfig config(){
		if(qiNiuConfig==null){
			qiNiuConfig=new QiNiuConfig();
			qiNiuConfig.auth=Auth.create(qiNiuConfig.accessKey, qiNiuConfig.secretKey);
			qiNiuConfig.uploadManager=new UploadManager();
			qiNiuConfig.bucketManager=new BucketManager(qiNiuConfig.auth);
		}
		return qiNiuConfig;
	}
	
	public UploadManager getUploadManager(){
		QiNiuConfig qiNiuConfig=QiNiuConfig.config();
		return qiNiuConfig.uploadManager;
	}
	
	public BucketManager getBucketManager() {
		QiNiuConfig qiNiuConfig = QiNiuConfig.config();
		return qiNiuConfig.bucketManager;
	}
	/**
	 * 配置七牛云的上传策略
	 * 当前为默认策略
	 * @param bucketName 上传空间
	 * @return
	 */
	public String getUpToken(String bucketName){
		QiNiuConfig qiNiuConfig=QiNiuConfig.config();
		if(!StringUtils.isBlank(bucketName))
			qiNiuConfig.bucketName=bucketName;
		return QiNiuConfig.config().auth.uploadToken(qiNiuConfig.bucketName);
	}
	
	/**
	 * 获取默认的上传空间
	 * @return
	 */
	public String getDefaultBucketName() {
		if (qiNiuConfig==null) {
			QiNiuConfig.config();
		}
		return qiNiuConfig.bucketName;
	}
	
}
