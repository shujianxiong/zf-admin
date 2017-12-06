/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.web.si;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.si.CreditPointDetail;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.chinazhoufan.admin.modules.lgt.entity.si.SupplierBrand;
import com.chinazhoufan.admin.modules.lgt.service.po.PurchaseOrderService;
import com.chinazhoufan.admin.modules.lgt.service.si.CreditPointDetailService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierBrandService;
import com.chinazhoufan.admin.modules.lgt.service.si.SupplierService;
import com.chinazhoufan.admin.modules.sys.entity.Office;
import com.chinazhoufan.admin.modules.sys.entity.Role;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.service.SystemService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 供应商Controller
 * @author 张金俊
 * @version 2015-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/lgt/si/supplier")
public class SupplierController extends BaseController {

	@Autowired
	private SupplierService supplierService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private PurchaseOrderService purchaseOrderService;
	@Autowired
	private SupplierBrandService supplierBrandService; 
	@Autowired
	private CreditPointDetailService creditPointDetailService;
	
	@ModelAttribute
	public Supplier get(@RequestParam(required=false) String id) {
		Supplier entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = supplierService.get(id);
		}
		if (entity == null){
			entity = new Supplier();
		}
		return entity;
	}
	
	@RequiresPermissions("lgt:si:supplier:view")
	@RequestMapping(value = {"list", ""})
	public String list(Supplier supplier, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Supplier> page = supplierService.findPage(new Page<Supplier>(request, response), supplier); 
		model.addAttribute("page", page);
		return "modules/lgt/si/supplierList";
	}

	@RequiresPermissions("lgt:si:supplier:view")
	@RequestMapping(value = "form")
	public String form(Supplier supplier, Model model) {
		if(StringUtils.isBlank(supplier.getId())) {
			supplier.setActiveFlag(Supplier.ACTIVEFLAGOK);//是否启用，默认为是
			supplier.setCreditPoint(100);//供应商默认信誉积分100
		}
		model.addAttribute("supplier", supplier);
		return "modules/lgt/si/supplierForm";
	}

	@RequiresPermissions("lgt:si:supplier:view")
	@RequestMapping(value = "info")
	public String info(Supplier supplier, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(supplier == null || StringUtils.isBlank(supplier.getId())) {
			addMessage(model, "友情提示：未能获取到要查看的供应商信息！");
			return "error/400";
		}
		SupplierBrand sb = new SupplierBrand();
		sb.setSupplier(supplier);
		SupplierBrand supplierBrand = supplierBrandService.getAllBrandNameBySupplierId(sb);
		supplier.setBrandNames(supplierBrand == null?"":supplierBrand.getBrand().getName());
		model.addAttribute("supplier", supplier);
		return "modules/lgt/si/supplierInfo";
	}
	
	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "save")
	public String save(Supplier supplier, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, supplier)){
			return form(supplier, model);
		}
		boolean isNew = false;
		if(StringUtils.isBlank(supplier.getId())) {
			isNew = true;
		}
		supplierService.save(supplier);
		
		if(isNew) {
			//保存供应商信誉积分流水记录
			CreditPointDetail cpd = new CreditPointDetail();
			cpd.setSupplier(supplier);
			cpd.setChangeTime(new Date());
			cpd.setOperaterType(CreditPointDetail.OPERATER_TYPE_SYS);
			cpd.setChangeType(CreditPointDetail.CHANGE_TYPE_ADD);
			cpd.setChangeCreditPoint(supplier.getCreditPoint());
			cpd.setLastCreditPoint(supplier.getCreditPoint());
			cpd.setChangeReasonType(CreditPointDetail.SUPPLIER_DEFAULT_CREDIT_POINT);
			creditPointDetailService.save(cpd);
		}
		
		addMessage(redirectAttributes, "保存供应商成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/supplier/?repage";
	}
	
	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "delete")
	public String delete(Supplier supplier, RedirectAttributes redirectAttributes) {
		if(supplier == null || StringUtils.isBlank(supplier.getId())) {
			addMessage(redirectAttributes, "友情提示：未能获取到要删除的供应商信息！");
			return "error/400";
		}
		supplierService.delete(supplier);
		addMessage(redirectAttributes, "删除供应商成功");
		return "redirect:"+Global.getAdminPath()+"/lgt/si/supplier/?repage";
	}

	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "getSupplierByUserId")
	public Supplier getSupplierByUserId(String userId) {
		return supplierService.getSupplierByUserId(userId);
	}
	
	/**
	 * 获取供应商（已启用）JSON数据。
	 * @param extId 排除的ID
	 * @param type	类型（1：公司；2：部门/小组/其它：3：用户）
	 * @param grade 显示级别
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, @RequestParam(required=false) String type,
			@RequestParam(required=false) Long grade, @RequestParam(required=false) Boolean isAll, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Supplier> list = supplierService.findListByActiveFlag(Supplier.TRUE_FLAG, Supplier.DEL_FLAG_NORMAL);
		for (int i=0; i<list.size(); i++){
			Supplier lss = list.get(i);
			
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", lss.getId());
			map.put("pId", "");
			map.put("name", lss.getName());
			mapList.add(map);
		}
		return mapList;
	}
	
	//-------------------------------供应商账号管理接口 START-------------------------------
	
	@RequiresPermissions("lgt:si:supplier:view")
	@RequestMapping(value = "supplierAccountList")
	public String supplierAccountList(User user, HttpServletRequest request, HttpServletResponse response, Model model) {
		user.setUserCategory(User.SUPPLIER_CATAGORY);
		Page<User> page = systemService.findUserWithSupplier(new Page<User>(request, response), user);
        model.addAttribute("page", page);
		return "modules/lgt/si/supplierAccountList";
	}
	
	
	@RequiresPermissions("lgt:si:supplier:view")
	@RequestMapping(value = "supplierAccountForm")
	public String supplierAccountForm(String uid, Model model) {
		User user = systemService.getUser(uid);
		if(user == null) {
			user = new User();
		}
		if (user.getCompany()==null || user.getCompany().getId()==null){
			user.setCompany(UserUtils.getUser().getCompany());
		}
		if (user.getOffice()==null || user.getOffice().getId()==null){
			user.setOffice(UserUtils.getUser().getOffice());
		}
		//1=是，0=否
		if(StringUtils.isBlank(user.getId())) {
			user.setLoginFlag(User.LOGINFLAGOK);
			user.setLoginAppFlag(User.LOGINAPPFLAGNO);
		}
		Role role = new Role();
		role.setId("54866109003a4a46b6f04e2244f600a1");
		role.setName("供应商");
		user.setRole(role);
		
		List<Role> allRoles = new ArrayList<Role>();
		allRoles.add(role);
		
		List<String> rids = new ArrayList<String>();
		rids.add(role.getId());
		user.setRoleIdList(rids);
		
		//1=系统管理,2=部门经理,3=普通用户
		user.setUserType("3");
		
		//给用户的工号自动赋值
		user.setNo(systemService.getLatestUser().getNo());
		
		if(StringUtils.isNotBlank(uid)) {//如果用户ID不为空，即为修改，修改时，需要把该账号管理的供应商信息带出来
			Supplier su = supplierService.getSupplierByUserId(uid);
			if(su != null) 
				model.addAttribute("supplierId", su.getId());
		}
		
		model.addAttribute("user", user);
		model.addAttribute("allRoles", allRoles);
		List<Supplier> supplierList = supplierService.findActivitySupplierList(Supplier.TRUE_FLAG, Supplier.DEL_FLAG_NORMAL);
		model.addAttribute("supplierList", supplierList);
		return "modules/lgt/si/supplierAccountForm";
	}
	
	@ResponseBody
	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "checkLoginNameForSupplier")
	public String checkLoginNameForSupplier(String loginName) {
		if (StringUtils.isNotBlank(loginName) && systemService.getUniqueUserByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}
	
	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "supplierAccountSave")
	public String supplierAccountSave(User user, String userId, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/user/list?repage";
		}
		// 修正引用赋值问题，不知道为何，Company和Office引用的一个实例地址，修改了一个，另外一个跟着修改。
		user.setCompany(new Office(request.getParameter("company.id")));
		user.setOffice(new Office(request.getParameter("office.id")));
		// 如果新密码为空，则不更换密码
		if (StringUtils.isNotBlank(user.getNewPassword())) {
			user.setPassword(SystemService.entryptPassword(user.getNewPassword()));
		}
		if (!beanValidator(model, user)){
			return supplierAccountForm(user.getId(), model);
		}
		if (StringUtils.isBlank(user.getId()) && StringUtils.isBlank(userId) && !"true".equals(checkLoginNameForSupplier(user.getLoginName()))){
			addMessage(model, "保存供应商'" + user.getLoginName() + "'失败，登录名已存在");
			return supplierAccountForm(user.getId(), model);
		}
		// 保存用户信息
		if(StringUtils.isBlank(user.getId())) {
			user.setId(userId);
		}
		Role role = new Role();
		role.setId("54866109003a4a46b6f04e2244f600a1");
		role.setName("供应商");
		user.setRole(role);
		
		List<Role> allRoles = new ArrayList<Role>();
		allRoles.add(role);
		
		List<String> rids = new ArrayList<String>();
		rids.add(role.getId());
		user.setRoleIdList(rids);
		
		systemService.saveUser(user);
		
		//保存完供货商周范账号后，同步更新供货商表里面和用户的关联字段值
		if(user.getSupplier() != null) {
			Supplier supplier = supplierService.get(user.getSupplier().getId());
			supplier.setSysUser(user);
			supplierService.save(supplier);
		}
		
		// 清除当前用户缓存
		if (user.getLoginName().equals(UserUtils.getUser().getLoginName())){
			UserUtils.clearCache();
			//UserUtils.getCacheMap().clear();
		}
		addMessage(redirectAttributes, (StringUtils.isBlank(userId) ?"保存":"更新")+"供应商账号'" + user.getLoginName() + "'成功");
		return "redirect:" + Global.getAdminPath() + "/lgt/si/supplier/supplierAccountList?repage";
	}
	
	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "supplierAccountDelete")
	public String supplierAccountDelete(String uid, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/lgt/si/supplier/supplierAccountList?repage";
		}
		//删除供应商账号之前，需要先置空关联的供应商对应的关联字段
		Supplier su = supplierService.getSupplierByUserId(uid);
		if(su != null) {//如果此供应商账号未绑定供应商，不做更新处理，只有绑定了才做更新处理
			User us = new User();
			us.setId(null);
			su.setSysUser(us);
			supplierService.save(su);
		}
		
		User user = systemService.getUser(uid);
		if (UserUtils.getUser().getId().equals(user.getId())){
			addMessage(redirectAttributes, "删除供应商账户失败, 不允许删除当前供应商账户");
		}else if (User.isAdmin(user.getId())){
			addMessage(redirectAttributes, "删除供应商账户失败, 不允许删除超级管理员用户");
		}else{
			systemService.deleteUser(user);
			addMessage(redirectAttributes, "删除供应商账户成功");
		}
		return "redirect:" + Global.getAdminPath() + "/lgt/si/supplier/supplierAccountList?repage";
	}
	
	/**
	 * 用户信息显示及保存
	 * @param user
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "supplierAccountInfo")
	public String supplierAccountInfo(String uid, HttpServletRequest request, HttpServletResponse response,Model model) {
		User user = systemService.getUser(uid);
		model.addAttribute("user", user);
		return "modules/lgt/si/supplierAccountInfo";
	}
	//============================供应商账号管理 END=======================
	
	/**
	 * 供应商查询选择界面
	 * @param supplier
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "select")
	public String select(Supplier supplier, HttpServletRequest request, HttpServletResponse response, Model model) {
		// 查询已启用的供应商
		supplier.setActiveFlag(Supplier.TRUE_FLAG);
		Page<Supplier> page = supplierService.findPage(new Page<Supplier>(request, response), supplier); 
		model.addAttribute("page", page);
		return "modules/lgt/si/supplierListSelect";
	}
	
	/**
	 * 供应商更改状态接口
	 * @param uid
	 * @param loginFlag
	 * @param loginAppFlag
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "changeFlag")
	public String changeFlag(String uid, String loginFlag, String loginAppFlag, HttpServletRequest request, HttpServletResponse response, Model model) {
		User sysUser = systemService.getUser(uid);
		if(!StringUtils.isBlank(loginFlag)) {
			sysUser.setLoginFlag(loginFlag);
		} else if(!StringUtils.isBlank(loginAppFlag)) {
			sysUser.setLoginAppFlag(loginAppFlag);
		}
		systemService.changeFlag(sysUser);
		return "redirect:" + Global.getAdminPath() + "/lgt/si/supplier/supplierAccountList?repage";
	};
	
	/**
	 * 供应商更改状态接口
	 * @param supplier
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("lgt:si:supplier:edit")
	@RequestMapping(value = "changeActiveFlag")
	public String changeActiveFlag(Supplier supplier,  HttpServletRequest request, HttpServletResponse response, Model model) {
		supplierService.changeActiveFlag(supplier);
		supplier = new Supplier();
		model.addAttribute("supplier", supplier);
		return list(supplier, request, response, model);
	};
		
}