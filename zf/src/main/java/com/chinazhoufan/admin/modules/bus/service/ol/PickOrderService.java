/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bus.service.ol;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.bus.dao.ol.PickOrderDao;
import com.chinazhoufan.admin.modules.bus.dao.ol.SendOrderDao;
import com.chinazhoufan.admin.modules.bus.entity.oe.ExperienceOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.PickOrder;
import com.chinazhoufan.admin.modules.bus.entity.ol.SendOrder;
import com.chinazhoufan.admin.modules.bus.service.oe.ExperienceOrderService;
import com.chinazhoufan.admin.modules.express.service.YTService;
import com.chinazhoufan.admin.modules.express.services.SFService;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressAppointRecord;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductService;
import com.chinazhoufan.admin.modules.lgt.service.tn.ExpressNoSegmentService;
import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import com.google.common.collect.Maps;


/**
 * 拣货单Service
 * @author 张金俊
 * @version 2017-04-12
 */
@Service
@Transactional(readOnly = true)
public class PickOrderService extends CrudService<PickOrderDao, PickOrder> {

	@Autowired
	private ProductService productService;
	@Autowired
	private SendOrderService sendOrderService;
	@Autowired
	private SendProduceService sendProduceService;
	@Autowired
	private ExpressNoSegmentService segmentService;
	@Autowired
	CodeGeneratorService codeGeneratorService;
	@Autowired
	SFService sfService;
	@Autowired
	private SendOrderDao sendOrderDao;
	@Autowired
	private YTService ytService;
	@Autowired
	private ExperienceOrderService experienceOrderService;
	

	public PickOrder get(String id) {
		return super.get(id);
	}
	
	public List<PickOrder> findList(PickOrder pickOrder) {
		return super.findList(pickOrder);
	}
	
	public Page<PickOrder> findPage(Page<PickOrder> page, PickOrder pickOrder) {
		return super.findPage(page, pickOrder);
	}
	
	/**
	 * 列出打包待接单的拣货单列表（拣货人不为空、打包人为空）
	 * @param page
	 * @param pickOrder
	 * @return
	 */
	public Page<PickOrder> findPageForPackageToGet(Page<PickOrder> page, PickOrder pickOrder) {
		pickOrder.setPage(page);
		page.setList(dao.listForPackageToGet(pickOrder));
		return page;
	}
	
