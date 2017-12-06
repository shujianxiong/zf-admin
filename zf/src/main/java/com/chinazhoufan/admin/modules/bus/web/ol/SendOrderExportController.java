/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestParam;

import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendProduct;
import com.chinazhoufan.admin.modules.bus.service.ol.SendOrderService;
import com.chinazhoufan.admin.modules.bus.service.ol.SendProductService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;

/**
 * 出库单导出Controller
 * @author 舒剑雄
 * @version 2017-08-28
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/sendOrderExport")
public class SendOrderExportController extends BaseController {

	@Autowired
	private SendOrderService sendOrderService;

	public static Map<String,String> status;

	public static Map<String,String> orderType;
	@Autowired
	private SendProductService sendProductService;
	@Autowired
	private ProductService productService;

	@RequiresPermissions("bus:ol:sendOrder:view")
	@RequestMapping(value = "export")
	public void export(@RequestParam(required=false) String createDate, HttpServletRequest request, HttpServletResponse response, Model model) {

		SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		SendOrder sendOrder = new SendOrder();
		try{
			sendOrder.setBeginCreateTime(formater.parse(createDate));
			Calendar cal = Calendar.getInstance();
			cal.setTime(formater.parse(createDate));
			cal.add(Calendar.DATE, 1);
			sendOrder.setEndCreateTime(cal.getTime());
		}catch (Exception se) {//时间格式错误
			addMessage(model, "时间格式错误");
		}
		List<SendOrder> dataList = sendOrderService.findList(sendOrder);
		if (dataList == null) {
			addMessage(model, "无结果集");
			//return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
			return;
		}
		String title = "出库单导出";

		//HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本

		HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
		HSSFSheet sheet = workbook.createSheet(title);                     // 创建工作表

		sheet.setColumnWidth(0, 30 * 256);
		sheet.setColumnWidth(1, 30 * 256);
		sheet.setColumnWidth(2, 20 * 256);
		sheet.setColumnWidth(3, 20 * 256);
		sheet.setColumnWidth(4, 20 * 256);
		sheet.setColumnWidth(5, 30 * 256);
		sheet.setColumnWidth(6, 20 * 256);
		sheet.setColumnWidth(7, 20 * 256);
		sheet.setColumnWidth(8, 20 * 256);


		// 产生表格标题行
		HSSFRow rowm = sheet.createRow(0);
		HSSFCell cellTiltle = rowm.createCell(0);

		//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
		HSSFCellStyle columnTopStyle = this.getColumnTopStyle(workbook);//获取列头样式对象
		HSSFCellStyle style = this.getStyle(workbook);                    //单元格样式对象

		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 7));
		cellTiltle.setCellStyle(columnTopStyle);
		cellTiltle.setCellValue(title);

		//第三行  发货单编号，关联订单类型，关联订单编号，生成时间，收货人，收货人电话，收货人地址，状态，激活状态
		HSSFRow threeRowName = sheet.createRow(3);                // 在索引2的位置创建行
		String[] threeTitleArr = new String[]{"发货单编号", "关联订单类型", "关联订单编号", "生成时间", "收货人", "收货人电话", "收货人地址", "状态", "激活状态"};

		// 将列头设置到sheet的单元格中
		for (int n = 0; n < 9; n++) {
			HSSFCell cellRowName = threeRowName.createCell(n);                //创建列头对应个数的单元格
			cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
			HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
			cellRowName.setCellValue(text);                                    //设置列头单元格的值
			cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
		}
		SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd");

		//将查询出的数据设置到sheet对应的单元格中
		for (int i = 0; i < dataList.size(); i++) {
			SendOrder obj = dataList.get(i);//遍历每个对象
			HSSFRow row2 = sheet.createRow(i + 4);//创建所需的行数
			HSSFCell cell = null;   //设置单元格的数据类型
			cell = row2.createCell(0, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getSendOrderNo());

			cell = row2.createCell(1, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(getOrderType(obj.getOrderType()));

			cell = row2.createCell(2, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getOrderNo());

			cell = row2.createCell(3, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(dateFormater.format(obj.getCreateDate()));

			cell = row2.createCell(4, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getReceiveName());

			cell = row2.createCell(5, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getReceiveTel());

			cell = row2.createCell(6, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getReceiveAreaStr());

			cell = row2.createCell(7, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(getStatus(obj.getStatus()));

			cell = row2.createCell(8, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getActiveFlag() == "0" ? "否" : "是");
		}

		if (workbook != null) {
			try {
				try {
					String fileName = createDate + ".xls";
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
	
	@RequiresPermissions("bus:ol:sendOrder:view")
	@RequestMapping(value = "exportOutboundDetails")
	public void exportOutboundDetails(SendOrder sendOrder, HttpServletRequest request, HttpServletResponse response, Model model) {

		List<SendOrder> dataList = sendOrderService.findOutboundDetailsList(sendOrder);
		if (dataList == null) {
			addMessage(model, "无结果集");
			//return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
			return;
		}
		String title = "快递出库明细";

		//HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本

		HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
		HSSFSheet sheet = workbook.createSheet(title);                     // 创建工作表

		sheet.setColumnWidth(0, 20 * 256);
		sheet.setColumnWidth(1, 15 * 256);
		sheet.setColumnWidth(2, 20 * 256);
		sheet.setColumnWidth(3, 20 * 256);
		sheet.setColumnWidth(4, 20 * 256);
		sheet.setColumnWidth(5, 15 * 256);
		sheet.setColumnWidth(6, 15 * 256);
		sheet.setColumnWidth(7, 15 * 256);
		sheet.setColumnWidth(8, 15 * 256);
		sheet.setColumnWidth(9, 15 * 256);
		sheet.setColumnWidth(10, 30 * 256);
		sheet.setColumnWidth(11, 15 * 256);
		sheet.setColumnWidth(12, 20 * 256);
		sheet.setColumnWidth(13, 20 * 256);

		// 产生表格标题行
		HSSFRow rowm = sheet.createRow(0);
		HSSFCell cellTiltle = rowm.createCell(0);

		//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
		HSSFCellStyle columnTopStyle = this.getColumnTopStyle(workbook);//获取列头样式对象
		HSSFCellStyle style = this.getStyle(workbook);                    //单元格样式对象

		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 12));
		cellTiltle.setCellStyle(columnTopStyle);
		cellTiltle.setCellValue(title);

		//第三行  序号，订单号，订单成交时间，订单类型，交易状态，仓库状态（X）, 商品条码, 收件人信息, 收件地址, 快递公司, 快递单号, 快递状态(X), 最新快递信息(X)
		HSSFRow threeRowName = sheet.createRow(3);               // 在索引2的位置创建行
		String[] threeTitleArr = new String[]{"序号", "快递单号", "订单号", "商品条码", "发货时间","订单成交时间", "订单类型", "交易状态", "仓库状态", "锁定状态",  "收件人信息", "收件地址", "快递公司", "快递状态","最新快递信息"};

		// 将列头设置到sheet的单元格中
		for (int n = 0; n < 15; n++) {
			HSSFCell cellRowName = threeRowName.createCell(n);                //创建列头对应个数的单元格
			cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
			HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
			cellRowName.setCellValue(text);                                    //设置列头单元格的值
			cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
		}
		SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd");

		//将查询出的数据设置到sheet对应的单元格中
		for (int i = 0; i < dataList.size(); i++) {
			SendOrder obj = dataList.get(i);//遍历每个对象
			HSSFRow row2 = sheet.createRow(i + 4);//创建所需的行数
			HSSFCell cell = null;   //设置单元格的数据类型

			cell = row2.createCell(0,HSSFCell.CELL_TYPE_STRING);
		    cell.setCellValue(i+1);
		    cell.setCellStyle(style);

			cell = row2.createCell(1, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getExpressNo());
			cell.setCellStyle(style);

			cell = row2.createCell(2, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getOrderNo());
			cell.setCellStyle(style);

			cell = row2.createCell(3, HSSFCell.CELL_TYPE_STRING);
			StringBuffer code = new StringBuffer("");
			List<SendProduct> sendProduct = sendProductService.findSendProductBySendOrder(obj.getId());
			
			for (int j = 0; j < sendProduct.size(); j++) {
				Product product =productService.get(sendProduct.get(j).getProduct().getId());
				if (product != null) {
					code.append(product.getCode()).append(",");
				} else {
					code.append("").append(",");
				}
			}

			if (code.length() != 0) {
				cell.setCellValue(code.toString().substring(0,code.length()-1));
				cell.setCellStyle(style);
			} else {
				cell.setCellValue("");
				cell.setCellStyle(style);
			}
		
			cell = row2.createCell(4, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getExpressTime()==null?null:DateUtils.formatDateTime(obj.getExpressTime()));
			cell.setCellStyle(style);

			cell = row2.createCell(5, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(dateFormater.format(obj.getCreateDate()));
			cell.setCellStyle(style);

			cell = row2.createCell(6, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(getOrderType(obj.getOrderType()));
			cell.setCellStyle(style);

			cell = row2.createCell(7, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("");
			cell.setCellStyle(style);

			cell = row2.createCell(8, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(getStatus(obj.getStatus()));
			cell.setCellStyle(style);

			cell = row2.createCell(9, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("");
			cell.setCellStyle(style);

			cell = row2.createCell(10, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getReceiveName());
			cell.setCellStyle(style);

			cell = row2.createCell(11, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getReceiveAreaStr()+obj.getReceiveAreaDetail());
			cell.setCellStyle(style);

			cell = row2.createCell(12, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(DictUtils.getDictLabel(obj.getExpressCompany(), "express_company", ""));
			cell.setCellStyle(style);

			cell = row2.createCell(13, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("");
			cell.setCellStyle(style);

			cell = row2.createCell(14, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("");
			cell.setCellStyle(style);
		}

		if (workbook != null) {
			try {
				try {
					String now = DateUtils.getDateTimeSimple();
					String fileName ="快递出库明细" +"_"+now+".xls";
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
	        //font.setFontHeightInPoints((short)10);
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

	  public String getStatus (String sta){
		  status = new HashMap<>();
		  status.put("1","待拣货");
		  status.put("2","拣货中");
		  status.put("3","打包中");
		  status.put("4","送货中");
		  status.put("5","发货完成");
		  status.put("99","发货取消");
		  return  status.get(sta);
	  }
	public String getOrderType (String type){
		orderType = new HashMap<>();
		orderType.put("1","体验");
		orderType.put("2","预约体验");
		orderType.put("3","购买");
		orderType.put("4","预约购买");
		return  orderType.get(type);
	}
}