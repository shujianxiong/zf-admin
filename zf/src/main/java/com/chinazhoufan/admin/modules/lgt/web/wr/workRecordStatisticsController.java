package com.chinazhoufan.admin.modules.lgt.web.wr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.lgt.entity.wr.WorkRecord;
import com.chinazhoufan.admin.modules.lgt.service.wr.WorkRecordService;

@Controller
@RequestMapping(value = "${adminPath}/lgt/wr/statistics")
public class workRecordStatisticsController extends BaseController {

	@Autowired
	private WorkRecordService workRecordService;

	@RequiresPermissions("lgt:wr:statistics:view")
	@RequestMapping(value = {"list", ""})
	public String list(WorkRecord workRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WorkRecord> page = workRecordService.findPage(new Page<WorkRecord>(request, response), workRecord);
		model.addAttribute("page", page);
		return "modules/lgt/wr/workRecordStat";
	}

}
