/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.web.ol;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

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
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.bus.service.ol.PickOrderService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 拣货单导出Controller
 * @author 舒剑雄
 * @version 2017-08-28
 */
@Controller
@RequestMapping(value = "${adminPath}/bus/ol/pickOrderExport")
public class PickOrderExportController extends BaseController {

	@Autowired
	private PickOrderService pickOrderService;

	@RequiresPermissions("bus:ol:pickOrderExport:view")
	@RequestMapping(value = "export")
	public void export(PickOrder pickOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Produce> dataList = pickOrderService.getMissionDetailByPickOrder(pickOrder);
	    if(dataList == null || dataList.size() == 0) {
	    	addMessage(model, "无结果集");
	    	//return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
	    	return;
	    }
		
	    String title = "拣货明细导出";
	    
	    //HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本
	    
	    HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
        HSSFSheet sheet = workbook.createSheet(title);                     // 创建工作表
        
        sheet.setColumnWidth(0, 30*256);
        sheet.setColumnWidth(1, 30*256);
        sheet.setColumnWidth(2, 20*256);
        sheet.setColumnWidth(3, 20*256);
        sheet.setColumnWidth(4, 20*256);

        	// 产生表格标题行
        	HSSFRow rowm = sheet.createRow(0);
        	HSSFCell cellTiltle = rowm.createCell(0);
        	
        	//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
        	HSSFCellStyle columnTopStyle = this.getColumnTopStyle(workbook);//获取列头样式对象
        	HSSFCellStyle style = this.getStyle(workbook);                    //单元格样式对象
        	
        	sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 4));  
        	cellTiltle.setCellStyle(columnTopStyle);
        	cellTiltle.setCellValue(title);
        	
        	// 定义所需列数
        	HSSFRow firstRowName = sheet.createRow(3);                // 在索引2的位置创建行
        	String[] firstTitleArr = new String[]{"托盘编号"};
        	
        	// 将列头设置到sheet的单元格中
        	for(int n=0;n<1;n++){
        		HSSFCell  cellRowName = firstRowName.createCell(n);                //创建列头对应个数的单元格
        		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
        		HSSFRichTextString text = new HSSFRichTextString(firstTitleArr[n]);
        		cellRowName.setCellValue(text);                                    //设置列头单元格的值
        		cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
        	}
    		HSSFRow row = sheet.createRow(4);//创建所需的行数
    		for(int j=0; j<1; j++){
    			HSSFCell  cell = null;   //设置单元格的数据类型
    			if(j == 0){
    				cell = row.createCell(j,HSSFCell.CELL_TYPE_STRING);
    				cell.setCellValue(dataList.get(0).getPlateNo());
    			}
    			cell.setCellStyle(style);                                    //设置单元格样式
    		}
        	//第三行  商品编码，货位，出库数量，所属托盘位置
    		HSSFRow threeRowName = sheet.createRow(6);                // 在索引2的位置创建行
        	String[] threeTitleArr = new String[]{"序号","商品编码", "货位", "出库数量", "所属托盘位置"};
        	
        	// 将列头设置到sheet的单元格中
        	for(int n=0;n<5;n++){
        		HSSFCell  cellRowName = threeRowName.createCell(n);                //创建列头对应个数的单元格
        		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
        		HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
        		cellRowName.setCellValue(text);                                    //设置列头单元格的值
        		cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
        	}

            //将查询出的数据设置到sheet对应的单元格中
            for(int i=0;i<dataList.size();i++){
            	Produce obj = dataList.get(i);//遍历每个对象
                HSSFRow row2 = sheet.createRow(i+7);//创建所需的行数

                HSSFCell  cell = null;   //设置单元格的数据类型
                cell = row2.createCell(0,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(i+1);
                cell.setCellStyle(style);

                cell = row2.createCell(1,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getGoods().getCode());
                cell.setCellStyle(style);

                cell = row2.createCell(2,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getFullWareplace());
                cell.setCellStyle(style);
                
                cell = row2.createCell(3,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getNum());
                cell.setCellStyle(style);

                cell = row2.createCell(4,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getPickNo());
                cell.setCellStyle(style);
            }

        if(workbook !=null){
        	try {  
                try {  
                	 String now = DateUtils.getDateTimeSimple();
                	 String fileName = dataList.get(0).getPlateNo()+"_"+now+".xls";
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