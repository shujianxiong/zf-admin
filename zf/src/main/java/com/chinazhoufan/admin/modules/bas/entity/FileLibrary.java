/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.entity;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Brand;
import com.chinazhoufan.admin.modules.lgt.entity.bs.Designer;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Categories;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.si.Supplier;
import com.google.common.collect.Lists;

/**
 * 图片库Entity
 * @author 刘晓东
 * @version 2016-05-03
 */
public class FileLibrary extends DataEntity<FileLibrary> {
	
	private static final long serialVersionUID = 1L;
	private String name;			// 图片名称
	private String type;			// 图片类型（图片/其他）
	private Supplier supplier; 		// 供应商
	private Brand brand;			// 品牌ID
	private Designer designer;		// 设计师ID
	private Categories category;	// 分类ID
	private Goods goods;			// 商品ID
	private String fileUrl;			// 图片地址
	private FileDir fileDir;		// 所属目录
	
	private String postfix;         //文件后缀
	
	private List<FileProp> fileProps=Lists.newArrayList();
	
	private Integer opType; // 1= 快速上传， 0= 默认上传
	
	/**图片**/
	public static final String TYPE_IMG="1";
	/**其它**/
	public static final String TYPE_OTHERS="2";
	
	
	public FileLibrary() {
		super();
	}

	public FileLibrary(String id){
		super(id);
	}
	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Length(min=1, max=2, message="图片类型（资料图/展示图）长度必须介于 1 和 2 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Designer getDesigner() {
		return designer;
	}

	public void setDesigner(Designer designer) {
		this.designer = designer;
	}

	public Categories getCategory() {
		return category;
	}

	public void setCategory(Categories category) {
		this.category = category;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public String getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public List<FileProp> getFileProps() {
		return fileProps;
	}

	public void setFileProps(List<FileProp> fileProps) {
		this.fileProps = fileProps;
	}

	public Integer getOpType() {
		return opType;
	}

	public void setOpType(Integer opType) {
		this.opType = opType;
	}
	
	public FileDir getFileDir() {
		return fileDir;
	}

	public void setFileDir(FileDir fileDir) {
		this.fileDir = fileDir;
	}

	public String getPostfix() {
		return postfix;
	}

	public void setPostfix(String postfix) {
		this.postfix = postfix;
	}
	
	
	
}