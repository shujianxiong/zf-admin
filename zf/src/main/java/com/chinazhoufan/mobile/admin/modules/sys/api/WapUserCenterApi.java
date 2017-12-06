/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.mobile.admin.modules.sys.api;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.Encodes;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductCodeChange;
import com.chinazhoufan.admin.modules.msg.entity.um.UmMessage;
import com.chinazhoufan.admin.modules.msg.entity.uw.Warning;
import com.chinazhoufan.admin.modules.msg.service.um.UmMessageService;
import com.chinazhoufan.admin.modules.msg.service.uw.WarningService;
import com.chinazhoufan.admin.modules.msg.web.uw.MyWarningController;
//import com.chinazhoufan.admin.modules.ser.entity.ms.Notice;
//import com.chinazhoufan.admin.modules.ser.entity.pi.ImPerson;
//import com.chinazhoufan.admin.modules.ser.service.ms.NoticeService;
//import com.chinazhoufan.admin.modules.ser.service.pi.ImPersonService;
import com.chinazhoufan.admin.modules.sys.dao.MenuDao;
import com.chinazhoufan.admin.modules.sys.entity.Menu;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.sys.dto.MenuDTO;
import com.chinazhoufan.mobile.admin.modules.sys.dto.UserDTO;
import com.chinazhoufan.mobile.admin.modules.sys.service.WapUserService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;

/**
 * 用户中心API
 * @author 张金俊
 * @version 2016-12-05
 */
@RestController
@RequestMapping(value = "${mobileAdminPath}/user/uc")
public class WapUserCenterApi extends BaseRestController {

	@Autowired
	private WapUserService wapUserService;
	@Autowired
	private RedisCacheService<String,UserDTO> userDTORedisCacheService;
	@Autowired
	private RedisCacheService<String,String> stringRedisCacheService;
	@Autowired
	private SystemService systemService;
//	@Autowired
//	private ImPersonService imPersonService;
//	@Autowired
//	private NoticeService noticeService;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private UmMessageService umMessageService;
	@Autowired
	private WarningService warningService; 
	
	
	/**权限标识**/
	public static final String PERMISSION_WAIT_OUT			= "waitOutWarehouse";	// 待出库
	public static final String PERMISSION_WAIT_REPAIR		= "waitRepair";			// 待维修
	
	
	/**9.1
	 * 用户中心主页面
	 * @param sessionID
	 * @return
	 */
	@RequestMapping(value = "userInfo", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos userInfo(HttpServletRequest request) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：userInfo()	请求时间："+DateUtils.getDateTime());
		Echos echos = null;
		
		try {
			String sessionID = request.getParameter("sid");
			UserDTO userDTO = userDTORedisCacheService.get(String.format(RedisCacheService.MOBILE_SESSION, sessionID));
			User user = wapUserService.getByLoginName(userDTO.getLoginName());
			echos = new Echos(Constants.SUCCESS, user);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	/**9.2
	 * 用户修改密码
	 * @param sessionID
	 * @return
	 */
	@RequestMapping(value = "modifyPassword", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos modifyPassword(@RequestParam(value="password",required=true, defaultValue="")String password, HttpServletRequest request) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：modifyPassword()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		Echos echos = null;
		
		try {
			if(StringUtils.isBlank(password)){
				echos = new Echos(Constants.PARAMETER_ISNULL);
			}
			systemService.updatePasswordById(currentUser.getId(), password, currentUser);
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	/**
	 * 9.3
	 * 用户未读通知数量、未完成任务数量统计
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "noticeCountUnread", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos noticeCountUnread(HttpServletRequest request, HttpServletResponse response) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：noticeCountUnread()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		Echos echos = null;
		
		try {
//			// 未读通知数量统计
//			ImPerson imPerson = imPersonService.getByUsercode(currentUser.getLoginName());
//			Notice noticeParam = new Notice();
//			noticeParam.setType(Notice.NOTICE_TYPE_SYS);	// 系统通知
//			noticeParam.setToPerson(imPerson);				// 接收用户
//			Integer unreadCount = noticeService.getCountUnread(noticeParam);
			
			// 未完成任务数量统计
			Menu m = new Menu();
			m.setUserId(currentUser.getId());
			List<Menu> menuList = menuDao.findByUserId(m);
			// 根据权限标识，查询对应的待完成任务数量并封装DTO
			List<MenuDTO> menuDTOList = new ArrayList<MenuDTO>();
			for(Menu menu : menuList){
				MenuDTO menuDTO = null;
				
				if(StringUtils.isNotEmpty(menu.getPermission())){
					menuDTO = new MenuDTO(menu.getPermission());
					if(Menu.FALSE_FLAG.equals(menu.getIsShow())){
						// menu显示状态为“不显示”，则该menu为功能
						menuDTO.setPermissionType(MenuDTO.PERMISSIONTYPE_OPERATION);
					}else{
						// menu显示状态为“不显示”，则该menu为菜单
						menuDTO.setPermissionType(MenuDTO.PERMISSIONTYPE_MENU);
						// 设置菜单的未完成任务数量
						switch (menu.getPermission()) {
						case WapUserCenterApi.PERMISSION_WAIT_OUT:
							/**
							 * 查询待出库任务数量
							 * 1.获取系统业务参数设置中设置的“租赁锁库存前延天数”
							 * 2.锁库存前延天数确定锁库存起始日期。
							 * 3.锁库存起始日期即系统出库起始日期。
							 * eg：	某订单10月20日起租，系统设定租赁锁库存前延天数=3
							 * 		则10月17日开始锁库存
							 * 		即10月17日开始出库，手持端待出库列表中可以查询到该订单。
							 */
							menuDTO.setTodoNum(1);
							break;
						case WapUserCenterApi.PERMISSION_WAIT_REPAIR:
							// 查询待维修任务数量
							menuDTO.setTodoNum(2);
							break;
						default:
							menuDTO.setTodoNum(0);
							break;
						}
					}
					//菜单或功能加入menuDTO传输给移动端
					menuDTOList.add(menuDTO);
				}
			}
			
