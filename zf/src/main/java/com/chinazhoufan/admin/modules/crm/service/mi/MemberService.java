/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.chinazhoufan.admin.modules.crm.service.mi;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.chinazhoufan.admin.common.persistence.Page;
import com.chinazhoufan.admin.common.service.CrudService;
import com.chinazhoufan.admin.common.service.ServiceException;
import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.utils.StringUtils;
import com.chinazhoufan.admin.modules.bas.service.code.CodeGeneratorService;
import com.chinazhoufan.admin.modules.crm.dao.mi.MemberDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.CreditDetail;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.crm.entity.mi.MemberStat;
import com.chinazhoufan.admin.modules.crm.entity.mi.PointDetail;
import com.chinazhoufan.admin.modules.crm.vo.NotifyMemberVO;
import com.chinazhoufan.admin.modules.sys.service.ConfigService;
import com.google.common.collect.Maps;

/**
 * 会员Service
 * @author 贾斌、张金俊
 * @version 2015-10-20
 * PS：	openid代表的是微信openid，即微信系统使用的openid。
 * 		wechatOpenid代表的是当前我们系统存储的，经过加密之后的openid。（2016-06-08 张金俊）
 */
@Service
@Transactional(readOnly = true)
public class MemberService extends CrudService<MemberDao, Member> {

	@Autowired
	private CodeGeneratorService codeGeneratorService;
	@Autowired
	private ConfigService configService;
	@Autowired
	private PointDetailService pointDetailService;
	@Autowired
	private CreditDetailService creditDetailService;

	
	public Member get(String id) {
		return super.get(id);
	}
	
	/**
	 * 通过ID查询会员（forUpdate锁表）
	 * @param id 会员ID
	 * @return
	 */
	public Member getForUpdate(String id) {
		return dao.getForUpdate(id);
	}	
	
	/**
	 * 通过usercode查询会员
	 * @param usercode
	 * @return Member
	 */
	public Member getByUsercode(String usercode) {
		return dao.getByUsercode(usercode);
	}	
	
	/**
	 * 通过微信openid查询会员
	 * @param openid	会员微信Openid
	 * @return Member
	 */
	public Member getByOpenid(String openid) {
		return dao.getByWechatOpenid(openid);
	}
	
	/**
	 * 通过wechatOpenid查询会员（直接通过wechatOpenid与wechat_openid字段进行匹配）
	 * @param wechatOpenid	会员wechatOpenid属性 
	 * @return Member
	 */
	public Member getByWechatOpenid(String wechatOpenid) {
		return dao.getByWechatOpenid(wechatOpenid);
	}
	
	/**
	 * 根据会员ID获取会员信息
	 * @param memberId
	 * @param modeType	根据modeType判断返回数据，1为简短，2为完整
	 * @return
	 */
	public Member getByModeType(String memberId, Integer modeType) {
		if (modeType == 1) {
			return dao.getShortInfo(memberId);
		}else {
			return dao.getCompleteInfo(memberId);
		}
	}
	
