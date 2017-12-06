/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.dao.mi;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.chinazhoufan.admin.common.persistence.CrudDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;

/**
 * 会员列表DAO接口
 * @author 贾斌、张金俊
 * @version 2015-10-20
 */
@MyBatisDao
public interface MemberDao extends CrudDao<Member> {
	
	/**
	 * 通过ID查询会员（forUpdate锁表）
	 * @param id 会员ID
	 * @return
	 */
	public Member getForUpdate(String id);
	
	/**
	 * 通过usercode查询会员
	 * @param usercode
	 * @return Member
	 */
	public Member getByUsercode(String usercode);
	
	/**
	 * 通过微信openid查询会员
	 * @param wechatOpenid
	 * @return Member
	 */
	public Member getByWechatOpenid(String wechatOpenid);
	
	public Member getShortInfo(@Param("memberId")String memberId);

	public Member getCompleteInfo(@Param("memberId")String memberId);
	
	/**前台调用方法
	 * 通过userCode和openId查询会员
	 * @param userCode和openId
	 * @return Member
	 */
	public Member getByUserCodeOpenId(Map<String, Object> map);
	
	public Member getByUserCodePassWord(Map<String, Object> map);
	
	/**
	 * 根据时间段获取会员注册数量
	 * @param member
	 * @return
	 */
	public int getRegisterNum(Member mebmer);
	
	
	/**
	 * 按时间段统计每天会员新增量
	 * @param member
	 * @return    设定文件
	 * @throws
	 */
	public List<Member> statNewRegister(Member member);
	
	
	
	/**
	 * 更新会员的wechatOpenid
	 * @param id			要更新的会员的id
	 * @param wechatOpenid	要更新的wechatOpenid
	 */
	public void updateWechatOpenid(@Param("id")String id, @Param("wechatOpenid")String wechatOpenid);
	/**
	 * 清空wechat_openid为wechatOpenid的会员的wechatOpenid属性（清空该wechatOpenid与所有会员的绑定）
	 * @param wechatOpenid		WechatOpenid的更新条件
	 */
	public void updateClearWechatOpenid(String wechatOpenid);
	
	/**
	 * 物理删除会员
	 * @param map
	 */
	public void remove(Map<String, Object> map);
	
	/**
	 * 实名认证审核
	 * @param mebmer    设定文件
	 * @throws
	 */
	public void check(Member mebmer);

	/**
	 * 查询注册未体验会员列表
	 * @param map
	 * @return
	 */
	public List<Member> findNotExperienceList(Map<String, Object> map);

	/**
	 * 查询体验未购买会员列表
	 * @param map
	 * @return
	 */
	public List<Member> findNotBuyList(Map<String, Object> map);

	/**
	 * 查询购买会员列表
	 * @param map
	 * @return
	 */
	public List<Member> findBuyList(Map<String, Object> map);

	/**
	 * 查询注册十天内未下单用户
	 * @param c 
	 * @return
	 */
	public List<Member> findExperienceRemindList();

	
	/**
	 * 查询欠款一天未付的用户
	 * @return
	 */
	public List<Member> findOneDayDebtWarningList();

	/**
	 * 查询欠款七天未付的用户
	 * @return
	 */
	public List<Member> findOneWeekDebtWarningList();
}