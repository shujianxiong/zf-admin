package com.chinazhoufan.admin.modules.msg.entity.um;

import java.io.Serializable;
import java.util.List;

import com.google.common.collect.Lists;

public class UmMessageVO implements Serializable{

	public List<UmMessage> list=Lists.newArrayList();
	
	public int count;//未读消息数量
	
	public UmMessageVO(){}
	
	public UmMessageVO(List<UmMessage> list,int count){
		this.list=list;
		this.count=count;
	}

	public List<UmMessage> getList() {
		return list;
	}

	public void setList(List<UmMessage> list) {
		this.list = list;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	
}
