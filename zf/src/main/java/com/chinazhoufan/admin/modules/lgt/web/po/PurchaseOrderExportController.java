/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.po;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
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
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduce;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseProduct;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseMissionService;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseOrderService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 采购订单导出Controller
 * @author 张金俊
 * @version 2015-10-16
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/po/purchaseOrderExport")
public class PurchaseOrderExportController extends BaseController {

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
	public void export(PurchaseOrder purchaseOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
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
		
		List<PurchaseOrder> list = purchaseOrderService.export(purchaseOrder);
	    if(list == null || list.size() == 0) {
	    	addMessage(model, "无结果集");
	    	//return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
	    	return;
	    }
		
	    String title = "采购单据导出";
	    
	    //HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本
	    
	    HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
        HSSFSheet sheet = workbook.createSheet(title);                     // 创建工作表
        
        sheet.setColumnWidth(0, 30*256);
        sheet.setColumnWidth(1, 30*256);
        sheet.setColumnWidth(2, 20*256);
        sheet.setColumnWidth(3, 20*256);
        sheet.setColumnWidth(4, 20*256);
        sheet.setColumnWidth(5, 20*256);
        sheet.setColumnWidth(6, 20*256);
        sheet.setColumnWidth(7, 20*256);
        
        
        for(PurchaseOrder po : list) {
        	// 产生表格标题行
        	HSSFRow rowm = sheet.createRow(0);
        	HSSFCell cellTiltle = rowm.createCell(0);
        	
        	//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
        	HSSFCellStyle columnTopStyle = this.getColumnTopStyle(workbook);//获取列头样式对象
        	HSSFCellStyle style = this.getStyle(workbook);                    //单元格样式对象
        	
        	sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 7));  
        	cellTiltle.setCellStyle(columnTopStyle);
        	cellTiltle.setCellValue(title);
        	
        	// 定义所需列数
        	HSSFRow firstRowName = sheet.createRow(2);                // 在索引2的位置创建行
        	String[] firstTitleArr = new String[]{"采购单编号","供应商"};
        	
        	// 将列头设置到sheet的单元格中
        	for(int n=0;n<2;n++){
        		HSSFCell  cellRowName = firstRowName.createCell(n);                //创建列头对应个数的单元格
        		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
        		HSSFRichTextString text = new HSSFRichTextString(firstTitleArr[n]);
        		cellRowName.setCellValue(text);                                    //设置列头单元格的值
        		cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
        	}
        	
        		
    		HSSFRow row = sheet.createRow(3);//创建所需的行数
    		for(int j=0; j<2; j++){
    			HSSFCell  cell = null;   //设置单元格的数据类型
    			if(j == 0){
    				cell = row.createCell(j,HSSFCell.CELL_TYPE_STRING);
    				cell.setCellValue(po.getOrderNo());    
    			}else{
    				cell = row.createCell(j,HSSFCell.CELL_TYPE_STRING);
    				cell.setCellValue(po.getSupplier().getName());                        //设置单元格的值
    			}
    			cell.setCellStyle(style);                                    //设置单元格样式
    		}
        		
        	//第三行   下单时间     预计回货时间
    		HSSFRow secondRowName = sheet.createRow(4);                // 在索引4的位置创建行
        	String[] secondTitleArr = new String[]{"下单时间","预计回货时间"};
        	
        	// 将列头设置到sheet的单元格中
        	for(int n=0;n<2;n++){
        		HSSFCell  cellRowName = secondRowName.createCell(n);                //创建列头对应个数的单元格
        		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
        		HSSFRichTextString text = new HSSFRichTextString(secondTitleArr[n]);
        		cellRowName.setCellValue(text);                                    //设置列头单元格的值
        		cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
        	}
        	
    		HSSFRow secondRow = sheet.createRow(5);//创建所需的行数
    		for(int j=0; j<2; j++){
    			HSSFCell  cell = null;   //设置单元格的数据类型
    			if(j == 0){
    				cell = secondRow.createCell(j,HSSFCell.CELL_TYPE_STRING);
    				String createDateStr = DateUtils.formatDateTime(po.getCreateDate());
    				cell.setCellValue(createDateStr);    
    			}else{
    				cell = secondRow.createCell(j,HSSFCell.CELL_TYPE_STRING);
    				String requiredTime = DateUtils.formatDateTime(po.getRequiredTime());
    				cell.setCellValue(requiredTime);                        //设置单元格的值
    			}
    			cell.setCellStyle(style);                                    //设置单元格样式
    		}
    		
    		
    		
