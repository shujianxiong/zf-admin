/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.bas.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.modules.bas.dao.AddTestDataDao;
import com.chinazhoufan.admin.modules.bas.dao.ScanCodeDao;
import com.chinazhoufan.admin.modules.bas.entity.ScanCode;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WareplaceDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.WhProduceDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;
import com.chinazhoufan.admin.modules.lgt.entity.ps.ProductWpIo;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Wareplace;
import com.chinazhoufan.admin.modules.lgt.service.ps.ProductWpIoService;
import com.google.common.collect.Lists;


/**
 * 添加测试数据Service
 * @author 张金俊
 * @version 2016-12-28
 */
@Service
@Transactional(readOnly = false)
public class AddTestDataService {
	
	@Autowired
	private AddTestDataDao addTestDataDao;
	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private ProduceDao produceDao;
	@Autowired
	private ProductDao productDao;
	@Autowired
	private WareplaceDao wareplaceDao;
	@Autowired
	private ScanCodeDao scanCodeDao;
	@Autowired
	private WhProduceDao whProduceDao;
	@Autowired
	private ProductWpIoService productWpIoService;
	
	/**
	 * 新增200个货品电子码（货品电子码从100001开始）
	 */
	@Transactional(readOnly = false)
	public int addScanCodeProduct(){
		Integer startCode = 100001;
		ScanCode lastScanCode = addTestDataDao.getScanCodeLastByType(ScanCode.TYPE_PRODUCT);
		if(lastScanCode != null){
			startCode = Integer.valueOf(lastScanCode.getCode()) + 1;
		}
		
		Integer num = 200;
		for(Integer i=startCode; i<(startCode+num); i++){
			ScanCode productScanCode = new ScanCode();
			productScanCode.setCode(i);
			productScanCode.setType(ScanCode.TYPE_PRODUCT);
			productScanCode.preInsert();
			scanCodeDao.insert(productScanCode);
		}
		return num;
	}
	
	/**
	 * 新增200个货位电子码（货位电子码从200001开始）
	 */
	@Transactional(readOnly = false)
	public int addScanCodeWareplace(){
		Integer startCode = 200001;
		ScanCode lastScanCode = addTestDataDao.getScanCodeLastByType(ScanCode.TYPE_WAREPLACE);
		if(lastScanCode != null){
			startCode = Integer.valueOf(lastScanCode.getCode()) + 1;
		}
		
		Integer num = 200;
		for(Integer i=startCode; i<(startCode+num); i++){
			ScanCode wareplaceScanCode = new ScanCode();
			wareplaceScanCode.setCode(i);
			wareplaceScanCode.setType(ScanCode.TYPE_WAREPLACE);
			wareplaceScanCode.preInsert();
			scanCodeDao.insert(wareplaceScanCode);
		}
		return num;
	}
	
