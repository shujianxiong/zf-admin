/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.mi;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.crm.dao.mi.PointDetailDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.mi.PointDetail;
import com.google.common.collect.Maps;

/**
 * 会员积分账户流水详情Service
 * @author 刘晓东
 * @version 2015-12-15
 */
@Service
@Transactional(readOnly = true)
public class PointDetailService extends CrudService<PointDetailDao, PointDetail> {

	@Autowired
	MemberService memberService;
	
	public Page<PointDetail> findPageByMember(Page<PointDetail> page, String memberId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("page", page);
		map.put("memberId", memberId);
		page.setList(dao.getPointDetailByMember(map));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(PointDetail pointDetail) {
		super.save(pointDetail);
	}
	
	/**
	 * 变更会员积分
	 */
	@Transactional(readOnly = false)
	public void updatePoint(PointDetail pointDetail) {
		Member member = memberService.getByUsercode(pointDetail.getMember().getUsercode());
		memberService.updatePointOperate(member.getId(), pointDetail.getChangeType(), pointDetail.getChangePoint(), 
				pointDetail.getChangeReasonType(), PointDetail.OPERATER_TYPE_STAFF, null);
	}
	
	/**
	 * 生成积分流水记录==积分新增
	 * @param addPoint 增加积分
	 * @param memberId 会员ID
	 * @param changeReasonType 变动原因
	 * @param operaterType 操作人类型
	 */
	@Transactional(readOnly = false)
	public void addPoint(Integer addPoint, String memberId, String changeReasonType, String operaterType){
		Member member = memberService.get(memberId);
		PointDetail pointDetail = new PointDetail(member);
		pointDetail.setChangeType(PointDetail.CHANGE_TYPE_ADD); //变动类型：新增
		pointDetail.setChangePoint(addPoint); //变动积分数量
		pointDetail.setLastPoint(member.getPoint()+addPoint); //变动后积分
		pointDetail.setChangeReasonType(changeReasonType); //变动原因
		pointDetail.setChangeTime(new Date()); //变动时间设置为当前时间
		pointDetail.setOperaterType(operaterType);// 操作类型
		save(pointDetail);
	}
	
}