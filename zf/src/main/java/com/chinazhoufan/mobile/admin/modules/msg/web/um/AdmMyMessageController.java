/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.msg.web.um;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.msg.entity.um.UmMessage;
import com.chinazhoufan.admin.modules.msg.service.um.UmMessageService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 我的消息中心接口Controller
 * @author 刘晓东
 * @version 2015-12-16
 */
@Controller
@RequestMapping(value = "${frontPath}/myMessage")
public class AdmMyMessageController extends BaseController {

	@Autowired
	private UmMessageService messageService;
	
	/**
	 * 管理端查看我的消息
	 * @param sysUserId
	 * @param goPage
	 * @param category
	 * @param type
	 * @param status
	 * @return
	 */
	@RequestMapping(value = "/sysUser/{sysUserId}/{goPage}", method = RequestMethod.POST)
	public @ResponseBody
	String getByUser(@PathVariable("sysUserId")String sysUserId,@PathVariable("goPage")Integer goPage,
			@RequestParam(value = "category",required = false,defaultValue = "")String category,
			@RequestParam(value = "type",required = false,defaultValue = "")String type,
			@RequestParam(value = "status",required = false,defaultValue = "")String status) {
		
		Echos echos = null;
		Page<UmMessage> page = new Page<UmMessage>();
		page.setPageNo(goPage);
		page.setPageSize(Constants.ADMIN_PAGESIZE);//pagesize为10
		try {
			page = messageService.findMyPageByUser(page, sysUserId,category,type,status);
			if (page.getList().size() > 0) {
				echos = new Echos(Constants.SUCCESS, page);
			}else {
				echos = new Echos(Constants.NO_MESSAGE);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR,e.getMessage());
		}
		return JsonMapper.toJsonString(echos);
	}

	/**
	 * 管理端删除我的消息
	 * @param messageId
	 * @return
	 */
	@RequestMapping(value = "/{messageId}", method = RequestMethod.DELETE)
	public @ResponseBody
	String delete(@PathVariable("messageId")String messageId) {
		Echos echos = null;
		try {
			messageService.delete(new UmMessage(messageId));
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR,e.getMessage());
		}
		return JsonMapper.toJsonString(echos);
	}
	
	/**
	 * 管理端统计是否有未读消息
	 * @param messageId
	 * @return
	 */
	@RequestMapping(value = "/sysUser/{sysUserId}", method = RequestMethod.POST)
	public @ResponseBody
	String countNotReadMessage(@PathVariable("sysUserId")String sysUserId) {
		Echos echos = null;
		try {
			int cnt = messageService.countNotReadMessage(sysUserId);
			echos = new Echos(Constants.SUCCESS, cnt);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR,e.getMessage());
		}
		return JsonMapper.toJsonString(echos);
	}
}