/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.lgt.service.tn;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.lgt.dao.tn.ExpressNoSegmentDao;
import com.chinazhoufan.admin.modules.lgt.entity.tn.ExpressNoSegment;
import com.google.common.base.Joiner;
import com.google.common.collect.Lists;

/**
 * 快递单号段表Service
 * @author liut
 * @version 2017-05-22
 */
@Service
@Transactional(readOnly = true)
public class ExpressNoSegmentService extends CrudService<ExpressNoSegmentDao, ExpressNoSegment> {

	public ExpressNoSegment get(String id) {
		return super.get(id);
	}
	
	public List<ExpressNoSegment> findList(ExpressNoSegment expressNoSegment) {
		return super.findList(expressNoSegment);
	}
	
	public Page<ExpressNoSegment> findPage(Page<ExpressNoSegment> page, ExpressNoSegment expressNoSegment) {
		return super.findPage(page, expressNoSegment);
	}
	
	public static void main(String[] args) {
		Matcher m = Pattern.compile("^[0-9a-zA-Z]{8,20}$").matcher("GF4阿达4443");
		System.out.println(m.matches());
	}
	
	@Transactional(readOnly = false)
	public void save(ExpressNoSegment expressNoSegment) {
		InputStreamReader isr = null;
		BufferedReader br = null;
		try {
			
			String fileName = expressNoSegment.getFile().getOriginalFilename();
			String suffix = fileName.substring(fileName.lastIndexOf("."), fileName.length());
			if(!".txt".equals(suffix)) {
				throw new ServiceException("失败：目前仅支持txt纯文本类型的数据导入，且格式只有一列，请核查!");
			}
			
			//处理txt文件里面的数据
			isr = new InputStreamReader(expressNoSegment.getFile().getInputStream(), "utf-8");
			br = new BufferedReader(isr);
			
			List<String> newList = Lists.newArrayList();
			List<String> doubleKeyList = Lists.newArrayList();
			String lineTxt = "";
			
            while ((lineTxt = br.readLine()) != null) {
            	Matcher m = Pattern.compile("^[0-9a-zA-Z]{8,20}$").matcher(lineTxt);
            	if(!m.matches()) {
            		throw new ServiceException("失败：文件内容格式不对，请核查!");
            	}
            	if(!newList.contains(lineTxt)) {
            		newList.add(lineTxt);
            	} else {
            		doubleKeyList.add(lineTxt);
            	}
            }
            br.close();
            isr.close();
			
            System.out.println("文档即将要导入的数量："+(newList.size()+doubleKeyList.size()) +",  重复数量："+doubleKeyList.size());
			
            if(doubleKeyList.size() > 0) {
            	throw new ServiceException("失败：文件中的部分快递单号彼此重复，重复的快递单号详情如下：\n"+Joiner.on(",").join(doubleKeyList));
            }
            
            
            List<ExpressNoSegment> existList = dao.findList(new ExpressNoSegment());
            List<String> existNoList = Lists.newArrayList();
            for(ExpressNoSegment e : existList) {
            	existNoList.add(e.getExpressNo());
            }
            //这里先copy，复制一份，如果和数据库里面没有重复，就直接保存，避免因为使用了retainAll，丢失数据
            List<String> copyList = Lists.newArrayList();
            copyList.addAll(newList);
            
            //因为retainAll操作会变更newList的集合长度，故先将原始集合copy一份
            newList.retainAll(existNoList);
            if(newList.size() > 0) {
            	throw new ServiceException("失败：文件导入的部分快递单号与系统存在的单号重复，请确认！ 重复数量："+newList.size());
            }
            
            List<ExpressNoSegment> eList = Lists.newArrayList();
            ExpressNoSegment en = null;
            for(String key : copyList) {
            	en = new ExpressNoSegment();
            	en.setExpressNo(key);
            	en.setStatus(ExpressNoSegment.FALSE_FLAG);//初始导入，默认为未使用
            	en.setExpressCompany(expressNoSegment.getExpressCompany());
            	en.setRemarks(expressNoSegment.getRemarks());
            	en.preInsert();
            	eList.add(en);
            }
			
			dao.batchSaveExpressNoSegment(eList);
			
		} catch (IOException e) {
			throw new ServiceException("文件解析失败，请核查格式是否正确!");
		} 
		
	}
	
	@Transactional(readOnly = false)
	public void delete(ExpressNoSegment expressNoSegment) {
		super.delete(expressNoSegment);
	}
	
	
	 /**
     * 获取两个可使用的快递单号（寄到与寄回）
     * @param expressNoSegment
     * @return
     */
	public List<ExpressNoSegment> findOneExpressNo(ExpressNoSegment expressNoSegment) {
		return dao.findOneExpressNo(expressNoSegment);
	};
	
	
	/**
	 * 根据快递单号和状态更新使用时间
	 * @param expressNoSegment
	 * @return
	 */
	@Transactional(readOnly = false)
	public void updateByExpressNo(ExpressNoSegment expressNoSegment) {
		 dao.updateByExpressNo(expressNoSegment);
	}
	
	
	
	
}