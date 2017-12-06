package com.chinazhoufan.admin.common.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.DataEntity;
import com.chinazhoufan.admin.modules.bas.dao.BasMissionDao;
import com.chinazhoufan.admin.modules.bas.entity.BasMission;
import com.chinazhoufan.admin.modules.lgt.dao.ps.GoodsDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProduceDao;
import com.chinazhoufan.admin.modules.lgt.dao.ps.ProductDao;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Goods;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Produce;
import com.chinazhoufan.admin.modules.lgt.entity.ps.Product;

/**
 * 条码业务
 * @author 杨晓辉
 *
 * 注：商品，货品，产品编码若编码已存在则递归调用可能会引发无限递归异常
 *  
 */
@Service
@Transactional(readOnly = true)
public class BarCodeService<D extends CrudDao<T>, T extends DataEntity<T>> {
	
	public static final String GOODS_CODE="G1";//商品编码业务标记
	public static final String PRODUCE_CODE="G2";//产品编码业务标记
	public static final String PRODUCT_CODE="G3";//货品编码业务标记
	
	public static final String MMISSION_CODE="M1";//任务编码业务标记
	
	public static final String PO_CODE="P1";//采购编码业务标记
	
	/**
	 * 商品编码
	 * 业务类型(长度2)+年月日(长度6)+商品数(长度5)+补位(1)
	 * @return
	 */
	public synchronized String createGoodsBarCode(Goods goods,GoodsDao goodsDao)throws ServiceException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");  
        String dateNow = sdf.format(new Date()); 
        StringBuffer sb=new StringBuffer();
        sb.append(GOODS_CODE);
        sb.append(dateNow);
        Integer goodsCount = goodsDao.findCount();
        String endStr="0";//补位
        sb.append(numCount(goodsCount,endStr));
        
        //校验编码是否存在
        Goods goodsOld = goodsDao.findByBarCode(sb.toString());
        if(goodsOld!=null)
        	return createGoodsBarCode(goods,goodsDao);    
		return sb.toString();
	}
	
	/**
	 * 产品编码
	 * 业务类型(长度2)+年月日(长度6)+商品数(长度5)+补位(1)
	 * @return
	 */
	public synchronized String createProduceBarCode(Produce produce,ProduceDao produceDao){
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");  
        String dateNow = sdf.format(new Date()); 
        StringBuffer sb=new StringBuffer();
        sb.append(PRODUCE_CODE);
        sb.append(dateNow);
        Integer goodsCount = produceDao.findCount();
        String endStr="0";//补位
        sb.append(numCount(goodsCount,endStr));
        
        //校验编码是否存在
        Produce produceOld = produceDao.findByBarCode(sb.toString());
        if(produceOld!=null)
        	return createProduceBarCode(produce,produceDao);    
		return sb.toString();
	}
	
	/**
	 * 货品编码
	 * 业务类型(长度2)+年月日(长度6)+商品数(长度5)+补位(1)
	 * @return
	 */
	public synchronized String createProductBarCode(Product product,ProductDao productDao){
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");  
        String dateNow = sdf.format(new Date()); 
        StringBuffer sb=new StringBuffer();
        sb.append(PRODUCE_CODE);
        sb.append(dateNow);
        Integer goodsCount = productDao.findCount();
        String endStr="0";//补位
        sb.append(numCount(goodsCount,endStr));
        
        //校验编码是否存在
        Product productOld = productDao.findByBarCode(sb.toString());
        if(productOld!=null)
        	return createProductBarCode(product,productDao);    
		return sb.toString();
	}
	
	/**
	 * 任务编码
	 * 业务类型(长度2)+年月日(长度6)+任务数(长度5)+补位(1)
	 * @return
	 */
	public synchronized String createMmissionBarCode(BasMission basMission,BasMissionDao basMissionDao){
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");  
        String dateNow = sdf.format(new Date()); 
        StringBuffer sb=new StringBuffer();
        sb.append(MMISSION_CODE);
        sb.append(dateNow);
        Integer count = basMissionDao.findCount();
        String endStr="0";//补位
        sb.append(numCount(count,endStr));
        
        //校验编码是否存在
        BasMission b = basMissionDao.findByBarCode(sb.toString());
        if(b!=null)
        	return createMmissionBarCode(basMission,basMissionDao);    
		return sb.toString();
	}
	
	
	/**
	 * 销售单编码
	 * @return
	 */
	public String createSellOrderNo(T t,D d){
		
		return "";
	}
	
	private String numCount(Integer num,String endStr){
		String goodsSize="00000";
		if(num==null)
        	goodsSize="00000";
        else if(num<10)
        	goodsSize="0000"+num;
        else if(num<100)
        	goodsSize="000"+num;
        else if(num<1000)
        	goodsSize="00"+num;
        else if(num<10000)
        	goodsSize="0"+num;
        else if(num<99999)
        	goodsSize=num.toString();
        else if(num>99999&&num<999999)//取消补位
        	endStr="";
        else
        	throw new ServiceException("警告：商品编码商品数量位数已不够用");
		goodsSize=goodsSize+endStr;
		return goodsSize;
	}
}
