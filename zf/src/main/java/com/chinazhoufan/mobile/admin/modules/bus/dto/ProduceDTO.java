package com.chinazhoufan.mobile.admin.modules.bus.dto;


/**
 * 订单关联产品DTO
 */
public class ProduceDTO {

	private String produceId;//产品
	
	private String goodsId;//商品
	
	private String goodsTitle;//商品标题
	
	private String produceName;//产品名称
	
	private String num;//关联数量
	
	private String fullWareplace;//具体货位
	
	private String stockNormal;//剩余库存

	
	
	
	public String getProduceId() {
		return produceId;
	}

	public void setProduceId(String produceId) {
		this.produceId = produceId;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getGoodsTitle() {
		return goodsTitle;
	}

	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}

	public String getProduceName() {
		return produceName;
	}

	public void setProduceName(String produceName) {
		this.produceName = produceName;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getFullWareplace() {
		return fullWareplace;
	}

	public void setFullWareplace(String fullWareplace) {
		this.fullWareplace = fullWareplace;
	}

	public String getStockNormal() {
		return stockNormal;
	}

	public void setStockNormal(String stockNormal) {
		this.stockNormal = stockNormal;
	}
	
	
	
}
