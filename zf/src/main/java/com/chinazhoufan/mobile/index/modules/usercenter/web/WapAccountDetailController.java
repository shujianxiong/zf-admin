package com.chinazhoufan.mobile.index.modules.usercenter.web;
///**
// * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
// */
//package com.thinkgem.mobile.index.modules.usercenter.web;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.shiro.authz.annotation.RequiresPermissions;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.thinkgem.mobile.index.modules.common.utils.Constants;
//import com.thinkgem.mobile.index.modules.common.vo.Echos;
//import com.thinkgem.mobile.index.modules.usercenter.service.WapAccountDetailService;
//import com.chinazhoufan.admin.common.config.Global;
//import com.chinazhoufan.admin.common.mapper.JsonMapper;
//import com.chinazhoufan.admin.common.persistence.Page;
//import com.chinazhoufan.admin.common.utils.StringUtils;
//import com.chinazhoufan.admin.common.web.BaseController;
//import com.chinazhoufan.admin.modules.crm.entity.mi.AccountDetail;
//
///**
// * 会员资金账户流水详情Controller
// * @author 贾斌
// * @version 2015-11-09
// */
//@Controller
//@RequestMapping(value = "${frontPath}/accountDetail")
//public class WapAccountDetailController extends BaseController {
//
//	@Autowired
//	private WapAccountDetailService accountDetailService;
//	
//	@ModelAttribute
//	public AccountDetail get(@RequestParam(required=false) String id) {
//		AccountDetail entity = null;
//		if (StringUtils.isNotBlank(id)){
//			entity = accountDetailService.get(id);
//		}
//		if (entity == null){
//			entity = new AccountDetail();
//		}
//		return entity;
//	}
//	/**
//	 * 跳转到查询个人消费记录页面
//	 * @param accountDetail
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 * ${txtWeb}/accountDetail/toList
//	 */
//	@RequestMapping(value = {"toList"})
//	public String list(AccountDetail accountDetail, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<AccountDetail> page = accountDetailService.findPage(new Page<AccountDetail>(request, response), accountDetail); 
//		model.addAttribute("page", page);
//		return "modules/crm/mi/accountDetailList";
//	}
//	/**
//	 * ajax 查询个人的消费记录
//	 * @param accountDetail
//	 * @param request
//	 * @param response
//	 * ${txtWeb}/accountDetail/doList
//	 */
//	@RequestMapping(value= {"doList"})
//	public void doList(AccountDetail accountDetail,HttpServletRequest request, HttpServletResponse response){
//		Echos echos = null;
//		try {
//			Page<AccountDetail> page = accountDetailService.findPage(new Page<AccountDetail> (request,response), accountDetail);
//			if(page.getList().size() > 0){
//				echos = new Echos(Constants.SUCCESS,page);
//			}else{
//				echos = new Echos(Constants.NO_MESSAGE);
//			}
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//			echos = new Echos(Constants.MESSAGE);
//		}
//		renderString(response, JsonMapper.toJsonString(echos));
//	}
//	@RequestMapping(value = "form")
//	public String form(AccountDetail accountDetail, Model model) {
//		model.addAttribute("accountDetail", accountDetail);
//		return "modules/crm/mi/accountDetailForm";
//	}
//
//	@RequestMapping(value = "save")
//	public String save(AccountDetail accountDetail, Model model, RedirectAttributes redirectAttributes) {
//		if (!beanValidator(model, accountDetail)){
//			return form(accountDetail, model);
//		}
//		accountDetailService.save(accountDetail);
//		addMessage(redirectAttributes, "保存会员资金账户流水详情成功");
//		return "redirect:"+Global.getAdminPath()+"/crm/mi/accountDetail/?repage";
//	}
//	
//	@RequiresPermissions("crm:mi:accountDetail:edit")
//	@RequestMapping(value = "delete")
//	public String delete(AccountDetail accountDetail, RedirectAttributes redirectAttributes) {
//		accountDetailService.delete(accountDetail);
//		addMessage(redirectAttributes, "删除会员资金账户流水详情成功");
//		return "redirect:"+Global.getAdminPath()+"/crm/mi/accountDetail/?repage";
//	}
//
//}