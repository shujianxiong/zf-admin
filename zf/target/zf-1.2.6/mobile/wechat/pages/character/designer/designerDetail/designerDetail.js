var goodsScroll = null;
var goodsType = $("#goodsType").val();

$(function(){
		//设置图片区域尺寸
	$("span","#fansArea").each(function(){
		$(this).height($(this).width())
	});
	
	$(".headArea").css("min-height",$(window).width()*0.64);
	$(".headPic").height($(".headPic").width());
	
	
	$("li[data-type='nav']").each(function(){
		if($(this).attr("data-val") == $("#goodsType").val()){
			$(this).attr("class","active");
		}
	})
	
	$("li[data-item=allGoods]").on("click",function(){
		var designerId = $("#designerId").val();
		window.location.href=ctxWeb+"/designer/detail?designerId="+designerId+"&goodsType=1";
		
	});
    $("li[data-item=hotGoods]").on("click",function(){
		var designerId = $("#designerId").val();
		window.location.href=ctxWeb+"/designer/detail?designerId="+designerId+"&goodsType=2";
	});
	
	$("li[data-item=foreGoods]").on("click",function(){
		var designerId = $("#designerId").val();
		window.location.href=ctxWeb+"/designer/detail?designerId="+designerId+"&goodsType=3";
	});
	
	var noDataString = "";
	if(goodsType == '3'){
		noDataString = "当前设计师暂无新款预定作品";
	}else if(goodsType == '2'){
		noDataString = "当前设计师暂无热门作品";
	}else{
		noDataString = "当前设计师暂无作品";
	}
	
	
	
	goodsScroll=new MyScroll('#designerWarp',{
		bottom:$("#bottomLoading"),
		isImgCache:true,
		isPage:true,
		loadType:1,
		headerHeight:45,
		getParameter:getParameter,
		clear:function(){
			$("#allDesignerWorks").html("");
		},
		loadUrl:ctxWeb+"/designer/goodsList",
		loadSuccess:nextPage,
		noDataView:noDataString
	});
	
	var designerWorksViewTop=$("#designerWorksView").offset().top;
	goodsScroll.scroll.on("scroll",function(){
		if(-this.y>=designerWorksViewTop){
			$("#topSelectView").show()
		}else{
			$("#topSelectView").hide()
		}

	})
	
});

function getParameter(){
	var designerId = $("#designerId").val();
	//goodsType：查询类型‘1’全部，‘2’热门，‘3’预定
	var param="{\"goodsType\":\""+goodsType+"\",\"designerId\":\""+designerId+"\"}";
	var obj=$.parseJSON(param);
	return obj
}

function nextPage(list){
	for (var i=0;i<list.length;i++) {
		var goods = list[i];
		var html="<li  onclick=window.location.href='"+ctxWeb+"/goodsInfo/simple/"+goods.id+"'><div class='li_subWarp'><div class='buyMode'>";
		if(goods.isBuyable=="1"){
			html+="<span class='saleAble'>可售</span>";
		}
		html+="</div>";
		html+="<img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+goods.icon+"'/>";
		html+="<div class='price'>";
		html+="<h3>"+goods.name+"</h3>";
		html+="<h2><p>RMB&nbsp;"+goods.price+"</p>";
		if(goods.isBuyable=="1"){
			html+="<b>已售"+goods.sellNum+"</b>";
		}
		html+="</h2></div></div></li>";
		$("#bottomLoading").before(html);
	}
	//初始化商品列表图片高度
	$("img[data-height=false]",$("#designerWorksPanel")).each(function(){
		$(this).height($(this).width()*0.85)
		$(this).attr("data-height","true")
	})
	
}


/**
 * 关注
 * @param id
 */
function designerFocus(id){
	ajax.submit("post",ctxWeb+"/member/designer/focus",{"designerId":id},function(data){
		if(data.status=="1"){
			var obj=$("#attentionIcon");
			var numObj=$("#fansNum");
			var val=parseInt(numObj.text());
			if(obj.attr("data-key")=="1"){
				obj.attr("data-key","0");
				$("#attentionIcon").html("<i class='iconfont'>&#xe624;</i>关注</span>")
				//数量减少
				val--;
			}else{
				obj.attr("data-key","1");
				$("#attentionIcon").html("<i class='iconfont'>&#xe606;</i>已关注</span>")
				//数量增加
				val++;
			}
			numObj.text(val)
		}
	})
}