
//var hireOrderItemWrapper=null;
var hireOrderScroll=null;
//var buyOrderItemWrapper=null;
var buyOrderScroll=null;
$(function(){
	
	leftTouch.init({
		mainPanel:$("#myOrderList_orderItemWrap"),
		activeClass:"active",
		isActive:true,
		activePanel:$("#myorderListTop"),
		initCallBack:function(){//leftTouch->init初始化完成后回调，默认初始化租赁订单scroll
			//租赁订单scroll
			hireOrderScroll=new MyScroll('#hireOrderWapper',{
				bottom:$("#hireLoading"),
				isImgCache:true,
				loadType:3,
				headerHeight:40,
				getParameter:getHireOrderParameter,
				loadUrl:ctxWeb+"/member/orderList",
				clear:function(){
					$("#myOrderList_hireOrder").children().each(function(){
						if($(this).attr("class")!= "loading"){
							$(this).remove();
						}
					});
				},
				loadSuccess:hireOrdernextPage,
				noDataView:"您当前还没有【租赁订单】!<a href='../index' style='color:red'>前往选购</a>"
			})
		},
		moveCallBack:function(index){
			if(index==0){//租赁订单
				hireOrderScroll.active();
				//销毁购买订单scroll
				if(buyOrderScroll!=null){
					buyOrderScroll.suspend();
				}
			}
			if(index==1){//购买订单 leftTouch->movey移动到购买订单
				if(buyOrderScroll==null){
					buyOrderScroll=new MyScroll('#buyOrderWapper',{
						bottom:$("#buyLoading"),
						isImgCache:true,
						loadType:3,
						headerHeight:40,
						getParameter:getBuyOrderParameter,
						clear:function(){
							$("#myOrderList_buyOrder").children().each(function(){
								if($(this).attr("class")!= "loading"){
									$(this).remove();
								}
							});
						},
						loadUrl:ctxWeb+"/member/orderList",
						loadSuccess:buyOrdernextPage,
						noDataView:"您当前还没有【购买订单】!<a href='../index' style='color:red'>前往选购</a>"
					})
				}else{
					buyOrderScroll.active();
				}
				if(hireOrderScroll!=null){
					hireOrderScroll.suspend();
				}
			}
		}
	})
	
	$("#hireOrder").on("click",function(){
		leftTouch.move(0);
//    	$("#noContent").hide();
	});
    $("#buyOrder").on("click",function(){
    	leftTouch.move(1);
//    	$("#noContent").hide();
	});
});

/**
 * 租赁订单nextPage加载函数
 * @param {Object} list
 */
