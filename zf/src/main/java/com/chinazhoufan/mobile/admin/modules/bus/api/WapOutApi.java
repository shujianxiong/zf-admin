///**
// * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
// */
//package com.chinazhoufan.mobile.admin.modules.bus.api;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.chinazhoufan.admin.common.mapper.JsonMapper;
//import com.chinazhoufan.admin.common.persistence.Page;
//import com.chinazhoufan.admin.common.service.ServiceException;
//import com.chinazhoufan.admin.common.utils.DateUtils;
//import com.chinazhoufan.admin.common.utils.Encodes;
//import com.chinazhoufan.admin.common.web.BaseRestController;
//import com.chinazhoufan.admin.modules.bas.entity.ScanCode;
//import com.chinazhoufan.admin.modules.bas.service.ScanCodeService;
//import com.chinazhoufan.admin.modules.bus.entity.oh.HireOrder;
//import com.chinazhoufan.admin.modules.bus.entity.ol.LogisticsOrder;
//import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
//import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpChange;
//import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
//import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
//import com.chinazhoufan.admin.modules.ser.service.pi.ImPersonService;
//import com.chinazhoufan.api.common.config.Constants;
//import com.chinazhoufan.api.modules.im.INoticeService;
//import com.chinazhoufan.mobile.admin.modules.bus.service.oh.WapHireOrderService;
//import com.chinazhoufan.mobile.admin.modules.lgt.service.ps.WapProductService;
//import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
//
///**
// * 出库API
// * @author 张金俊
// * @version 2016-10-11
// */
//@RestController
//@RequestMapping(value = "${mobileAdminPath}/user/bus/ow")
//public class WapOutApi extends BaseRestController {
//
//	@Autowired
//	private WapHireOrderService wapHireOrderService;
//	@Autowired
//	private WapProductService wapProductService;
//	@Autowired
//	private ProductService productService;
//	@Autowired
//	private ScanCodeService scanCodeService;
//	@Autowired
//	private ImPersonService imPersonService;
//	@Autowired
//	private INoticeService iNoticeService;
//	
//	
//	/**权限标识**/
//	public static final String LISTTYPE_WAIT_OUT		= "1";	// 待接任务（未被接单的“待出库”订单）
//	public static final String LISTTYPE_MINE_OUTING		= "2";	// 货品出库（我的“出库中”订单）
//	public static final String LISTTYPE_MINE_PACKAGEING	= "3";	// 运单录入（我的“配货中”订单）
//	
//	
//	/**
//	 * 2.1
//	 * 待出库订单列表接口
//	 * @param pageNo	当前页码
//	 * @param pageSize	页面大小
//	 * @param dataType	订单列表类型（1：未被接单的待出库订单  2：我的待出库订单）
//	 * @param request
//	 * @param response
//	 * @return
//	 */
//	@RequestMapping(value = "/outList",method = {RequestMethod.GET,RequestMethod.POST})
//	public Echos outList(
//			@RequestParam(value="pageNo",required=true, defaultValue="1") Integer pageNo,
//			@RequestParam(value="pageSize",required=true, defaultValue="10") Integer pageSize, 
//			@RequestParam(value="dataType",required=true, defaultValue="1")String dataType, 
//			HttpServletRequest request, 
//			HttpServletResponse response) {
//		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：outList()	请求时间："+DateUtils.getDateTime());
//		
////		// 维修完成，给维修单申请人发送通知
////		ImPerson imPerson = imPersonService.getByUsercode("admin18");
////		iNoticeService.sendSysNotice(imPerson.getId(), "18，维修单已完成", "您的维修单对应的货品已维修完成，请到对应的维修人员处取货");
//		
//		iNoticeService.sendSysNotice("32ae2bd622714db19766ebec52b6624e", "租赁订单已发货", "您的租赁订单已发货，请随时查询物流信息注意收货");
//		return null;
//		
////		currentUser = getUser(request);
////		Echos echos = null;
////		Page<HireOrder> page = new Page<HireOrder>(request, response);
////		
////		try {
////			HireOrder hireOrderParam = new HireOrder(new LogisticsOrder());
////			if(LISTTYPE_WAIT_OUT.equals(dataType)){
////				/**
////				 * 查询未被接单的“待出库”订单
////				 * 默认：锁库起始日期即系统出库起始日期
////				 * 		前端查询库存时根据订单的锁库起始日期判断该订单占用库存情况
////				 * 		移动端根据锁库起始日期判断订单是否开始出库（当前日期到达锁库起始日期，则手持端待出库列表中可以查询到该订单）
////				 */
////				wapHireOrderService.findPageToOut(page, hireOrderParam);
////			}else if(LISTTYPE_MINE_OUTING.equals(dataType)){
////				// 查询我的“出库中”的租赁订单
////				hireOrderParam.setStatusSystem(HireOrder.STATUS_SYSTEM_OUTING);
////				hireOrderParam.getLogisticsOrder().setOutBy(currentUser);
////				wapHireOrderService.findPage(page, hireOrderParam);
////			}else if(LISTTYPE_MINE_PACKAGEING.equals(dataType)){
////				// 查询我的“配货中”的租赁订单
////				hireOrderParam.setStatusSystem(HireOrder.STATUS_SYSTEM_PACKAGEING);
////				hireOrderParam.getLogisticsOrder().setPackageBy(currentUser);
////				wapHireOrderService.findPage(page, hireOrderParam);
////			}
////			echos = new Echos(Constants.SUCCESS, page);
////		} catch (Exception e) {
////			e.printStackTrace();
////			echos = new Echos(Constants.ERROR);
////		}
////		return echos;
//	}
//	
//	/**2.2
//	 * 接手&显示订单详情
//	 * @param id	租赁订单ID
//	 * @return
//	 */
//	@RequestMapping(value = "/outDetail",method = {RequestMethod.GET,RequestMethod.POST})
//	public Echos outDetail(@RequestParam(value="id",required=true, defaultValue="")String id, HttpServletRequest request) {
//		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：outDetail()	请求时间："+DateUtils.getDateTime());
//		currentUser = getUser(request);
//		Echos echos = null;
//		try {
//			HireOrder hireOrder = wapHireOrderService.getWithHireProduces(id);
//			HireOrder hireOrderResult; 
//			
//			if(HireOrder.STATUS_SYSTEM_WAIT_OUT.equals(hireOrder.getStatusSystem())){
//				// 待出库订单接单成功，更新接单状态变为“出库中”，并显示订单详情
//				wapHireOrderService.handleOutWarehouse(hireOrder, currentUser);
//				hireOrderResult = wapHireOrderService.getWithHireProducesDetail(id);
//				echos = new Echos(Constants.WAP_HO_HANDLE_OUTING_SUCCESS, hireOrderResult);
//			}else if(HireOrder.STATUS_SYSTEM_OUTING.equals(hireOrder.getStatusSystem())
//					&& currentUser.getId().equals(hireOrder.getLogisticsOrder().getOutBy().getId())) {
//				// 当前用户的出库中订单，显示订单详情
//				hireOrderResult = wapHireOrderService.getWithHireProducesDetail(id);
//				echos = new Echos(Constants.SUCCESS, hireOrderResult);
//			}else {
//				// 待出库订单接单失败，该订单已被其他人接单
//				echos = new Echos(Constants.WAP_HO_HANDLE_OUTING_ERROR);
//			}
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			echos = new Echos(Constants.ERROR);
//		}
//		return echos;
//	}
//	
//	/**2.3
//	 * 扫描货品接口
//	 * @param code	货品编码
//	 * @return
//	 */
//	@RequestMapping(value = "/scanProduct",method = {RequestMethod.GET,RequestMethod.POST})
//	public Echos scanProduct(@RequestParam(value="code",required=true, defaultValue="")String code) {
//		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：scanProduct()	请求时间："+DateUtils.getDateTime());
//		Echos echos = null;
//		
//		try {
//			ScanCode scanCode = scanCodeService.getByCode(code);
//			if(scanCode != null){
//				if(ScanCode.TYPE_PRODUCT.equals(scanCode.getType())){
//					Product product = productService.getByScanCode(code);
//					if(product != null){																		// 货品存在
//						if(product.getWareplace() != null && product.getWareplace().getId() != null){			// 货品对应的货位存在
//							if(Wareplace.TRUE_FLAG.equals(product.getWareplace().getUsableFlag())){				// 货品货位启用
//								if(Wareplace.LOCKFLAG_UNLOCKED.equals(product.getWareplace().getLockFlag())){	// 货品货位未锁定
//									if(Product.FALSE_FLAG.equals(product.getDelFlag())
//											&& Product.STATUS_NORMAL.equals(product.getStatus())
//											&& Product.STATUS_LGT_IN.equals(product.getStatusLogistics())){
//										// 扫描到可出库货品（未删除、状态正常、物流状态在库） 
//										echos = new Echos(Constants.SUCCESS, product);
//									}else {
//										// 货品信息异常
//										echos = new Echos(Constants.WAP_HO_PRODUCT_ERROR);
//									}
//								}else {
//									// 该货品调出货位已锁定，不能调出
//									echos = new Echos(Constants.WAP_HO_WP_CHANGE_PREWAREPLACE_LOCKED);
//								}
//							}else {
//								// 该货品的调出货位未启用，不能调出
//								echos = new Echos(Constants.WAP_HO_WP_CHANGE_PREWAREPLACE_USELESS);
//							}
//						}else {
//							// 货品的货位信息不存在
//							echos = new Echos(Constants.WAP_HO_WAREPLACE_UNEXIST);		
//						}
//					}else {
//						// 货品不存在
//						echos = new Echos(Constants.WAP_HO_PRODUCT_UNEXIST);					
//					}
//				}else {
//					// 电子码类型异常，请扫描货品电子码
//					echos = new Echos(Constants.WAP_HO_SCAN_CODE_TYPE_ERROR);
//				}
//			}else {
//				// 电子码不存在
//				echos = new Echos(Constants.WAP_HO_SCAN_CODE_UNEXIST);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			echos = new Echos(Constants.ERROR);
//		}
//		return echos;
//	}
//	
//	/**2.4
//	 * 完成出库接口
//	 * @param hireOrderJson	租赁订单Json字符串
//	 * @return
//	 */
//	@RequestMapping(value = "/finishOut",method = {RequestMethod.GET,RequestMethod.POST})
//	public Echos finishOut(String hireOrderJson, HttpServletRequest request) {
//		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：finishOut()	请求时间："+DateUtils.getDateTime());
//		currentUser = getUser(request);
//		Echos echos = null;
//		
//		try {
//			// 移动端传递过来的Json字符串转换为HireOrder对象
//			hireOrderJson = Encodes.unescapeHtml(hireOrderJson);
//			HireOrder hireOrder = (HireOrder)JsonMapper.fromJsonString(hireOrderJson, HireOrder.class);
//			
//			// 租赁订单出库
//			wapHireOrderService.finishOut(hireOrder, currentUser);
//			echos = new Echos(Constants.SUCCESS);
//		} catch (ServiceException se){
//			switch (se.getMessage()) {
//			case "1":
//				// 租赁订单状态不正确（当前租赁订单不是出库中状态，无法确认出库）
//				echos = new Echos(Constants.WAP_HO_HIREORDER_STATUS_ERROR);
//				break;
//			case ProductWpChange.FAIL_PREWAREPLACE_USELESS:
//				// 货品货位调整：异常，货品调出货位未启用，不能调出
//				echos = new Echos(Constants.WAP_HO_WP_CHANGE_PREWAREPLACE_USELESS);
//				break;
//			case ProductWpChange.FAIL_PREWAREPLACE_LOCKED:
//				// 货品货位调整：异常，货品调出货位已锁定，不能调出
//				echos = new Echos(Constants.WAP_HO_WP_CHANGE_PREWAREPLACE_LOCKED);
//				break;
//			default:
//				se.printStackTrace();
//				echos = new Echos(Constants.ERROR);
//				break;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			echos = new Echos(Constants.ERROR);
//		}
//		return echos;
//	}
//}