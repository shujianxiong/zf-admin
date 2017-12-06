/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.ns;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.crm.dao.ns.SubscribeDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.entity.ns.Subscribe;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;

/**
 * 订阅Service
 * @author 张金俊
 * @version 2017-07-18
 */
@Service
@Transactional(readOnly = true)
public class SubscribeService extends CrudService<SubscribeDao, Subscribe> {

	@Autowired
	NotifyService notifyService;
	
	public Subscribe get(String id) {
		return super.get(id);
	}
	
	public List<Subscribe> findList(Subscribe subscribe) {
		return super.findList(subscribe);
	}
	
	public Page<Subscribe> findPage(Page<Subscribe> page, Subscribe subscribe) {
		return super.findPage(page, subscribe);
	}
	
	@Transactional(readOnly = false)
	public void save(Subscribe subscribe) {
		super.save(subscribe);
	}
	
	@Transactional(readOnly = false)
	public void delete(Subscribe subscribe) {
		super.delete(subscribe);
	}
	
	/**
	 * 根据订阅及消息的条件，查询订阅记录（及消息数据）
	 * @param subscribe
	 * @param notify
	 * @return
	 */
	public List<Subscribe> findBySubscribeAndNotify(Subscribe subscribe, Notify notify) {
		return dao.findBySubscribeAndNotify(subscribe, notify);
	}
	
	/**
	 * 根据订阅及消息的条件，更新订阅记录状态
	 * @param status	将更新的状态
	 * @param currDate	将更新的更新时间
	 * @param subscribe
	 * @param notify
	 * @return
	 */
	@Transactional(readOnly = false)
	public void updateStatusBySubscribeAndNotify(String status, Date currDate, Subscribe subscribe, Notify notify) {
		dao.updateStatusBySubscribeAndNotify(status, currDate, subscribe, notify);
	}
	
	/**
	 * （zf-index操作接口）
	 * 前台用户点击“产品到货提醒”时，生成订阅记录
	 * @param member
	 * @param produce
	 */
	@Transactional(readOnly = false)
	public void createForProducePurchaseFinish(Member member, Produce produce) {
		// 获取产品到货提醒对应的消息
		Notify notify = notifyService.getByTargetTypeAndAction(Notify.RTT_PRODUCE, Notify.RTA_PRODUCE_PURCHASEFINISH);
		if(notify == null || Notify.STATUS_PUBLISHED != notify.getStatus())
			throw new ServiceException("未在消息列表中找到已发布的产品到货提醒相关的记录，请核查!");
		// 生成订阅记录
		Subscribe subscribe = new Subscribe();
		subscribe.setTargetId(produce.getId());
		subscribe.setMember(member);
		subscribe.setNotify(notify);
		subscribe.setStatus(Subscribe.STATUS_NEW);
		subscribe.preInsert();
		dao.insert(subscribe);
	}
	
	/**
	 * 产品到货时，更新对应订阅的状态为待提醒（订阅目标ID为产品ID、订阅状态为新建、订阅删除标记为未删除、对应消息的提醒目标类型为“produce”、对应消息的提醒目标动作为“produce_purchaseFinish”）
	 * @param produce	到货的产品
	 */
	@Transactional(readOnly = false)
	public void updateWhenPurchaseFinish(Produce produce) {
		Subscribe subscribe = new Subscribe();
		subscribe.setTargetId(produce.getId());
		subscribe.setStatus(Subscribe.STATUS_NEW);
		subscribe.setDelFlag(Subscribe.DEL_FLAG_NORMAL);
		Notify notify = new Notify();
		notify.setRemindTargetType(Notify.RTT_PRODUCE);
		notify.setRemindTargetAction(Notify.RTA_PRODUCE_PURCHASEFINISH);
		notify.setDelFlag(Notify.DEL_FLAG_NORMAL);
		this.updateStatusBySubscribeAndNotify(Subscribe.STATUS_TOREMIND, new Date(), subscribe, notify);
	}
	
	/**
	 * （zf-index查询接口）
	 * 查询“产品到货提醒”类订阅
	 */
	public List<Subscribe> findWithNotifyAndProduce() {
		Subscribe subscribeParam = new Subscribe();
		subscribeParam.setNotify(new Notify());
		return dao.findWithNotifyAndProduce(subscribeParam);
	}
}
