/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.entity.ps;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 货品编码变动记录Entity
 * @author 张金俊
 * @version 2017-04-20
 */
public class ProductCodeChange extends DataEntity<ProductCodeChange> {
	
	private static final long serialVersionUID = 1L;
	private Product product;			// 货品
	private String preProductCode;		// 调前货品编号
	private String postProductCode;		// 调后货品编号
	private String reasonType;			// 变更原因
	
	// 变更原因 lgt_ps_product_code_change_reasonType
	public static final String REASONTYPE_LOSTCODE	= "1";	// 条码遗失
	
	public ProductCodeChange() {
		super();
	}

	public ProductCodeChange(String id){
		super(id);
	}
	

	@Length(min=1, max=64, message="货品ID长度必须介于 1 和 64 之间")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	@Length(min=0, max=64, message="调前货品编号长度必须介于 0 和 64 之间")
	public String getPreProductCode() {
		return preProductCode;
	}

	public void setPreProductCode(String preProductCode) {
		this.preProductCode = preProductCode;
	}
	
	@Length(min=0, max=64, message="调后货品编号长度必须介于 0 和 64 之间")
	public String getPostProductCode() {
		return postProductCode;
	}

	public void setPostProductCode(String postProductCode) {
		this.postProductCode = postProductCode;
	}
	
	@Length(min=1, max=2, message="变更原因长度必须介于 1 和 2 之间")
	public String getReasonType() {
		return reasonType;
	}

	public void setReasonType(String reasonType) {
		this.reasonType = reasonType;
	}
	
}