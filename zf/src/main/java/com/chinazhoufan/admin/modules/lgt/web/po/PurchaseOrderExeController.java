/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.po;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.excel.ExportExcel;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinazhoufan.admin.common.config.Global;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.lgt.entity.po.PurchaseOrder;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseOrderService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;

/**
 * 采购订单执行Controller
 * @author 张金俊
 * @version 2015-10-16
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/po/purchaseOrderExe")
public class PurchaseOrderExeController extends BaseController {

	@Autowired
	private PurchaseOrderService purchaseOrderService;
	@Autowired
	private SupplierService supplierService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public PurchaseOrder get(@RequestParam(required=false) String id) {
		PurchaseOrder entity = null;
		/*if (StringUtils.isNotBlank(id)){
			entity = purchaseOrderService.getWithPurchaseProducesAndPurchaseProducts(id);
		}*/
		if (entity == null){
			entity = new PurchaseOrder();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:po:purchaseOrderExe:view")
	@RequestMapping(value = "info")
	public String info(PurchaseOrder purchaseOrder, Model model) {
		purchaseOrder = purchaseOrderService.getWithPurchaseProducesAndPurchaseProducts(purchaseOrder.getId());
		model.addAttribute("purchaseOrder", purchaseOrder);
		return "modules/lgt/po/purchaseOrderExeInfo";
	}
	
	@RequiresPermissions("lgt:po:purchaseOrderExe:view")
	@RequestMapping(value = {"list", ""})
	public String list(PurchaseOrder purchaseOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		//判断是否有采购审批权限，如果有，就显示全部采购单，否，就显示当初登录人的采购单
		User user = UserUtils.getUser();
		List<Role> roleList = user.getRoleList();
//		boolean hasApprove = false;
		boolean hasEdit = false;
		if(roleList != null && roleList.size() > 0) {
			for(Role role : roleList) {
//				boolean flag = systemService.isApprovePermission(role.getId(), "lgt:po:purchaseOrderExe:approve");
//				if(flag) 
//					hasApprove = true;
				boolean editFlag = systemService.isApprovePermission(role.getId(), "lgt:po:purchaseOrderExe:edit");
				boolean insertFlag = systemService.isApprovePermission(role.getId(), "lgt:po:purchaseOrderExe:insert");

				if(editFlag)
					hasEdit = true;
				if(insertFlag)
					hasEdit = false;
			}
		}
		if(hasEdit) {//有编辑权限，就查询采购人自己的采购单信息，否则显示全部
			purchaseOrder.setPurchaseUser(UserUtils.getUser());
		} 
		Page<PurchaseOrder> page = purchaseOrderService.findPage(new Page<PurchaseOrder>(request, response), purchaseOrder); 
		model.addAttribute("page", page);
		
		List<Supplier> supplierList = supplierService.findList(new Supplier());
		model.addAttribute("supplierList", supplierList);
		return "modules/lgt/po/purchaseOrderExeList";
	}
	
	
	@RequiresPermissions("lgt:po:purchaseOrderExe:view")
	@RequestMapping(value = {"select", ""})
	public String select(PurchaseOrder purchaseOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		purchaseOrder.setPurchaseUser(UserUtils.getUser());
		Page<PurchaseOrder> page = purchaseOrderService.findPage(new Page<PurchaseOrder>(request, response), purchaseOrder); 
		model.addAttribute("page", page);
		return "modules/lgt/po/purchaseOrderSelect";
	}
	
	/**
	 * 审批采购单
	 * @param purchaseMission
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("lgt:po:purchaseOrderExe:view")
	@RequestMapping(value = "checkExeForm")
	public String checkExeForm(PurchaseOrder purchaseOrder, Model model) {
		purchaseOrder = purchaseOrderService.getWithPurchaseProducesAndPurchaseProducts(purchaseOrder.getId());
		model.addAttribute("purchaseOrder", purchaseOrder);
		return "modules/lgt/po/purchaseOrderExeCheckForm";
	}
	
	/**
	 * 保存审批结果
	 * @param purchaseMission
	 * @param redirectAttributes
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("lgt:po:purchaseOrderExe:approve")
	@RequestMapping(value = "saveExeCheckResult")
	public String saveExeCheckResult(PurchaseOrder purchaseOrder, RedirectAttributes redirectAttributes) {
		purchaseOrderService.saveCheckResult(purchaseOrder);
		addMessage(redirectAttributes, "保存采购任务审批结果成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
	}
	
	
	/**接单*/
	@RequiresPermissions("lgt:po:purchaseOrderExe:view")
	@RequestMapping(value = {"receiveOrder", ""})
	public String receiveOrder(PurchaseOrder purchaseOrder, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes, Model model) {
		PurchaseOrder po = purchaseOrderService.get(purchaseOrder);
		if(!PurchaseOrder.ORDERSTATUS_SUBMITED.equals(po.getOrderStatus())){
			addMessage(redirectAttributes, "当前订单不是已提交状态，不能执行接单操作!");
		}else{
			// 更新采购单状态
			po.setOrderStatus(PurchaseOrder.ORDERSTATUS_PURCHASING);
			po.setReceiveTime(new Date());
			purchaseOrderService.save(po);
			addMessage(redirectAttributes, "接单成功!");
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
	}

	
	/**
	 * 录入货品界面
	 * @param purchaseOrder
	 * @param model
	 * @return    设定文件
	 * @throws
	 */
	@RequiresPermissions("lgt:po:purchaseOrderExe:insert")
	@RequestMapping(value = "form")
	public String form(PurchaseOrder purchaseOrder, Model model) {
		purchaseOrder = purchaseOrderService.getWithPurchaseProducesAndPurchaseProducts(purchaseOrder.getId());
		model.addAttribute("purchaseOrder", purchaseOrder);
		return "modules/lgt/po/purchaseOrderExeForm";
	}
	
	// 录入货品保存
	@RequiresPermissions("lgt:po:purchaseOrderExe:edit")
	@RequestMapping(value = "save")
	public String save(PurchaseOrder purchaseOrder, Model model, RedirectAttributes redirectAttributes) {
		PurchaseOrder po = purchaseOrderService.get(purchaseOrder);
		if(!PurchaseOrder.ORDERSTATUS_PURCHASING.equals(po.getOrderStatus())){
			addMessage(redirectAttributes, "当前订单不是采购中状态，不能执行编辑操作！");
		}else {
			try {
				purchaseOrderService.saveForm(purchaseOrder);
				addMessage(redirectAttributes, "保存采购单信息成功");
			} catch(ServiceException se) {
				addMessage(redirectAttributes, se.getMessage());
			} catch (Exception e) {
				e.printStackTrace();
				addMessage(redirectAttributes, e.getMessage());
			}
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/form?id="+purchaseOrder.getId();
	}
	
	// 完成订单
	@RequiresPermissions("lgt:po:purchaseOrderExe:edit")
	@RequestMapping(value = "finish")
	public String finish(PurchaseOrder purchaseOrder, RedirectAttributes redirectAttributes) {
		purchaseOrder = purchaseOrderService.getWithPurchaseProducesAndPurchaseProducts(purchaseOrder.getId());
		if(!PurchaseOrder.ORDERSTATUS_PURCHASING.equals(purchaseOrder.getOrderStatus())){
			addMessage(redirectAttributes, "当前订单不是采购中状态，不能执行确认订单操作！");
		}else {
			try {
				purchaseOrderService.finish(purchaseOrder);
				addMessage(redirectAttributes, "采购单确认成功");
			} catch (Exception e) {
				e.printStackTrace();
				addMessage(redirectAttributes, e.getMessage());
			}
		}
		return "redirect:"+Global.getAdminPath()+"/lgt/po/purchaseOrderExe/list/?repage";
	}

	// 供应商供货管理
	@RequiresPermissions("lgt:po:purchaseOrderExe:view")
	@RequestMapping(value = "supplierSupplyOrderList")
	public String listPurchaseOrderForSupplier(PurchaseOrder purchaseOrder, String sysUserId, Model model, HttpServletRequest request, HttpServletResponse response) {
		Page<PurchaseOrder> page = purchaseOrderService.listPurchaseOrderForSupplier(new Page<PurchaseOrder>(request,response), purchaseOrder, sysUserId);
		model.addAttribute("page", page);
		return "modules/lgt/po/supplierSupplyOrderList";
		
	}
	
	@RequiresPermissions("lgt:po:purchaseOrderExe")
    @RequestMapping(value = "export", method=RequestMethod.POST)
	public String export(Member member, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		return null;
		/*try {
            String fileName = "会员注册数据统计"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            List<Member> list = purchaseOrderService.statNewRegisterByTime(member);
    		new ExportExcel("会员注册数据统计", Member.class).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出会员注册统计数据失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/dac/mi/memberDac/statNewRegister?repage";*/
	}
}