	/**
	 * 根据打包人（当前用户）列出该打包人的拣货单
	 * @param page
	 * @param pickOrder
	 * @return
	 */
	public Page<PickOrder> findPageForPackage(Page<PickOrder> page, PickOrder pickOrder) {
		pickOrder.setPage(page);
		page.setList(dao.listForPackage(pickOrder));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(PickOrder pickOrder) {
		//记录打包人
		if(StringUtils.isNotBlank(pickOrder.getId())) {
			pickOrder.setPackageBy(UserUtils.getUser());
		}
		super.save(pickOrder);
	}
	
	@Transactional(readOnly = false)
	public void receivePickOrder(PickOrder pickOrder) {
		//记录打包人,打包开始时间
		if(StringUtils.isNotBlank(pickOrder.getId())) {
			if(pickOrder.getPackageStartTime() == null) {
				Date date = new Date();
				pickOrder.setPackageStartTime(date);
				pickOrder.setPickEndTime(date);
			}
			pickOrder.setPackageBy(UserUtils.getUser());
		}
		super.save(pickOrder);
		
		//更新发货单的状态为打包中
		SendOrder so = new SendOrder();
		so.setPickOrder(pickOrder);
		so.setStatus(SendOrder.STATUS_PACKAGEING);
		//只有拣货中的发货单才能更新状态
		sendOrderService.updateStatusByPickOrder(so);
		
	}
	
	@Transactional(readOnly = false)
	public void updatePackgeTime(PickOrder pickOrder) {
		//记录打包开始时间
		if(StringUtils.isNotBlank(pickOrder.getId())) {
			if(pickOrder.getPackageStartTime() == null) {
				Date date = new Date();
				pickOrder.setPackageStartTime(date);
				pickOrder.setPickEndTime(date);
			}
			super.save(pickOrder);
		}
	}
	
	
	@Transactional(readOnly = false)
	public void delete(PickOrder pickOrder) {
		super.delete(pickOrder);
	}
	
	/**
	 * 根据拣货单，获取拣货序号第一位的状态为待打包的发货单，及其关联产品
	 * @param pickOrder
	 */
	@Transactional(readOnly = false)
	public SendOrder generateData(PickOrder pickOrder) {
		SendOrder sendOrder = new SendOrder();
		return pickOrder(sendOrder,pickOrder);
	}

	/**
	 * 根据拣货单，获取拣货序号第一位的状态为待打包的发货单，及其关联产品
	 * @param pickOrder
	 */
	@Transactional(readOnly = false)
	public SendOrder generateData(PickOrder pickOrder, String status) {
		SendOrder sendOrder = new SendOrder();
		sendOrder.setStatus(status);
		return pickOrder(sendOrder,pickOrder);
	}

	@Transactional(readOnly = false)
	SendOrder pickOrder(SendOrder sendOrder , PickOrder pickOrder){
		sendOrder.setPickOrder(pickOrder);
		SendOrder so;
		if(pickOrder.getSendOrderId() != null && StringUtils.isNotEmpty(pickOrder.getSendOrderId())){
			//发货单补发
			sendOrder.setId(pickOrder.getSendOrderId());
		}
		List<SendOrder> soList = sendOrderService.findSendOrderWithMinPickNo(sendOrder);
		if(soList == null || soList.size() == 0)
			return null;
		so = soList.get(0);//获取序号最小的拣货单
	    if (com.chinazhoufan.admin.common.utils.StringUtils.isBlank(so.getExpressNo())){
	    	ExperienceOrder experienceOrder = experienceOrderService.get(so.getOrderId());
            Map<String, Object> result = ytService.orderService(so, experienceOrder.getProv(), experienceOrder.getCity());
			if (!"OK".equals(result.get("result").toString())){
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				result = sfService.orderService(so);
			}
			if("OK".equals(result.get("result").toString())){
				so.setExpressNo(result.get("mailNo").toString());
				so.setExpressCompany(SendOrder.EXPRESS_COMPANY_YT);
				so.setDestCode(result.get("shortAddress").toString());
				// 1.更新发货单、发货时间
				so.setExpressTime(new Date());
				sendOrderService.save(so);
			}else{
				throw new ServiceException("预约快递失败");
			}
		}
		return so;
	}
	
	/**
	 * 根据拣货人列出该拣货人还未拣货完成的拣货单数量
	 * @param pickOrder
	 * @return
	 */
	public Integer countUnCompletePickWithPickBy(PickOrder pickOrder) {
		return dao.countUnCompletePickWithPickBy(pickOrder);
	}
	
	/**
	 * 根据拣货单ID获取拣货任务明细，按照货位显示
	 * @param pickOrder
	 * @return
	 */
	public List<Produce> getMissionDetailByPickOrder(PickOrder pickOrder) {
		return dao.getMissionDetailByPickOrder(pickOrder);
	}
	
	/**
	 * 根据托盘编码获取最近一次的关联拣货单正在使用的记录
	 * @param pickOrder
	 * @return
	 */
	public PickOrder findPickOrderByPlateNo(PickOrder pickOrder) {
		return dao.findPickOrderByPlateNo(pickOrder);
	}
	
	public PickOrder getDetailWithSendOrder(PickOrder pickOrder) {
		return dao.getDetailWithSendOrder(pickOrder);
	}

	public PickOrder findPickOrderByPlateNo(String plateNo){
		Map<String, Object> map = Maps.newHashMap();
		map.put("plateNo", plateNo);
		map.put("DEL_FLAG_NORMAL", PickOrder.DEL_FLAG_NORMAL);
		return dao.findPickOrderByPlateNo(map);
	}

	/**
	 * 按托盘号取消拣货单
	 * @param pickOrder
	 */
	@Transactional(readOnly = false)
	public void cancelByPlateNo(PickOrder pickOrder) {
		List<SendOrder> list = sendOrderService.findByPickOrder(pickOrder.getId());
		PickOrder pickOrderTmp = new PickOrder();
		for (SendOrder sendOrder:list){
			sendOrder.setStatus(SendOrder.STATUS_TOPICK);
			sendOrder.setPickOrder(pickOrderTmp);
			sendOrder.setPickNo(null);
			sendOrderService.save(sendOrder);
		}
		//删除拣货单
		delete(pickOrder);
	}
}