/**
 * WapPickOrderApi.java
 * com.chinazhoufan.mobile.admin.modules.bus.api
 *
 * Function： TODO 
 *
 *   ver     date      		author
 * ──────────────────────────────────
 *   		 2017年4月12日 		chenshi
 *
 * Copyright (c) 2017, TNT All Rights Reserved.
*/

package com.chinazhoufan.mobile.admin.modules.bus.api;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.qiniu.FileManager;
import com.chinazhoufan.admin.common.qiniu.QiNiuConfig;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.Encodes;
import com.chinazhoufan.admin.common.utils.SystemPath;
import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.entity.or.RepairOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProductService;
import com.chinazhoufan.admin.modules.bus.service.or.RepairOrderService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpChangeService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareplaceService;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.lgt.service.ps.WapGoodsService;
import com.chinazhoufan.mobile.admin.modules.lgt.service.ps.WapProduceService;
import com.chinazhoufan.mobile.admin.modules.lgt.service.ps.WapProductService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.qiniu.common.QiniuException;

/**
 * 订单查询API
 * @author   liut
 *
 */

@RestController
@RequestMapping(value = "${mobileAdminPath}/user/returnOrder")
public class WapReturnOrderApi extends BaseRestController {

	public static final String TEMP_FILE_PATH="uploadTemp";//上传文件临时目录

	@Autowired
	private ReturnOrderService returnOrderService;//退货单Service
	@Autowired
	private ReturnProductService returnProductService;
	@Autowired
	private RepairOrderService repairOrderService;
	
	
	/**
	 * 根据物流单号获取退货单信息
	 * @param expressNo
	 * @return
	 */
	@RequestMapping(value = "/searchReturnOrderByExpressNo", method = RequestMethod.GET)
	public Echos searchReturnOrderByExpressNo(
			@RequestParam(name = "expressNo", defaultValue = "", required = true)String expressNo) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：searchReturnOrderByExpressNo()	请求时间："+DateUtils.getDateTime());
		