        	//第五行  商品原厂编码， 商品编码，商品名称，商品规格，下单数量
    		HSSFRow threeRowName = sheet.createRow(7);                // 在索引6的位置创建行
        	String[] threeTitleArr = new String[]{"商品原厂编码", "商品编码", "商品名称", "产品编码", "产品规格", "电金工艺", "电金厚度", "下单数量"};
        	
        	// 将列头设置到sheet的单元格中
        	for(int n=0;n<8;n++){
        		HSSFCell  cellRowName = threeRowName.createCell(n);                //创建列头对应个数的单元格
        		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
        		HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
        		cellRowName.setCellValue(text);                                    //设置列头单元格的值
        		cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
        	}
    		
        	
        	List<PurchaseProduce>  dataList = po.getPurchaseProduceList();
            //将查询出的数据设置到sheet对应的单元格中
            for(int i=0;i<dataList.size();i++){
                
            	PurchaseProduce obj = dataList.get(i);//遍历每个对象
                HSSFRow row2 = sheet.createRow(i+8);//创建所需的行数
                
                HSSFCell  cell = null;   //设置单元格的数据类型
                cell = row2.createCell(0,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getGoodsFactoryCode());    
                
                cell = row2.createCell(1,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getProduce().getGoods().getCode());    
                
                cell = row2.createCell(2,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getProduce().getGoods().getName());    
                
                cell = row2.createCell(3,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getProduce().getCode()); 
                
                cell = row2.createCell(4,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(obj.getProduce().getName());    
                
                cell = row2.createCell(5,HSSFCell.CELL_TYPE_STRING);
                cell.setCellValue(DictUtils.getDictLabel(obj.getElectrolyticGoldCrafts(), "lgt_si_supplier_produce_egCrafts", ""));
                
                cell = row2.createCell(6,HSSFCell.CELL_TYPE_NUMERIC);
                BigDecimal nes = obj.getElectrolyticGoldThickness();
                cell.setCellValue(nes == null ? 0.0 : nes.doubleValue());
                
                cell = row2.createCell(7,HSSFCell.CELL_TYPE_NUMERIC);
                cell.setCellValue(obj.getRequiredNum());    
                    
            }
        }
        
