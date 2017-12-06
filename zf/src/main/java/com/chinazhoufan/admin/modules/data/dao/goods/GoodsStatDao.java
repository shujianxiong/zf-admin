package com.chinazhoufan.admin.modules.data.dao.goods;

import java.util.List;

import com.chinazhoufan.admin.common.persistence.BaseDao;
import com.chinazhoufan.admin.common.persistence.annotation.MyBatisDao;
import com.chinazhoufan.admin.modules.data.vo.goods.GoodsStat;

@MyBatisDao
public interface GoodsStatDao extends BaseDao {

	
	public List<GoodsStat> statGoodsCategoryStockPie();
	
}
