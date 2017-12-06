
//账户明细列表滚动区
var billDetailWrapper = null;

$(function(){
	//初始化账户明细列表滚动区
	billDetailWrapper=new IScroll('#couponItemWrapper',{
		click:true, //是否响应click事件
		probeType: 3,
		scrollbars: true,//滚动条可见
        fadeScrollbars: true,//滚动条渐隐
        useTransform: true,//CSS转化
        useTransition: true,//CSS过渡
	});
	
	myScroll.init({
		scroll:billDetailWrapper,
		isBottomLoad:false,
		isRefresh:true,
		isImgCache:false,
		isPage:false,
		clear:clear,
		headerLoadingHeight:30,
		getParameter:getParameter,
		loadUrl:"./couponsitem/list",
		loadSuccess:nextPage
	});
	
});

function clear(){
	var content=$("#content");
	content.html("");
}

function getParameter(){
	var param="{}";
	var obj=$.parseJSON(param);
	return obj
}
/**
 * 下一页渲染
 */
function nextPage(list){
	var content=$("#content");
	if(list == null){
		content.html("<br><br><p>暂无记录</p>");
		return;
	}
	//此处不需要做状态检测
	//状态检测统一处理
	
	for(var i=0;i<list.length;i++){
		
		var outClass ="coupon_item";
		var outStr = "";
		if(list[i].useFlag == '2'){
			outClass = 'coupon_item past';
			outStr = "已过期";
		}
		var html="";
		html+="<div class='"+outClass+"'>";
		html+=		"<div class='itemLeft'>";
		html+=			"<p>"+list[i].moneyShow+"</p>";
		html+=			"<span>"+outStr+"</span>";
		html+=		"</div>";
		html+=		"<div class='itemRight'>";
		html+=			"<h2>"+list[i].name+"</h2>";
		html+=			"<h3>满 "+list[i].minOrderAmount+" 使用</h3>";
		html+=			"<p>使用期限 "+list[i].startTime+"-"+list[i].endTime+"</p>";
		html+=			"<span>本现优惠券适用于"+list[i].scope+"商品</span>";
		html+=		"</div>";
		html+="</div>";
		content.append(html);
	}
}