	/**
	 * 新增货品
	 * （为系统增加测试用的货品数据）
	 * （查询所有产品，所有货位，按产品顺序为每个产品新增随机1-10个货品并存放在同一个货位内，并更新对应仓库库存）
	 * @param productWpIo
	 */
	@Transactional(readOnly = false)
	public int addProduct() {
		List<Produce> pList = produceDao.findList(new Produce());
		List<Wareplace> wpEmptyList = wareplaceDao.findListEmpty(new Wareplace());	// 查询未使用的货位
		List<Wareplace> wpList = wareplaceDao.findList(new Wareplace());			// 查询所有货位
		int totalNum = 0;
		
		// 新增货品
		for(int i=0; i<pList.size(); i++){
			// 新建状态的产品，跳过
			if(pList.get(0).getStatus().equals(Produce.STATUS_NEW)){
				continue;
			}
			
			// 为每个产品增加货品
			// 设置货位（优先设置空货位，空货位使用完之后，随机使用所有货位）
			Wareplace wareplaceTemp;
			if(i < wpEmptyList.size()){
				wareplaceTemp = wpEmptyList.get(i);			// 存放货位				
			}else {
				int wpRandom = (int)(Math.random()*wpList.size());
				wareplaceTemp = wpList.get(wpRandom);
			}
			
			int num = 1+(int)(Math.random()*10);			// 随机新增货品数量[1-10]
			for(int j=0; j<num; j++){
				Product product = new Product();
				product.setProduce(pList.get(i));
				product.setGoods(pList.get(i).getGoods());
				product.setWeight(new BigDecimal("0.228"));
				
				ProductWpIo productWpIo = new ProductWpIo();
				productWpIo.setProduct(product);
				productWpIo.setIoType(ProductWpIo.IOTYPE_IN);
				productWpIo.setIoReasonType(ProductWpIo.IOREASIONTYPE_IN_PURCHASE);
				productWpIo.setIoWareplace(wareplaceTemp);
				productWpIo.setIoTime(new Date());
				productWpIoService.productInSave(productWpIo);
			}
			
//			// 查找到货位对应仓库，增加对应库存
//			Wareplace wpFull = wareplaceDao.getWithWarehouse(wareplaceTemp.getId());
//			WhProduce whProduce = whProduceDao.getWhProduceByWidAndPid(wpFull.getWarecounter().getWarearea().getWarehouse().getId(), pList.get(i).getId());
//			whProduce.setStockTotal(whProduce.getStockTotal() + num);
//			whProduce.setStockHire(whProduce.getStockHire() + num);
//			whProduce.preUpdate();
//			whProduceDao.update(whProduce);
			
			System.out.println("____新增测试货品[productId："+pList.get(i).getId()+" productName:"+pList.get(i).getName()+" 数量"+num+"]_________________");
			totalNum += num;
		}
		System.out.println("____新增测试货品总数量"+totalNum+"_________________");
		return totalNum;
	}
	
	/**
	 * 重置所有货品的电子码（清空，并依次设置电子码，电子码不足则结束）
	 */
	@Transactional(readOnly = false)
	public int resetProductScanCode(){
		// 清空所有货品的电子码
		addTestDataDao.clearScanCodeForProduct();
		
		// 查询所有货品
		List<Product> productList = productDao.findList(new Product());
		// 查询所有货品电子码
		ScanCode scanCodeParam = new ScanCode();
		scanCodeParam.setType(ScanCode.TYPE_PRODUCT);
		List<ScanCode> scanCodeList = scanCodeDao.findList(scanCodeParam);	
		
		// 设置电子码的货品数量
		int totalReset = 0;
		for(int i=0; i<productList.size(); i++){
			if(i < scanCodeList.size()){
				Product productTemp = productList.get(i);
				productTemp.setScanCode(scanCodeList.get(i).getCode() + "");
				productDao.updateSingle(productTemp);
				totalReset++ ;
			}
		}
		
		return totalReset;
	}
	
	/**
	 * 重置所有货位的电子码（清空，并依次设置电子码，电子码不足则结束）
	 */
	@Transactional(readOnly = false)
	public int resetWareplaceScanCode(){
		// 清空所有货位的电子码
		addTestDataDao.clearScanCodeForWareplace();
		
		// 查询所有货位
		List<Wareplace> wareplaceList = wareplaceDao.findList(new Wareplace());
		// 查询所有货位电子码
		ScanCode scanCodeParam = new ScanCode();
		scanCodeParam.setType(ScanCode.TYPE_WAREPLACE);
		List<ScanCode> scanCodeList = scanCodeDao.findList(scanCodeParam);	
		
		// 设置电子码的货位数量
		int totalReset = 0;
		for(int i=0; i<wareplaceList.size(); i++){
			if(i < scanCodeList.size()){
				Wareplace wareplaceTemp = wareplaceList.get(i);
				wareplaceTemp.setScanCode(scanCodeList.get(i).getCode() + "");
				wareplaceDao.update(wareplaceTemp);
				totalReset++ ;
			}
		}
		
		return totalReset;
	}
}