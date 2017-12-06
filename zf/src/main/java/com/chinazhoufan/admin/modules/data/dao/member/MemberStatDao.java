package com.chinazhoufan.admin.modules.data.dao.member;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.BaseDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.data.vo.member.MemberRegStat;

@MyBatisDao
public interface MemberStatDao extends BaseDao {

	
	public List<MemberRegStat> statMemberRegisterBar(Member m);
	
	
}
