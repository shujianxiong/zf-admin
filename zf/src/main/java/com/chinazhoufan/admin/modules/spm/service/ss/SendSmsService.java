/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ss;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.emay.SendMsgUtil;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.modules.spm.dao.ss.SendSmsDao;
import com.chinazhoufan.admin.modules.spm.entity.ss.SendSms;

@Service
@Transactional(readOnly = true)
public class SendSmsService extends CrudService<SendSmsDao, SendSms> {

	public SendSms get(String id) {
		return super.get(id);
	}
	
	public List<SendSms> findList(SendSms spmSsSendSms) {
		return super.findList(spmSsSendSms);
	}
	
	public Page<SendSms> findPage(Page<SendSms> page, SendSms sendSms) {
		return super.findPage(page, sendSms);
	}
	
	@Transactional(readOnly = false)
	public void save(SendSms sendSms) {
		if(sendSms.getClickRate() == null){
			sendSms.setClickRate(0);
		}
		if(sendSms.getId().equals("")){
			//参数设置随机
			sendSms.setParameter(UUID.randomUUID().toString());
		}
		super.save(sendSms);
	}
	
	@Transactional(readOnly = false)
	public void delete(SendSms sendSms) {
		super.delete(sendSms);
	}

	@Transactional(readOnly = false)
	public void importSendMsg(String context, String remarks, ImportExcel ei) {
		for (int i = 0; i < ei.getLastDataRowNum(); i++) {
			SendSms sendSms = new SendSms();
			Row row = ei.getRow(i);
			
			Object val_0 = ei.getCellValue(row, 0);
			if ((""+val_0).indexOf("E")!=-1 || (""+val_0).indexOf("e")!=-1 || (""+val_0).indexOf("+")!=-1) {
                BigDecimal bd = new BigDecimal(""+val_0);
                val_0 = bd.toPlainString();
            }else{
            	val_0 = "" +  val_0;
            }
			try {
				if (StringUtils.isNotBlank(val_0.toString())) {
					String phone = val_0.toString();
					sendSms.setContext(context);
					sendSms.setRemarks(remarks);
					sendSms.setPhone(phone);
					sendSms.setSendTime(new Date());
				}else{
					//过滤空白行
					continue;
				}
			} catch (ServiceException e) {
				throw new ServiceException("导入数据格式不正确，请重新导入！");
			}
			String code = SendMsgUtil.sendSales(val_0.toString(), context, "");
			if ("0".equals(code)){
		             sendSms.setStatus(code);
					 save(sendSms);
				} else {
					 sendSms.setStatus(code);
					 save(sendSms);
					 throw new ServiceException("发送短信失败");
				}
			
		}
	}
}