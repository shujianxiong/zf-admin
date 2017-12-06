var allReversedOrderScroll=null;
var waittingPayEarnestScroll=null;
var waittingReceivingScroll=null;
var waittingPayFinalScroll=null;

var type=$("#type").val(); //“1”预购，“2”预租

var statusIndex = 0;

$(function(){
	$(".img","#myOrderList_orderItemWrap").each(function(){
		$(this).height($(this).width())
	})
	
	var noDataViewString = "";
	if(type == 1){
		noDataViewString = "您当前还没有【预购订单】!<a href='../index' style='color:red'>前往选购</a>";
	}else{
		noDataViewString = "您当前还没有【预租订单】!<a href='../index' style='color:red'>前往选购</a>";
	}
	
	leftTouch.init({
		mainPanel:$("#myOrderList_orderItemWrap"),
		activeClass:"active",
		isActive:true,
		activePanel:$("#myorderListTop"),
		initCallBack:function(){//leftTouch->init初始化完成后回调，默认初始化租赁订单scroll
			allReversedOrderScroll=new MyScroll('#allReversedOrderWrapper',{
				bottom:$("#allLoading"),
				isImgCache:true,
				loadType:3,
				headerHeight:54,
				getParameter:allReversedOrderGetParameter,
				loadUrl:ctxWeb+"/member/orderList",
				clear:function(){
						$("#allReversedOrderUl").children().each(function(){
							if($(this).attr("class")!= "loading"){
								$(this).remove();
							}
						});
				},
				loadSuccess:nextPage,
				noDataView:noDataViewString
			})
		},
		moveCallBack:function(index){
			console.log(index)
			if(index==0){//全部订单
				statusIndex = index;
				allReversedOrderScroll.active();
				//暂停代付定金scroll
				if(waittingPayEarnestScroll!=null){
					waittingPayEarnestScroll.suspend();
				}
				//销毁等待到货scroll
				if(waittingReceivingScroll!=null){
					waittingReceivingScroll.suspend();
				}
				//销毁代付尾款scroll
				if(waittingReceivingScroll!=null){
					waittingReceivingScroll.suspend();
				}
			}
			else if(index==1){//待付定金
				statusIndex = index;
				if(waittingPayEarnestScroll==null){//从未创建代付定金scroll
					waittingPayEarnestScroll=new MyScroll('#waittingPayEarnestWrapper',{
						bottom:$("#waittingPayEarnestLoading"),
						isImgCache:true,
						loadType:3,
						headerHeight:54,
						getParameter:waittingPayEarnestGetParameter,
						loadUrl:ctxWeb+"/member/orderList",
						clear:function(){
							$("#waittingPayEarnestUl").children().each(function(){
								if($(this).attr("class")!= "loading"){
									$(this).remove();
								}
							});
						},
						loadSuccess:nextPage,
						noDataView:"您当前还没有【待付定金订单】!<a href='../index' style='color:red'>前往选购</a>"
					})
				}else {
					waittingPayEarnestScroll.active();
				}
				//销毁全部、等待到货、代付尾款订单scroll
				if(allReversedOrderScroll != null){
					allReversedOrderScroll.suspend();
				}
				if(waittingReceivingScroll != null){
					waittingReceivingScroll.suspend();
				}
				if(waittingPayFinalScroll != null){
					waittingPayFinalScroll.suspend();
				}
			}
			else if(index == 2){//等待到货
				statusIndex = index;
				if(waittingReceivingScroll==null){//从未创建等待到货scroll
					waittingReceivingScroll=new MyScroll('#waittingReceivingWrapper',{
						bottom:$("#waittingReceivingLoading"),
						isImgCache:true,
						loadType:3,
						headerHeight:54,
						getParameter:waittingReceivingGetParameter,
						loadUrl:ctxWeb+"/member/orderList",
						clear:function(){
							$("#waittingReceivingUl").children().each(function(){
								if($(this).attr("class")!= "loading"){
									$(this).remove();
								}
							});
						},
						loadSuccess:nextPage,
						noDataView:"您当前还没有【等待到货订单】!<a href='../index' style='color:red'>前往选购</a>"
					})
				}else {
					waittingReceivingScroll.active();
				}
				//销毁全部、待付定金、待付尾款订单scroll
				if(allReversedOrderScroll != null){
					allReversedOrderScroll.suspend();
				}
				if(waittingPayEarnestScroll != null){
					waittingPayEarnestScroll.suspend();
				}
				if(waittingPayFinalScroll != null){
					waittingPayFinalScroll.suspend();
				}
				
			}
			else if(index == 3){//待付尾款
				statusIndex = index;
				if(waittingPayFinalScroll==null){//从未创建代付尾款scroll
					waittingPayFinalScroll=new MyScroll('#waittingPayFinalWrapper',{
						bottom:$("#waittingPayFinalLoading"),
						isImgCache:true,
						loadType:3,
						headerHeight:54,
						getParameter:waittingPayFinalGetParameter,
						loadUrl:ctxWeb+"/member/orderList",
						clear:function(){
							$("#waittingPayFinalUl").children().each(function(){
								if($(this).attr("class")!= "loading"){
									$(this).remove();
								}
							});
						},
						loadSuccess:nextPage,
						noDataView:"您当前还没有【待付尾款订单】!<a href='../index' style='color:red'>前往选购</a>"
					})
				}else {
					waittingPayFinalScroll.active();
				}
				//销毁全部、待付定金、等待到货订单scroll
				if(allReversedOrderScroll != null){
					allReversedOrderScroll.suspend();
				}
				if(waittingPayEarnestScroll != null){
					waittingPayEarnestScroll.suspend();
				}
				if(waittingReceivingScroll != null){
					waittingReceivingScroll.suspend();
				}
				
			}
		}
	})
	
	$("#allOrder").on("click",function(){
		leftTouch.move(0);
	});
    $("#waittingPayEarnest").on("click",function(){
    	leftTouch.move(1);
	});
	$("#waittingReceiving").on("click",function(){
    	leftTouch.move(2);
	});
	$("#waittingPayFinal").on("click",function(){
    	leftTouch.move(3);
	});
	console.log(allReversedOrderScroll)
});



