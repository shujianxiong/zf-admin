package com.chinazhoufan.admin.modules.data.vo.member;

public class MemberRegStat {
	
	private String label;//显示数据
	
	private String num;//显示值

	private String data;//格式数据 (柱状图：二维数组的json串)
	
	private String color;//颜色

	
	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
	
	
}
