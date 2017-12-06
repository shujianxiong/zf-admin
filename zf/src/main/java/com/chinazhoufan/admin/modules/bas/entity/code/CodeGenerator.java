/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity.code;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 业务编码列表Entity
 * @author 贾斌
 * @version 2015-11-23
 */
public class CodeGenerator extends DataEntity<CodeGenerator> {
	
	private static final long serialVersionUID = 1L;
	private String codeHandle;		// 编码代码
	private String codeName;		// 编码名称
	private String prefix;			// 前缀
	private String dateType;		// 日期类型
	private String dateValue;		// 日期值
	private String midfix;			// 中缀
	private String mainValueType;	// 主值随机类型
	private Integer mainValueLength;// 主值长度
	private Long mainValue;			// 主值
	private String postfix;			// 后缀
	private String lastCode;		// 最后生成编码
	
	public static final String DATE_TYPE_NO 		= "0"; 	// 无
	public static final String DATE_TYPE_YYYY 		= "1"; 	// 年(1999)
	public static final String DATE_TYPE_YYYYMM 	= "2"; 	// 年月(1999/01)
	public static final String DATE_TYPE_YYYYMMDD 	= "3"; 	// 年月日(19990101)
	public static final String DATE_TYPE_YYMMDD 	= "4"; 	// 年月日(990101)
	
	public static final String MAIN_VALUE_TYPE_ADDONE 	 = "1";	// 自增
	public static final String MAIN_VALUE_TYPE_ADDRANDOM = "2";	// 随机自增
	public static final String MAIN_VALUE_TYPE_RANDOM 	 = "3";	// 随机
	
	
	
	public CodeGenerator() {
		super();
	}

	public CodeGenerator(String id){
		super(id);
	}

	@NotNull(message = "编码代码不能为空")
	@Length(min=1, max=100, message="编码代码长度必须介于 1 和 100 之间")
	public String getCodeHandle() {
		return codeHandle;
	}

	public void setCodeHandle(String codeHandle) {
		this.codeHandle = codeHandle;
	}
	@NotNull(message = "编码名称不能为空")
	@Length(min=1, max=100, message="编码名称长度必须介于 1 和 100 之间")
	public String getCodeName() {
		return codeName;
	}

	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	
	@Length(min=0, max=10, message="前缀长度必须介于0 和 10 之间")
	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	@Length(min=1, max=2, message="日期类型长度必须介于 1 和 2 之间")
	public String getDateType() {
		return dateType;
	}

	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	
	@Length(min=0, max=10, message="日期值长度必须介于 0 和 10 之间")
	public String getDateValue() {
		return dateValue;
	}

	public void setDateValue(String dateValue) {
		this.dateValue = dateValue;
	}
	
	@Length(min=0, max=10, message="中缀长度必须介于 0 和 10 之间")
	public String getMidfix() {
		return midfix;
	}

	public void setMidfix(String midfix) {
		this.midfix = midfix;
	}
	
	@Length(min=1, max=2, message="主值随机类型长度必须介于 1 和 2 之间")
	public String getMainValueType() {
		return mainValueType;
	}

	public void setMainValueType(String mainValueType) {
		this.mainValueType = mainValueType;
	}
	@NotNull(message = "主值长度不能为空")
//	@Length(min=1, max=11, message="主值长度长度必须介于 1 和 11 之间")
	public Integer getMainValueLength() {
		return mainValueLength;
	}

	public void setMainValueLength(Integer mainValueLength) {
		this.mainValueLength = mainValueLength;
	}
	
//	@Length(min=1, max=11, message="主值长度必须介于 1 和 11 之间")
	public Long getMainValue() {
		return mainValue;
	}

	public void setMainValue(Long mainValue) {
		this.mainValue = mainValue;
	}
	
	@Length(min=0, max=10, message="后缀长度必须介于 0 和 10 之间")
	public String getPostfix() {
		return postfix;
	}

	public void setPostfix(String postfix) {
		this.postfix = postfix;
	}

	public String getLastCode() {
		return lastCode;
	}

	public void setLastCode(String lastCode) {
		this.lastCode = lastCode;
	}
	
}