function nextPage(list){
	var ul;
	var bottom;
    if(statusIndex == 1){
		ul = $("#waittingPayEarnestUl");
		bottom=$("#waittingPayEarnestLoading");
	}else if(statusIndex == 2){
		ul = $("#waittingReceivingUl");
		bottom=$("#waittingReceivingLoading");
	}else if(statusIndex == 3){
		ul = $("#waittingPayFinalUl");
		bottom=$("#waittingPayFinalLoading");
	}else{
		ul = $("#allReversedOrderUl");
		bottom=$("#allLoading");
	}
	//购买
	if(type == "1"){
		var li="";
		for(var i = 0; i<list.length; i++){
			var buyOrder = list[i];
			var buyProduceList = buyOrder.buyOrderProduceList;
			li=$("<li></li>");
			//首先拼接公共部分html
			html ="<div class='type'><p>购买</p><h3>"+buyOrderStatusTransfer(buyOrder.orderMemStatus)+"</h3></div>";
			html+="<div class='orderCondent' onclick=\"goToDetail('1','"+buyOrder.id+"','"+buyOrder.orderMemStatus+"')\">";
			//购买产品逐个拼接html
			for (var j = 0; j<buyProduceList.length; j++) {
				var buyProduce = buyProduceList[j];
				html+="<div class='orderItem'>";
				html+="<div class='img'><img data-type='lazyImg' data-height='false' src="+buyProduce.produce.goods.displayIcon+"/></div>";
				html+="<div class='text' >";
				html+="<h2>"+buyProduce.goodsDisplayTitle+"</h2>";
				html+="<p>"+buyProduce.produceName+"<b>X"+buyProduce.num+"</b></p>";
				html+="<div class='price'>";
				html+="<h2>购买价:<span>"+buyProduce.priceBuy+"</span></h2>";
				html+="</div>";
				html+="</div>";
				html+="</div>";
			}
			//再拼接公共部分
			html+="</div>";
			html+="<div class='totalNum'>";
			html+="<p>";
			html+="<span>共"+buyOrder.buyOrderProduceNum+"件商品</span>";
			html+="<span>合计：</span>";
			html+="<b>￥"+buyOrder.moneyPayable+"</b>";
			html+="<span>（含运费）</span>";
			html+="</p>";
			html+="</div>";
			html+="<div class='orderButton'>";
			//根据订单状态判断显示按钮
			if(buyOrder.orderMemStatus == 1){//待付定金
				html+="<span >联系客服</span>";
				html+="<span >取消订单</span>";
				html+="<span class='pay'>支付定金</span>";
			}else if(buyOrder.orderMemStatus == 2){//等待到货
				html+="<span >联系客服</span>";
			}else if(buyOrder.orderMemStatus == 3){//待付尾款
				html+="<span >联系客服</span>";
				html+="<span >支付尾款</span>";
			}else{//交易结束
				html+="<span >删除订单</span>";
			}
			html+="</div>";
			li.html(html);
			bottom.before(li);
		}
	}else{
		//租赁
		for (var i=0; i<list.length; i++) {
			var hireOrder = list[i];
			var hireProduceList = hireOrder.hireOrderProduceList;
			//首先拼接公共部分html
			var li=$("<li></li>")
			html="<div class=type><p>租赁</p><h3>"+hireOrderStatusTransfer(hireOrder.orderMemStatus)+"</h3></div>";
			html+="<div class='orderCondent'  onclick=\"goToDetail('2','"+hireOrder.id+"','"+hireOrder.orderMemStatus+"')\">";
			for(var j=0;j<hireProduceList.length;j++){
				var hireProduce=hireProduceList[j];
				html+="<div class=orderItem>";
				html+="<div class=img><img data-type='lazyImg' data-height='false' src="+hireProduce.produce.goods.displayIcon+"/></div>";
				html+="<div class=text >";
				html+="<h2>"+hireProduce.goodsDisplayTitle+"</h2>";
				html+="<p>"+hireProduce.produceName+"<b>X"+hireProduce.num+"</b></p>";
				html+="<div class=price>";
				html+="</div>";
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
			//根据订单状态（会员）判断显示按钮
			if(hireOrder.orderMemStatus == 1){//待付定金
				html+="<span >联系客服</span>";
				html+="<span >取消订单</span>";
				html+="<span class='pay'>支付定金</span>";
			}else if(hireOrder.orderMemStatus == 2){//等待到货
				html+="<span >联系客服</span>";
			}else if(hireOrder.orderMemStatus == 3){//待付尾款
				html+="<span >联系客服</span>";
				html+="<span >支付尾款</span>";
			}else{//交易结束
				html+="<span >删除订单</span>";
			}
			html+="</div>"
			li.html(html);
			bottom.before(li);
		}
	}
}

function allReversedOrderGetParameter(){
	var orderType = "";
	if(type == 1){
		orderType = "22"; //预购
	}else{
		orderType = "12"; //预租
	}
	//type：查询类型‘1’购买，‘2’租赁，orderMemStatus：订单状态，orderType：订单类型
	var param="{\"type\":\""+type+"\",\"orderType\":\""+orderType+"\"}";
	var obj=$.parseJSON(param);
	return obj
}

function waittingPayEarnestGetParameter(){
	var orderType = "";
	if(type == 1){
		orderType = "22"; //预购
	}else{
		orderType = "12"; //预租
	}
	//type：查询类型‘1’购买，‘2’租赁，orderMemStatus：订单状态，orderType：订单类型
	var param="{\"type\":\""+type+"\",\"orderMemStatus\":\"1\",\"orderType\":\""+orderType+"\"}";
	var obj=$.parseJSON(param);
	return obj
}

function waittingReceivingGetParameter(){
	var orderType = "";
	if(type == 1){
		orderType = "22"; //预购
	}else{
		orderType = "12"; //预租
	}
	//type：查询类型‘1’购买，‘2’租赁，orderMemStatus：订单状态，orderType：订单类型
	var param="{\"type\":\""+type+"\",\"orderMemStatus\":\"2\",\"orderType\":\""+orderType+"\"}";
	var obj=$.parseJSON(param);
	return obj
}

function waittingPayFinalGetParameter(){
	var orderType = "";
	if(type == 1){
		orderType = "22"; //预购
	}else{
		orderType = "12"; //预租
	}
	//type：查询类型‘1’购买，‘2’租赁，orderMemStatus：订单状态，orderType：订单类型
	var param="{\"type\":\""+type+"\",\"orderMemStatus\":\"3\",\"orderType\":\""+orderType+"\"}";
	var obj=$.parseJSON(param);
	return obj
}

/**
 * 租赁订单状态字典转换
 * @param {Object} value
 */
function hireOrderStatusTransfer(value){
	if(value == 1){
		return "等待支付定金";
	}else if(value == 2){
		return "已付定金，等待到货"
	}else if(value == 3){
		return "等待支付尾款"
	}else {
		return "交易关闭"
	}
}

/**
 * 购买订单状态字典转换
 * @param {Object} value
 */
function buyOrderStatusTransfer(value){
	if(value == 1){
		return "等待支付定金";
	}else if(value == 2){
		return "已付定金，等待到货"
	}else if(value == 3){
		return "等待支付尾款"
	}else {
		return "交易关闭"
	}
}


/**
 * 根据订单状态跳转不同页面
 * @param {Object} type
 * @param {Object} id
 * @param {Object} orderMemStatus
 */
function goToDetail(type, id, orderMemStatus){
	if(orderMemStatus == 1){
		window.location.href = ctxWeb+"/member/reservedWaitEarnestOrderDetail?type="+type+"&id="+id;
	}else if(orderMemStatus == 2){
		
	}else {
		window.location.href = ctxWeb+"/member/reservedWaitFinalOrderDetail?type="+type+"&id="+id;
	}
}