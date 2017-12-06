/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.spm.service.ep;

import java.util.*;

import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.ns.Notify;
import com.chinazhoufan.admin.modules.crm.service.mi.MemberService;
import com.chinazhoufan.admin.modules.crm.service.ns.MemberNotifyService;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePackItem;
import com.chinazhoufan.admin.modules.spm.entity.ep.Invitation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.spm.entity.ep.ExperiencePack;
import com.chinazhoufan.admin.modules.spm.dao.ep.ExperiencePackDao;

/**
 * 体验包Service
 * @author 舒剑雄
 * @version 2017-08-30
 */
@Service
@Transactional(readOnly = true)
public class ExperiencePackService extends CrudService<ExperiencePackDao, ExperiencePack> {

	@Autowired
	private ExperiencePackItemService experiencePackItemService;

	@Autowired
	private InvitationService invitationService;

	@Autowired
	private MemberNotifyService memberNotifyService;

	@Autowired
	private MemberService memberService;
	public ExperiencePack get(String id) {
		return super.get(id);
	}
	
	public List<ExperiencePack> findList(ExperiencePack experiencePack) {
		return super.findList(experiencePack);
	}
	
	public Page<ExperiencePack> findPage(Page<ExperiencePack> page, ExperiencePack experiencePack) {
		return super.findPage(page, experiencePack);
	}
	
	@Transactional(readOnly = false)
	public void save(ExperiencePack experiencePack) {
	    if(experiencePack.getId() == null){
            ExperiencePack expPack =dao.getOneByType(experiencePack);
            if(expPack !=null){
                throw new ServiceException("不能新增多条类型为注册的体验包");
            }
        }
		super.save(experiencePack);
	}
	
	@Transactional(readOnly = false)
	public void delete(ExperiencePack experiencePack) {
		super.delete(experiencePack);
	}


}