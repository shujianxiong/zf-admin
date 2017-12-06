/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.ps;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.ExportUtil;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.ps.GoodBadChange;
import com.chinazhoufan.admin.modules.lgt.service.ps.GoodBadChangeService;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 好坏货调动表Controller
 * @author liuxiaodong
 * @version 2017-11-02
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/ps/goodBadChange")
public class GoodBadChangeController extends BaseController {

	@Autowired
	private GoodBadChangeService goodBadChangeService;
	
	@ModelAttribute
	public GoodBadChange get(@RequestParam(required=false) String id) {
		GoodBadChange entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodBadChangeService.get(id);
		}
		if (entity == null){
			entity = new GoodBadChange();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:ps:goodBadChange:view")
	@RequestMapping(value = {"list", ""})
	public String list(GoodBadChange goodBadChange, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<GoodBadChange> page = goodBadChangeService.findPage(new Page<GoodBadChange>(request, response), goodBadChange); 
		model.addAttribute("page", page);
		return "modules/lgt/ps/goodBadChangeList";
	}

	@RequiresPermissions("lgt:ps:goodBadChange:view")
	@RequestMapping(value = "form")
	public String form(GoodBadChange goodBadChange, Model model) {
		model.addAttribute("goodBadChange", goodBadChange);
		return "modules/lgt/ps/goodBadChangeForm";
	}

	@RequiresPermissions("lgt:ps:goodBadChange:edit")
	@RequestMapping(value = "save")
	public String save(GoodBadChange goodBadChange, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goodBadChange)){
			return form(goodBadChange, model);
		}
		try {
			goodBadChangeService.save(goodBadChange);
			addMessage(redirectAttributes, "保存好坏货调动记录成功");
		}catch (Exception e){
			addMessage(model, e.getMessage());
			return form(goodBadChange, model);
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodBadChange/?repage";
	}
	
