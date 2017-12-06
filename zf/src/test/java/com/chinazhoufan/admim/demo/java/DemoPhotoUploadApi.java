package com.chinazhoufan.admim.demo.java;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.chinazhoufan.admin.common.qiniu.FileManager;
import com.chinazhoufan.admin.common.qiniu.QiNiuConfig;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
//import com.chinazhoufan.index.common.web.BaseRestApi;

@RestController
@RequestMapping(value="${indexPath}/memberTest")
public class DemoPhotoUploadApi {
	
	/**
	 * zf-index项目中更新用户头像
	 */
	@SuppressWarnings("null")
	@RequestMapping(value="/info",method=RequestMethod.POST)
	public String updateInfo(Member member,HttpServletRequest request) {
		
		try{
			if (StringUtils.isNotBlank(member.getGravatar())) {
				//上传头像
				FileManager fileManager = new FileManager();
				member.setGravatar(fileManager.uploadByBase64(member.getGravatar(), QiNiuConfig.bucketName));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
}