        if(workbook !=null){
        	try {  
                try {  
                	 String now = DateUtils.getDateTimeSimple();
                	 String fileName = list.get(0).getOrderNo()+"_"+now+".xls";
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
	
	  @RequiresPermissions("lgt:po:purchaseOrderExport:view")
		@RequestMapping(value = "exportProduct")
		public void exportProduct(PurchaseOrder purchaseOrder, HttpServletRequest request, HttpServletResponse response, Model model) {

		/*  User user = UserUtils.getUser();
			List<Role> roleList = user.getRoleList();
			boolean hasEdit = false;
			if(roleList != null && roleList.size() > 0) {
				for(Role role : roleList) {
					boolean editFlag = systemService.isApprovePermission(role.getId(), "lgt:po:purchaseOrderExport:view");
					if(editFlag) 
						hasEdit = true;
				}
			}
			if(hasEdit) {//有编辑权限，就查询采购人自己的采购单信息，否则显示全部
				purchaseOrder.setPurchaseUser(UserUtils.getUser());
			} */
		   List<PurchaseOrder>	 list = purchaseOrderService.findProductList(purchaseOrder);
		    if(list == null ) {
		    	addMessage(model, "无结果集");
		    	//return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
		    	return;
		    }
			
		    String title = "采购货品导出";
		    
		    //HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本
		    
		    HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
	        HSSFSheet sheet = workbook.createSheet(title);                     // 创建工作表
	        
	        sheet.setColumnWidth(0, 30*256);
	        sheet.setColumnWidth(1, 30*256);
	        sheet.setColumnWidth(2, 20*256);
	        sheet.setColumnWidth(3, 20*256);
	        sheet.setColumnWidth(4, 20*256);
	        sheet.setColumnWidth(5, 20*256);
	        sheet.setColumnWidth(6, 20*256);
	        sheet.setColumnWidth(7, 20*256);
	        sheet.setColumnWidth(8, 20*256);
	        sheet.setColumnWidth(9, 20*256);
	        sheet.setColumnWidth(10, 20*256);
	        sheet.setColumnWidth(11, 20*400);
	        int num = 0;
	        for (int i = 0; i < list.size(); i++) {
	        	HSSFRow row2 = null;
  			    PurchaseOrder order = list.get(i);//遍历每个对象
  			    List<PurchaseProduce>  purchaseProduceList = order.getPurchaseProduceList();
	        	
	        	for(int j=0;j<purchaseProduceList.size();j++){
    		    PurchaseProduce purchaseProduce = purchaseProduceList.get(j);//遍历每个对象
    		    List<PurchaseProduct> dataList =purchaseProduce.getPurchaseProductList();

	        	// 产生表格标题行
	        	HSSFRow rowm = sheet.createRow(0);
	        	HSSFCell cellTiltle = rowm.createCell(0);
	        	
	        	//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
	        	HSSFCellStyle columnTopStyle = this.getColumnTopStyle(workbook);//获取列头样式对象
	        	HSSFCellStyle style = this.getStyle(workbook);                    //单元格样式对象
	        	
	        	sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 11));  
	        	cellTiltle.setCellStyle(columnTopStyle);
	        	cellTiltle.setCellValue(title);
	    		
	    		HSSFRow threeRowName = sheet.createRow(2);                // 在索引2的位置创建行
	    		String[] threeTitleArr = new String[]{"接单时间", "采购单编号", "产品编号", "货品编码", "供应商", "名称", "商品是否合格", "存放货位", "价格","录入时间","录入人","备注"};
	        	
	        	// 将列头设置到sheet的单元格中
	        	for(int n=0;n<12;n++){
	        		HSSFCell  cellRowName = threeRowName.createCell(n);                //创建列头对应个数的单元格
	        		cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
	        		HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
	        		cellRowName.setCellValue(text);                                    //设置列头单元格的值
	        		cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
	        	}
                for(int k=0;k<dataList.size();k++){
                  PurchaseProduct obj = dataList.get(k);
                //入库时间
	                
                    row2 = sheet.createRow(num+3);//创建所需的行数
                    num++;
	                HSSFCell  cell = null;
	                cell = row2.createCell(0, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(order.getReceiveTime()==null?null:DateUtils.formatDateTime(order.getReceiveTime()));
	                cell.setCellStyle(style);

	                //采购单编号
	                cell = row2.createCell(1, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(order.getOrderNo());
	                cell.setCellStyle(style);
	                
	                //产品编号
	                cell = row2.createCell(2, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(purchaseProduce.getProduce().getCode());
	                cell.setCellStyle(style);
	                
	                //货品编码
	                cell = row2.createCell(3, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(obj.getProduct().getCode());
	                cell.setCellStyle(style);

	                //供应商
	                cell = row2.createCell(4, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(order.getSupplier().getName());
	                cell.setCellStyle(style);

	                //名称
	                cell = row2.createCell(5, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(purchaseProduce.getProduce().getGoods().getName());
	                cell.setCellStyle(style);

	                //商品是否合格
	                cell = row2.createCell(6, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(DictUtils.getDictLabel(obj.getRegularFlag(), "yes_no", ""));
	                cell.setCellStyle(style);

	                //存放货位
	                cell = row2.createCell(7, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(obj.getWareplace().getWarecounter().getWarearea().getCode()+"-"+obj.getWareplace().getWarecounter().getCode()+"-"+obj.getWareplace().getCode());
	                cell.setCellStyle(style);

	                //价格
	                cell = row2.createCell(8, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(purchaseProduce.getProduce().getPricePurchase().toString());
	                cell.setCellStyle(style);

	                //操作时间
	                cell = row2.createCell(9, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(obj.getEnterTime()==null?null:DateUtils.formatDateTime(obj.getEnterTime()));
	                cell.setCellStyle(style);

	                //录入人
	                cell = row2.createCell(10, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(UserUtils.get(obj.getEnterPerson()).getName());
	                cell.setCellStyle(style);

	                //备注
	                cell = row2.createCell(11, HSSFCell.CELL_TYPE_STRING);
	                cell.setCellValue(obj.getRemarks());
	                cell.setCellStyle(style);
	                    
	            }
	         }
	     }
	        	  if(workbook !=null){
	        	try {  
	                try {  
	                	 String now = DateUtils.getDateTimeSimple();
	                	 String fileName = now+".xls";
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
  }