	@RequiresPermissions("lgt:ps:goodBadChange:edit")
	@RequestMapping(value = "delete")
	public String delete(GoodBadChange goodBadChange, RedirectAttributes redirectAttributes) {
		goodBadChangeService.delete(goodBadChange);
		addMessage(redirectAttributes, "删除好坏货调动记录成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodBadChange/?repage";
	}

    @RequiresPermissions("lgt:ps:goodBadChange:view")
    @RequestMapping(value = "info")
    public String info(GoodBadChange goodBadChange, Model model) {
        model.addAttribute("goodBadChange", goodBadChange);
        return "modules/lgt/ps/goodBadChangeInfo";
    }

    @RequiresPermissions("lgt:ps:goodBadChange:audit")
    @RequestMapping(value = "auditGoodBadChange")
      public String auditGoodBadChange(GoodBadChange goodBadChange, RedirectAttributes redirectAttributes, HttpServletRequest request) {
    	String checkRemarks= request.getParameter("checkRemarks");
    	try {
			checkRemarks= new String(checkRemarks.getBytes("iso-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
    	goodBadChange.setCheckRemarks(checkRemarks);
        if(GoodBadChange.STATUS_TO_CHECK.equals(goodBadChange.getStatus())) {
          addMessage(redirectAttributes, "审核失败：当前好坏货状态为待审核，请先判定审核结果!");
          return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodBadChangeList";
        }
        GoodBadChange old = goodBadChangeService.get(goodBadChange);
        if(!GoodBadChange.STATUS_TO_CHECK.equals(old.getStatus())) {
          addMessage(redirectAttributes, "审核失败：当前好坏货状态已审核完成，请勿重复审核!");
          return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodBadChangeList";
        }
        goodBadChangeService.auditGoodBadChange(goodBadChange);
        addMessage(redirectAttributes, "审核成功");
      return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodBadChange";
      }

    @RequiresPermissions("lgt:ps:goodBadChange:audit")
	@RequestMapping(value = "batchAudit")
	public String batchAudit(@RequestParam(required=false) String ids, @RequestParam(required=false) String changeStatus, RedirectAttributes redirectAttributes) {
		if(StringUtils.isBlank(ids)) {
			addMessage(redirectAttributes, "参数值未制定");
			return "error/404";
		}
		try {
			String[] idList = ids.split(",");
			for (String id : idList){
				goodBadChangeService.batchAudit(id, changeStatus);
				addMessage(redirectAttributes, "审核成功");
			}
		} catch (ServiceException se) {
			se.printStackTrace();
			addMessage(redirectAttributes, se.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/ps/goodBadChange";
	}

	/**
	 * 导出记录
	 * @param goodBadChange
	 * @return
	 */
	@RequiresPermissions("lgt:ps:goodBadChange:edit")
	@RequestMapping(value = "export")
	public void export(GoodBadChange goodBadChange, HttpServletResponse response, Model model) {

		List<GoodBadChange> goodBadChangeList =goodBadChangeService.findList(goodBadChange);

		if (goodBadChangeList == null) {
			addMessage(model, "无结果集");
			return;
		}
		String title = "好坏货调整明细";

		//HSSFWorkbook只能操作excel2003一下版本,  XSSFWorkbook只能操作excel2007以上版本

		HSSFWorkbook workbook = new HSSFWorkbook();                        // 创建工作簿对象
		HSSFSheet sheet = workbook.createSheet(title);                     // 创建工作表

		sheet.setColumnWidth(0, 20 * 256);
		sheet.setColumnWidth(1, 15 * 256);
		sheet.setColumnWidth(2, 20 * 256);
		sheet.setColumnWidth(3, 20 * 256);
		sheet.setColumnWidth(4, 20 * 256);
		sheet.setColumnWidth(5, 20 * 256);
        sheet.setColumnWidth(6, 20 * 256);
        sheet.setColumnWidth(7, 20 * 256);
        sheet.setColumnWidth(8, 20 * 256);
        sheet.setColumnWidth(9, 20 * 256);

		// 产生表格标题行
		HSSFRow rowm = sheet.createRow(0);
		HSSFCell cellTiltle = rowm.createCell(0);

		//sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】
		HSSFCellStyle columnTopStyle = ExportUtil.getColumnTopStyle(workbook);//获取列头样式对象
		HSSFCellStyle style = ExportUtil.getStyle(workbook);                    //单元格样式对象

		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 9));
		cellTiltle.setCellStyle(columnTopStyle);
		cellTiltle.setCellValue(title);

		HSSFRow threeRowName = sheet.createRow(2);               // 在索引2的位置创建行
		String[] threeTitleArr = new String[]{"序号", "货品编码","定损金额", "调前货位编号", "调后货位编号", "变动原因类型", "责任人", "创建人", "创建时间", "备注"};

		// 将列头设置到sheet的单元格中
		for (int n = 0; n < 10; n++) {
			HSSFCell cellRowName = threeRowName.createCell(n);                //创建列头对应个数的单元格
			cellRowName.setCellType(HSSFCell.CELL_TYPE_STRING);                //设置列头单元格的数据类型
			HSSFRichTextString text = new HSSFRichTextString(threeTitleArr[n]);
			cellRowName.setCellValue(text);                                    //设置列头单元格的值
			cellRowName.setCellStyle(columnTopStyle);                        //设置列头单元格样式
		}

		//将查询出的数据设置到sheet对应的单元格中
		for (int i = 0; i < goodBadChangeList.size(); i++) {
            GoodBadChange obj = goodBadChangeList.get(i);//遍历每个对象
			HSSFRow row2 = sheet.createRow(i + 3);//创建所需的行数
			HSSFCell cell = null;   //设置单元格的数据类型

			cell = row2.createCell(0,HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(i+1);
			cell.setCellStyle(style);

			cell = row2.createCell(1, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getProduct().getCode());
			cell.setCellStyle(style);

            cell = row2.createCell(2, HSSFCell.CELL_TYPE_STRING);
            cell.setCellValue(obj.getAssessmentAmount().toString());
            cell.setCellStyle(style);

			cell = row2.createCell(3, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getPreWareplace().getWarecounter().getWarearea().getWarehouse().getCode()
                                + "-"
                                + obj.getPreWareplace().getWarecounter().getWarearea().getCode()
                                + "-"
                                + obj.getPreWareplace().getWarecounter().getCode()
                                + "-"
                                + obj.getPreWareplace().getCode());
			cell.setCellStyle(style);

			cell = row2.createCell(4, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(obj.getPostWareplace().getWarecounter().getWarearea().getWarehouse().getCode()
                                + "-"
                                + obj.getPostWareplace().getWarecounter().getWarearea().getCode()
                                + "-"
                                + obj.getPostWareplace().getWarecounter().getCode()
                                + "-"
                                + obj.getPostWareplace().getCode());
			cell.setCellStyle(style);


			cell = row2.createCell(5, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(DictUtils.getDictLabel(obj.getReasonType(), "lgt_ps_good_bad_change_reasonType", ""));
			cell.setCellStyle(style);

			cell = row2.createCell(6, HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(UserUtils.get(obj.getPersonLiable().getId()).getName());
			cell.setCellStyle(style);

            cell = row2.createCell(7, HSSFCell.CELL_TYPE_STRING);
            cell.setCellValue(UserUtils.get(obj.getCreateBy().getId()).getName());
            cell.setCellStyle(style);

            cell = row2.createCell(8, HSSFCell.CELL_TYPE_STRING);
            cell.setCellValue(DateUtils.formatDateTime(obj.getCreateDate()));
            cell.setCellStyle(style);

            cell = row2.createCell(9, HSSFCell.CELL_TYPE_STRING);
            cell.setCellValue(obj.getRemarks());
            cell.setCellStyle(style);


		}

		if (workbook != null) {
			try {
				try {
					String now = DateUtils.getDateTimeSimple();
					String fileName ="好坏货调整明细" +"_"+now+".xls";
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