package com.chinazhoufan.admin.modules.data.service.member;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinazhoufan.admin.common.service.BaseService;
import com.chinazhoufan.admin.modules.crm.entity.mi.Member;
import com.chinazhoufan.admin.modules.data.dao.member.MemberStatDao;
import com.chinazhoufan.admin.modules.data.vo.member.MemberRegStat;

@Service
@Transactional(readOnly = false)
public class MemberStatService extends BaseService {

	@Autowired
	private MemberStatDao memberStatDao;
	
	public List<MemberRegStat> statMemberRegisterBar() {
		Calendar cal = Calendar.getInstance();
		Date to = cal.getTime();
		cal.add(Calendar.MONTH, -5);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		Date from = cal.getTime();
		
		Member m = new Member();
		m.setBeginRegisterTime(from);
		m.setEndRegisterTime(to);
		return memberStatDao.statMemberRegisterBar(m);
	};
}
