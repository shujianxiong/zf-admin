/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/chinazhoufan/admin">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.wcp.service.ar;

import java.util.Date;
import java.util.List;

import com.chinazhoufan.admin.modules.sys.utils.UserUtils;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.modules.wcp.entity.ar.MsgImg;
import com.chinazhoufan.admin.modules.wcp.dao.ar.MsgImgDao;

import static com.chinazhoufan.admin.common.persistence.BaseEntity.DEL_FLAG_NORMAL;

/**
 * 图文内置图片Service
 * @author 舒剑雄
 * @version 2017-09-20
 */
@Service
@Transactional(readOnly = true)
public class MsgImgService extends CrudService<MsgImgDao, MsgImg> {

	public MsgImg get(String id) {
		return super.get(id);
	}
	
	public List<MsgImg> findList(MsgImg msgImg) {
		return super.findList(msgImg);
	}
	
	public Page<MsgImg> findPage(Page<MsgImg> page, MsgImg msgImg) {
		return super.findPage(page, msgImg);
	}
	
	@Transactional(readOnly = false)
	public void save(MsgImg msgImg) {
		super.save(msgImg);
	}
	
	@Transactional(readOnly = false)
	public void delete(MsgImg msgImg) {
		super.delete(msgImg);
	}
	@Transactional(readOnly = false)
	public void msgImgSave(String fileName,String photoUrl){
		MsgImg msgImg= new MsgImg();
		msgImg.setPhotoUrl(photoUrl);
		msgImg.setPhotoName(fileName);
		msgImg.setCreateBy(UserUtils.getUser());
		msgImg.setCreateDate(new Date());
		msgImg.setUpdateBy(UserUtils.getUser());
		msgImg.setUpdateDate(new Date());
		msgImg.setDelFlag(DEL_FLAG_NORMAL);
		super.save(msgImg);
	}
	
}