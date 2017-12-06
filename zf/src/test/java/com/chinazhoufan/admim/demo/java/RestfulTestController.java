package com.chinazhoufan.admim.demo.java;

import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.impl.util.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinazhoufan.admin.modules.sys.entity.User;


/**
 * 基于Restful风格架构测试
 * 
 * @author dekota
 * @since JDK1.5
 * @version V1.0
 * @history 2014-2-15 下午3:00:12 dekota 新建
 */
@Controller
public class RestfulTestController {

	/** 日志实例 */
	private static final Logger logger = Logger.getLogger(RestfulTestController.class);

	@RequestMapping(value = "/hello", produces = "text/plain;charset=UTF-8")
	public @ResponseBody
	String hello() {
		return "你好！hello";
	}

	@RequestMapping(value = "/say/{msg}", produces = "application/json;charset=UTF-8")
	public @ResponseBody
	String say(@PathVariable(value = "msg") String msg) {
		return "{\"msg\":\"you say:'" + msg + "'\"}";
	}

	@RequestMapping(value = "/user/{id:\\d+}", method = RequestMethod.GET)
	public @ResponseBody
	User getUser(@PathVariable("id") int id) {
		logger.info("获取人员信息id=" + id);
		User user = new User();
		user.setName("张三");
		return user;
	}

	@RequestMapping(value = "/user/{id:\\d+}", method = RequestMethod.DELETE)
	public @ResponseBody
	Object deleteUser(@PathVariable("id") int id) {
		logger.info("删除人员信息id=" + id);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("msg", "删除人员信息成功");
		return jsonObject;
	}

	@RequestMapping(value = "/user", method = RequestMethod.POST)
	public @ResponseBody
	Object addUser(User user) {
		logger.info("注册人员信息成功id=" + user.getId());
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("msg", "注册人员信息成功");
		return jsonObject;
	}

	@RequestMapping(value = "/user", method = RequestMethod.PUT)
	public @ResponseBody
	Object updateUser(User user) {
		logger.info("更新人员信息id=" + user.getId());
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("msg", "更新人员信息成功");
		return jsonObject;
	}

	@RequestMapping(value = "/user", method = RequestMethod.PATCH)
	public @ResponseBody
	List<User> listUser(@RequestParam(value = "name", required = false, defaultValue = "") String name) {

		logger.info("查询人员name like " + name);
		List<User> lstUsers = new ArrayList<User>();

		User user = new User();
		user.setName("张三");
		lstUsers.add(user);
		User user2 = new User();
		user2.setName("李四");
		lstUsers.add(user2);

		User user3 = new User();
		user3.setName("王五");
		lstUsers.add(user3);

		return lstUsers;
	}

}
