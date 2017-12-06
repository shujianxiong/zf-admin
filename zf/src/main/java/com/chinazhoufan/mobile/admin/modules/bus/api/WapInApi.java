///**
// * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
// */
//package com.chinazhoufan.mobile.admin.modules.bus.api;
//
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.alibaba.druid.util.StringUtils;
//import com.chinazhoufan.admin.common.service.ServiceException;
//import com.chinazhoufan.admin.common.utils.DateUtils;
//import com.chinazhoufan.admin.common.web.BaseRestController;
//import com.chinazhoufan.admin.modules.bas.entity.ScanCode;
//import com.chinazhoufan.admin.modules.bas.service.ScanCodeService;
//import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
//import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpChange;
//import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
//import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
//import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpChangeService;
//import com.chinazhoufan.admin.modules.lgt.service.ps.WareplaceService;
//import com.chinazhoufan.api.common.config.Constants;
//import com.chinazhoufan.mobile.admin.modules.bus.service.oh.WapHireOrderService;
//import com.chinazhoufan.mobile.admin.modules.bus.service.oh.WapHireProductService;
//import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
//
///**
// * 入库API
// * @author 张金俊
// * @version 2016-11-03
// */
//@RestController
//@RequestMapping(value = "${mobileAdminPath}/user/bus/in")
//public class WapInApi extends BaseRestController {
//
//	@Autowired
//	private WapHireOrderService wapHireOrderService;
//	@Autowired
//	private WapHireProductService wapHireProductService;
//	@Autowired
//	private ProductService productService;
//	@Autowired
//	private ScanCodeService scanCodeService;
//	@Autowired
//	private WareplaceService wareplaceService;
//	@Autowired
//	private ProductWpChangeService productWpChangeService;
//	
//	public static final String PRODUCT_BYID_UNEXIST = "productUnexist";
//	
//	
////	/**
////	 * 入库中订单列表（入库人从拆包人手上接手的订单列表接口）
////	 * @return
////	 */
////	@RequestMapping(value = "/myInList/{goPage}",method = {RequestMethod.GET,RequestMethod.POST})
////	public Echos myInList(@PathVariable Integer goPage, HttpServletRequest request) {
////		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：myInList()	请求时间："+DateUtils.getDateTime());
////		currentUser = getUser(request);
////		Echos echos = null;
////		
////		Page<HireOrder> page = new Page<HireOrder>();
////		page.setPageNo(goPage);
////		page.setPageSize(10);
////		
////		try {
////			HireOrder hireOrderParam = new HireOrder(new LogisticsOrder());
////			hireOrderParam.setStatusSystem(HireOrder.STATUS_SYSTEM_INING);
////			hireOrderParam.getLogisticsOrder().setInBy(currentUser);
////			wapHireOrderService.findPage(page, hireOrderParam);
////			echos = new Echos(Constants.SUCCESS, page);
////		} catch (Exception e) {
////			e.printStackTrace();
////			echos = new Echos(Constants.ERROR);
////		}
////		return echos;
////	}
//	
////	/**
////	 * 扫描货品编码，接手货品及对应的物流单
////	 * 1.根据货品查询租赁单，租赁单状态为“待入库”或“入库中”则正确。否则为历史数据。
////	 * 2.更新“待入库”租赁单状态及其对应物流单入库信息
////	 * 3.更新租赁货品入库状态
////	 * @param code	货品编码
////	 * @return
////	 */
////	@RequestMapping(value = "/scanProduct",method = {RequestMethod.GET,RequestMethod.POST})
////	public Echos scanProduct(@RequestParam(value="code",required=true, defaultValue="")String code, HttpServletRequest request) {
////		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：scanProduct()	请求时间："+DateUtils.getDateTime());
////		currentUser = getUser(request);
////		Echos echos = null;
////		
////		try {
////			wapHireOrderService.scanProductForIn(code, currentUser);
////			echos = new Echos(Constants.SUCCESS);
////		} catch (Exception e) {
////			e.printStackTrace();
////			echos = new Echos(Constants.ERROR);
////		}
////		return echos;
////	}
//	
////	/**
////	 * 入库中货品列表（入库状态为“入库中”的租赁货品列表）
////	 * @return
////	 */
////	@RequestMapping(value = "/myProductList/{goPage}",method = {RequestMethod.GET,RequestMethod.POST})
////	public Echos myProductList(@PathVariable Integer goPage, HttpServletRequest request) {
////		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：myProductList()	请求时间："+DateUtils.getDateTime());
////		currentUser = getUser(request);
////		Echos echos = null;
////		
////		Page<HireProduct> page = new Page<HireProduct>();
////		page.setPageNo(goPage);
////		page.setPageSize(10);
////		
////		try {
////			HireProduct hireProductParam = new HireProduct(new HireOrder(new LogisticsOrder()));
////			hireProductParam.setStatusIn(HireProduct.STATUS_INING);						// 租赁货品状态为“入库中”
////			hireProductParam.getHireOrder().getLogisticsOrder().setInBy(currentUser);	// 对应租赁订单的物流单的入库人为当前用户
////			wapHireProductService.findPageWithDetail(page, hireProductParam);
////			echos = new Echos(Constants.SUCCESS, page);
////		} catch (Exception e) {
////			e.printStackTrace();
////			echos = new Echos(Constants.ERROR);
////		}
////		return echos;
////	}
//	
//	/**7.3
//	 * 货品入库：入库界面扫码枪扫描电子码
//	 * 电子码为货品电子码或货位电子码。
//	 * 货品电子码对应的货品为物流状态是待入库状态的货品，不区分该货品应该由谁入库。
//	 * 货位电子码对应的货位为启用中、未锁定且可存该货的货位
//	 * @param code		扫描电子码
//	 * @param productId	货品ID
//	 * @param request
//	 * @return
//	 */
//	@RequestMapping(value = "/scanCode",method = {RequestMethod.GET,RequestMethod.POST})
//	public Echos scanCode(@RequestParam(value="code",required=true, defaultValue="")String code, 
//			@RequestParam(value="productId",required=false, defaultValue="")String productId, 
//			HttpServletRequest request) {
//		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：scanCode()	请求时间："+DateUtils.getDateTime());
//		currentUser = getUser(request);
//		Echos echos = null;
//		
//		try {
//			ScanCode scanCode = scanCodeService.getByCode(code);
//			if(scanCode != null){
//				if(ScanCode.TYPE_PRODUCT.equals(scanCode.getType())){
//					// 扫到货品电子码
//					Product product = productService.getByScanCode(code);
//					if(product != null){
//						if(Product.STATUS_LGT_WAIT_IN.equals(product.getStatusLogistics())){
//							// 扫码枪扫到对应待入库货品，查询货品最后一次出库货位（最近时间内的由货位变动到持有人的“货品货位变动记录”中的货位）
//							ProductWpChange productWpChange = productWpChangeService.getLastOutChange(product.getId());
//							Wareplace outWareplace = wareplaceService.get(productWpChange.getPreWareplace());
//							product.setWareplace(outWareplace);
//							echos = new Echos(Constants.WAP_HO_SCAN_CODE_PRODUCT_INFO, product);
//						}else {
//							// 当前货品物流状态不处于待入库状态
//							echos = new Echos(Constants.WAP_HO_PRODUCT_ERROR);
//						}
//					}else {
//						// 电子码对应的货品不存在
//						echos = new Echos(Constants.WAP_HO_PRODUCT_UNEXIST);
//					}
//				}else if(ScanCode.TYPE_WAREPLACE.equals(scanCode.getType())){
//					// 扫到货位电子码（确认入库的货品ID非空）
//					if(!StringUtils.isEmpty(productId)){
//						// 查询对应货位
//						Wareplace wareplace = wareplaceService.getByScanCode(code);
//						if(wareplace != null){
//							// 扫码枪扫描到可入库货位，对单个货品进行入库操作
//							wapHireOrderService.finishInSingle(productId, wareplace, currentUser);
//							echos = new Echos(Constants.WAP_HO_SCAN_CODE_WAREPLACE_UPDATED, wareplace);
//						}else {
//							// 电子码对应的货位不存在
//							echos = new Echos(Constants.WAP_HO_WAREPLACE_UNEXIST);
//						}
//					}else{
//						// 提交要入库的货位的电子码时同时提交的入库货品ID不能为空
//						echos = new Echos(Constants.WAP_HO_PRODUCT_ID_NULL);
//					}
//				}else {
//					// 电子码类型异常，请扫描货品电子码或货位电子码 
//					echos = new Echos(Constants.WAP_HO_SCAN_CODE_TYPE_ERROR);
//				}
//			}else {
//				// 电子码不存在
//				echos = new Echos(Constants.WAP_HO_SCAN_CODE_UNEXIST);
//			}
//		} catch (ServiceException se){
//			switch (se.getMessage()) {
//			case PRODUCT_BYID_UNEXIST:
//				// 提交要入库的货位的电子码时同时提交的入库货品ID对应的货品不存在
//				echos = new Echos(Constants.WAP_HO_PRODUCT_BYID_UNEXIST);
//				break;
//			case ProductWpChange.FAIL_POSTWAREPLACE_USELESS:
//				// 货品货位调整：异常，货品调入货位未启用，不能调入
//				echos = new Echos(Constants.WAP_HO_WP_CHANGE_POSTWAREPLACE_USELESS);
//				break;
//			case ProductWpChange.FAIL_POSTWAREPLACE_LOCKED:
//				// 货品货位调整：异常，货品调入货位已锁定，不能调入
//				echos = new Echos(Constants.WAP_HO_WP_CHANGE_POSTWAREPLACE_LOCKED);
//				break;
//			case ProductWpChange.FAIL_POSTWAREPLACE_OCCUPIED:
//				// 货品货位调整：异常，货品调入货位已存放其他产品类型的货品
//				echos = new Echos(Constants.WAP_HO_WP_CHANGE_POSTWAREPLACE_OCCUPIED);
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
//	
//}