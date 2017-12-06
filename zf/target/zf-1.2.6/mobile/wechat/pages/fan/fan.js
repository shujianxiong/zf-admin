//筛选条件滚动区
var filtrateScroll=null; 
//列表滚动区
var fanWrapper=null;
//筛选条件集合
var filtrateList=new Array();

$(function(){
	$("#noContent").html("该场景暂无数据,去其它场景看看吧！")
	// 加载完页面后，将页面保存的参数值取到JS中供JS初始化使用
	var sortFlag	= $("#sortFlag").val();		// 排序方式
	var sceneId 	= $("#sceneId").val();		// 场景Id
	var effectId 	= $("#effectId").val();		// 场景效果Id
	var priceType 	= $("#priceType").val();	// 价格类型
	var heightType 	= $("#heightType").val();	// 身高类型
	var bodyType 	= $("#bodyType").val();		// 身材类型
	
	//头部高度
	var headerHeight=95;
	//滑动速度
	var slideTime=300;
	//初始化场景列表滚动区
	var myScroll=new MyScroll("#fanWrapper",{
		isImgCache:true,//启用图片延迟加载
		loadType:1,//加载数据类型:0 不加载 1底部加载 2顶部刷新 3底部加载且顶部刷新 ，整型
		getParameter:getParameter,//传值参数
		bottom:$("#listLoadingLi"),//配置底部区域
		loadUrl:"./fanListApi",
		loadSuccess:nextPage,//请求成功配置数据
		noDataView:$("#noContent")//请求没有数据提示需在function里面配置$("#noContent").html("显示内容")
	})
	//页面悬浮按钮控制器（暂时去除）
//	new SuspendBtn();
	
	// 初始化排序信息、排序选中状态
	var sortText = "综合排序";
	if(sortFlag == 10){
		sortText = "综合排序";
	}else if(sortFlag == 21){
		sortText = "按销量";
	}else if(sortFlag == 30){
		sortText = "价格从低到高";
	}else if(sortFlag == 31){
		sortText = "价格从高到低";
	}else if(sortFlag == 41){
		sortText = "按收藏";
	}else if(sortFlag == 51){
		sortText = "按新品";
	}
	$("#synthesize").html(sortText + "<i class='iconfont'>&#xe625;</i>");
	$("li[data-type=item]",$("#zonghe")).each(function(){
		if($(this).attr("data-val") == sortFlag){
			$(this).addClass("active");
		}
	});	
	// 初始化各筛选按钮、筛选条件集合
	sceneOnClick(sceneId);
	effectOnClick(effectId);
	priceOnClick(priceType);	
	heightOnClick(heightType);		
	bodyOnClick(bodyType);	
	
	//重置综合排序top
	$("#zonghe").offset({top:-($("#zonghe").height()+headerHeight)});
	$("#zonghe").css("display","none");
	//重置筛选条件top
	$("#filtrate").offset({top:-($("#filtrate").height()+headerHeight)});
	$("#filtrate").css("display","none");
	//综合排序滑进滑出
	$("#synthesize").on("click",function(){
		//重置筛选条件top
		$("#filtrate").offset({top:-($("#filtrate").height()+headerHeight)});
		$("#filtrate").css("display","none");
		if($("#zonghe").css("display")=="block"){
			$('#zonghe').animate({'top': -$("#zonghe").height() }, slideTime,function(){
				$("#zonghe").css("display","none");
				$("#synthesize").removeClass();
			});
		}else{
			$("#zonghe").css("display","block");
			$('#zonghe').animate({'top': '95px' }, slideTime);
			$("#synthesize").addClass("current");
			$("#filter").removeClass();
		}
	});
	//综合排序勾选
	$("li[data-type=item]",$("#zonghe")).each(function(){
		$(this).on("click",function(){
			$("li[data-type=item]",$("#zonghe")).each(function(){
				var iButton=$(this);
				iButton.removeClass("active")
			})
			var iButton=$(this);
			iButton.addClass("active");
			//收起综合排序
			$('#zonghe').animate({'top': -$("#zonghe").height() }, slideTime,function(){
				$("#zonghe").css("display","none");
			});
			var html=$($("span",iButton)[0]).text()+"<i class='iconfont'>&#xe625;</i>";
			$("#synthesize").html(html);
			$("#sortFlag").val(iButton.attr("data-val"));
			//请求查询
			document.fanListForm.submit();
		})
 	});
	
	//筛选条件滑进滑出
	$("#filter").on("click",function(){
		//重置综合筛选top
		$("#zonghe").offset({top:-($("#zonghe").height()+headerHeight)});
		$("#zonghe").css("display","none");
		if($("#filtrate").css("display")=="block"){
			$('#filtrate').animate({'top': -$("#filtrate").height() }, slideTime,function(){
				$("#filtrate").css("display","none");
				$("#filter").removeClass();
				filtrateScroll.destroy();
				filtrateScroll=null;
			});
		}else{
			$("#filtrate").css("display","block");
			$("#filter").addClass("current");
			$("#synthesize").removeClass();
			$('#filtrate').animate({'top': '95px' }, slideTime,function(){
				if(filtrateScroll==null){
					//创建筛选条件滑动区
					filtrateScroll=new IScroll("#filtrate",{click:true});
				}
			});
		}
	})
	
	//场景按钮绑定点击功能
	$("span[data-type=scene_span]",$("#filtrate")).on("click",function(){
		sceneOnClick($(this).attr("data-value"));
	})
	//效果按钮绑定点击事件
	$("span[data-type=effect_span]",$("#filtrate")).on("click",function(){
		effectOnClick($(this).attr("data-value"));
	})
	//价格按钮绑定点击事件
	$("span[data-type=price_span]",$("#filtrate")).on("click",function(){
		priceOnClick($(this).attr("data-value"));
	})
	//身高按钮绑定点击事件
	$("span[data-type=height_span]",$("#filtrate")).on("click",function(){
		heightOnClick($(this).attr("data-value"));
	})
	//身材按钮绑定点击事件
	$("span[data-type=body_span]",$("#filtrate")).on("click",function(){
		bodyOnClick($(this).attr("data-value"));
	})
	
	//筛选项重置
	$("#reInput").on("click",function(){
		//所有“场景”按钮去掉选中效果，删掉筛选条件集合中对应元素，重新执行点击
		$("span[data-type=scene_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("scene");
		sceneId = $("#sceneId").val();
		sceneOnClick(sceneId);
		//所有“效果”按钮去掉选中效果，删掉筛选条件集合中对应元素，重新执行点击
		$("span[data-type=effect_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("effect");
		effectId = $("#effectId").val();
		effectOnClick(effectId);
		//所有“价格”按钮去掉选中效果
		$("span[data-type=price_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("price");
		priceType = $("#priceType").val();
		priceOnClick(priceType);
		//所有“身高”按钮去掉选中效果
		$("span[data-type=height_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("height");
		heightType = $("#heightType").val();
		heightOnClick(heightType);
		//所有“身材”按钮去掉选中效果
		$("span[data-type=body_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("body");
		bodyType = $("#bodyType").val();
		bodyOnClick(bodyType);
	});	
	
	//筛选项提交
	$("#confirm").on("click",function(){
		//将js内筛选项集合数据，更新至要提交的表单
		copyFiltrateListToForm();
		//提交表单
		document.fanListForm.submit();
	});
});



//打印筛选集参数
function consoleFiltrateList(){
	var str = "";
	for(var i=0; i<filtrateList.length; i++){
		str += filtrateList[i].paramType;
		str += ":";
		str += filtrateList[i].value;
		str += ".";
	}
	console.log(str);
}

/**
 * 从筛选集删除参数
 * @param typeName 	参数名
 */
function deleteFiltrateList(typeName){
	for(var i=0; i<filtrateList.length; i++){
		if(filtrateList[i].paramType == typeName){
			filtrateList.splice(i,1);
		}
	}
}

/**
 * 添加参数至筛选集
 * @param typeName 	参数名
 * @param val 		参数值
 */
function saveFiltrateList(typeName, val){
	var isExist = false;
	//更新参数
	for(var i=0; i<filtrateList.length; i++){
		if(filtrateList[i].paramType == typeName){
			filtrateList[i].value = val;
			isExist=true;
		}
	}
	//新增参数
	if(!isExist){
		var filtrateObj={
				"paramType"	: typeName,
				"value"		: val
		};
		filtrateList.push(filtrateObj);
	}
}

/**
 * 添加筛选集参数至页面表单
 * 	ps:筛选集参数并非当前页面数据的筛选参数，
 * 	   因为用户可能再筛选界面操作后（即更新了筛选集数据）并未点击“确定”按钮提交数据
 * 	   此时下拉刷新、上拉加载、重新排序都不应该以筛选集参数为查询数据的条件
 */
function copyFiltrateListToForm(){
	$("#sceneId").val("");
	$("#effectId").val("");
	$("#priceType").val("");
	$("#heightType").val("");
	$("#bodyType").val("");
	for(var i=0; i<filtrateList.length; i++){
		if(filtrateList[i].paramType=="scene"){
			$("#sceneId").val(filtrateList[i].value);
		}else if(filtrateList[i].paramType=="effect"){
			$("#effectId").val(filtrateList[i].value);
		}else if(filtrateList[i].paramType=="price"){
			$("#priceType").val(filtrateList[i].value);
		}else if(filtrateList[i].paramType=="height"){
			$("#heightType").val(filtrateList[i].value);
		}else if(filtrateList[i].paramType=="body"){
			$("#bodyType").val(filtrateList[i].value);
		}	
	}
}


/**
 * “场景”按钮点击功能
 * @param sid 场景参数
 * @param eid 效果参数（可空）
 */
function sceneOnClick(sid){
	//当前点击的场景按钮是否已激活
	var sidExist = false;
	for(var i=0; i<filtrateList.length; i++){
		if(filtrateList[i].paramType == "scene"){
			if(filtrateList[i].value == sid){
				sidExist = true;
			}
		}
	}
	if(sidExist){
		//所有“场景”按钮去掉选中效果
		$("span[data-type=scene_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("scene");
		//隐藏所有“效果”按钮，并去掉“效果”按钮选中效果
		$("li[data-type=effect_li]").css("display","none");
		$("span[data-type=effect_span]",$("li[data-type=effect_li]")).removeClass("active");
		deleteFiltrateList("effect");
	}else {
		//所有“场景”按钮去掉选中效果
		$("span[data-type=scene_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("scene");
		//激活“当前场景”选中效果
		$("span[data-type=scene_span]",$("#filtrate")).each(function(){
			if($(this).attr("data-value") == sid){
				$(this).addClass("active");
				saveFiltrateList("scene", sid);
			}
		});
		//隐藏所有“效果”按钮，并去掉“效果”按钮选中效果
		$("li[data-type=effect_li]",$("#filtrate")).each(function(){
			$(this).css("display","none");
			$(this).find("span").removeClass("active");
		});
		deleteFiltrateList("effect");
		//显示当前场景下“效果”按钮
		effectDisplay(sid);
	}
	//点击“场景”之后“效果”区域高度可能产生变化，因此刷新筛选滚动区
	if($("#filtrate").css("display")=="block"){
		filtrateScroll.refresh();		
	}
}

/**
 * 显示某场景下“效果”按钮
 * @param sid 场景Id
 */
function effectDisplay(sid){
	$("li[data-type=effect_li]",$("#filtrate")).each(function(){
		if($(this).attr("data-value") == sid){ 
			$(this).css("display","block");
		}else {
			$(this).css("display","none");
		}
	});
}

/**
 * “效果”按钮点击功能
 * @param eid 效果Id
 */
function effectOnClick(eid){
	//当前点击的“效果”按钮是否已激活
	var eidExist = false;
	for(var i=0; i<filtrateList.length; i++){
		if(filtrateList[i].paramType == "effect"){
			if(filtrateList[i].value == eid){
				eidExist = true;
			}
		}
	}
	if(eidExist){
		//所有“效果”按钮去掉选中效果
		$("span[data-type=effect_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("effect");
	}else {
		//所有“效果”按钮去掉选中效果
		$("span[data-type=effect_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("effect");
		$("span[data-type=effect_span]",$("#filtrate")).each(function(){
			//激活“当前效果”选中效果
			if($(this).attr("data-value") ==eid){
				$(this).addClass("active");
				saveFiltrateList("effect", eid);
			}
		});
	}
}

/**
 * “价格”按钮点击功能
 * @param pType 价格参数
 */
function priceOnClick(pType){
	//当前点击的“价格”按钮是否已激活
	var pTypeExist = false;
	for(var i=0; i<filtrateList.length; i++){
		if(filtrateList[i].paramType == "price"){
			if(filtrateList[i].value == pType){
				pTypeExist = true;
			}
		}
	}
	if(pTypeExist){
		//所有“价格”按钮去掉选中效果
		$("span[data-type=price_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("price");
	}else {
		//所有“价格”按钮去掉选中效果
		$("span[data-type=price_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("price");
		$("span[data-type=price_span]",$("#filtrate")).each(function(){
			//激活“当前价格”选中效果
			if($(this).attr("data-value") ==pType){
				$(this).addClass("active");
				saveFiltrateList("price", pType);
			}
		});
	}
}

/**
 * “身高”按钮点击功能
 * @param hType 身高参数
 */
function heightOnClick(hType){
	//当前点击的“身高”按钮是否已激活
	var hTypeExist = false;
	for(var i=0; i<filtrateList.length; i++){
		if(filtrateList[i].paramType == "height"){
			if(filtrateList[i].value == hType){
				hTypeExist = true;
			}
		}
	}
	if(hTypeExist){
		//所有“身高”按钮去掉选中效果
		$("span[data-type=height_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("height");
	}else {
		//所有“身高”按钮去掉选中效果
		$("span[data-type=height_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("height");
		$("span[data-type=height_span]",$("#filtrate")).each(function(){
			//激活“当前身高”选中效果
			if($(this).attr("data-value") ==hType){
				$(this).addClass("active");
				saveFiltrateList("height", hType);
			}
		});
	}
}

/**
 * “身材”按钮点击功能
 * @param bType 身材参数
 */
function bodyOnClick(bType){
	//当前点击的“身材”按钮是否已激活
	var bTypeExist = false;
	for(var i=0; i<filtrateList.length; i++){
		if(filtrateList[i].paramType == "body"){
			if(filtrateList[i].value == bType){
				bTypeExist = true;
			}
		}
	}
	if(bTypeExist){
		//所有“身材”按钮去掉选中效果
		$("span[data-type=body_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("body");
	}else {
		//所有“身材”按钮去掉选中效果
		$("span[data-type=body_span]",$("#filtrate")).removeClass("active");
		deleteFiltrateList("body");
		$("span[data-type=body_span]",$("#filtrate")).each(function(){
			//激活“当前身材”选中效果
			if($(this).attr("data-value") ==bType){
				$(this).addClass("active");
				saveFiltrateList("body", bType);
			}
		});
	}
}


/**
 * 获取请求参数
 * @returns
 */
function getParameter(){
	var sortFlag	= $("#sortFlag").val();		// 排序方式
	var sceneId 	= $("#sceneId").val();		// 场景Id
	var effectId 	= $("#effectId").val();		// 场景效果Id
	var priceType 	= $("#priceType").val();	// 价格类型
	var heightType 	= $("#heightType").val();	// 身高类型
	var bodyType 	= $("#bodyType").val();		// 身材类型
	
	var param="{\"sortFlag\":\""+sortFlag+"\","
				+"\"sceneId\":\""+sceneId+"\","
				+"\"effectId\":\""+effectId+"\","
				+"\"priceType\":\""+priceType+"\","
				+"\"heightType\":\""+heightType+"\","
				+"\"bodyType\":\""+bodyType+"\"}";
	var obj=$.parseJSON(param);
	console.log(obj);
	return obj;
}

/**
 * 下一页渲染
 */
function nextPage(list){
	/**此处不需要做状态检测 状态检测统一处理*/
	
	var fanListUl = $("#fanListUl");
	var loadingLi = $("#listLoadingLi");

	//空心：<i class="iconfont">&#xe62b;</i>
	//实心：<i class="iconfont">&#xe613;</i>
	//加载数据
	for(var i=0; i<list.length; i++){
		var html = "";
		var currFan = list[i];
		html += "<li class='content_main_match_warp'>";
		html += 	"<div id='' class='content_main_match_pic'>";
		html += 		"<img data-type='lazyImg' data-height='a' src='"+ctxMobile+"/img/cachePic.png' data-src='"+currFan.photoUrl+"'/>";
		html += 		"<span class='likeNum'>";
		html += 			"<i class='iconfont'>&#xe613;</i>";
		html += 			"<b>"+currFan.collectNum+"</b>";
		html += 		"</span>";
		html += 	"</div>";
		html += 	"<ul class='content_main_match_subpic'>";
		html += 		"<li>";
		html += 			"<img data-type='lazyImg' data-height='b' src='"+ctxMobile+"/img/cachePic.png' data-src='"+currFan.subphotoUrl1+"' />";
		html += 		"</li>";
		html += 		"<li>";
		html += 			"<img data-type='lazyImg' data-height='b' src='"+ctxMobile+"/img/cachePic.png' data-src='"+currFan.subphotoUrl2+"' />";
		html += 		"</li>";
		html += 	"</ul>";
		html += "</li>";
		console.log(html)
		loadingLi.before(html);
	}
	//初始化商品列表图片高度
	$("img[data-height=a]",$("#fanWrapper")).each(function(){
		$(this).height($(this).width()*0.48);
		$(this).attr("data-height","");
	})
	$("img[data-height=b]",$("#fanWrapper")).each(function(){
		$(this).height($(this).width()*0.85);
		$(this).attr("data-height","");
	})
}



