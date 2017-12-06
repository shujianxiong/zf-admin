package com.chinazhoufan.mobile.admin.modules.sys.api;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.chinazhoufan.admin.common.utils.DateUtils;
import com.chinazhoufan.admin.common.web.BaseRestController;
import com.chinazhoufan.admin.modules.sys.entity.Dict;
import com.chinazhoufan.admin.modules.sys.service.DictService;
import com.chinazhoufan.api.common.config.Constants;
import com.chinazhoufan.mobile.index.modules.common.vo.Echos;


/**
 *  字典API
 */

@RestController
@RequestMapping(value = "${mobileAdminPath}/user/dict")
public class WapDictApi extends BaseRestController {

	@Autowired
	private DictService dictService;
	
	/**
	 * 根据字典类型获取字典集合
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/listByType",method = RequestMethod.GET)
	public Echos listByType(@RequestParam(name = "type", defaultValue="", required=true)String type) {
		
		System.out.println(">>>>>>>>>>>>>>>>【移动端】请求方法：listByType()	请求时间："+DateUtils.getDateTime());
		
		try {
			if(StringUtils.isBlank(type))
				return new Echos(Constants.PARAMETER_ISNULL);
			Dict dict = new Dict();
			dict.setType(type);
			return new Echos(Constants.SUCCESS, dictService.findList(dict));
		} catch (Exception e) {
			e.printStackTrace();
			return new Echos(Constants.ERROR);
		}
		
	}
}
