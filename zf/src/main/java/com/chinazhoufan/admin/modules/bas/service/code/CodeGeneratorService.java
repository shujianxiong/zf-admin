/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service.code;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bas.dao.code.CodeGeneratorDao;
import com.chinazhoufan.admin.modules.bas.entity.code.CodeGenerator;

/**
 * 业务编码生成器Service
 * @author 贾斌
 * @version 2015-11-23
 */
@Service
@Transactional(readOnly = true)
public class CodeGeneratorService extends CrudService<CodeGeneratorDao, CodeGenerator>{

	@Autowired
	public CodeGeneratorDao codeGeneratorDao;
	public CodeGenerator get(String id) {
		return super.get(id);
	}
	
	public List<CodeGenerator> findList(CodeGenerator codeGenerator) {
		return super.findList(codeGenerator);
	}
	
	public Page<CodeGenerator> findPage(Page<CodeGenerator> page, CodeGenerator codeGenerator) {
		return super.findPage(page, codeGenerator);
	}
	
	
	
	@Transactional(readOnly = false)
	public void save(CodeGenerator codeGenerator) {
		//初始化日期值
		String format = "";
		if (CodeGenerator.DATE_TYPE_YYYY.equals(codeGenerator.getDateType())) {
			format = "yyyy";
		} else if (CodeGenerator.DATE_TYPE_YYYYMM.equals(codeGenerator.getDateType())) {
			format = "yyyyMM";
		} else if (CodeGenerator.DATE_TYPE_YYYYMMDD.equals(codeGenerator.getDateType())) {
			format = "yyyyMMdd";
		} else if (CodeGenerator.DATE_TYPE_YYMMDD.equals(codeGenerator.getDateType())) {
			format = "yyMMdd";
		}	
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		String currentDate = formatter.format(new Date());
		if (!CodeGenerator.DATE_TYPE_NO.equals(codeGenerator.getDateType())) {
			codeGenerator.setDateValue(currentDate);
		}
		//初始化主值
		if(!CodeGenerator.MAIN_VALUE_TYPE_RANDOM.equals(codeGenerator.getMainValueType())&&codeGenerator.getMainValue() == null){
			//自增或随机自增初始主值为0、随机初始主值为空
			codeGenerator.setMainValue(new Long(0));
		}
		super.save(codeGenerator);
	}
	
	@Transactional(readOnly = false)
	public void delete(CodeGenerator codeGenerator) {
		super.delete(codeGenerator);
	}
	
	/**
	 * 根据业务编码生成编号
	 * PS：使用该方法生成的业务编码的字段，应添加唯一性约束（因为系统时间不正确等原因可能导致生成的编码重复）
	 * @param codeHandle 业务编码代码
	 * @return code 业务编码
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public String generateCode(String codeHandle) throws ServiceException{
		//通过codeHandle查询业务编码生成器，同时锁定业务编码生成器表
		List<CodeGenerator> codeGeneratorList = codeGeneratorDao.findForUpdate(codeHandle);
		if(codeGeneratorList == null || codeGeneratorList.size() == 0){
			throw new ServiceException("警告：暂无生成器代码为【"+codeHandle+"】的业务编码生成器，请创建后再使用！");
		}
		CodeGenerator codeGenerator = codeGeneratorList.get(0);
		String prefix 		= codeGenerator.getPrefix()==null ? "" : codeGenerator.getPrefix();					// 前缀
		String dateType 	= codeGenerator.getDateType()==null ? "" : codeGenerator.getDateType();				// 日期类型
		String dateValue 	= codeGenerator.getDateValue()==null ? "" : codeGenerator.getDateValue();			// 日期值
		String midfix 		= codeGenerator.getMidfix()==null ? "" : codeGenerator.getMidfix();					// 中缀
		String mainValueType= codeGenerator.getMainValueType()==null ? "" : codeGenerator.getMainValueType();	// 主值随机类型
		int mainValueLength = codeGenerator.getMainValueLength()==null ? 0 : codeGenerator.getMainValueLength();// 主值长度
		long mainValue 		= codeGenerator.getMainValue()==null ? 0 : codeGenerator.getMainValue();			// 主值
		String postfix 		= codeGenerator.getPostfix()==null ? "" : codeGenerator.getPostfix();				// 后缀
		
		//获取当前日期
		String dateFormat = "yyyyMMdd";
		if (dateType.equals(CodeGenerator.DATE_TYPE_YYYY)) {
			dateFormat = "yyyy";
		} else if (dateType.equals(CodeGenerator.DATE_TYPE_YYYYMM)) {
			dateFormat = "yyyyMM";
		} else if (dateType.equals(CodeGenerator.DATE_TYPE_YYYYMMDD)) {
			dateFormat = "yyyyMMdd";
		} else if (dateType.equals(CodeGenerator.DATE_TYPE_YYMMDD)) {
			dateFormat = "yyMMdd";
		}
		SimpleDateFormat formatter = new SimpleDateFormat(dateFormat);
		String dateCurrent = formatter.format(new Date());	//系统当前时间
		
		//主值随机
		if(mainValueType.equals(CodeGenerator.MAIN_VALUE_TYPE_RANDOM)){
			if(CodeGenerator.DATE_TYPE_NO.equals(dateType)){
				dateValue = "";
			}else {
				dateValue = dateCurrent;
			}
			mainValue = new Double((Math.random()*new Long(StringUtils.leftPad("", mainValueLength, '9')))).longValue()+1;	//指定长度的随机数，首位不足则用9填充
		}else {
			//主值自增（自增量为1）
			long increaseValue = 1;
			if(mainValueType.equals(CodeGenerator.MAIN_VALUE_TYPE_ADDRANDOM)){
				//主值随机自增（自增量为1-9的随机数）
				increaseValue = new Double((Math.random()*9)).longValue()+1;
			}
			mainValue += increaseValue;
			//生成器带日期值且日期值不为最新的话，更新日期值，同时主值重置为1（带日期的业务编码，主值每天从1开始自增）
			if(CodeGenerator.DATE_TYPE_NO.equals(dateType)){
				dateValue = "";
			}else {
				if(!dateValue.equals(dateCurrent)){
					dateValue = dateCurrent;
					mainValue = 1;
				}
			}
		}
		// 更新业务编码生成器（更新日期值、主值）
		codeGenerator.setDateValue(dateValue);
		codeGenerator.setMainValue(mainValue);
		String generatedCode = prefix + dateValue + midfix + StringUtils.leftPad(Long.toString(mainValue), mainValueLength, '0') + postfix;	// 最终生成编码
		codeGenerator.setLastCode(generatedCode);
		super.save(codeGenerator);
		// 返回生成的业务编码
		return generatedCode;
	}
	
}