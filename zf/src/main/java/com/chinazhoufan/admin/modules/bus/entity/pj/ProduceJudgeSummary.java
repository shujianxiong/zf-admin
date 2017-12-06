/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.entity.pj;

import org.hibernate.validator.constraints.Length;

import com.chinazhoufan.admin.common.persistence.DataEntity;

/**
 * 产品评价摘要Entity
 * @author liut
 * @version 2017-07-28
 */
public class ProduceJudgeSummary extends DataEntity<ProduceJudgeSummary> {
	
	private static final long serialVersionUID = 1L;
	private ProduceJudge produceJudge;		// 评价ID
	private Summary summary;		// 评价摘要ID
	
	public ProduceJudgeSummary() {
		super();
	}

	public ProduceJudgeSummary(String id){
		super(id);
	}

	@Length(min=1, max=64, message="评价ID长度必须介于 1 和 64 之间")
	public ProduceJudge getProduceJudge() {
		return produceJudge;
	}

	public void setProduceJudge(ProduceJudge produceJudge) {
		this.produceJudge = produceJudge;
	}
	
	@Length(min=1, max=64, message="评价摘要ID长度必须介于 1 和 64 之间")
	public Summary getSummary() {
		return summary;
	}

	public void setSummary(Summary summary) {
		this.summary = summary;
	}
	
}