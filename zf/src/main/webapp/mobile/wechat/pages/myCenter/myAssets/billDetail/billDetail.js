
//账户明细列表滚动区

$(function(){
	$("#noContent").html("您暂时还沒有账户消费记录！")
	//初始化账户明细列表滚动区
	var myScroll=new MyScroll("#billDetailWrapper",{
		isImgCache:true,
		clear:clear,
		loadType:3,
		headerHeight:30,//下拉刷新加载框显示高度
		getParameter:getParameter,
		bottom:$("#bottomLoading"),//配置底部区
		loadUrl:"./bankbookitem/list",
		loadSuccess:nextPage,
		noDataView:$("#noContent")
	})
});

function clear(){
	console.log("--------clear--------")
	var ul=$("#billDetailUl");
	$("#billDetailUl")
	$("li",$("#billDetailUl")).each(function(){
		if($(this).attr("id")!="headerLoading"&&$(this).attr("id")!="bottomLoading")
			$(this).remove();
	})
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
	//此处不需要做状态检测
	//状态检测统一处理
	var ul=$("#billDetailUl");
	var loadingLi=$("#bottomLoading");
	for(var i=0;i<list.length;i++){
		var html="";
		html +="<li>";
		html +=		"<p>"+list[i].time+"</p>";
		html +=		"<h3><span>"+list[i].changeType+"</span><span>￥"+list[i].moneyStr+"<b>("+list[i].moneyType+")</b></span></h3>";
		html +=		"<h4><span>余额</span><span>￥"+list[i].usableBalance+"<b></b></span></h4>";
		html +="</li>";
		loadingLi.before(html);
	}
}