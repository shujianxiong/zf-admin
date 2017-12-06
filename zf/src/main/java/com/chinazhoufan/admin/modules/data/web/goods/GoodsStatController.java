package com.chinazhoufan.admin.modules.data.web.goods;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.chinazhoufan.admin.common.mapper.JsonMapper;
import com.chinazhoufan.admin.common.web.BaseController;
import com.chinazhoufan.admin.modules.data.service.goods.GoodsStatService;
import com.chinazhoufan.admin.modules.data.vo.goods.GoodsStat;

public class GoodsStatController extends BaseController {
	
	
	@Autowired
	private GoodsStatService goodsStatService;
	
	
	/**
	 * 饼状图名称修改为：货品分类库存占比
	 * 查询所有商品的库存量并根据分类做分组，形成数组数据，绘制饼图
	 * @return
	 */
	@RequestMapping(value = "statGoodsCategoryStockPie")
	@ResponseBody
	public String statGoodsCategoryStockPie(HttpServletRequest request, HttpServletResponse response) {
		List<GoodsStat> list = goodsStatService.statGoodsCategoryStockPie();
		return JsonMapper.toJsonString(list);
	}
	
	
	
}
