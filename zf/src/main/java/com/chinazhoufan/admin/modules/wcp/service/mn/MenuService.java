/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.service.mn;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.chinazhoufan.admin.modules.wcp.entity.ar.ArticleMsg;

/**
 * 微信菜单Service
 * @author 张金俊
 * @version 2016-05-25
 */
@Service
@Transactional(readOnly = true)
public class MenuService {

	public ArticleMsg get(String id) {
		return null;
	}
	
	public List<ArticleMsg> findList(ArticleMsg articleMsg) {
		return null;
	}
	
	public void save(ArticleMsg articleMsg) {
	}
	
	public void delete(ArticleMsg articleMsg) {
	}
	
}