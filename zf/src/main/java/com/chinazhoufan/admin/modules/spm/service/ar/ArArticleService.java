/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ar;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.dao.ar.ArArticleDao;
import com.chinazhoufan.admin.modules.spm.entity.ar.ArArticle;

/**
 * 宣传文章Service
 * @author 张金俊
 * @version 2016-05-19
 */
@Service
@Transactional(readOnly = true)
public class ArArticleService extends CrudService<ArArticleDao, ArArticle> {

	public ArArticle get(String id) {
		return super.get(id);
	}
	
	public List<ArArticle> findList(ArArticle arArticle) {
		return super.findList(arArticle);
	}
	
	public Page<ArArticle> findPage(Page<ArArticle> page, ArArticle arArticle) {
		return super.findPage(page, arArticle);
	}
	
	@Transactional(readOnly = false)
	public void save(ArArticle arArticle) {
		super.save(arArticle);
	}
	
	@Transactional(readOnly = false)
	public void delete(ArArticle arArticle) {
		super.delete(arArticle);
	}
	
}