/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bus.service.ol.SendProductService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/ProductExport")
public class ProductExportController extends BaseController {

	@Autowired
	private ProductService productService;

	public static Map<String,String> status;

	public static Map<String,String> orderType;
	@Autowired
	private SendProductService sendProductService;
	@Autowired
	private SystemService systemService;

	@RequiresPermissions("lgt:ps:product:view")
	@RequestMapping(value = "export")
	public void export(Product product, HttpServletRequest request, HttpServletResponse response, Model model) {

		List<Product> dataList = productService.findList(product);
		if (dataList == null) {
			addMessage(model, "无结果集");
			//return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
			return;
		}
		//String title = "货品列表导出";

		//HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本

		HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
		HSSFSheet sheet = workbook.createSheet();                     // 创建工作表

		sheet.setColumnWidth(0, 30 * 256);
		sheet.setColumnWidth(1, 30 * 256);
		sheet.setColumnWidth(2, 20 * 256);
		sheet.setColumnWidth(3, 20 * 256);
		sheet.setColumnWidth(4, 20 * 256);
		sheet.setColumnWidth(5, 30 * 256);
		sheet.setColumnWidth(6, 20 * 256);
		sheet.setColumnWidth(7, 20 * 256);
		sheet.setColumnWidth(8, 20 * 256);
		sheet.setColumnWidth(9, 20 * 270);


		// 产生表格标题行
		//HSSFRow rowm = sheet.createRow(0);
		//HSSFCell cellTiltle = rowm.createCell(0);

		//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
		HSSFCellStyle columnTopStyle = this.getColumnTopStyle(workbook);//获取列头样式对象
		HSSFCellStyle style = this.getStyle(workbook);                    //单元格样式对象

		//sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 9));
		//cellTiltle.setCellStyle(columnTopStyle);
		//cellTiltle.setCellValue(title);

		//第三行  发货单编号，关联订单类型，关联订单编号，生成时间，收货人，收货人电话，收货人地址，状态，激活状态
		HSSFRow threeRowName = sheet.createRow(0);                // 在索引2的位置创建行
		String[] threeTitleArr = new String[]{"货品编码", "产品编码", "产品全称", "产品状态", "货品状态", "存放货位", "持有人", "货品克重", "更新时间","备注","所属供应商"};

		// 将列头设置到sheet的单元格中
		for (int n = 0; n < 11; n++) {
			HSSFCell cellRowName = threeRowName.createCell(n);                //创建列头对应个数的单元格
			cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
			HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
			cellRowName.setCellValue(text);                                    //设置列头单元格的值
			cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
		}

		//将查询出的数据设置到sheet对应的单元格中
		for (int i = 0; i < dataList.size(); i++) {
			Product obj = dataList.get(i);//遍历每个对象
			HSSFRow row2 = sheet.createRow(i + 1);//创建所需的行数
			HSSFCell cell = null;   //设置单元格的数据类型
			//货品编码
			cell = row2.createCell(0, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getCode());
			cell.setCellStyle(style);

			//产品编码
			cell = row2.createCell(1, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getProduce().getCode());
			cell.setCellStyle(style);

			//产品全称
			cell = row2.createCell(2, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getGoods().getName());
			cell.setCellStyle(style);

			//产品状态
			cell = row2.createCell(3, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(getStatus(obj.getProduce().getStatus()));
			cell.setCellStyle(style);

			//货品状态
			cell = row2.createCell(4, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(getOrderType(obj.getStatus()));
			cell.setCellStyle(style);

			//存放货位
			cell = row2.createCell(5, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getWareplace().getWarecounter().getWarearea().getCode()+"-"+obj.getWareplace().getWarecounter().getCode()+"-"+obj.getWareplace().getCode());
			cell.setCellStyle(style);

			//持有人
			cell = row2.createCell(6, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getHoldUser()== null?"":obj.getHoldUser().getName());
			cell.setCellStyle(style);

			//货品克重
			cell = row2.createCell(7, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getWeight()== null ?"":obj.getWeight().toString());
			cell.setCellStyle(style);

			//更新时间
			cell = row2.createCell(8, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(DateUtils.formatDateTime(obj.getUpdateDate()));
			cell.setCellStyle(style);
			
			//备注
			cell = row2.createCell(9, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getRemarks());
			cell.setCellStyle(style);

			//所属供应商
			cell = row2.createCell(10, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getSupplier()== null?"":obj.getSupplier().getName());
			cell.setCellStyle(style);

		}

		if (workbook != null) {
			try {
				try {
					String now = DateUtils.getDateTimeSimple();
					String fileName = now + ".xls";
					fileName = new String(fileName.getBytes(), "gb2312");

					response.setContentType("application/octet-stream;charset=gb2312");
					response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
					response.addHeader("Pargam", "no-cache");
					response.addHeader("Cache-Control", "no-cache");

					OutputStream os = response.getOutputStream();
					workbook.write(os);
					os.flush();
					os.close();
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			} catch (Exception ex) {
				ex.printStackTrace();
			}

		}

	}

	/* 
	 * 列头单元格样式
	 */    
	  public HSSFCellStyle getColumnTopStyle(HSSFWorkbook workbook) {
	      
	        // 设置字体
	      HSSFFont font = workbook.createFont();
	      //设置字体大小
	      font.setFontHeightInPoints((short)11);
	      //字体加粗
	      font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	      //设置字体名字 
	      font.setFontName("Courier New");
	      //设置样式; 
	      HSSFCellStyle style = workbook.createCellStyle();
	      //设置底边框; 
	      style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	      //设置底边框颜色;  
	      style.setBottomBorderColor(HSSFColor.BLACK.index);
	      //设置左边框;   
	      style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	      //设置左边框颜色; 
	      style.setLeftBorderColor(HSSFColor.BLACK.index);
	      //设置右边框; 
	      style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	      //设置右边框颜色; 
	      style.setRightBorderColor(HSSFColor.BLACK.index);
	      //设置顶边框; 
	      style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	      //设置顶边框颜色;  
	      style.setTopBorderColor(HSSFColor.BLACK.index);
	      //在样式用应用设置的字体;  
	      style.setFont(font);
	      //设置自动换行; 
	      style.setWrapText(false);
	      //设置水平对齐的样式为居中对齐;  
	      style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	      //设置垂直对齐的样式为居中对齐; 
	      style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	      
	      return style;
	      
	  }
	  
	  /*  
	 * 列数据信息单元格样式
	 */  
	  public HSSFCellStyle getStyle(HSSFWorkbook workbook) {
	        // 设置字体
	        HSSFFont font = workbook.createFont();
	        //设置字体大小
	        font.setFontHeightInPoints((short)10);
	        //字体加粗
	        //font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	        //设置字体名字 
	        font.setFontName("Courier New");
	        //设置样式; 
	        HSSFCellStyle style = workbook.createCellStyle();
	        //设置底边框; 
	        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	        //设置底边框颜色;  
	        style.setBottomBorderColor(HSSFColor.BLACK.index);
	        //设置左边框;   
	        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	        //设置左边框颜色; 
	        style.setLeftBorderColor(HSSFColor.BLACK.index);
	        //设置右边框; 
	        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
	        //设置右边框颜色; 
	        style.setRightBorderColor(HSSFColor.BLACK.index);
	        //设置顶边框; 
	        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	        //设置顶边框颜色;  
	        style.setTopBorderColor(HSSFColor.BLACK.index);
	        //在样式用应用设置的字体;  
	        style.setFont(font);
	        //设置自动换行; 
	        style.setWrapText(false);
	        //设置水平对齐的样式为居中对齐;  
	        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	        //设置垂直对齐的样式为居中对齐; 
	        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	       
	        return style;
	  
	  }
	  //产品状态
	  public String getStatus (String sta){
		  status = new HashMap<>();
		  status.put("1","新建");
		  status.put("2","上架");
		  status.put("3","下架");
		  status.put("4","冻结");
		  return  status.get(sta);
	  }
	  //货品状态
	public String getOrderType (String type){
		orderType = new HashMap<>();
		orderType.put("1","正常");
		orderType.put("2","锁定");
		orderType.put("3","体验中");
		orderType.put("4","已售出");
		orderType.put("5","已移除");
		return  orderType.get(type);
	}
}