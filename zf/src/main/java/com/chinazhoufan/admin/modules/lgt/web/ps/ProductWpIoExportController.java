/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduce;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduct;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseMissionService;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseOrderService;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * 采购货品导出Controller
 * @author 舒剑雄
 * @version 2017-08-169
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/ProductWpIoExport")
public class ProductWpIoExportController extends BaseController {

	@Autowired
	private ProductWpIoService productWpIoService;

	
	@RequiresPermissions("lgt:ps:productWpIo:view")
	@RequestMapping(value = "export")
	public void export(ProductWpIo productWpIo, HttpServletRequest request, HttpServletResponse response, Model model) {
	    //HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本
	    HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
        HSSFSheet sheet = workbook.createSheet();                     // 创建工作表
        
        sheet.setColumnWidth(0, 30*256);
        sheet.setColumnWidth(1, 30*256);
        sheet.setColumnWidth(2, 30*600);
        sheet.setColumnWidth(3, 30*256);
        sheet.setColumnWidth(4, 30*256);
        sheet.setColumnWidth(5, 30*256);
		sheet.setColumnWidth(6, 30*256);
		sheet.setColumnWidth(7, 30*256);
		sheet.setColumnWidth(8, 30*600);
		sheet.setColumnWidth(9, 30*256);
		sheet.setColumnWidth(10, 30*256);
		sheet.setColumnWidth(11, 30*256);
    	// 产生表格标题行
    	//HSSFRow rowm = sheet.createRow(0);
    	//HSSFCell cellTiltle = rowm.createCell(0);
    	
    	//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
    	HSSFCellStyle columnTopStyle = this.getColumnTopStyle(workbook);		// 获取列头样式对象
    	HSSFCellStyle style = this.getStyle(workbook);                    		// 单元格样式对象
    	
    	//sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 3));  
    	//cellTiltle.setCellStyle(columnTopStyle);
    	//cellTiltle.setCellValue(title);
    	
    	// 定义所需列数
    	/*HSSFRow firstRowName = sheet.createRow(2);                				// 在索引2的位置创建行
    	String[] firstTitleArr = new String[]{"采购单编号","供应商"};*/
    	
    	// 将列头设置到sheet的单元格中
    	/*for(int n=0;n<2;n++){
    		HSSFCell  cellRowName = firstRowName.createCell(n);                	// 创建列头对应个数的单元格
    		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                	// 设置列头单元格的数据类型
    		HSSFRichTextString text = new HSSFRichTextString(firstTitleArr[n]);
    		cellRowName.setCellValue(text);                                    	// 设置列头单元格的值
    		cellRowName.setCellStyle(columnTopStyle);                        	// 设置列头单元格样式
    	}*/
    		
/*		HSSFRow row = sheet.createRow(3);	// 创建所需的行数
		for(int j=0; j<2; j++){
			HSSFCell  cell = null;   		// 设置单元格的数据类型
			if(j == 0){
				cell = row.createCell(j,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(order.getOrderNo());
			}else{
				cell = row.createCell(j,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(order.getSupplier().getName());				// 设置单元格的值
			}
			cell.setCellStyle(style);                                    		// 设置单元格样式
		}*/

    	//第一行 "货品编码","产品全称","操作类型", "操作原因", "出入库货位", "入库类型", "入库状态", "操作人", "操作时间", "来源业务单号", "所属供应商", "备注"
		HSSFRow threeRowName = sheet.createRow(0);                				// 在索引0的位置创建行
    	String[] threeTitleArr = new String[]{"货品编码","产品全称","操作类型", "操作原因", "出入库货位", "入库类型", "入库状态", "操作人", "操作时间", "来源业务单号", "所属供应商", "备注"};
    	
    	// 将列头设置到sheet的单元格中
    	for(int n=0;n<12;n++){
    		HSSFCell  cellRowName = threeRowName.createCell(n);                	// 创建列头对应个数的单元格
    		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                	// 设置列头单元格的数据类型
    		HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
    		cellRowName.setCellValue(text);                                    	// 设置列头单元格的值
    		cellRowName.setCellStyle(columnTopStyle);                        	// 设置列头单元格样式
    	}

		List<ProductWpIo>  dataList = productWpIoService.findList(productWpIo);
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd mm:HH:ss");
        //将查询出的数据设置到sheet对应的单元格中
		Integer rowNum =0;
			for(int j=0;j<dataList.size();j++){
				rowNum++;
				ProductWpIo obj = dataList.get(j);
				HSSFRow row2 = sheet.createRow(rowNum+0);	// 创建所需的行数
				HSSFCell  cell = null;   	// 设置单元格的数据类型

				cell = row2.createCell(0,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(obj.getProduct().getCode());
				cell.setCellStyle(style);

				cell = row2.createCell(1,HSSFCell.CELL_TYPE_STRING);
			    cell.setCellValue(obj.getProduct().getProduce().getGoods().getName()+obj.getProduct().getProduce().getName());
				cell.setCellStyle(style);

				cell = row2.createCell(2,HSSFCell.CELL_TYPE_STRING);
				String ioType = DictUtils.getDictLabel(obj.getIoType(),"lgt_ps_product_wp_io_ioType",null);
				cell.setCellValue(ioType);
				cell.setCellStyle(style);

				cell = row2.createCell(3,HSSFCell.CELL_TYPE_STRING);
				String reasonType = DictUtils.getDictLabel(obj.getIoReasonType(),"lgt_ps_product_wp_io_ioReasonType",null);
				cell.setCellValue(reasonType);
				cell.setCellStyle(style);

				cell = row2.createCell(4,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(obj.getIoWareplace().getWarecounter().getWarearea().getWarehouse().getCode()+"-"+obj.getIoWareplace().getWarecounter().getWarearea().getCode()+"-"+obj.getIoWareplace().getWarecounter().getCode()+"-"+obj.getIoWareplace().getCode());
				cell.setCellStyle(style);

				cell = row2.createCell(5,HSSFCell.CELL_TYPE_STRING);
				String inType = DictUtils.getDictLabel(obj.getInType(),"lgt_ps_product_wp_io_inType",null);
				cell.setCellValue(inType);
				cell.setCellStyle(style);

				cell = row2.createCell(6,HSSFCell.CELL_TYPE_STRING);
				String inStatus = DictUtils.getDictLabel(obj.getInStatus(),"lgt_ps_product_status",null);
				cell.setCellValue(inStatus);
				cell.setCellStyle(style);

				cell = row2.createCell(7,HSSFCell.CELL_TYPE_STRING);
				String name = UserUtils.get(obj.getIoUser() ==null?"" : obj.getIoUser().getId()) == null?"":UserUtils.get(obj.getIoUser() ==null?"" : obj.getIoUser().getId()).getName();
				cell.setCellValue(name);
				cell.setCellStyle(style);

				cell = row2.createCell(8,HSSFCell.CELL_TYPE_STRING);
				if(obj.getIoTime() != null){
					String time = format.format(obj.getIoTime());
					cell.setCellValue(time);
				}else{
					cell.setCellValue("");
				}
				cell.setCellStyle(style);

				cell = row2.createCell(9,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(obj.getIoBusinessorderId());
				cell.setCellStyle(style);

				cell = row2.createCell(10,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(obj.getSupplier()==null?"":obj.getSupplier().getName());
				cell.setCellStyle(style);

				cell = row2.createCell(11,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(obj.getRemarks());
				cell.setCellStyle(style);
			}   

        if(workbook !=null){
        	try {  
                try {  
                	 String fileName = "productExport.xls";
                     fileName = new String(fileName.getBytes(),"gb2312");
                     
                     response.setContentType("application/octet-stream;charset=gb2312");  
                     response.setHeader("Content-Disposition", "attachment;filename="+ fileName);  
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
	        font.setFontHeightInPoints((short)12);
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
	
}