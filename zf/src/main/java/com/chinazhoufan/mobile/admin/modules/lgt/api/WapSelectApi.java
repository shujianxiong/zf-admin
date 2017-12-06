/**
 * WapSelectApi.java
 * com.chinazhoufan.mobile.admin.modules.lgt.api
 *
 * Function： TODO 
 *
 *   ver     date      		author
 * ──────────────────────────────────
 *   		 2017年4月6日 		chenshi
 *
 * Copyright (c) 2017, TNT All Rights Reserved.
*/

package com.chinazhoufan.mobile.admin.modules.lgt.api;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.qiniu.FileManager;
import com.chinazhoufan.admin.common.qiniu.QiNiuConfig;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.Encodes;
import com.chinazhoufan.admin.common.utils.SystemPath;
import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.bus.entity.or.RepairOrder;
import com.chinazhoufan.admin.modules.bus.service.or.RepairOrderService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductCodeChange;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpChange;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpChangeService;
import com.chinazhoufan.admin.modules.lgt.service.ps.WareplaceService;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.admin.modules.lgt.service.ps.WapGoodsService;
import com.chinazhoufan.mobile.admin.modules.lgt.service.ps.WapProduceService;
import com.chinazhoufan.mobile.admin.modules.lgt.service.ps.WapProductService;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;
import com.google.common.collect.Lists;
import com.qiniu.common.QiniuException;

/**
 * ClassName:WapSelectApi
 * @author   liut
 * @Date	 2017年4月6日		上午10:44:45
 */

@RestController
@RequestMapping(value = "${mobileAdminPath}/user/lgt")
public class WapSelectApi extends BaseRestController {
	
	public static final String TEMP_FILE_PATH="uploadTemp";//上传文件临时目录

	@Autowired
	private WapGoodsService wapGoodsService;
	@Autowired
	private WapProduceService wapProduceService;
	@Autowired
	private WapProductService wapProductService;
	@Autowired
	private WareplaceService wareplaceService;
	@Autowired
	private ProductWpChangeService productWpChangeService;
	@Autowired
	private RepairOrderService repairOrderService;
	
	
	/**
	 * 根据查询关键字检索对应的商品/产品/货品信息
	 * @param key  查询关键字【商品编码/商品名称（模糊）/产品编码/货品编码】
	 * @return 根据输入的查询关键字，返回对应的商品/产品/货品集合
	 * @throws
	 */
	@RequestMapping(value = "/select",method = RequestMethod.GET)
	public Echos findGoodsBySearchKey(@RequestParam(name = "key", defaultValue="", required=true)String key) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：select()	请求时间："+DateUtils.getDateTime());
		
