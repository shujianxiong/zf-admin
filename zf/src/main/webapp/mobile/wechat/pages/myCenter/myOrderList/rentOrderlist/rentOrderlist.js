var hireOrderScroll = null;

$(function(){
	
	//租赁订单scroll
	hireOrderScroll=new MyScroll('#hireOrderWrapper',{
		bottom:$("#hireLoading"),//底部加载区
		isImgCache:true, //图片延迟加载
		loadType:3, //顶部+底部刷新
		headerHeight:30, //头部高度
		getParameter:getParameter,
		clear:function(){//清除函数
		$("#myOrderList_hireOrder").children().each(function(){
				if($(this).attr("class") != "loading"){
					$(this).remove();
				}
			});
		},
		loadUrl:ctxWeb+"/member/orderList",//请求URL
		loadSuccess:nextPage,
		noDataView:$("#noContent")
	})
	
});

function getParameter(){
	var param="{\"type\":\"2\",\"orderMemStatus\":\"3\",\"orderType\":\"11\"}";//只查租赁中订单
	var obj=$.parseJSON(param);
	return obj
}

function nextPage(list){
	var ul=$("#myOrderList_hireOrder");
	var bottom=$("#hireLoading");
	for (var i=0; i<list.length; i++) {
		var hireOrder = list[i];
		var hireProduceList = hireOrder.hireOrderProduceList;
		//首先拼接公共部分html
		var li=$("<li></li>")
		html="<div class=type><p>租赁</p><h3>正在租赁</h3></div>";
		html+="<div class=orderCondent>";
		for(var j=0;j<hireProduceList.length;j++){
			var hireProduce=hireProduceList[j];
			console.log(hireProduce);
			html+="<div class=orderItem>";
			html+="<div class=img><img data-type='lazyImg' data-height='false' src="+hireProduce.produce.goods.displayIcon+"/></div>";
			html+="<div class=text >";
			html+="<h2>"+hireProduce.goodsDisplayTitle+"</h2>";
			html+="<p>"+hireProduce.produceName+"<b>X"+hireProduce.num+"</b></p>";
			html+="<div class=price>";
			html+="</div>";
			html+="</div>";					
		}
		html+="</div>";
		html+="<div class=totalNum>"
		html+="<p>"
		html+="<span>共"+hireOrder.hireOrderProduceNum+"件商品</span>"
		html+="<span>合计：</span><b>￥"+hireOrder.moneyPayable+"</b>"
		html+="</p>"
		html+="</div>"
		html+="<div class=orderButton>";
		html+="<span >退租</span>";
		html+="<span >申请售后</span>";
		html+="<span >请评价</span>";
		html+="<span >换货</span>";
		html+="</div>"
		li.html(html);
		bottom.before(li);
	}
}