			// 返回未读消息数量、未完成任务数量
//			echos = new Echos(Constants.SUCCESS, unreadCount);
//			echos.setData(unreadCount);
//			echos.setList(menuDTOList);
			
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	/**
	 * 9.4
	 * 用户通知列表
	 * @param pageNo	当前页码
	 * @param pageSize	页面大小
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "noticeList", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos noticeList(
			@RequestParam(value="pageNo",required=true, defaultValue="1") Integer pageNo,
			@RequestParam(value="pageSize",required=true, defaultValue="10") Integer pageSize, 
			@RequestParam(value="type",required=true, defaultValue="0") String type, 
			HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：noticeList()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		Echos echos = null;
//		Page<Notice> page = new Page<Notice>(request, response);
		
		try {
//			ImPerson imPerson = imPersonService.getByUsercode(currentUser.getLoginName());
//			Notice noticeParam = new Notice();
//			noticeParam.setToPerson(imPerson);
//			noticeParam.setType(type);
//			noticeService.findPage(page, noticeParam);
//			echos = new Echos(Constants.SUCCESS, page);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	/**9.5
	 * 用户通知详情
	 * @param id	通知ID
	 * @return
	 */
	@RequestMapping(value = "noticeInfo", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos noticeInfo(@RequestParam(value="id",required=true, defaultValue="") String id) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：noticeInfo()	请求时间："+DateUtils.getDateTime());
		Echos echos = null;
		
		try {
//			Notice notice = noticeService.get(id);
//			echos = new Echos(Constants.SUCCESS, notice);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
	
	/**
	 * 9.6
	 * 消息列表
	 * @param pageNo	当前页码
	 * @param pageSize	页面大小
	 * @param type      消息类型(1=系统，2=个人)
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "messageList", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos messageList(
			@RequestParam(value="pageNo",required=true, defaultValue="1") Integer pageNo,
			@RequestParam(value="pageSize",required=true, defaultValue="10") Integer pageSize, 
			@RequestParam(value="type",required=true, defaultValue="0") String type, 
			@RequestParam(value="searchKey",required=true, defaultValue="0") String searchKey, 
			HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：noticeList()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		Echos echos = null;
		Page<UmMessage> page = new Page<UmMessage>(request, response);
		
		try {
			UmMessage messageParam = new UmMessage();
			messageParam.setReceiveUser(currentUser);
			messageParam.setType(type);
			messageParam.setTitle(searchKey);
			umMessageService.findPage(page, messageParam);
			echos = new Echos(Constants.SUCCESS, page);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
	/**9.7
	 * 消息详情
	 * @param id	消息ID
	 * @return
	 */
	@RequestMapping(value = "messageInfo", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos messageInfo(@RequestParam(value="id",required=true, defaultValue="") String id) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：messageInfo()	请求时间："+DateUtils.getDateTime());
		Echos echos = null;
		
		try {
			UmMessage message = umMessageService.get(id);
			echos = new Echos(Constants.SUCCESS, message);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
	/**9.8
	 * 消息删除
	 * @param id	消息ID
	 * @return
	 */
	@RequestMapping(value = "deleteMessageById", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos deleteMessageById(@RequestParam(value="id",required=true, defaultValue="") String id) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：deleteMessageById()	请求时间："+DateUtils.getDateTime());
		Echos echos = null;
		
		try {
			umMessageService.delete(new UmMessage(id));
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
	/**9.9
	 * 消息查看
	 * @param id	消息ID
	 * @return
	 */
	@RequestMapping(value = "viewMessage", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos viewMessage(@RequestParam(value="id",required=true, defaultValue="") String id) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：viewMessage()	请求时间："+DateUtils.getDateTime());
		Echos echos = null;
		
		try {
			UmMessage um = umMessageService.get(id);
			umMessageService.view(um);
			echos = new Echos(Constants.SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
	
	
	/**
	 * 10.1
	 * 预警列表
	 * @param pageNo	当前页码
	 * @param pageSize	页面大小
	 * @param status    预警状态  ("1";//待查看 ,"2";//待处理,"3";//已处理)
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "warningList", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos warningList(
			@RequestParam(value="pageNo",required=true, defaultValue="1") Integer pageNo,
			@RequestParam(value="pageSize",required=true, defaultValue="15") Integer pageSize, 
			@RequestParam(value="status",required=true, defaultValue="0") String status, 
			HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：warningList()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		Echos echos = null;
		Page<Warning> page = new Page<Warning>(request, response);
		
		try {
			Warning warning = new Warning();
			warning.setReceiveUser(currentUser);
			warning.setStatus(status);
			warningService.findPage(page, warning);
			
			echos = new Echos(Constants.SUCCESS, page);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
	/**10.2
	 * 预警消息已读
	 * @param id	预警消息ID
	 * @return
	 */
	@RequestMapping(value = "changeWarningReadFlagById", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos changeWarningReadFlagById(@RequestParam(value="id",required=true, defaultValue="") String id) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：changeWarningReadFlagById()	请求时间："+DateUtils.getDateTime());
		Echos echos = null;
		
		try {
			Warning warning = warningService.get(id);
			warning.setStatus(Warning.STATUS_TO_DEAL);//待处理
			warningService.save(warning);
			echos = new Echos(Constants.SUCCESS, warning);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	/**10.3
	 * 预警消息处理
	 * @param warningJson	预警消息json串
	 * @return
	 */
	@RequestMapping(value = "dealWarning", method = {RequestMethod.GET,RequestMethod.POST})
	public Echos dealWarning(
			@RequestParam(name = "warningJson", defaultValue = "", required = true)String warningJson,
			HttpServletRequest request
			) {
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：dealWarningById()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		Echos echos = null;
		
		try {
			if(StringUtils.isBlank(warningJson)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			// 移动端传递过来的Json字符串转换为 【货品货签变更记录】对象
			warningJson = Encodes.unescapeHtml(warningJson);
			Warning warning = (Warning)JsonMapper.fromJsonString(warningJson, Warning.class);
			
			warning.setDealStartTime(DateUtils.parseDate(DateUtils.getDate("yyyy-MM-dd HH:mm:ss"))); //处理开始时间
			warning.setDealUser(currentUser); //处理人
			warning.setStatus(Warning.STATUS_FINISH); //状态：处理完成
			warningService.save(warning);
			echos = new Echos(Constants.SUCCESS, warning);
		} catch (Exception e) {
			e.printStackTrace();
			echos = new Echos(Constants.ERROR);
		}
		return echos;
	}
	
	
	
	
	
}