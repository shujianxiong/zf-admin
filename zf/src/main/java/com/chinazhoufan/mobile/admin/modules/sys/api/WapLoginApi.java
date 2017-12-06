/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.sys.api;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.warning.exception.RedisPingException;
import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
//import com.chinazhoufan.admin.modules.ser.entity.pi.ImPerson;
//import com.chinazhoufan.admin.modules.ser.service.pi.ImPersonService;
import com.chinazhoufan.admin.modules.sys.dao.MenuDao;
import com.chinazhoufan.admin.modules.sys.entity.Menu;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.sys.dto.UserDTO;
import com.chinazhoufan.mobile.admin.modules.sys.service.WapUserService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 手持设备员工登录Controller
 * @author 张金俊
 * @version 2016-10-11
 */
@RestController
@RequestMapping(value = "${mobileAdminPath}/sys")
public class WapLoginApi extends BaseRestController {

	@Autowired
	private WapUserService wapUserService;
	@Autowired
	private RedisCacheService<String,UserDTO> userDTORedisCacheService;
	@Autowired
	private RedisCacheService<String,String> stringRedisCacheService;
//	@Autowired
//	private ImPersonService imPersonService;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private SendOrderService sendOrderService;
	
	
	/**1.1
	 * 移动管理端登录接口
	 * @param loginName	登录账号
	 * @param password	登录密码
	 * @return
	 */
	@RequestMapping(value = "/login",method = {RequestMethod.GET,RequestMethod.POST})
	public Echos login(
			@RequestParam(value="loginName",required=true, defaultValue="")String loginName,
			@RequestParam(value="password", required=true, defaultValue="")String password,
			HttpServletRequest request) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：login()	请求时间："+DateUtils.getDateTime());
		Echos echos = null;
		try {
			// 验证登录名、密码
			User user = wapUserService.getByLoginName(loginName);
			if(user == null) {
				echos = new Echos(Constants.WAP_LOGIN_USER_UNEXIST);		// 账号loginName不存在,请核查
			} else {
				boolean flag = SystemService.validatePassword(password, user.getPassword());
				if(!flag) {
					echos = new Echos(Constants.WAP_LOGIN_PASSWORD_WRONG);	// 密码错误,请核查
				}else {
					if(!User.USER_CATAGORY.equals(user.getUserCategory())) {
						echos = new Echos(Constants.WAP_LOGIN_NO_RIGHT);	// 此账号没有访问系统后台模块的权限，请先核对下账号拥有的权限信息
					}else{
						// 登录成功，缓存sessionID信息到redis
						UserDTO userDTO = new UserDTO(); 
						userDTO.setId(user.getId());
						userDTO.setLoginName(user.getLoginName());
						userDTO.setName(user.getName());
						
						/**
						 * 删除当前用户缓存的（loginName：sessionID）和（sessionID：userDTO），即踢出该用户之前的登录状态，实现单点登录
						 */
						/*if(stringRedisCacheService.exists(String.format(RedisCacheService.MOBILE_LOGINNAME, loginName))){
							String oldSessionID = stringRedisCacheService.get(String.format(RedisCacheService.MOBILE_LOGINNAME, loginName));								
							if(StringUtils.isNotEmpty(oldSessionID)){
								if(userDTORedisCacheService.exists(String.format(RedisCacheService.MOBILE_SESSION, oldSessionID))){
									userDTORedisCacheService.del(String.format(RedisCacheService.MOBILE_SESSION, oldSessionID));
								}
							}
							stringRedisCacheService.del(String.format(RedisCacheService.MOBILE_LOGINNAME, loginName));
						}*/
						
						// 生成当前登录的新的sessionID
						String currentSessionID = UUID.randomUUID().toString();
						/**
						 * 缓存新的sessionID
						 * 缓存（“前缀_loginName”，当前登录生成的新的sessionID)
						 */
						stringRedisCacheService.set(String.format(RedisCacheService.MOBILE_LOGINNAME, loginName), currentSessionID, new Long(Global.getConfig("redisSession.mobileSessionTimeout")));
						/**
						 * 缓存新的sessionID对应的UserDTO
						 * 拦截器验证判断时使用，用以维持手持端回话）
						 */
						userDTORedisCacheService.set(String.format(RedisCacheService.MOBILE_SESSION, currentSessionID), userDTO, new Long(Global.getConfig("redisSession.mobileSessionTimeout")));
						
						// 将融云token拼接在sessionID后面提供给移动端
//						ImPerson imPerson = imPersonService.getByUsercode(loginName);
//						String rongcloudToken = imPerson==null ? "" : imPerson.getRongcloudToken();
//						String message = currentSessionID + "," + rongcloudToken;
						
						// 菜单权限及未完成任务数量统计
						Menu m = new Menu();
						m.setUserId(user.getId());
						
						List<Menu> meList = menuDao.findByPermissionForWapLogin("handMenu");
						if(meList == null || meList.size() == 0)
							return new Echos(Constants.NO_RESULT);

						Menu me = meList.get(0);
						if(me == null) 
							return new Echos(Constants.NO_RESULT);
						
						m.setParent(me);
						
						List<Menu> menuList = menuDao.findByUserIdForWapLogin(m);
						
						/** 登录成功 */
						echos = new Echos(Constants.WAP_LOGIN_SUCCESS);
						// sessionID,RongcloudToken
//						echos.setMessage(message);
						// 当前登录人信息
						echos.setData(user);
						// 权限及未完成任务数量
						echos.setList(menuList);
					}
				}
			}
		} catch (RedisPingException rpe) {
			echos = new Echos(Constants.CACHE_CON_NULL);						// 登录过程中缓存sessionID时访问redis服务失败
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	/**
	 * 移动管理端登出接口
	 * @param sessionID
	 * @return
	 */
	@RequestMapping(value = "logout", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos logout(HttpServletRequest request) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：logout()	请求时间："+DateUtils.getDateTime());
		Echos echos = null;
		
		try {
			String sessionID = request.getParameter("sid");
			if(StringUtils.isEmpty(sessionID)){
				/** 登出失败，请提交对应的sessionID */
				echos = new Echos(Constants.WAP_LOGOUT_FAIL_EMPTY_SESSIONID);
			}else {
				if(userDTORedisCacheService.exists(String.format(RedisCacheService.MOBILE_SESSION, sessionID))){
					userDTORedisCacheService.del(String.format(RedisCacheService.MOBILE_SESSION, sessionID));
				}
			}
		} catch (RedisPingException rpe) {
			/** 登出过程中缓存sessionID时访问redis服务失败 */
			echos = new Echos(Constants.CACHE_CON_NULL);
		} catch (DataAccessException dae) {
			/** 登出过程中缓存sessionID时存取数据失败 */
			echos = new Echos(Constants.CACHE_DATAACCESS_FAIL);
		}
		/** 登出成功 */
		echos = new Echos(Constants.WAP_LOGOUT_SUCCESS);
		return echos;
	}
	
	
	//统计待拣货, 待打包数量
	@RequestMapping(value = "/countSendOrderByStatus", method = RequestMethod.GET)
	public Echos countSendOrderByStatus() {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：countSendOrderByStatus()	请求时间："+DateUtils.getDateTime());
		
		try {
			SendOrder sendOrder = new SendOrder();
			sendOrder.setStatus(SendOrder.STATUS_TOPICK);
			List<SendOrder> toPickList = sendOrderService.findList(sendOrder);
			int a = toPickList.size();
			
			sendOrder.setStatus(SendOrder.STATUS_PICKING);
			List<SendOrder> toSendList = sendOrderService.findList(sendOrder);
			int b = toSendList.size();
			
			return new Echos(Constants.SUCCESS, a+"="+b);
		} catch(Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
		
	}
		
	
	
	
	
	
}