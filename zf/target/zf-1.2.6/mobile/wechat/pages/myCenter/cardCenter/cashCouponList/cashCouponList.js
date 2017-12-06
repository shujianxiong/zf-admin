
//账户明细列表滚动区
var billDetailWrapper = null;

$(function(){
	
	var myScroll = new MyScroll("#couponItemWrapper",{
		isRefresh:true,
		isImgCache:false,
		isPage:false,
		clear:clear,
		headerHeight:0,
		getParameter:getParameter,
		loadUrl:"./couponsitem/list",
		loadSuccess:loadData,
		loadType:2,
		noDataView:$("#noContent")
	});
});

function clear(){
	var ul=$("#content");
	ul.html("");
}

function getParameter(){
	var param="{}";
	var obj=$.parseJSON(param);
	return obj
}

function loadData(list){
	var content = $("#content");
	console.log(list);
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
		html+=			"<span>本现金券适用于"+list[i].scope+"商品</span>";
		html+=		"</div>";
		html+="</div>";
		content.append(html);
	}
}