		try {
			if(StringUtils.isBlank(key)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			List<Goods> gList = wapGoodsService.getBySearchKey(key);//商品需要显示编码
			if(gList != null && gList.size() > 0) 
				return new Echos(Constants.SUCCESS,"G", gList);
			Produce produce = wapProduceService.getByCode(key);//产品需要显示库存
			if(produce != null) {
				List<Produce> produceList = Lists.newArrayList();
				produceList.add(produce);
				return new Echos(Constants.SUCCESS, "P", produceList);
			}
			Product product = wapProductService.getByCode(key);//货品需要显示货位
			if(product != null)	{
				List<Product> produceList = Lists.newArrayList();
				produceList.add(product);
				return new Echos(Constants.SUCCESS, "T", produceList);
			}
				
			return new Echos(Constants.NO_RESULT);
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
	/**
	 * 根据商品ID获取商品详情，包括对应的产品规格，及货品信息
	 * @param id
	 * @return    返回商品详情
	 * @throws
	 */
	@RequestMapping(value = "/getGoodsWithDetailById", method = RequestMethod.GET)
	public Echos getGoodsWithDetailById(@RequestParam(name = "id", defaultValue = "", required = true)String id) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：getGoodsWithDetailById()	请求时间："+DateUtils.getDateTime());
		
		try {
			if(StringUtils.isBlank(id)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			Goods goods = wapGoodsService.getGoodsWithDetailById(id);
			return new Echos(Constants.SUCCESS, goods);
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
	
	
	/**
	 * 根据货位信息获取商品详情，包括对应的产品规格，及货品信息
	 * @param id
	 * @return    返回产品列表集合
	 * @throws
	 */
	@RequestMapping(value = "/searchByWareplace", method = RequestMethod.GET)
	public Echos searchByWareplace(
			@RequestParam(name = "wareplaceCode", defaultValue = "", required = true)String wareplaceCode,
			@RequestParam(value="pageNo",required=true, defaultValue="1") Integer pageNo,
			@RequestParam(value="pageSize",required=true, defaultValue="15") Integer pageSize, 
			HttpServletRequest request,
			HttpServletResponse response) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：searchByWareplace()	请求时间："+DateUtils.getDateTime());
		
		try {
			if(StringUtils.isBlank(wareplaceCode)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			Page<Produce> page = new Page<Produce>(request, response);
			Produce p = new Produce();
			p.setFullWareplace(wareplaceCode);
			wapProduceService.searchByWareplace(page, p);
			
			return new Echos(Constants.SUCCESS, page);
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
	
	/**
	 * 根据货品编码查询货品信息
	 * @param code
	 * @return    返回货品
	 * @throws
	 */
	@RequestMapping(value = "/searchProductByCode", method = RequestMethod.GET)
	public Echos searchProductByCode(@RequestParam(name = "code", defaultValue = "", required = true)String code) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：searchProductByCode()	请求时间："+DateUtils.getDateTime());
		
		try {
			if(StringUtils.isBlank(code)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			Product product = wapProductService.getByCode(code);
			Goods goods = wapGoodsService.find(product.getGoods().getId());
			product.setGoods(goods);
			return new Echos(Constants.SUCCESS, product);
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
	
	/**
	 * 根据货品编码查询货品信息,不包括货品对应商品的图册集
	 * @param code
	 * @return    返回货品
	 * @throws
	 */
	@RequestMapping(value = "/getProductByCodeWithoutAtlas", method = RequestMethod.GET)
	public Echos getProductByCodeWithoutAtlas(@RequestParam(name = "code", defaultValue = "", required = true)String code) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：getProductByCodeWithoutAtlas()	请求时间："+DateUtils.getDateTime());
		
		try {
			if(StringUtils.isBlank(code)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			Product product = wapProductService.getByCode(code);
			return new Echos(Constants.SUCCESS, product);
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
	
	/**
	 * 根据货位电子码返货货位对象
	 * @param scanCode
	 * @return    返回货位对象
	 * @throws
	 */
	@RequestMapping(value = "/searchWareplaceByScanCode", method = RequestMethod.GET)
	public Echos searchWareplaceByScanCode(@RequestParam(name = "scanCode", defaultValue = "", required = true)String scanCode) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：searchWareplaceByScanCode()	请求时间："+DateUtils.getDateTime());
		
		try {
			if(StringUtils.isBlank(scanCode)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			return new Echos(Constants.SUCCESS, wareplaceService.getByScanCode(scanCode));
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
	
	/**
	 * 保存货品货位调整信息
	 * @param 货品货位调整对象json字符串
	 * @param 变更后的货位电子码
	 * @return    返回操作结果消息
	 * @throws
	 */
	@RequestMapping(value = "/saveProductWpChange", method = RequestMethod.POST)
	public Echos saveProductWpChange(
			@RequestParam(name = "wpChangeJson", defaultValue = "", required = true)String wpChangeJson,
			@RequestParam(name = "scanCode", defaultValue = "", required = true)String scanCode,
			HttpServletRequest request) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：saveProductWpChange()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		
		try {
			if(StringUtils.isBlank(wpChangeJson) || StringUtils.isBlank(scanCode)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			Wareplace wp = wareplaceService.getByScanCode(scanCode);
			if(wp == null) {
				return new Echos(Constants.ERROR, "该电子码对应的货位不存在，请核查");
			}
			
			// 移动端传递过来的Json字符串转换为ProductWpChange对象
			wpChangeJson = Encodes.unescapeHtml(wpChangeJson);
			ProductWpChange productWpChange = (ProductWpChange)JsonMapper.fromJsonString(wpChangeJson, ProductWpChange.class);
			
			//调整货位的持有人置为空
			productWpChange.setPostHoldUser(null);
			productWpChange.setPostWareplace(wp);
			productWpChangeService.updateProductPosition(productWpChange, currentUser);
			
			return new Echos(Constants.SUCCESS, "保存货品货位调整记录成功");
		} catch (ServiceException se) {
			Echos ec = null;
			switch (se.getMessage()) {
				case "preWareplaceUseless":
					ec = new Echos(Constants.ERROR, "货品货位调整异常，货品调前货位未启用，不能调出");
					break;
				case "preWareplaceLocked":
					ec = new Echos(Constants.ERROR, "货品货位调整异常，货品调前货位已锁定，不能调出");
					break;
				case "postWareplaceUseless":
					ec = new Echos(Constants.ERROR, "货品货位调整异常，货品调后货位未启用，不能调入");
					break;
				case "postWareplaceLocked":
					ec = new Echos(Constants.ERROR, "货品货位调整异常，货品调后货位已锁定，不能调入");
					break;
				case "postWareplaceOccupied":
					ec = new Echos(Constants.ERROR, "货品货位调整异常，货品调入货位已存放其他产品类型的货品");
					break;
				default:
					ec = new Echos(Constants.ERROR);
					break;
			}
			return ec;
			
		}
	}
	
	
	/**
	 * 保存货品破损维修登记信息
	 * @param 维修登记对象json字符串
	 * @return    返回货位对象
	 * @throws
	 */
	@RequestMapping(value = "/saveRepairRegister", method = RequestMethod.POST)
	public Echos saveRepairRegister(
			@RequestParam(name = "repairRegJson", defaultValue = "", required = true)String repairRegJson,
			@RequestParam(name = "files", defaultValue = "", required = false)MultipartFile[] files,
			HttpServletRequest request) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：saveRepairRegister()	请求时间："+DateUtils.getDateTime());
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
			
			return new Echos(Constants.SUCCESS, "保存货品维修登记记录成功");
		} catch (ServiceException se) {
			return new Echos(Constants.ERROR);
		}
		
	}
	
	
	/**
	 * 保存货品入库记录
	 * @param productWpIoJson
	 * @param productIds 货品ID集合，A，B，C字符串传递
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/saveProductWpIo", method = RequestMethod.POST)
	public Echos saveProductWpIo(
			@RequestParam(name = "productWpIoJson", defaultValue = "", required = true)String productWpIoJson,
			@RequestParam(name = "productIds", defaultValue = "", required = true)String productIds,
			HttpServletRequest request) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：saveProductWpIo()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		
		try {
			if(StringUtils.isBlank(productWpIoJson) || StringUtils.isBlank(productIds)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			// 移动端传递过来的Json字符串转换为 【货品出入库变更记录】对象
			productWpIoJson = Encodes.unescapeHtml(productWpIoJson);
			ProductWpIo productWpIo = (ProductWpIo)JsonMapper.fromJsonString(productWpIoJson, ProductWpIo.class);
			productWpIo.setIoType(ProductWpIo.IOTYPE_IN);//入库
			productWpIo.setCreateBy(currentUser);
			productWpIo.setUpdateBy(currentUser);
			
			Wareplace wp = wareplaceService.getByScanCode(productWpIo.getIoWareplace().getScanCode());
			if(wp == null) 
				return new Echos(Constants.NO_RESULT,"数据库中没有找到该货位的电子码，请核查!");
			productWpIo.setIoWareplace(wp);
			
			String[] tids = productIds.split(",");
			for(String id : tids) {
				productWpIo.setProduct(wapProductService.get(id));
			}
			
			wapProductService.saveProductWpIo(productWpIo);
			
			return new Echos(Constants.SUCCESS, "保存货品入库记录成功");
		} catch(Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
		
	}
	
	
	
	/**
	 * 保存货品货签变更记录
	 * @param productCodeChangeJson   货品货签变更对象json串
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/saveProductCodeChange", method = RequestMethod.POST)
	public Echos saveProductCodeChange(
			@RequestParam(name = "productCodeChangeJson", defaultValue = "", required = true)String productCodeChangeJson,
			HttpServletRequest request) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：saveProductCodeChange()	请求时间："+DateUtils.getDateTime());
		currentUser = getUser(request);
		
		try {
			if(StringUtils.isBlank(productCodeChangeJson)) 
				return new Echos(Constants.PARAMETER_ISNULL);
			
			// 移动端传递过来的Json字符串转换为 【货品货签变更记录】对象
			productCodeChangeJson = Encodes.unescapeHtml(productCodeChangeJson);
			ProductCodeChange productCodeChange = (ProductCodeChange)JsonMapper.fromJsonString(productCodeChangeJson, ProductCodeChange.class);
			
			wapProductService.saveProductCodeChange(productCodeChange);
			
			return new Echos(Constants.SUCCESS, "保存货品货签变更记录成功");
		} catch(Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
	}
	
	
}

