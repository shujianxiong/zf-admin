/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.tf;

import java.math.BigDecimal;
import java.util.List;

import com.chinazhoufan.admin.common.redis.RedisCacheService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.excel.ImportExcel;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Warehouse;
import com.chinazhoufan.admin.modules.lgt.service.ps.WarehouseService;
import com.chinazhoufan.admin.modules.sys.entity.Area;
import com.chinazhoufan.admin.modules.sys.service.AreaService;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.lgt.entity.tf.TransportFee;
import com.chinazhoufan.admin.modules.lgt.dao.tf.TransportFeeDao;

/**
 * 运费模板Service
 * @author 张金俊
 * @version 2016-12-03
 */
@Service
@Transactional(readOnly = true)
public class TransportFeeService extends CrudService<TransportFeeDao, TransportFee> {

	@Autowired
	private AreaService areaService;


	@Autowired
	private WarehouseService warehouseService;


	public TransportFee get(String id) {
		return super.get(id);
	}
	
	public List<TransportFee> findList(TransportFee transportFee) {
		return super.findList(transportFee);
	}
	
	public Page<TransportFee> findPage(Page<TransportFee> page, TransportFee transportFee) {
		return super.findPage(page, transportFee);
	}
	
	@Transactional(readOnly = false)
	public void save(TransportFee transportFee) {
		super.save(transportFee);
	}
	
	@Transactional(readOnly = false)
	public void delete(TransportFee transportFee) {
		super.delete(transportFee);
	}
	/**
	 * 运费模板数据Excel导入
	 * @param ei
	 */
	@Transactional(readOnly = false)
	public void importTransportFee(ImportExcel ei) {
		for (int i = 0; i < ei.getLastDataRowNum(); i++) {
			TransportFee transportFee = new TransportFee();
			Area area = new Area();
			Row row = ei.getRow(i);
			Object val_0 = ei.getCellValue(row, 0);
			Object val_1 = ei.getCellValue(row, 1);
			Object val_2 = ei.getCellValue(row, 2);
			Object val_3 = ei.getCellValue(row, 3);
			Object val_4 = ei.getCellValue(row, 4);
			Object val_5 = ei.getCellValue(row, 5);
			Object val_6 = ei.getCellValue(row, 6);
			Object val_7 = ei.getCellValue(row, 7);
			try {
				if (StringUtils.isNotBlank(val_0.toString())) {//仓库编码
					String warehouseCode = val_0.toString();
					Warehouse warehouse = new Warehouse();
					warehouse.setCode(warehouseCode);
					List<Warehouse> warehouseList = warehouseService.findList(warehouse);
					if (warehouseList != null && warehouseList.size() > 0) {
						transportFee.setWarehouse(warehouseList.get(0));
					}
				}
				if (StringUtils.isNotBlank(val_1.toString())) {//快递公司价格
					Double price = Double.valueOf(val_1.toString());
					transportFee.setCostMoney(BigDecimal.valueOf(price));
				}
				if (StringUtils.isNotBlank(val_2.toString())) {//运费
					Double price = Double.valueOf(val_2.toString());
					transportFee.setMoney(BigDecimal.valueOf(price));
				}
				if (StringUtils.isNotBlank(val_3.toString())) {//寄送耗时
					double days =Double.valueOf(val_3.toString());
					transportFee.setDays(Integer.valueOf((int)days));
				}
				if (StringUtils.isNotBlank(val_4.toString())) {//启用状态
					String usableFlag = val_4.toString().substring(0,1);
					if(usableFlag.equals("1") || usableFlag.equals("0")){
						transportFee.setUsableFlag(usableFlag);
					}else{
						throw new ServiceException("格式不正确！");
					}
				}
				//省份
				String province = val_5.toString();
				List<Area> areaProvince = areaService.findByName(province);

				//市
				List<Area> areaCity = areaService.findByName(val_6.toString());

				//区
				List<Area> areaQu = areaService.findByName(val_7.toString());
				for(Area qu :areaQu){
					if(qu.getParentIds().contains(areaProvince.get(0).getId())){
						transportFee.setReceiveArea(qu);
						break;
					}
				}
			} catch (ServiceException e) {
				throw new ServiceException(e.getMessage());
			}
			super.save(transportFee);
		}
	}

}