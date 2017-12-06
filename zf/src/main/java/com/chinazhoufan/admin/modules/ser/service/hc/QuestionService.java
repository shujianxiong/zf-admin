/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.ser.service.hc;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.ser.entity.hc.Question;
import com.chinazhoufan.admin.modules.ser.dao.hc.QuestionDao;

/**
 * 帮助中心问题Service
 * @author 张金俊
 * @version 2017-07-31
 */
@Service
@Transactional(readOnly = true)
public class QuestionService extends CrudService<QuestionDao, Question> {

	public Question get(String id) {
		return super.get(id);
	}
	
	public List<Question> findList(Question question) {
		return super.findList(question);
	}
	
	public Page<Question> findPage(Page<Question> page, Question question) {
		return super.findPage(page, question);
	}
	
	@Transactional(readOnly = false)
	public void save(Question question) {
		super.save(question);
	}
	
	@Transactional(readOnly = false)
	public void delete(Question question) {
		super.delete(question);
	}
	
}