	/**前台调用方法
	 * 通过userCode、openId或mobile查询会员（userCodeOpenId与userCode、openId或mobile匹配）
	 * @param userCodeOpenId
	 * @return Member
	 */
	public Member getByUserCodeOpenId(String userCodeOpenId) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("userCodeOpenId", userCodeOpenId);
		return dao.getByUserCodeOpenId(map);
	}
	
	/**
	 * 根据会员账号和密码获取会员
	 * @param userCode
	 * @param passWord
	 * @return
	 */
	public Member getByUserCodePassWord(String userCode,String passWord){
		Map<String, Object> map = Maps.newHashMap();
		map.put("userCode", userCode);
		map.put("passWord", passWord);
		return dao.getByUserCodePassWord(map);
	}
	
	/**
	 * 根据时间段获取会员注册数量
	 * @param member
	 * @return
	 */
	public int getRegisterNum(Member member){
		return dao.getRegisterNum(member);
	}
	
	/**
	 * 按照时间段统计每天的会员新增量
	 * @param member
	 * @return    设定文件
	 * @throws
	 */
	public List<Member> statNewRegisterByTime(Member member) {
		return dao.statNewRegister(member);
	}
	
	/**
	 * 图表绘制按照时间段统计每天的会员新增量数据
	 * @param member
	 * @return    设定文件
	 * @throws
	 */
	public List<MemberStat> drawNewRegister(Member member) {
		List<Member> list = dao.statNewRegister(member);
		List<MemberStat> statList = new ArrayList<MemberStat>(list.size());
		MemberStat stat = null;
		for(Member m : list) {
			stat = new MemberStat();
			stat.x = DateUtils.formatDate(m.getRegisterTime(),"yyyy-MM-dd");
			stat.y = m.getCount();
			statList.add(stat);
		}
		return statList;
	}
	
	public List<Member> findList(Member member) {
		return super.findList(member);
	}
	
	public Page<Member> findPage(Page<Member> page, Member member) {
		return super.findPage(page, member);
	}
	
	@Transactional(readOnly = false)
	public void save(Member member) {
		super.save(member);
	}
	
	/**
	 * 用户注册
	 */
	@Transactional(readOnly = false)
	public void add(Member crmMiMember,String openid) {
		String code = codeGeneratorService.generateCode(Member.GENERATECODE_MEMBERCODE);	// 生成会员编号
		Member member = new Member();
		Member memberOpenId = null;		// 验证微信openId在数据库是否存在
		Member memberUserCode = null;	// 验证手机号是否存在
		if(StringUtils.isNotBlank(openid)){
			// openid存在表示是通过微信端口进入，验证openid在数据库是否存在
			memberOpenId = this.getByOpenid(openid);
		}
		// 这是通过其他入口注册会员的或者是通过微信端注册会员执行下面步骤
		if(StringUtils.isNotBlank(crmMiMember.getUsercode())){
			// userCode如果用户手机号不为空
			memberUserCode = this.getByUserCodeOpenId(crmMiMember.getUsercode());	// 查询用户手机号是否已经注册
			if(memberUserCode != null){	// 验证手机号已经注册的
				if(memberOpenId != null){
					if(!memberUserCode.getId().equals(memberOpenId.getId())){		// 判断手机号和openId是否同时存在，如果同时存在就表示该数据完整的
						memberUserCode.setWechatOpenid(openid);
						super.save(memberUserCode);
						remove(memberOpenId.getId());
					}
				}
				
			}else{//手机号没有注册的
				if(memberOpenId != null){
					member.setWechatOpenid(openid);//微信openId
					remove(memberOpenId.getId());	//删除openid原有的这条记录
				}
				member.setGravatar("mobile/wechat/img/head.png");			// 用户默认头像
				member.setUsercode(crmMiMember.getUsercode());				// 会员账号,用户注册的手机号
				member.setNickname(crmMiMember.getNickname());				// 会员昵称
				member.setPassword(crmMiMember.getPassword());				// 密码
				member.setMobile(crmMiMember.getUsercode());				// 手机号默认为注册账号
				member.setMemberCode(code);									// 会员编号需要系统生成，保证唯一性
				member.setLevel(Member.LEVEL_YJ);							// 需要前台初始系统积分等级
				member.setRegisterPlatform(Member.REGISTERPLATFORM_WEB);	// 注册来源（WEB端）
				member.setMemberStatus(Member.MEMBERSTATUS_ENABLE);			// 会员状态（正常）
				member.setUsercodeStatus(Member.USERCODESTATUS_NORMAL);		// 账号状态（正常）
				member.setBlackwhiteStatus(Member.BLACKWHITESTATUS_NORMAL);	// 黑名单状态（正常）
				member.setRegisterTime(new Date());
				super.save(member);
			}
		}
	}
	
	/**
	 * 用户注册，根据账号（手机号）生成会员信息
	 * @param usercode
	 * @return
	 */
	@Transactional(readOnly = false)
	public Member saveMemberByUsercode(String usercode) {
		Member member = new Member();
		member.setGravatar("mobile/wechat/img/head.png");			// 用户默认头像
		member.setWechatOpenid(null);								// 微信openId
		member.setUsercode(usercode);								// 会员账号
		member.setMemberCode(codeGeneratorService.generateCode(Member.GENERATECODE_MEMBERCODE));	// 会员编号需要系统生成，保证唯一性
		member.setLevel(Member.LEVEL_YJ);							// 需要前台初始系统积分等级
		member.setRegisterPlatform(Member.REGISTERPLATFORM_WC);		// 注册来源（微信端）
		member.setMemberStatus(Member.MEMBERSTATUS_ENABLE);			// 会员状态（正常）
		member.setUsercodeStatus(Member.USERCODESTATUS_NORMAL);		// 账号状态（正常）
		member.setBlackwhiteStatus(Member.BLACKWHITESTATUS_NORMAL);	// 黑名单状态（正常）
		member.setRegisterTime(new Date());
		super.save(member);
		return member;
	}
	
	/**
	 * 变更会员状态（1：启用    2：停用）
	 * @param member
	 */
	@Transactional(readOnly = false)
	public void setMemberStatus(Member member) {
		if (Member.MEMBERSTATUS_ENABLE.equals(member.getMemberStatus())) {
			member.setMemberStatus(Member.MEMBERSTATUS_DISABLE);
		}else if (Member.MEMBERSTATUS_DISABLE.equals(member.getMemberStatus())) {
			member.setMemberStatus(Member.MEMBERSTATUS_ENABLE);
		}else {
			return;
		} 
		member.preUpdate();
		dao.update(member);
	}

	/**
	 * 设置会员账号状态（1：正常    2：冻结    3：限制下单）
	 * @param member
	 * @param status
	 */
	@Transactional(readOnly = false)
	public void setUsercodeStatus(Member member, String status) {
		member.setUsercodeStatus(status);
		save(member);
	}

	/**
	 * 设置会员黑白名单状态（1：正常    2：白名单    3：黑名单    4：风险顾客）
	 * @param member
	 * @param status
	 */
	@Transactional(readOnly = false)
	public void setBlackwhiteStatus(Member member, String status) {
		member.setBlackwhiteStatus(status);
		save(member);
	}
	
	/**
	 * 更新会员的wechatOpenid
	 * 1.清空该wechatOpenid与所有会员的绑定
	 * 2.设置该会员的wechat_openid为wechatOpenid
	 * @param memberId		会员ID
	 * @param wechatOpenid	加密后的微信openid
	 */
	@Transactional(readOnly = false)
	public void updateMemberWechatOpenid(String memberId, String wechatOpenid){
		dao.updateClearWechatOpenid(wechatOpenid);
		dao.updateWechatOpenid(memberId, wechatOpenid);
	}
	
	/**
	 * 会员积分操作通用方法
	 * @param memberId			账户所属会员ID		不能为空
	 * @param changeType		变动类型			不能为空
	 * @param changePoint		变动积分数量		不能为空
	 * @param changeReasonType	变动原因			不能为空
	 * @param operaterType		操作人类型			不能为空
	 * @param operateSourceNo	来源业务编号		可为空
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public void updatePointOperate(final String memberId, final String changeType, final int changePoint, 
			final String changeReasonType, final String operaterType, final String operateSourceNo) 
			throws ServiceException{
		// 更新会员积分
		Member member = this.getForUpdate(memberId);
		if("A".equals(changeType)){
			member.setPoint((member.getPoint()==null ? 0 : member.getPoint()) + changePoint);
		}else if("D".equals(changeType)){
			if(member.getPoint() == null || member.getPoint() < changePoint){
				throw new ServiceException("警告：当前用户账户积分不足");
			}else {
				member.setPoint(member.getPoint() - changePoint);
			}
		}
		this.save(member);
		
		// 插入会员积分流水
		PointDetail pointDetail = new PointDetail();
		pointDetail.setMember(member);
		pointDetail.setChangeType(changeType);
		pointDetail.setChangePoint(changePoint);
		pointDetail.setLastPoint(member.getPoint());
		pointDetail.setChangeReasonType(changeReasonType);
		pointDetail.setChangeTime(new Date());
		pointDetail.setOperaterType(operaterType);
		pointDetail.setOperateSourceNo(operateSourceNo);
		pointDetailService.save(pointDetail);
	}
	
	/**
	 * 会员信誉操作通用方法
	 * @param memberId			账户所属会员ID		不能为空
	 * @param changeType		变动类型			不能为空
	 * @param changeCredit		变动信誉数量		不能为空
	 * @param changeReasonType	变动原因			不能为空
	 * @param operaterType		操作人类型			不能为空
	 * @param operateSourceNo	来源业务编号		可为空
	 * @throws ServiceException
	 */
	@Transactional(readOnly = false)
	public void updateCreditOperate(final String memberId, final String changeType, final int changeCredit, 
			final String changeReasonType, final String operaterType, final String operateSourceNo) 
			throws ServiceException{
		// 更新会员信誉
		Member member = this.getForUpdate(memberId);
		if("A".equals(changeType)){
			member.setCredit((member.getCredit()==null ? 0 : member.getCredit()) + changeCredit);
		}else if("D".equals(changeType)){
			if(member.getCredit() == null || member.getCredit() < changeCredit){
				throw new ServiceException("警告：当前用户账户信誉不足");
			}else {
				member.setCredit(member.getCredit() - changeCredit);
			}
		}
		this.save(member);
		
		// 插入会员信誉流水
		CreditDetail creditDetail = new CreditDetail();
		creditDetail.setMember(member);
		creditDetail.setChangeType(changeType);
		creditDetail.setChangeCredit(changeCredit);
		creditDetail.setLastCredit(member.getCredit());
		creditDetail.setChangeReasonType(changeReasonType);
		creditDetail.setChangeTime(new Date());
		creditDetail.setOperaterType(operaterType);
		creditDetail.setOperateSourceNo(operateSourceNo);
		creditDetailService.save(creditDetail);
	}
	
	/**
	 * 伪删除会员（设置“del_flag=1”）
	 * @param map
	 */
	@Transactional(readOnly = false)
	public void delete(Member member) {
		super.delete(member);
	}
	
	/**
	 * 物理删除会员
	 * @param map
	 */
	@Transactional(readOnly =false)
	public void remove(String id) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", id);
		dao.remove(map);
	}

	public Page<Member> findPage(Page<Member> page, NotifyMemberVO notifyMemberVO) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("DEL_FLAG_NORMAL", Member.DEL_FLAG_NORMAL);
		map.put("page", page);
		map.put("notifyMemberVO", notifyMemberVO);
		if (StringUtils.isNotBlank(notifyMemberVO.getType())) {
			switch (notifyMemberVO.getType()) {
			//注册未交易
			case NotifyMemberVO.TYPE_REGISTER:
				page.setList(dao.findNotExperienceList(map));
				break;
			//体验未购买	
			case NotifyMemberVO.TYPE_EXPERIENCE:
				page.setList(dao.findNotBuyList(map));
				break;
				//体验未购买	
			case NotifyMemberVO.TYPE_BUY:
				page.setList(dao.findBuyList(map));
				break;
			default:
				break;
			}
		}
		return page;
	}
	
	public List<Member> findList(NotifyMemberVO notifyMemberVO) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("DEL_FLAG_NORMAL", Member.DEL_FLAG_NORMAL);
		map.put("notifyMemberVO", notifyMemberVO);
		List<Member> list = null;
		if (StringUtils.isNotBlank(notifyMemberVO.getType())) {
			switch (notifyMemberVO.getType()) {
			//注册未交易
			case NotifyMemberVO.TYPE_REGISTER:
				list = dao.findNotExperienceList(map);
				break;
			//体验未购买	
			case NotifyMemberVO.TYPE_EXPERIENCE:
				list=dao.findNotBuyList(map);
				break;
				//体验未购买	
			case NotifyMemberVO.TYPE_BUY:
				list= dao.findBuyList(map);
				break;
			default:
				break;
			}
		}
		return list;
	}
	
	/**
	 * 查询注册十天内未下单用户
	 * @return
	 */
	public List<Member> findExperienceRemindList(){
		return dao.findExperienceRemindList();
	}

	/**
	 * 查询欠款一天用户
	 * @return
	 */
	public List<Member> findOneDayDebtWarningList() {
		return dao.findOneDayDebtWarningList();
	}
	
	/**
	 * 查询欠款七天用户
	 * @return
	 */
	public List<Member> findOneWeekDebtWarningList() {
		return dao.findOneWeekDebtWarningList();
	}
	
}