/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.po;

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
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduce;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduct;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseMissionService;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseOrderService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 采购货品导出Controller
 * @author 舒剑雄
 * @version 2017-08-169
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/po/purchaseProductExport")
public class PurchaseProductExportController extends BaseController {

	@Autowired
	private PurchaseOrderService purchaseOrderService;
	@Autowired
	private SupplierService supplierService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private PurchaseMissionService purchaseMissionService;
	
	
	@RequiresPermissions("lgt:po:purchaseOrderExport:view")
	@RequestMapping(value = "export")
	public void export(PurchaseOrder purchaseOrder,@RequestParam(value="inBatchNos",required=false)String inBatchNos, HttpServletRequest request, HttpServletResponse response, Model model) {
		//判断是否有采购审批权限，如果有，就显示全部采购单，否，就显示当前登录人的采购单
		User user = UserUtils.getUser();
		List<Role> roleList = user.getRoleList();
		boolean hasEdit = false;
		if(roleList != null && roleList.size() > 0) {
			for(Role role : roleList) {
				boolean editFlag = systemService.isApprovePermission(role.getId(), "lgt:po:purchaseOrderExe:edit");
				if(editFlag) 
					hasEdit = true;
			}
		}
		if(hasEdit) {//有编辑权限，就查询采购人自己的采购单信息，否则显示全部
			purchaseOrder.setPurchaseUser(UserUtils.getUser());
		} 
		/*StringBuffer sbBuffer=new StringBuffer();
		if (inBatchNos != null) {
			for (int i=0;i<inBatchNos.length;i++) {
				if (i == inBatchNos.length -1) {
					sbBuffer.append(inBatchNos[i]);
				}else {
					sbBuffer.append(inBatchNos[i]+",");
				}
			}
		}*/
		PurchaseOrder order = null;
		if(inBatchNos!=null)
			order = purchaseOrderService.exportByInBatchNo(purchaseOrder ,inBatchNos.split("_"));
	    if(order == null ) {
	    	addMessage(model, "无结果集");
	    	//return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
	    	return;
	    }
		
	    //String title = "采购货品导出";
	    
	    //HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本
	    
	    HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
        HSSFSheet sheet = workbook.createSheet();                     // 创建工作表
        
        sheet.setColumnWidth(0, 30*256);
        sheet.setColumnWidth(1, 30*256);
        sheet.setColumnWidth(2, 30*600);
        sheet.setColumnWidth(3, 30*256);
        sheet.setColumnWidth(4, 30*256);
        sheet.setColumnWidth(5, 30*256);

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

    	//第一行  批次，序号， 名称，商品名称，价格，货品编码，存放货位
		HSSFRow threeRowName = sheet.createRow(0);                				// 在索引0的位置创建行
    	String[] threeTitleArr = new String[]{"批次","序号","名称", "价格", "货品编码", "存放货位"};
    	
    	// 将列头设置到sheet的单元格中
    	for(int n=0;n<6;n++){
    		HSSFCell  cellRowName = threeRowName.createCell(n);                	// 创建列头对应个数的单元格
    		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                	// 设置列头单元格的数据类型
    		HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
    		cellRowName.setCellValue(text);                                    	// 设置列头单元格的值
    		cellRowName.setCellStyle(columnTopStyle);                        	// 设置列头单元格样式
    	}

    	List<PurchaseProduce>  purchaseProduceList = order.getPurchaseProduceList();
        //将查询出的数据设置到sheet对应的单元格中
		Integer rowNum =0;
        for(int i=0;i<purchaseProduceList.size();i++){
        	PurchaseProduce purchaseProduce = purchaseProduceList.get(i);		// 遍历每个对象
			List<PurchaseProduct> dataList =purchaseProduce.getPurchaseProductList();
			String code = "";
			if(i == 0) {
				code = purchaseProduce.getProduce().getCode();
			} else {
				if (!code.equals(purchaseProduce.getProduce().getCode())) {
					rowNum+=1;
				}
			}
			code = purchaseProduce.getProduce().getCode();
			for(int j=0;j<dataList.size();j++){

				rowNum++;
				PurchaseProduct obj = dataList.get(j);
				//HSSFRow row2 = sheet.createRow(rowNum+5);	// 创建所需的行数
				HSSFRow row2 = sheet.createRow(rowNum+0);	// 创建所需的行数
				HSSFCell  cell = null;   	// 设置单元格的数据类型

			/*	cell = row2.createCell(0,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(purchaseProduce.getProduce().getCode());
				cell.setCellStyle(style);*/

				cell = row2.createCell(0,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(obj.getInBatchNo());
				cell.setCellStyle(style);

				cell = row2.createCell(1,HSSFCell.CELL_TYPE_STRING);
			    cell.setCellValue(j+1);
				cell.setCellStyle(style);

				cell = row2.createCell(2,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(purchaseProduce.getProduce().getGoods().getTitle()+" "+purchaseProduce.getProduce().getTitle());
				cell.setCellStyle(style);

				cell = row2.createCell(3,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue((purchaseProduce.getProduce().getPriceSrc()).toString());
				cell.setCellStyle(style);

				cell = row2.createCell(4,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(obj.getProduct().getCode());
				cell.setCellStyle(style);

				cell = row2.createCell(5,HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(obj.getWareplace().getWarecounter().getWarearea().getCode()+"-"+obj.getWareplace().getWarecounter().getCode()+"-"+obj.getWareplace().getCode());
				cell.setCellStyle(style);
			}   
        }

        if(workbook !=null){
        	try {  
                try {  
                	 String fileName = inBatchNos+".xls";
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