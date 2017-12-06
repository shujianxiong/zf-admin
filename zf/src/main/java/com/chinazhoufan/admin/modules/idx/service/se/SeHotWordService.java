/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.idx.service.se;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.idx.entity.se.SeHotWord;
import com.chinazhoufan.admin.modules.idx.dao.se.SeHotWordDao;

/**
 * 搜索热词Service
 * @author liut
 * @version 2016-11-09
 */
@Service
@Transactional(readOnly = true)
public class SeHotWordService extends CrudService<SeHotWordDao, SeHotWord> {

	public SeHotWord get(String id) {
		return super.get(id);
	}
	
	public List<SeHotWord> findList(SeHotWord seHotWord) {
		return super.findList(seHotWord);
	}
	
	public Page<SeHotWord> findPage(Page<SeHotWord> page, SeHotWord seHotWord) {
		return super.findPage(page, seHotWord);
	}
	
	@Transactional(readOnly = false)
	public void save(SeHotWord seHotWord) {
		super.save(seHotWord);
	}
	
	@Transactional(readOnly = false)
	public void delete(SeHotWord seHotWord) {
		super.delete(seHotWord);
	}
	
}