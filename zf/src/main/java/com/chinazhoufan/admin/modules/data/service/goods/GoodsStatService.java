package com.chinazhoufan.admin.modules.data.service.goods;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinazhoufan.admin.common.service.BaseService;
import com.chinazhoufan.admin.modules.data.dao.goods.GoodsStatDao;
import com.chinazhoufan.admin.modules.data.vo.goods.GoodsStat;

@Service
public class GoodsStatService extends BaseService {
	
	@Autowired
	private GoodsStatDao goodsStatDao;

	public List<GoodsStat> statGoodsCategoryStockPie() {
		List<GoodsStat> list = goodsStatDao.statGoodsCategoryStockPie();
		String[] colorArr = new String[]{"#FFC125","#836FFF","#5F9EA0","#473C8B","#2E2E2E","#FF0000","#8B1C62","#787878","#008B00","#EE7AE9","#00FF7F","#FF1493","#EED2EE","#EE3A8C","#4169E1","#FFFF00","#E066FF","#CDC1C5","#F5DEB3","#CAFF70","#87CEFA","#191970","#FF83FA","#B4EEB4","#8B2500","#6E8B3D","#556B2F","#FFBBFF","#76EEC6","#CAE1FF"}; 
//		int i = 0;
//		if (list!=null&&!list.isEmpty()) {
//			for(GoodsStat gs : list) {
//				if(i <= colorArr.length-1)  {
//					gs.setColor(colorArr[i]);
//					i++;
//				} else {
//					gs.setColor(getRandomColor());
//				}
//			}
//		}
		
		for (int j = 0; j < list.size(); j++) {
			if (list.get(j) != null) {
				if (j <= colorArr.length - 1) {
					list.get(j).setColor(colorArr[j]);
				}else {
					list.get(j).setColor(getRandomColor());
				}
			}
		}
		return list;
	}
	
	
	public String getRandomColor() {  
        String r,g,b;    
        Random random = new Random();    
        r = Integer.toHexString(random.nextInt(256)).toUpperCase();    
        g = Integer.toHexString(random.nextInt(256)).toUpperCase();    
        b = Integer.toHexString(random.nextInt(256)).toUpperCase();    
            
        r = r.length()==1 ? "0" + r : r ;    
        g = g.length()==1 ? "0" + g : g ;    
        b = b.length()==1 ? "0" + b : b ;    
            
        return "#"+r+g+b;    
   }  
	
}
