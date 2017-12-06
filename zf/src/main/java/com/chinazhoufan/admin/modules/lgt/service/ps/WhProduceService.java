/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.ps;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chinazhoufan.admin.modules.crm.service.ns.SubscribeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WarehouseDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WhProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.entity.ps.WhProduce;
import com.chinazhoufan.admin.modules.msg.dao.uw.WarningConfigDao;
import com.chinazhoufan.admin.modules.msg.entity.uw.Warning;
import com.chinazhoufan.admin.modules.msg.entity.uw.WarningConfig;
import com.chinazhoufan.admin.modules.msg.service.uw.WarningService;
import com.chinazhoufan.admin.modules.sys.entity.User;
import com.chinazhoufan.admin.modules.sys.utils.DictUtils;
import com.google.common.collect.Maps;

/**
 * 仓库产品库存表Service
 * @author 刘晓东
 * @version 2016-03-17
 */
@Service
@Transactional(readOnly = true)
public class WhProduceService extends CrudService<WhProduceDao, WhProduce> {
	
	@Autowired
	private ProduceDao produceDao;
	@Autowired
	private WarehouseDao warehouseDao;
	@Autowired
	private WarningConfigDao warningConfigDao;
	@Autowired
	private WarningService warningService;
	@Autowired
	private SubscribeService subscribeService;
	

	public WhProduce get(String id) {
		return super.get(id);
	}
	
