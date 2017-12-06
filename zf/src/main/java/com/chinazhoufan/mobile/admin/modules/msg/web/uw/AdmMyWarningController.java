/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.msg.web.uw;


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
import com.chinazhoufan.admin.modules.msg.entity.uw.Warning;
import com.chinazhoufan.admin.modules.msg.service.uw.WarningService;
import com.chinazhoufan.mobile.index.modules.common.utils.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 员工报警中心Controller
 * @author 刘晓东
 * @version 2015-12-16
 */
@Controller
@RequestMapping(value = "${frontPath}/myWarning")
public class AdmMyWarningController extends BaseController {

	@Autowired
	private WarningService warningService;
	
	/**
	 * 移动管理端我的预警记录列表接口
	 * @param sysUserId
	 * @param category
	 * @param type
	 * @param status
	 * @param goPage
	 * @param response
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/sysUser/{sysUserId}/{goPage}",method = RequestMethod.POST)
	public @ResponseBody
	String getByUser(@PathVariable("sysUserId")String sysUserId,@PathVariable("goPage")Integer goPage,
			@RequestParam(value = "category",required = false,defaultValue = "")String category,
			@RequestParam(value = "type",required = false,defaultValue = "")String type,
			@RequestParam(value = "status",required = false,defaultValue = "")String status
			) {
		Echos echos = null;
		Page<Warning> page = new Page<Warning>();
		page.setPageSize(Constants.ADMIN_PAGESIZE);//pagesize为10
		page.setPageNo(goPage);
		try {
			page = warningService.findMyPageByUser(page, sysUserId,category,type,status);
			if (page.getList() == null && page.getList().isEmpty()) {
				echos = new Echos(Constants.NO_MESSAGE);
			}else {
				echos = new Echos(Constants.SUCCESS, page);
			}
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return JsonMapper.toJsonString(echos);
	}
	
//	/**
//	 * 管理端查看预警
//	 * @param warningId
//	 * @return
//	 */
//	@RequestMapping(value = "/{warningId}", method = RequestMethod.POST)
//	public @ResponseBody
//	String view(@PathVariable("warningId")String warningId) {
//		Echos echos = null;
//		try {
//			Warning warning = warningService.view(warningId);
//			if (warning == null) {
//				echos = new Echos(Constants.NO_MESSAGE);
//			}else {
//				echos = new Echos(Constants.SUCCESS, warning);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			echos = new Echos(Constants.ERROR);
//		}
//		return JsonMapper.toJsonString(echos);
//	}

	/**
	 * 管理端删除预警
	 * @param warningId
	 * @return
	 */
	@RequestMapping(value = "/{warningId}", method = RequestMethod.DELETE)
	public @ResponseBody
	String delete(@PathVariable("warningId")String warningId) {
		Echos echos = null;
		try {
			warningService.delete(new Warning(warningId));;
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR, e.getMessage());
		}
		return JsonMapper.toJsonString(echos);
	}
}