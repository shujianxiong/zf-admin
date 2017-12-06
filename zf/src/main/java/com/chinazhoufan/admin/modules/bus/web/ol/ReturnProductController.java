/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.ExportUtil;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bus.entity.ol.ReturnProduct;
import com.chinazhoufan.admin.modules.bus.service.ol.ReturnProductService;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * 退货货品Controller
 * @author 张金俊
 * @version 2017-04-19
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/returnProduct")
public class ReturnProductController extends BaseController {

	@Autowired
	private ReturnProductService returnProductService;

	@Autowired
	private ProductService productService;
	
	@ModelAttribute
	public ReturnProduct get(@RequestParam(required=false) String id) {
		ReturnProduct entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = returnProductService.get(id);
		}
		if (entity == null){
			entity = new ReturnProduct();
		}
		return entity;
	}
	
	@RequiresPermissions("bus:ol:returnProduct:view")
	@RequestMapping(value = {"list", ""})
	public String list( ReturnProduct returnProduct , Model model) {
		//获取待入库的退货货品
		returnProduct.setInStatus(ReturnProduct.STATUS_TOWARE);
		List<ReturnProduct> returnProductList =returnProductService.findList(returnProduct);
		model.addAttribute("returnProductList", returnProductList);
		model.addAttribute("returnProduct", returnProduct);
		return "modules/bus/ol/returnProductList";
	}

	@RequiresPermissions("bus:ol:returnProduct:view")
	@RequestMapping(value = "index")
	public String index( ReturnProduct returnProduct, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ReturnProduct> page = returnProductService.findPage(new Page<ReturnProduct>(request, response), returnProduct);
		model.addAttribute("page", page);
		model.addAttribute("beginQualityTime", returnProduct.getBeginQualityTime());
		model.addAttribute("endQualityTime", returnProduct.getEndQualityTime());
		return "modules/bus/ol/returnProductIndex";
	}
	/**
	 * 回货货品损坏图片上传跳转
	 */
	@RequiresPermissions("bus:ol:returnProduct:view")
	@RequestMapping(value = "form")
	public String form(ReturnProduct returnProduct, Model model) {
		returnProduct = returnProductService.getDetail(returnProduct.getId());
		model.addAttribute("returnProduct", returnProduct);
		return "modules/bus/ol/returnProductUpLoad";
	}
	/**
	 * 回货货品损坏图片上传保存
	 */
	@RequiresPermissions("bus:ol:returnProduct:edit")
	@RequestMapping(value = "save")
	public String save(ReturnProduct returnProduct, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, returnProduct)){
			return form(returnProduct, model);
		}
		returnProductService.save(returnProduct);
		addMessage(redirectAttributes, "保存退货货品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnProduct/index?repage";
	}
	
	@RequiresPermissions("bus:ol:returnProduct:edit")
	@RequestMapping(value = "delete")
	public String delete(ReturnProduct returnProduct, RedirectAttributes redirectAttributes) {
		returnProductService.delete(returnProduct);
		addMessage(redirectAttributes, "删除退货货品成功");
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnProduct/?repage";
	}

    @RequiresPermissions("bus:ol:returnProduct:view")
    @RequestMapping(value = "info")
    public String info(ReturnProduct returnProduct, Model model) {
		returnProduct = returnProductService.getDetail(returnProduct.getId());
        model.addAttribute("returnProduct", returnProduct);
        return "modules/bus/ol/returnProductInfo";
    }
	/**
	 * 根据待入库的货品编码添加需入库的货品，待入库=》入库中
	 * @param model
	 * @return
	 */
	@RequiresPermissions("bus:ol:returnProduct:edit")
	@RequestMapping(value = "savePro")
	public String savePro(String code,Model model, RedirectAttributes redirectAttributes) {
		try {
			Product pro = productService.getByCode(code);
			if(pro != null){
				returnProductService.savePro(code);
			}else{
				addMessage(redirectAttributes, "未找到货品记录，请核查!");
			}
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnProduct/?repage";
	}
	/**
	 * 回货货品入库，入库中=》入库完成
	 * @param model
	 * @return
	 */
	@RequiresPermissions("bus:ol:returnProduct:edit")
	@RequestMapping(value = "inWarehouse")
	public String inWarehouse(ReturnProduct returnProduct, Model model, RedirectAttributes redirectAttributes) {
		try {
			returnProductService.inWarehouse(returnProduct);
			addMessage(redirectAttributes, "退货货品入库成功");
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnProduct/?repage";
	}


	/**
	 * 回货货品批量入库，入库中=》入库完成
	 * @param ids
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("bus:ol:returnProduct:edit")
	@RequestMapping(value = "batchInWarehouse")
	public String batchInWarehouse(@RequestParam("ids") String[] ids, RedirectAttributes redirectAttributes) {
		try {
			returnProductService.batchInWarehouse(ids);
			addMessage(redirectAttributes, "退货货品批量入库成功");
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/bus/ol/returnProduct/?repage";
	}

	/**
	 * 导出记录
	 * @param returnProduct
	 * @return
	 */
	@RequiresPermissions("bus:ol:returnProduct:edit")
	@RequestMapping(value = "export")
	public void batchInWarehouse(ReturnProduct returnProduct, HttpServletResponse response, Model model) {

		returnProduct.setInStatus(ReturnProduct.STATUS_WARE);
		List<ReturnProduct> returnProductList =returnProductService.findList(returnProduct);

		if (returnProductList == null) {
			addMessage(model, "无结果集");
			//return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
			return;
		}
		String title = "退货货品入库明细";

		//HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本

		HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
		HSSFSheet sheet = workbook.createSheet(title);                     // 创建工作表

		sheet.setColumnWidth(0, 20 * 256);
		sheet.setColumnWidth(1, 15 * 256);
		sheet.setColumnWidth(2, 20 * 256);
		sheet.setColumnWidth(3, 20 * 256);
		sheet.setColumnWidth(4, 20 * 256);
		sheet.setColumnWidth(5, 20 * 256);

		// 产生表格标题行
		HSSFRow rowm = sheet.createRow(0);
		HSSFCell cellTiltle = rowm.createCell(0);

		//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
		HSSFCellStyle columnTopStyle = ExportUtil.getColumnTopStyle(workbook);//获取列头样式对象
		HSSFCellStyle style = ExportUtil.getStyle(workbook);                    //单元格样式对象

		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 5));
		cellTiltle.setCellStyle(columnTopStyle);
		cellTiltle.setCellValue(title);

		//第三行  序号", "货品编码", "货品名称", "货品状态", "损坏类型", "质检时间
		HSSFRow threeRowName = sheet.createRow(2);               // 在索引2的位置创建行
		String[] threeTitleArr = new String[]{"序号", "货品编码", "货品名称", "货品状态", "损坏类型", "质检时间"};

		// 将列头设置到sheet的单元格中
		for (int n = 0; n < 6; n++) {
			HSSFCell cellRowName = threeRowName.createCell(n);                //创建列头对应个数的单元格
			cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
			HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
			cellRowName.setCellValue(text);                                    //设置列头单元格的值
			cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
		}

		//将查询出的数据设置到sheet对应的单元格中
		for (int i = 0; i < returnProductList.size(); i++) {
			ReturnProduct obj = returnProductList.get(i);//遍历每个对象
			HSSFRow row2 = sheet.createRow(i + 3);//创建所需的行数
			HSSFCell cell = null;   //设置单元格的数据类型

			cell = row2.createCell(0,HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(i+1);
			cell.setCellStyle(style);

			cell = row2.createCell(1, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getProduct().getCode());
			cell.setCellStyle(style);

			cell = row2.createCell(2, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getProduct().getGoods().getName());
			cell.setCellStyle(style);

			cell = row2.createCell(3, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(DictUtils.getDictLabel(obj.getInStatus(), "bus_ol_return_product_inStatus", ""));
			cell.setCellStyle(style);


			cell = row2.createCell(4, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(DictUtils.getDictLabel(obj.getDamageType(), "bus_or_repair_order_breakdownType", ""));
			cell.setCellStyle(style);

			cell = row2.createCell(5, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getQualityTime()==null?null:DateUtils.formatDateTime(obj.getQualityTime()));
			cell.setCellStyle(style);


		}

		if (workbook != null) {
			try {
				try {
					String now = DateUtils.getDateTimeSimple();
					String fileName ="货品出入库明细" +"_"+now+".xls";
					fileName = new String(fileName.getBytes("GBK"),"ISO-8859-1");

					response.setContentType("application/octet-stream;charset=gb2312");
					response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
					response.addHeader("Pargam", "no-cache");
					response.addHeader("Cache-Control", "no-cache");

					OutputStream os = response.getOutputStream();
					workbook.write(os);
					os.flush();
					os.close();
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}

			} catch (Exception ex) {
				ex.printStackTrace();
			}

		}




	}


}