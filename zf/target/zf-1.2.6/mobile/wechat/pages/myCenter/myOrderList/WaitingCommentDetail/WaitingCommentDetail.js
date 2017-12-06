
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
		html += "<div class='waitingPay_topText'><h2>卖家已发货</h2>";
		html += "<p>订单编号<b>"+buyOrder.id+"</b></p>";
		html += "<p>创建时间<b>"+buyOrder.createTime+"</b></p>";
		html += "<p>付款时间<b>"+buyOrder.createTime+"</b></p>";
		html += "<p>发货时间<b>"+buyOrder.createTime+"</b></p>";
		html += "<p>收货时间<b>"+buyOrder.createTime+"</b></p>";
		html += "</div>";
		html += "<div class='waitingPay_button'>";
		//未评价订单显示评价按钮
		if(buyOrder.orderMemStatus == 3){
			html +=	"<span id='' class='pay'>评价</span>";
		}
		html += "<div id='' class='button'>";
		html += "<div><span id='' class='cancel'>申请售后</span></div>";			
		html += "<div><span id='' class='restart'>查看物流</span></div>"	;		
		html += "</div>";
		html += "</div>";
		html += "<div class='deliverStatus'>";
		html += "<div class='title'>";
		html += "<p>物流状态</p>";
		html += "</div>";
		html += "<div class='status'>";
		html += "<p>【拱墅区】您的快递已飞奔在路上</p>";
		html += "<p>发货时间<b>2016-01-08 13:52</b></p>";
		html += "</div>";
		html += "<i class='iconfont'>&#xe626;</i>";
		html += "</div>";
		html += "<div class='waitingPay_address'>";
		html += "<div class='name'>";
		html += "<span>"+buyOrder.receiveName+"</span>";
		html += "<span>"+buyOrder.receiveTel+"</span>";
		html += "</div>";
		html += "<div class='address'>";
		html += "<i class='iconfont'>&#xe618;</i>";
		html += "<p>"+buyOrder.receiveAreaStr+buyOrder.receiveAreaDetail+"</p>";
		html += "</div>";
		html += "</div>";
		html += "<div class='waitingPay_leaveWords'>";
		html += "<h2>买家留言</h2>";
		html += "<p>"+buyOrder.message+"</p>";
		html += "</div>";
		//产品部分循环拼接html
		for(var i=0; i<buyOrder.buyOrderProduceList.length; i++){
			var buyOrderProduce = buyOrder.buyOrderProduceList[i];
			html += "<div class='waitingPay_cont'>";
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
		html += "<div class='delivery'>";
		html += "<div class='isDelivery'>"
		html += "<span class='check-text'>"+receiveTypeTransfer(buyOrder.receiveType)+"</span>";
		html += "</div>";
		html += "<div class='time'>";
		html += "<p>送货时间<span>"+(buyOrder.expectDate).substr(0,10)+"</span></p>";
		html += "</div>";
		html += "<div class='picUpAddress'>";
		html += "<p>查看提货地址</p>";
		html += "<i class='iconfont'>&#xe626;</i>";
		html += "</div>";
		html += "</div>";
		html += "<div class='discount'><div class='loan'><p>银行贷款申请<span>季度险</span></p></div></div>";
		html += "<div class='totalNum'><div>";
		html += "<p>商品购买金额<span>￥"+buyOrder.moneyPayable+"</span></p>";
		html += "<p>跑腿费<span>￥"+buyOrder.moneyLogistics+"</span></p>";
		html += "<p>优惠券<span>-￥100</span></p>";
		html += "</div>";
		html += "<h3>应付：<span>￥"+buyOrder.moneyPayable+"</span></h3>";
		html += "</div>";
		
		$(".contactService").before(html);
	}else{
		//租赁订单
		var orderDetailVo = data;
		var hireOrder = orderDetailVo.hireOrder;
		var html = "";
		html += "<div class='waitingPay_topText'><h2>交易成功</h2>";
		html += "<p>订单编号<b>"+hireOrder.id+"</b></p>";
		html += "<p>创建时间<b>"+hireOrder.createTime+"</b></p>";
		html += "<p>付款时间<b>"+hireOrder.createTime+"</b></p>";
		html += "<p>发货时间<b>"+hireOrder.createTime+"</b></p>";
		html += "<p>收货时间<b>"+hireOrder.createTime+"</b></p>";
		html += "</div>";
		html += "<div class='waitingPay_button'>";
		html +=	"<span id='' class='pay'>评价</span>";
		html += "<div id='' class='button'>";
		html += "<div><span id='' class='cancel'>申请售后</span></div>";			
		html += "<div><span id='' class='restart'>查看物流</span></div>"	;		
		html += "</div>";
		html += "</div>";
		html += "<div class='deliverStatus'>";
		html += "<div class='title'>";
		html += "<p>物流状态</p>";
		html += "</div>";
		html += "<div class='status'>";
		html += "<p>【拱墅区】您的快递已飞奔在路上</p>";
		html += "<p>发货时间<b>2016-01-08 13:52</b></p>";
		html += "</div>";
		html += "<i class='iconfont'>&#xe626;</i>";
		html += "</div>";
		html += "<div class='waitingPay_address'>";
		html += "<div class='name'>";
		html += "<span>"+hireOrder.receiveName+"</span>";
		html += "<span>"+hireOrder.receiveTel+"</span>";
		html += "</div>";
		html += "<div class='address'>";
		html += "<i class='iconfont'>&#xe618;</i>";
		html += "<p>"+hireOrder.receiveAreaStr+hireOrder.receiveAreaDetail+"</p>";
		html += "</div>";
		html += "</div>";
		html += "<div class='waitingPay_leaveWords'>";
		html += "<h2>买家留言</h2>";
		html += "<p>"+hireOrder.message+"</p>";
		html += "</div>";
		//产品部分循环拼接html
		for(var i=0; i<hireOrder.hireOrderProduceList.length; i++){
			var hireOrderProduce = hireOrder.hireOrderProduceList[i];
			html += "<div class='waitingPay_cont'>";
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
			html += "<div class='rentSelect'>";
			html += "<p>租赁方案<span>"+hireOrderProduce.hirePlan.priceTitle+"</span></p>";
			html += "</div>";
			if(hireOrderProduce.hireInsurance != null && hireOrderProduce.hireInsurance != undefined){
				html += "<div class='insurance'>";
				html += "<p>保险<span>"+hireOrderProduce.hireInsurance.title+"</span></p>";
				html += "</div>";
			}
		}
		html += "<div class='total'>";
		html += "<p><span>共"+hireOrder.hireOrderProduceNum+"件商品</span>合计:<i>￥"+hireOrder.moneyPayable+"</i></p>";
		html += "</div>";
		html += "</div>";
		html += "<div class='delivery'>";
		html += "<div class='isDelivery'>"
		html += "<span class='check-text'>"+receiveTypeTransfer(hireOrder.receiveType)+"</span>";
		html += "</div>";
		html += "<div class='time'>";
		html += "<p>送货时间<span>"+(hireOrder.expectDate).substr(0,10)+"</span></p>";
		html += "</div>";
		html += "<div class='picUpAddress'>";
		html += "<p>查看提货地址</p>";
		html += "<i class='iconfont'>&#xe626;</i>";
		html += "</div>";
		html += "</div>";
		html += "<div class='discount'><div class='loan'><p>银行贷款申请<span>季度险</span></p></div></div>";
		html += "<div class='totalNum'><div>";
		html += "<p>商品租赁押金<span>￥"+hireOrder.moneyDeposit+"</span></p>";
		html += "<p>商品租赁租金<span>￥"+hireOrder.moneyHire+"</span></p>";
		html += "<p>跑腿费<span>￥"+hireOrder.moneyLogistics+"</span></p>";
		html += "<p>优惠券<span>-￥100</span></p>";
		html += "</div>";
		html += "<h3>应付：<span>￥"+hireOrder.moneyPayable+"</span></h3>";
		html += "</div>";
		
		$(".contactService").before(html);
	}
}

function receiveTypeTransfer(value){
	if(value == 1){
		return "上门送货"
	}else{
		return "到店取货";
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