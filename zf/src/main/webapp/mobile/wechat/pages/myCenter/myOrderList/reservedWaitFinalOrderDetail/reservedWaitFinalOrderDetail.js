
$(function(){
	//猜你喜欢配置
	recommendGoods.init({
		getParameter:recommendGetParameter,
		nextPage:recommendNextPage,
		nextButton:$("#recommendBtn"),
		clear:recommendClear,
		loadUrl:ctxWeb+"/defaultRecommendGoods"
	});
	
	//发ajax请求订单详情数据
	
	var id = $("#id").val();
	var type = $("#type").val();
	var param = {"type":type,"id":id};
	ajax.submit(
    	'POST',
        ctxWeb+'/member/orderDetail',
        param,
        function(data){
            if(data.status == Constants.SUCCESS){
	        	loadData(type,data.data);
            }
        }
    );
	
	
})

function loadData(type, data){
	if(type == 1){//购买订单
		var orderDetailVo = data;
		var buyOrder = orderDetailVo.buyOrder;
		var html = "";
		html += "<div class='WaitFinal_topText'><h2>等待支付尾款</h2>";
		html += "<p>已付定金<span>￥"+buyOrder.moneyPayableFront+"</span></p>";
		html += "<p>订单编号<b>"+buyOrder.id+"</b></p>";
		html += "<p>创建时间<b>"+buyOrder.createTime+"</b></p>";
		html += "</div>";
		html += "<div class='WaitFinal_button'>";
		html += "<div id='' class='button'>";
		html += "<div><span id='' class='pay available'>去付款</span></div>";			
		html += "</div>";
		html += "</div>";
		//产品部分循环拼接html
		for(var i=0; i<buyOrder.buyOrderProduceList.length; i++){
			var buyOrderProduce = buyOrder.buyOrderProduceList[i];
			html += "<div class='WaitFinal_cont'>";
			html += "<div class='order_type'>购买</div>";
			html += "<div class='order_main'>";
			html += "<div class='img'>";
			html += "<img src="+buyOrderProduce.produce.goods.displayIcon+"/>";
			html += "</div>";
			html += "<div class='order_right'>";
			html += "<h2>"+buyOrderProduce.goodsDisplayTitle+"</h2>";
			html += "<p>"+buyOrderProduce.produceName+"</p>";
			html += "<h3>会员价<span>￥"+buyOrderProduce.priceBuy+"</span><b>￥"+buyOrderProduce.produce.goods.displayPrice+"</b><i>X "+buyOrderProduce.num+"</i></h3>";
			html += "</div>";
			html += "</div>";
		}
		html += "<div class='total'>";
		html += "<p><span>共"+buyOrder.buyOrderProduceNum+"件商品</span>合计:<i>￥"+buyOrder.moneyPayable+"</i></p>";
		html += "</div>";
		html += "</div>";
		html += "<div class='WaitFinal_leaveWords'>";
		html += "<h2>买家留言</h2>";
		html += "<p>"+buyOrder.message+"</p>";
		html += "</div>";
		html += "<div class='totalNum'>";
		html += "<div>";
		html += "<p>根据预定规则，您需要先支付20%商品定金，尽情谅解</p>";
		html += "<p>商品金额<span>￥"+buyOrder.moneyPayable+"</span></p>";
		html += "<p>已支付<span>￥"+buyOrder.moneyPayableFront+"</span></p>";
		html += "</div>";
		var needPay = Number(buyOrder.moneyPayable)- Number(buyOrder.moneyPayableFront); //待支付尾款
		html += "<h3>需支付：<span>￥"+needPay+"</span></h3>"
		html += "</div>";
		
		$(".contactService").before(html);
	}else{
		//租赁订单
		var orderDetailVo = data;
		var hireOrder = orderDetailVo.hireOrder;
		var html = "";
		html += "<div class='WaitFinal_topText'><h2>等待支付尾款</h2>";
		html += "<p>已付定金<span>￥"+hireOrder.moneyPayableFront+"</span></p>";
		html += "<p>订单编号<b>"+hireOrder.id+"</b></p>";
		html += "<p>创建时间<b>"+hireOrder.createTime+"</b></p>";
		html += "</div>";
		html += "<div class='WaitFinal_button'>";
		html += "<div id='' class='button'>";
		html += "<div><span id='' class='pay available'>去付款</span></div>"	;		
		html += "</div>";
		html += "</div>";
		//产品部分循环拼接html
		for(var i=0; i<hireOrder.hireOrderProduceList.length; i++){
			var hireOrderProduce = hireOrder.hireOrderProduceList[i];
			html += "<div class='WaitFinal_cont'>";
			html += "<div class='order_type'>租赁</div>";
			html += "<div class='order_main'>";
			html += "<div class='img'>";
			html += "<img src="+hireOrderProduce.produce.goods.displayIcon+"/>";
			html += "</div>";
			html += "<div class='order_right'>";
			html += "<h2>"+hireOrderProduce.goodsDisplayTitle+"</h2>";
			html += "<p>"+hireOrderProduce.produceName+"</p>";
			html += "<h3>会员价<span>￥"+hireOrderProduce.produce.buyPrice+"</span><b>￥"+hireOrderProduce.produce.goods.displayPrice+"</b><i>X "+hireOrderProduce.num+"</i></h3>";
			html += "<h3>租赁押金<span>￥"+hireOrderProduce.priceDeposit+"</span></h3>";
			html += "</div>";
			html += "</div>";
		}
		html += "<div class='total'>";
		html += "<p><span>共"+hireOrder.hireOrderProduceNum+"件商品</span>合计:<i>￥"+hireOrder.moneyPayable+"</i></p>";
		html += "</div>";
		html += "</div>";
		html += "<div class='WaitFinal_leaveWords'>";
		html += "<h2>买家留言</h2>";
		html += "<p>"+hireOrder.message+"</p>";
		html += "</div>";
		html += "<div class='totalNum'>";
		html += "<div>";
		html += "<p>根据预定规则，您需要先支付20%商品定金，尽情谅解</p>";
		html += "<p>商品金额<span>￥"+hireOrder.moneyPayable+"</span></p>";
		html += "<p>已支付<span>￥"+hireOrder.moneyPayableFront+"</span></p>";
		html += "</div>";
		var needPay = Number(hireOrder.moneyPayable)- Number(hireOrder.moneyPayableFront);
		html += "<h3>需支付：<span>￥"+needPay+"</span></h3>"
		html += "</div>";
		
		$(".contactService").before(html);
	}
}

function recommendGetParameter(){
	return {pageSize:6,serviceType:""}
}

function recommendClear(){
	$("#recommendList").html("");
}

function recommendNextPage(data){
	var ul=$("#recommendList");
	var html="";
	for(var i=0;i<data.length;i++){
		html+="<li><img data-type='"+i+"' data-height='false' src='"+data[i].displayIcon+"' onclick=\"window.location.href='"+ctxWeb+"/goodsInfo/simple/"+data[i].id+"';\" />";
		html+=		"<div>"+data[i].displayTitle+"</div>";
		html+=			"<p>会员价<b>￥"+data[i].displayPrice+"</b></p>";
		html+="</li>";
	}
	ul.html(html);
	//初始化商品列表图片高度
	$("img[data-height=false]",$("#recommendList")).each(function(){
		$(this).height($(this).width())
		$(this).attr("data-height","true")
	})
}