$(function(){
	$("#noContent").html("您还没有消息");
	//初始化列表滚动区
    var myScroll=new MyScroll("#messageCenterWrapper",{
		isImgCache:true,
		clear:clear,
		loadType:3,
		headerHeight:30,//下拉刷新加载框显示高度
		getParameter:getParameter,
		bottom:$("#bottomLoading"),//配置底部区
		loadUrl:ctxWeb+"/member/messagelist",
		loadSuccess:nextPage,
		noDataView:$("#noContent")
	})

})


/**
 * 上拉刷新情况数据,重新加载
 **/
function clear(){
	console.log("--------clear--------")
	var div=$("#messageCenterList");
	$("#messageCenterList")
	$("li",$("#messageCenterList")).each(function(){
		if($(this).attr("id")!="headerLoading"&&$(this).attr("id")!="bottomLoading")
			$(this).remove();
	})
}
/**
 * 获取请求参数
 * @returns
 */
function getParameter(){
	var status = $("#status").val();
	console.log("status:"+status);
	var param = {"msgCategory":status};
	return param
}


/**
 * List拼接html
 * @param list
 */
function nextPage(list){
	var ul=$("#messageCenterList");
	var loadingLi=$("#bottomLoading");
	for(var i = 0; i < list.length; i++) {
	        var result = list[i];
	        var html="";
	        html +="<li class='oderItem'>";
	        html += "<h1>"+result.sendTime+"</h1>";
	        html += "<div class='order'>";
	        html += 	"<h3>"+result.title+"</h3>";
	        html += 	"<div>";
	        html +=			"<p>"+result.content+"</p>";
	        html += 	"</div>";
	        html += 	"<h2>阅读全文<i class='iconfont'>&#xe626;</i></h2>";
	        html += "</div>";
	        html +="</li>";
	        loadingLi.before(html);
	}
}