package com.chinazhoufan.mobile.index.modules.index.utils;

import com.chinazhoufan.admin.common.utils.CacheUtils;
import com.chinazhoufan.admin.modules.sys.utils.ConfigUtils;
import com.chinazhoufan.mobile.index.modules.index.vo.Index;

/**
 * 首页缓存 
 * @author 杨晓辉、张金俊
 * @version 2015-12-30
 */
public class IndexCacheUtil {
	
	public static final String CACHE_INDEX = "index_Cache";
	public static final int BIGCAST_FAN_LIMIT = 4;		// 时尚大咖周范儿点赞会员图标显示数量
	public static final int MINICAST_FAN_LIMIT = 4;		// 小咖秀点赞会员图标显示数量
	
	
	/**
	 * 获取首页对象
	 * @return Index
	 */
	public static Index getIndex(){
		Index index = (Index)CacheUtils.get(CACHE_INDEX);
		// 如果缓存首页数据为空，或缓存首页数据不为空但系统业务参数设置中设置缓存不启用，则通过数据库查询首页数据并更新至缓存
		if(index==null || (index!=null && "0".equals(ConfigUtils.getConfig("indexCacheUsableFlag").getConfigValue()))){
			index = getIndexFromDB();
			CacheUtils.put(CACHE_INDEX, index);
		}
		return index;
	}
	
	/**
	 * 更新缓存
	 */
	public static void updateIndex(){
		CacheUtils.remove(CACHE_INDEX);
		Index index = getIndexFromDB();
		CacheUtils.put(CACHE_INDEX, index);
	}
	
	/**
	 * 从数据库实时查询首页展示数据
	 * @return Index
	 */
	public static Index getIndexFromDB(){
		Index index = new Index();
		
		return index;
	}
}
