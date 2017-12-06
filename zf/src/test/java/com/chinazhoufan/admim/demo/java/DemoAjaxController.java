/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admim.demo.java;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;

/**
 * Ajax方法Controller
 * @author 张金俊
 * @version 2016-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/demoAjax")
public class DemoAjaxController extends BaseController {
	
	/**AJAX
	 * 评价菜谱
	 * @param dietId	菜谱ID
	 * @param level		评价级别
	 * @param request
	 * @return
	 */
	@RequiresPermissions("hrm:di:dietJudge:edit")
	@ResponseBody
	@RequestMapping(value = "judge/{dietId}", method = RequestMethod.POST)
	public String judge(
			@PathVariable("dietId")String dietId, 
			@RequestParam(required=false)String level, 
			HttpServletRequest request) {
		if(StringUtils.isBlank(dietId) || StringUtils.isBlank(level)){
			return "{\"status\":\"0\",\"message\":\"菜谱评价失败：未能获取到菜谱标记或评价级别\"}";
		}
		
		// doSth
		Integer score = 1;
		return "{\"status\":\"1\",\"score\":\""+score+"\",\"message\":\"菜谱评价成功\"}";
	}

}