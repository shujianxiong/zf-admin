/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.pj;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 产品评价图片Entity
 * @author liut
 * @version 2017-07-28
 */
public class ProduceJudgePhoto extends DataEntity<ProduceJudgePhoto> {
	
	private static final long serialVersionUID = 1L;
	private ProduceJudge produceJudge;		// 评价ID
	private String photoUrl;		// 图片URL
	
	public ProduceJudgePhoto() {
		super();
	}

	public ProduceJudgePhoto(String id){
		super(id);
	}

	@Length(min=1, max=64, message="评价ID长度必须介于 1 和 64 之间")
	public ProduceJudge getProduceJudge() {
		return produceJudge;
	}

	public void setProduceJudge(ProduceJudge produceJudge) {
		this.produceJudge = produceJudge;
	}
	
	@Length(min=1, max=255, message="图片URL长度必须介于 1 和 255 之间")
	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	
}