		try {
			if(StringUtils.isBlank(expressNo)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			//获取返回数据
			ReturnOrder ro = new ReturnOrder();
			ro.setExpressNo(expressNo);
			ReturnOrder returnOrder = returnOrderService.findWithProductByExpressNo(ro);
			returnOrder.setStatus(DictUtils.getDictLabel(returnOrder.getStatus(), "bus_ol_return_order_status", ""));
			
			List<ReturnProduct> returnProductList = returnOrder.getReturnProductList();
			for(ReturnProduct rt : returnProductList) {
//				rt.setStatus(DictUtils.getDictLabel(rt.getStatus(), "bus_ol_return_product_status", ""));
			}
			
			//变更退货单状态（退货中=》待质检）
			ro = returnOrder;
			ro.setStatus(ReturnOrder.STATUS_TOCHECK);
			returnOrderService.updateStatusById(ro);
			
			//变更退货货品的状态
			ReturnProduct returnProduct = new ReturnProduct();
//			returnProduct.setStatus(ReturnProduct.CHECK_WAIT);
			returnProduct.setExpressNo(expressNo);
			returnProductService.updateStatusByExpressNo(returnProduct);
			
			
			return new Echos(Constants.SUCCESS, returnOrder);
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
	
	
	
	/**
	 * 保存退货货品登记信息
	 * @param 维修登记对象json字符串
	 * @param 上传图片files
	 * @param 退货单ID
	 * @return    
	 * @throws
	 */
	@RequestMapping(value = "/saveReturnProductRegister", method = RequestMethod.POST)
	public Echos saveReturnProductRegister(
			@RequestParam(name = "repairRegJson", defaultValue = "", required = true)String repairRegJson,
			@RequestParam(name = "files", defaultValue = "", required = false)MultipartFile[] files,
			@RequestParam(name = "returnOrderId", defaultValue = "", required = true)String returnOrderId,
			HttpServletRequest request) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：saveReturnProductRegister()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		
		try {
			if(StringUtils.isBlank(repairRegJson)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			StringBuilder sb = new StringBuilder();
			if(files != null && files.length > 0) {
				int c = 0;
				for(MultipartFile file : files) {
					String fileName = file.getOriginalFilename(); 
					String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());
					
					String newFileName = UUID.randomUUID().toString();
					String imgFilePath = SystemPath.getSysPath()+""+ TEMP_FILE_PATH+"\\"+newFileName+suffix;//新生成的图片
					String[] fileTypes=fileName.split("\\.");
					if(fileTypes.length<2)
						return new Echos(Constants.ERROR);
					
					try {
						OutputStream out = new FileOutputStream(imgFilePath);      
						out.write(file.getBytes());  
						out.flush();  
						out.close(); 
							
						String tempFilePath = SystemPath.getSysPath()+""+ TEMP_FILE_PATH;
						File f = new File(tempFilePath);
						if(!f.exists()) {
							boolean flag = f.mkdirs();
							if(flag) 
								System.out.println("临时图片存储路径创建成功："+tempFilePath);
						} 
							
						File targetFile = new File(imgFilePath);
						FileManager fileManager=new FileManager();
						String qiNiufileName=fileManager.uploadByFile(targetFile, QiNiuConfig.bucketName);
						sb.append(qiNiufileName);
						if(c != files.length-1) {
							sb.append(",");
						}
						c++;
						targetFile.delete();
					} catch (FileNotFoundException e) {
						e.printStackTrace();
						return new Echos(Constants.ERROR);
					} catch (QiniuException e) {
						e.printStackTrace();
						return new Echos(Constants.ERROR);
					} catch (IOException e) {
						e.printStackTrace();
						return new Echos(Constants.ERROR);
					}
				}
			}
			
			//System.out.println("破损图片证据："+sb.toString());
			
			// 移动端传递过来的Json字符串转换为 【维修登记对象待定】对象
			repairRegJson = Encodes.unescapeHtml(repairRegJson);
			RepairOrder repairOrder = (RepairOrder)JsonMapper.fromJsonString(repairRegJson, RepairOrder.class);
			
			repairOrder.setApplyBy(currentUser);
			repairOrder.setApplyTime(new Date());
			repairOrder.setApplyType(RepairOrder.DEALTYPE_SELF_REPAIR);//默认维修
			repairOrder.setDealType(RepairOrder.DEALTYPE_SELF_REPAIR);//默认维修
			repairOrder.setStatus(RepairOrder.STATUS_WAIT_REPAIR);
			repairOrder.setDealPhotos(sb.toString());//破损证据
			repairOrderService.save(repairOrder);
			
			
			
			// 变更退货货品的质检状态
			ReturnProduct returnProduct = new ReturnProduct();
			returnProduct.setProduct(repairOrder.getProduct());
//			returnProduct.setStatus(ReturnProduct.CHECK_READY);
//			returnProduct.setPreStatus(ReturnProduct.CHECK_WAIT);
			returnProductService.updateStatusByProductAndStatus(returnProduct);
			
			//如果这个退货单对应的退货货品接已经质检过了，那么退货单状态从待质检变更为待结算
			
			ReturnOrder returnOrder = new ReturnOrder(returnOrderId);
			
			returnProduct = new ReturnProduct();
//			returnProduct.setStatus(ReturnProduct.CHECK_WAIT);
			returnProduct.setReturnOrder(returnOrder);
			Integer c = returnProductService.countWaitCheckReturnProduct(returnProduct);
			if(c == 0) {
				returnOrder.setStatus(ReturnOrder.STATUS_TOACCOUNT);
				returnOrderService.updateStatusById(returnOrder);
			}
			
			return new Echos(Constants.SUCCESS, "保存退货货品登记记录成功");
		} catch (ServiceException se) {
			return new Echos(Constants.ERROR);
		}
		
	}
	
	
	
}

