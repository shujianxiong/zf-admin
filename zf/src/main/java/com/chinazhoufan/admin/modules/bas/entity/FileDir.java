package com.chinazhoufan.admin.modules.bas.entity;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.TreeEntity;

/**
 * 文件目录一旦建立仅支持del_flag删除
 * 文件目录
 * @author  杨晓辉
 * @date 创建时间：2016年10月26日 下午1:49:14 
 * @version 2.0.0 
 */
public class FileDir extends TreeEntity<FileDir>{
	
	/**
	 * @Fields serialVersionUID:TODO
	 */
	private static final long serialVersionUID = 1513601968608115129L;
	
	private Integer orderNo;            // 排序字段
	
	private String code;				// 目录编码，不可变更
	
	private String type;				// 0隐藏 1公开
	
	private List<FileLibrary> files;	// 包含文件
	
	public static final String TYPE_PUBLIC = "1";  //公开
	public static final String TYPE_PRIVATE = "0"; //影藏
	
	public FileDir(){
		super();
		this.orderNo = 30;
	}
	
	public FileDir(String id){
		super(id);
	}
	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public FileDir getParent() {
		return parent;
	}

	public void setParent(FileDir parent) {
		this.parent = parent;
	}

	public List<FileLibrary> getFiles() {
		return files;
	}

	public void setFiles(List<FileLibrary> files) {
		this.files = files;
	}

	public static void sortList(List<FileDir> list, List<FileDir> sourcelist, String parentId){
		for (int i=0; i<sourcelist.size(); i++){
			FileDir e = sourcelist.get(i);
			if (e.getParent()!=null && e.getParent().getId()!=null
					&& e.getParent().getId().equals(parentId)){
				list.add(e);
				// 判断是否还有子节点, 有则继续获取子节点
				for (int j=0; j<sourcelist.size(); j++){
					FileDir child = sourcelist.get(j);
					if (child.getParent()!=null && child.getParent().getId()!=null
							&& child.getParent().getId().equals(e.getId())){
						sortList(list, sourcelist, e.getId());
						break;
					}
				}
			}
		}
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
	
}