	public List<WhProduce> findList(WhProduce whProduce,String stockStatus) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("whProduce", whProduce);
		map.put("stockStatus", stockStatus);
		return dao.findList(map);
	}
	
	public List<WhProduce> findAllList(WhProduce whProduce) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("whProduce", whProduce);
		return dao.findAllList(map);
	}
	
	public List<WhProduce> findListByProduceIdArr(String warehouseId, List<String> produceIdList) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("warehouseId", warehouseId);
		map.put("produceIdList", produceIdList);
		return dao.findListByProduceIdArr(map);
	}
	
	public Page<WhProduce> findPage(Page<WhProduce> page, WhProduce whProduce, String stockStatus) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("page", page);
		map.put("whProduce", whProduce);
		map.put("stockStatus", stockStatus);
		page.setList(dao.findList(map));
		return page;
	}
	
	/**
	 * 为仓库新增一套初始化的产品库存数据
	 * @param warehouseId 仓库ID
	 */
	@Transactional(readOnly = false)
	public void addWhProducesByWarehouseId(String warehouseId) {
		Warehouse warehouse = new Warehouse(warehouseId);
		List<Produce> produceList = produceDao.findList(new Produce());
		for(Produce produceTemp : produceList){
			WhProduce whProduce = new WhProduce();
			whProduce.setWarehouse(warehouse);
			whProduce.setProduce(produceTemp);
			whProduce.setStockNormal(0);
			whProduce.setStockLock(0);
			whProduce.setStockDebt(0);
			whProduce.setMotinorStatus(WhProduce.MOTINORSTATUS_UNUSED);
			whProduce.preInsert();
			dao.insert(whProduce);
		}
	}
	
	/**
	 * 根据产品ID，为该产品创建一套库存体系
	 * @param produceId
	 */
	@Transactional(readOnly=false)
	public void addWhProducesByProduceId(String produceId) {
		Produce produce = new Produce(produceId);
		List<Warehouse> warehouses = warehouseDao.findList(new Warehouse());
		for(Warehouse warehouseTemp : warehouses){
			WhProduce whProduce = new WhProduce();
			whProduce.setWarehouse(warehouseTemp);
			whProduce.setProduce(produce);
			whProduce.setStockNormal(0);
			whProduce.setStockLock(0);
			whProduce.setStockDebt(0);
			whProduce.setMotinorStatus(WhProduce.MOTINORSTATUS_UNUSED);
			save(whProduce);;
		}
	}
	

	/**
	 * 更新仓库产品库存数据通用方法
	 * @param wid		仓库ID
	 * @param pid		产品ID
	 * @param snType	正常库存增减类型（A/D）
	 * @param snNum		正常库存增减数量
	 * @param slType	锁定库存增减类型（A/D）
	 * @param slNum		锁定库存增减数量
	 * @param sdType	负债库存增减类型（A/D）
	 * @param sdNum		负债库存增减数量
	 */
	@Transactional(readOnly = false)
	public void updateWhProduceStock(String wid, String pid, 
										String snType, int snNum, 
										String slType, int slNum,
										String sdType, int sdNum) {
		WhProduce whProduce = this.getWhProduceByWidAndPid(wid, pid);
		// 更新正常库存
		if("A".equals(snType)){
			whProduce.setStockNormal(whProduce.getStockNormal() + Math.abs(snNum));
		}else if("D".equals(snType)){
			whProduce.setStockNormal(whProduce.getStockNormal() - Math.abs(snNum));
		}
		// 更新锁定库存
		if("A".equals(slType)){
			whProduce.setStockLock(whProduce.getStockLock() + Math.abs(slNum));
		}else if("D".equals(slType)){
			whProduce.setStockLock(whProduce.getStockLock() - Math.abs(slNum));
		}
		// 更新负债库存
		if("A".equals(sdType)){
			whProduce.setStockDebt(whProduce.getStockDebt() + Math.abs(sdNum));
		}else if("D".equals(sdType)){
			whProduce.setStockDebt(whProduce.getStockDebt() - Math.abs(sdNum));
		}
		if(whProduce.getStockDebt() < 0){
			whProduce.setStockDebt(0);//当负债库存减少成负数，说明不存在负债，则置零
		}
		// 检测库存合理性
		if(whProduce.getStockNormal() < 0 || whProduce.getStockLock() < 0 ){
			throw new ServiceException("更新仓库产品库存不能导致各库存为负数！");
		}
		whProduce.preUpdate();
		dao.update(whProduce);
		/**当正常库存大于零时  发送到货提醒**/
		if(whProduce.getStockNormal() > 0){
			subscribeService.updateWhenPurchaseFinish(whProduce.getProduce());
		}

		//获取产品信息
		Produce p = produceDao.get(whProduce.getProduce().getId());
		Goods g = p.getGoods();
		
		//如果库存预警监控启用，就生成预警消息，且产品库存相关衡量值不允许为空
		if(WhProduce.MOTINORSTATUS_WORKING.equals(whProduce.getMotinorStatus())) {
			if(whProduce.getStockNormal() != null && whProduce.getStockSafe() != null) {
				//生成预警消息
				//当库存低于安全库存,发警报消息
				if(whProduce.getStockNormal() < whProduce.getStockSafe()) {
					WarningConfig wc = new WarningConfig();
					wc.setCategory(WarningConfig.CATEGORY_STOCK);//警报类别   ->  库存监控
					wc.setType(WarningConfig.TYPE_SAFETY);//低于安全库存
					wc.setReceiveType(WarningConfig.RECEIVETYPE_USER);//接收类型 ->  设置指派
					List<WarningConfig> wcList = warningConfigDao.findList(wc);
					
					if(wcList == null || wcList.size() == 0)
						return;
					
					Warning w = null;
					
					for(WarningConfig config : wcList) {
						w = new Warning();
						w.setCategory(config.getCategory());
						w.setType(config.getType());				// 警报类型（库存超标/到货延迟/低于安全库存/低于警报库存）
						w.setSendUser(new User("1"));				// 发送用户ID（系统管理员）
						String type = DictUtils.getDictLabel(config.getType(), "msg_uw_warning_config_type", "");
						w.setTitle(p.getCode()+""+type+"库存预警");				// 标题  产品编码+预警类型+库存预警
						w.setContent(g.getCode()+""+g.getName()+""+p.getCode()+""+p.getName()+""+type);				// 内容  商品编码+商品名称+产品编码+产品名称+预警类型
						w.setReceiveUser(config.getReceiveUser());			// 接收用户ID
						w.setStatus(Warning.STATUS_TO_VIEW);				// 警报状态（待推/已推/已看/处理中/完成）
						w.setPushTime(new Date());				// 推送时间
						//w.setViewTime();				// 查看时间
						//w.setDealStartTime();			// 处理开始时间
						//w.setDealEndTime();			// 处理完成时间
						//w.setDealResultType();		// 处理结果类型
						//w.setDealResultRemarks();	// 处理结果备注
						warningService.save(w);
					}
				}
			}
			
			
			if(whProduce.getStockNormal() != null &&  whProduce.getStockWarning() != null) {
				//当库存低于警戒库存,发警报消息
				if(whProduce.getStockNormal() < whProduce.getStockWarning()) {
					WarningConfig wc = new WarningConfig();
					wc.setCategory(WarningConfig.CATEGORY_STOCK);//警报类别   ->  库存监控
					wc.setType(WarningConfig.TYPE_AlARM);//低于警戒库存
					wc.setReceiveType(WarningConfig.RECEIVETYPE_USER);//接收类型 ->  设置指派
					List<WarningConfig> wcList = warningConfigDao.findList(wc);
					
					if(wcList == null || wcList.size() == 0)
						return;
					
					Warning w = null;
					for(WarningConfig config : wcList) {
						w = new Warning();
						w.setCategory(config.getCategory());
						w.setType(config.getType());				// 警报类型（库存超标/到货延迟/低于安全库存/低于警报库存）
						w.setSendUser(new User("1"));				// 发送用户ID（系统管理员）
						String type = DictUtils.getDictLabel(config.getType(), "msg_uw_warning_config_type", "");
						w.setTitle(p.getCode()+""+type+"库存预警");				// 标题  产品编码+预警类型+库存预警
						w.setContent(g.getCode()+""+g.getName()+""+p.getCode()+""+p.getName()+""+type);				// 内容  商品编码+商品名称+产品编码+产品名称+预警类型
						w.setReceiveUser(config.getReceiveUser());			// 接收用户ID
						w.setStatus(Warning.STATUS_TO_VIEW);				// 警报状态（待推/已推/已看/处理中/完成）
						w.setPushTime(new Date());				// 推送时间
						//w.setViewTime();				// 查看时间
						//w.setDealStartTime();			// 处理开始时间
						//w.setDealEndTime();			// 处理完成时间
						//w.setDealResultType();		// 处理结果类型
						//w.setDealResultRemarks();	// 处理结果备注
						warningService.save(w);
					}
				}
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void save(WhProduce whProduce) {
		if(whProduce.getStockStandard() != null && whProduce.getStockSafe() != null && (whProduce.getStockStandard() < whProduce.getStockSafe())){
			throw new ServiceException("警告：标准库存不得低于安全库存！");
		} 
		if(whProduce.getStockSafe() != null && whProduce.getStockWarning() != null && (whProduce.getStockSafe() < whProduce.getStockWarning())){
			throw new ServiceException("警告：安全库存不得低于警戒库存！");
		}
		super.save(whProduce);
	}
	
	@Transactional(readOnly = false)
	public void delete(WhProduce whProduce) {
		super.delete(whProduce);
	}
	
	/**
	 * 根据产品删除对应的产品库存记录，这里主要是针对删除商品时，同步删除状态为新建状态的产品，此时要同步删除新建状态产品对应的库存
	 * @param produce
	 */
	@Transactional(readOnly = false)
	public void deleteByProduce(Produce produce) {
		dao.deleteByProduce(produce);
	}
	
	
	
	/**
	 * 查询产品总库存
	 * @param produce
	 * @return
	 */
	public int getStockTotalByProduce(Produce produce) {
		return dao.getStockTotalByProduce(produce);
	}
	
	/**
	 * 
	 * @param produce
	 * @return
	 */
	public WhProduce getByProduce(Produce produce) {
		return dao.getByProduce(produce);	
	}
	/**
	 * 根据仓库Id和产品id查询
	 * @param warehouseId
	 * @param produceId
	 * @return
	 */
	public WhProduce getWhProduceByWidAndPid(String warehouseId, String produceId){
		return dao.getWhProduceByWidAndPid(warehouseId, produceId);
	}
	
	
	/**
	 * 根据仓库id 和 产品id 查询唯一结果
	 * @param WhProduce
	 * @return
	 * @throws ServiceException
	 */
	public WhProduce getWhProduceByWarehouseIdAnProduceId(WhProduce whProduce) throws ServiceException{
		List<WhProduce> list = dao.getWhProduceByWarehouseIdAnProduceId(whProduce);
		if(list == null){
			return null;
		}else if(list.size() == 1){
			return list.get(0);
		}else if(list.size()> 1){
			throw new ServiceException("警告：根据产品和仓库查询到不唯一结果");
		}
		return null;
	}

	/**
	 * 修改
	 * @param whProduceOld
	 */
	@Transactional(readOnly=false)
	public void update(WhProduce whProduceOld) {
		whProduceOld.preUpdate();
		dao.update(whProduceOld);
	}

	/**
	 * 根据仓库查询产品
	 * @param page
	 * @param whProduce
	 * @return
	 */
	public Page<Produce> findWarehouseProduce(Page<Produce> page,
			WhProduce whProduce) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("page", page);
		map.put("whProduce", whProduce);
		page.setList(dao.findWarehouseProduce(map));
		return page;
	}

	/**
	 * 批量保存库存设置
	 * @param whProduce
	 */
	@Transactional(readOnly=false)
	public void batchSave(WhProduce whProduce) {
		WhProduce whProduceTemp = null;
		for (Produce produce : whProduce.getProduceLists()) {
			//过滤空数据
			if (produce!=null&&!StringUtils.isBlank(produce.getId())) {
				whProduceTemp = dao.getWhProduceByWidAndPid(whProduce.getWarehouse().getId(), produce.getId());
				whProduceTemp.setStockStandard(produce.getStockStandard());//标准库存
				whProduceTemp.setStockSafe(produce.getStockSafe());//安全库存
				whProduceTemp.setStockWarning(produce.getStockWarning());//警戒库存
				save(whProduceTemp);
			}
		}
	}

	@Transactional(readOnly=false)
	public void releaseLockStock(String warehouseId,String produceId, Integer num) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("warehouseId", warehouseId);
		map.put("produceId", produceId);
		map.put("num", num);
		dao.releaseLockStock(map);
	}

}