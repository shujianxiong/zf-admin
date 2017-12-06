/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import java.util.Date;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 货位列表Entity
 * @author 贾斌
 * @version 2015-10-13
 */
public class Wareplace extends DataEntity<Wareplace> {
	
	private static final long serialVersionUID = 1L;
	private Warecounter warecounter; 		// 所属货屉
	private String code;					// 编号
	private String scanCode;				// 电子码
	private Produce produce;				// 存货产品
	private String lockFlag;				// 锁定状态
	private String usableFlag;				// 是否启用
	
	/******************************* 自定义查询属性  ********************************/
	private Date beginUpdateDate;			// 开始 更新时间
	private Date endUpdateDate;				// 结束 更新时间
	private Integer stock;					// 货位库存
	/**
	 * 当findList()方法根据produce.id查询货位时，
	 * produceNullFlag==false查询存货产品为produce.id的货位
	 * produceNullFlag==true查询存货产品为produce.id的货位，及存货产品为空的货位
	 */
	public boolean produceNullFlag = false;
	/**
	 * 货位选择器分两种：一种是列出所有仓库的所有货位，然后根据仓库等其他条件去定位货位，一种是列出已知仓库的货位，然后直接选择
	 * 该参数主要是为了处理界面上的查询条件个数，当modalWhDisplayFlag=true的时候，就说明货位列表数据是全部仓库的货位数据，需要开放仓库等选择条件
	 * 当modalWhDisplayFlag=false的时候，就不需要显示仓库等的查询条件了
	 */
	public boolean modalWhDisplayFlag = false;
	
	/********************************* 自定义常量  *********************************/
	public static final String LOCKFLAG_UNLOCKED 	= "0";	// 未锁定
	public static final String LOCKFLAG_LOCKED 		= "1";	// 锁定
	
	
	/** 构造 */
	public Wareplace() {
		super();
	}

	public Wareplace(String id){
		super(id);
	}

	public Wareplace(Warecounter warecounter) {
		this.warecounter = warecounter;
	}

	public Wareplace(Warecounter warecounter, String code,String lockFlag, String usableFlag) {
		super();
		this.warecounter = warecounter;
		this.code = code;
		this.lockFlag = lockFlag;
		this.usableFlag = usableFlag;
	}
	

	/** 方法 */
	@NotBlank(message="货位不能为空")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Length(min=0, max=255, message="货位电子码长度必须介于 0 和 255 之间")
	public String getScanCode() {
		return scanCode;
	}

	public void setScanCode(String scanCode) {
		this.scanCode = scanCode;
	}
	
	public Date getBeginUpdateDate() {
		return beginUpdateDate;
	}

	public void setBeginUpdateDate(Date beginUpdateDate) {
		this.beginUpdateDate = beginUpdateDate;
	}
	
	public Date getEndUpdateDate() {
		return endUpdateDate;
	}

	public void setEndUpdateDate(Date endUpdateDate) {
		this.endUpdateDate = endUpdateDate;
	}

	public String getLockFlag() {
		return lockFlag;
	}

	public void setLockFlag(String lockFlag) {
		this.lockFlag = lockFlag;
	}

	public Integer getStock() {
		return stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

	public boolean isProduceNullFlag() {
		return produceNullFlag;
	}

	public void setProduceNullFlag(boolean produceNullFlag) {
		this.produceNullFlag = produceNullFlag;
	}

	public boolean isModalWhDisplayFlag() {
		return modalWhDisplayFlag;
	}

	public void setModalWhDisplayFlag(boolean modalWhDisplayFlag) {
		this.modalWhDisplayFlag = modalWhDisplayFlag;
	}
	
	public Warecounter getWarecounter() {
		return warecounter;
	}

	public void setWarecounter(Warecounter warecounter) {
		this.warecounter = warecounter;
	}

	public Produce getProduce() {
		return produce;
	}

	public void setProduce(Produce produce) {
		this.produce = produce;
	}

	public String getUsableFlag() {
		return usableFlag;
	}

	public void setUsableFlag(String usableFlag) {
		this.usableFlag = usableFlag;
	}
	
}