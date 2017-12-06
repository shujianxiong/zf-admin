/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.pr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.spm.dao.pr.PrizeRecordDao;
import com.chinazhoufan.admin.modules.spm.entity.pr.Prize;
import com.chinazhoufan.admin.modules.spm.entity.pr.PrizeRecord;
import com.chinazhoufan.admin.modules.spm.service.ac.AcActivityService;

/**
 * 奖品领取记录表Service
 * @author liut
 * @version 2016-05-19
 */
@Service
@Transactional(readOnly = true)
public class PrizeRecordService extends CrudService<PrizeRecordDao, PrizeRecord> {

	@Autowired
	private PrizeService prizeService;
	@Autowired
	private AcActivityService acActivityService;
	
	public PrizeRecord get(String id) {
		return super.get(id);
	}
	
	public List<PrizeRecord> findList(PrizeRecord prizeRecord) {
		return super.findList(prizeRecord);
	}
	
	public Page<PrizeRecord> findPage(Page<PrizeRecord> page, PrizeRecord prizeRecord) {
		return super.findPage(page, prizeRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(PrizeRecord prizeRecord) {
		super.save(prizeRecord);
		//同步减少奖品的可用数量
		if(PrizeRecord.RECEIVE_PASS.equals(prizeRecord.getReceiveStatus())) {
			Prize prize = prizeService.get(prizeRecord.getPrize().getId());
			prize.setUsableNum(""+(Integer.valueOf(prize.getUsableNum()).intValue()-1));
			prizeService.save(prize);
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(PrizeRecord prizeRecord) {
		super.delete(prizeRecord);
	}
	
	@Transactional(readOnly = false)
	public void changeFlag(PrizeRecord prizeRecord) {
		prizeRecord.preUpdate();
		dao.update(prizeRecord);
	}

	
	
	/**
	 * 根据奖品ID及会员ID查询奖品领取记录
	 * @param prizeId
	 * @param memberId
	 */
	public PrizeRecord getByPrizeAndMember(String prizeId, String memberId) {
		List<PrizeRecord> list = dao.getByPrizeAndMember(prizeId,memberId);
		return list == null ||list.isEmpty()?null:list.get(0);
	}

	/**
	 * 前端跳转到兑换页面生成奖品领取记录--领取状态为“未领取”
	 * @param memberId
	 * @param prizeId
	 * @param reasonType
	 */
	@Transactional(readOnly = false)
	public void save(String memberId, String prizeId, String reasonType) {
		PrizeRecord prizeRecord = new PrizeRecord();
		prizeRecord.setMember(new Member(memberId)); //领取会员
		prizeRecord.setPrize(new Prize(prizeId)); //领取奖品
		prizeRecord.setReasonType(reasonType); //领取原因
		prizeRecord.setReceiveStatus(PrizeRecord.RECEIVE_WAIT); //领取状态为未领取
		save(prizeRecord);
	}
}