function hireOrdernextPage(list){
	var ul=$("#myOrderList_hireOrder");
	var bottom=$("#hireLoading");
	for (var i=0; i<list.length; i++) {
		var hireOrder = list[i];
		var hireProduceList = hireOrder.hireOrderProduceList;
		//首先拼接公共部分html
		var li=$("<li></li>")
		html="<div class=type><p>租赁</p><h3>"+hireOrderStatusTransfer(hireOrder.orderMemStatus)+"</h3></div>";
		html+="<div class='orderCondent' onclick=\"goToDetail('2','"+hireOrder.id+"','"+hireOrder.orderMemStatus+"')\">";
		for(var j=0;j<hireProduceList.length;j++){
			var hireProduce=hireProduceList[j];
			//console.log(hireProduce);
			html+="<div class=orderItem >";
			html+="<div class=img><img data-type='lazyImg' data-height='false' data-size='sameWidthHeight' src="+hireProduce.produce.goods.displayIcon+"/></div>";
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
		if(hireOrder.orderMemStatus == 1){//代付款
			html+="<span data-type='blackTab'>联系客服</span>";
			html+="<span data-type='blackTab'>取消订单</span>";
			html+="<span data-type='blackTab'>重新下单</span>";
			html+="<span class='pay'data-type='blackTab'>付款</span>";
		}else if(hireOrder.orderMemStatus == 2){//待收货
			html+="<span data-type='blackTab'>查看物流</span>";
			html+="<span data-type='blackTab'>确认收货</span>";
		}else if(hireOrder.orderMemStatus == 3){//租赁中
			html+="<span data-type='blackTab'>退租</span>";
			html+="<span data-type='blackTab'>申请售后</span>";
			html+="<span data-type='blackTab'>请评价</span>";
			html+="<span data-type='blackTab'>换货</span>";
		}else if(hireOrder.orderMemStatus == 4){//交易结束
			html+="<span data-type='blackTab'>查看物流</span>";
			html+="<span data-type='blackTab'>删除订单</span>";
		}else if(hireOrder.orederMemberStatus == 5){//交易关闭
			html+="<span data-type='blackTab'>删除订单</span>";
		}
		html+="</div>"
		li.html(html);
		bottom.before(li);
	}
	/**
	 * 设置图片固定高
	 */
	$("img[data-size=sameWidthHeight]").each(function(){
		$(this).height($(this).width())
	});
	//执行点击效果
	effectUtils.iButtonClick();
	effectUtils.liClick();
	effectUtils.divClick();
	effectUtils.spanClick();
}

/**
 * 购买订单nextPage加载函数
 * @param {Object} list
 */
function buyOrdernextPage(list){
	var ul=$("#myOrderList_buyOrder");
	var bottom=$("#buyLoading");
	var li;
	for(var i = 0; i<list.length; i++){
		var buyOrder = list[i];
		var buyProduceList = buyOrder.buyOrderProduceList;
		li=$("<li></li>");//绑定详情跳转函数
		//首先拼接公共部分html
		html ="<div class='type'><p>购买</p><h3>"+buyOrderStatusTransfer(buyOrder.orderMemStatus)+"</h3></div>";
		html+="<div class='orderCondent' onclick=\"goToDetail('1','"+buyOrder.id+"','"+buyOrder.orderMemStatus+"')\">";
		//购买产品逐个拼接html
		for (var j = 0; j<buyProduceList.length; j++) {
			var buyProduce = buyProduceList[j];
			html+="<div class='orderItem' data-type='blackTab'>";
			html+="<div class='img'><img data-type='lazyImg' data-height='false' data-size='sameWidthHeight' src="+buyProduce.produce.goods.displayIcon+"/></div>";
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
		if(buyOrder.orderMemStatus == 1){//代付款
			html+="<span data-type='blackTab'>联系客服</span>";
			html+="<span data-type='blackTab'>取消订单</span>";
			html+="<span data-type='blackTab'>重新下单</span>";
			html+="<span class='pay'>付款</span>";
		}else if(buyOrder.orderMemStatus == 2){//待收货
			html+="<span data-type='blackTab'>查看物流</span>";
			html+="<span data-type='blackTab'>确认收货</span>";
		}else if(buyOrder.orderMemStatus == 3){//交易成功
			html+="<span data-type='blackTab'>查看物流</span>";
			html+="<span data-type='blackTab'>请评价</span>";
		}else if(buyOrder.orderMemStatus == 4){//交易结束
			html+="<span data-type='blackTab'>查看物流</span>";
			html+="<span data-type='blackTab'>删除订单</span>";
		}else if(buyOrder.orederMemberStatus == 5){//交易关闭
			html+="<span data-type='blackTab'>删除订单</span>";
		}
		html+="</div>";
		li.html(html);
		bottom.before(li);
	};
	/**
	 * 设置图片固定高
	 */
	$("img[data-size=sameWidthHeight]").each(function(){
		$(this).height($(this).width())
	});
	//执行点击效果
	effectUtils.iButtonClick();
	effectUtils.liClick();
	effectUtils.divClick();
	effectUtils.spanClick();
}

/**
 * 获取参数方法
 */
function getHireOrderParameter(){
	var orderMemStatus=$("#orderMemStatus").val();
	//type：查询类型‘1’购买，‘2’租赁，orderMemStatus：订单状态，orderType：订单类型：‘11’，租赁
	var param="{\"type\":\"2\",\"orderMemStatus\":\""+orderMemStatus+"\",\"orderType\":\"11\"}";
	var obj=$.parseJSON(param);
	return obj
}

/**
 * 获取参数方法
 */
function getBuyOrderParameter(){
	var orderMemStatus=$("#orderMemStatus").val();
	//type：查询类型‘1’购买，‘2’租赁，orderMemStatus：订单状态，orderType：订单类型：‘21’，购买
	var param="{\"type\":\"1\",\"orderMemStatus\":\""+orderMemStatus+"\",\"orderType\":\"21\"}";
	var obj=$.parseJSON(param);
	return obj
}

/**
 * 租赁订单状态字典转换
 * @param {Object} value
 */
function hireOrderStatusTransfer(value){
	if(value == 1){
		return "等待付款";
	}else if(value == 2){
		return "买家已付款"
	}else if(value == 3){
		return "正在租赁"
	}else if(value == 4){
		return "交易结束"
	}else if(value == 5){
		return "交易关闭"
	}
}

/**
 * 购买订单状态字典转换
 * @param {Object} value
 */
function buyOrderStatusTransfer(value){
	if(value == 1){
		return "等待付款";
	}else if(value == 2){
		return "买家已付款"
	}else if(value == 3){
		return "交易成功，请评价"
	}else if(value == 4){
		return "交易结束"
	}else if(value == 5){
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
		window.location.href = ctxWeb+"/member/waitingPayDetail?type="+type+"&id="+id; //待支付
	}else if(orderMemStatus == 2){
		window.location.href = ctxWeb+"/member/waitingReceiveDetail?type="+type+"&id="+id; //待收货
	}else if(orderMemStatus == 3 || orderMemStatus == 4) {
		window.location.href = ctxWeb+"/member/waitingCommentDetail?type="+type+"&id="+id; //待评价或已评价
	}else{
		
	}
}
