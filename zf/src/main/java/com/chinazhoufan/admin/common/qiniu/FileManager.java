package com.chinazhoufan.admin.common.qiniu;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;

import com.chinazhoufan.admin.common.utils.Base64Util;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;

/**
 * 七牛云图片上传
 * @author  杨晓辉
 * @date 创建时间：2016年9月28日 下午3:36:21 
 * @version 2.0.0 
 */
public class FileManager {
	
	private QiNiuConfig qiNiuConfig;		// 七牛云配置
	
	public FileManager(){
		this.qiNiuConfig=QiNiuConfig.config();
	}
	
	/**
	 * 简单上传,上传到指定空间
	 * @param filePath 		文件路径，可以采用spring接收后的temp文件路径
	 * @param fileName		文件名
	 * @param bucketName	上传空间
	 * @return
	 * @throws QiniuException
	 */
	public Response upload(String filePath,String fileName,String bucketName)throws QiniuException{
		return qiNiuConfig.getUploadManager().put(filePath, fileName, qiNiuConfig.getUpToken(bucketName));
	}
	
	/**
	 * 简单上传，上传到默认空间
	 * @param filePath 		文件路径，可以采用spring接收后的temp文件路径
	 * @param fileName		文件名
	 * @return
	 * @throws QiniuException
	 */
	public Response upload(String filePath,String fileName)throws QiniuException{
		return qiNiuConfig.getUploadManager().put(filePath, fileName, qiNiuConfig.getUpToken("zfimags"));
	}
	
	/**
	 * 简单上传，上传到指定空间(可保证文件不重复，节省资源空间)
	 * @param base64Str		BASE64字符串图片格式
	 * @param bucketName
	 * @return
	 * 		文件名(MD5码)
	 * 		NULL 上传失败,原因可能为BASE64转文件失败
	 * @throws QiniuException
	 * @throws IOException
	 */
	public String uploadByBase64(String base64Str,String bucketName)throws QiniuException,IOException{
		String filePath=Base64Util.GenerateImage(base64Str);
		if(StringUtils.isBlank(filePath))
			return null;
		File file=new File(filePath);
		String md5=DigestUtils.md5Hex(new FileInputStream(file)); 
		upload(filePath, md5,bucketName);
		file.delete();
		return md5;
	}
	
	/**
	 * 简单上传，上传到指定空间(可保证文件不重复，节省资源空间)
	 * @param file			文件
	 * @param bucketName	文件空间
	 * @return
	 * 		文件名(MD5码)
	 * @throws QiniuException
	 * @throws IOException
	 */
	public String uploadByFile(File file,String bucketName)throws QiniuException,IOException{
		String md5=DigestUtils.md5Hex(new FileInputStream(file)); 
		upload(file.getPath(), md5,bucketName);
		file.delete();
		return md5;
	}
	
	
	/**
	 * 删除默认空间即zfimags中的文件
	 * @param fileName
	 * @throws QiniuException
	 */
	public void delete(String fileName) throws QiniuException {
		qiNiuConfig.getBucketManager().delete(qiNiuConfig.getDefaultBucketName(), fileName);
	}
	
	/**
	 * 删除指定空间的文件
	 * @param bucketName    空间名
	 * @param fileName      文件名
	 * @throws QiniuException
	 */
	public void delete(String bucketName, String fileName) throws QiniuException {
		qiNiuConfig.getBucketManager().delete(bucketName, fileName);
	}
	
	/**
	 * 修改默认空间即zfimags中的文件名key
	 * @param oldName    	旧名字
	 * @param newName		新名字
	 * @throws QiniuException 
	 */
	public void rename(String oldName, String newName) throws QiniuException {
		qiNiuConfig.getBucketManager().rename(qiNiuConfig.getDefaultBucketName(), oldName, newName);
	}
	
	
	/**
	 * 修改指定空间的文件名 
	 * @param bucketName    空间名
	 * @param oldName       旧名字
	 * @param newName       新名字
	 * @throws QiniuException
	 */
	public void rename(String bucketName, String oldName, String newName) throws QiniuException {
		qiNiuConfig.getBucketManager().rename(bucketName, oldName, newName);
	}
	
	/**
	 * 修改默认空间即zfimags中的指定文件名的资源
	 * @param filaName		文件名
	 * @param newPath		新文件路径
	 * @throws QiniuException 
	 */
	public void modifyPath(String fileName, String newPath) throws QiniuException {
			delete(fileName);
			upload(newPath, fileName);
	}
	
	/**
	 * 修改指定空间文件资源
	 * @param bucketName	空间名    
	 * @param fileName		文件名
	 * @param newPath		新文件路径
	 * @throws QiniuException
	 */
	public void modifyPath(String bucketName,String fileName,String oldPath, String newPath) throws QiniuException {
			delete(bucketName, fileName);
			upload(newPath, fileName, bucketName);
	}
	
	public static void main(String[] args) {
		FileManager fm = new FileManager();
		try {
			Response response = fm.upload("D:/50.jpg", "hello-cs");
			System.out.println(response.statusCode+"========="+response.bodyString());
		} catch (QiniuException e) {
			
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
	}
}
