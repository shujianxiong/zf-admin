
var scroll=null;
var bannerscroll=null;
$(function(){
	//设置顶部轮播宽高
	$("#viewport").height($(window).width()*0.5);
	$(".slide",$("#scroller")).each(function(){
		$(this).width($(window).width())
	})
	$("#scroller").width($(".slide",$("#scroller")).length*$(window).width())
	//惊声尖叫宽高
	$("li",$("#screamBlock")).each(function(){
		$(this).height($(window).width()*0.33333);
	})
	//设置底部宽
	$("span",$(".index_content_show_content_bottom")).each(function(){
		$(this).height($(this).width());
		$(this).css("lineHeight",$(this).width()+ 'px')
	})
	//生活场景
	$(".fashion_sub2_mainPic").height($(this).width()/2);
	//时尚导师
	$(".fashionTeacher_designer").height($(this).width()/2);
	$(".fashionTeacher_model").height($(this).width()/2);
	$("span",$(".fashionTeacher_match")).each(function(){
		$(this).height($(this).width()*1.166);
	})
	//预租
	$(".prepare_product_main").height($(this).width()*0.43);
	$("li",$(".prepare_product_sub")).each(function(){
		$(this).height($(this).width());
	})
	//大小咖
	$("span",$(".index_content_show_content_pic")).each(function(){
		$(this).height($(this).width());
	})
	$("span",$(".show_content_top_pic")).each(function(){
		$(this).height($(this).width());
	})
	/*var myScroll=new MyScroll("#warpper",{
		getParameter:getParameter,
		bottom:$("#bottomLoading"),//配置底部区
		loadUrl:"./defaultRecommendGoods",
		loadSuccess:nextPage,
		isImgCache:true,
		loadType:1
	})*/
	//页面悬浮按钮控制器
	//new SuspendBtn(myScroll.scroll,"index");
	//启用图片延迟加载
	//$("img[data-type=lazyImg]").unveil();
	
	//商品描述配置图片配置延迟加载
	scroll=new WindowScroll($(window),{
		getParameter:getParameter,
		bottom:$("#bottomLoading"),//配置底部区
		loadUrl:"./defaultRecommendGoods",
		loadSuccess:nextPage,
		isImgCache:true,
		loadType:1
	});
	$("img[data-type=lazyImg]").lazyload({effect : "fadeIn"});
	
	scroll.on("upScroll",function(obj){
		if($("#header").attr("data-val")=="1"){
			$("#header").attr("data-val","0");
			$("#header").fadeIn(400);
		}
	});
	scroll.on("downScroll",function(){
		$("#header").animate({'opacity':0},100)
	});
	scroll.on("upScroll",function(){
		$("#header").animate({'opacity':1},100)
	})
	
	bannerscroll = new IScroll('#bannerWrapper', {
		click:true,
		probeType: 3,
		scrollX: true,
		scrollY: false,
		momentum: false,
		snap: true,
		snapSpeed: 400,
		indicators: {
			el: document.getElementById('indicator'),
			resize: false
		}
	});
	bannerscroll.on("scrollStart",bannerOnScrollStart)
	bannerscroll.on("scrollEnd",bannerOnScrollEnd)
	bannerTimer=setInterval("bannerScroll()",bannerTime)
})

/**
 * 首页图片轮播
 */
var bannerPage=0;//轮播页序号
var bannerTimer=null;
var bannerTime=5000;
function bannerScroll(){
	bannerPage++;
	if(bannerPage<0)
		bannerPage=0;
	if(bannerPage>3)
		bannerPage=0
	bannerscroll.goToPage(bannerPage, 0, 300)
}

function bannerOnScrollStart(){
	window.clearInterval(bannerTimer);
	bannerTimer=null;
}

function bannerOnScrollEnd(){
	if(bannerTimer==null){
		if(this.directionX<0&&bannerPage>0){
			bannerPage--
		}
		if(this.directionX>=0&&bannerPage<3){
			bannerPage++;
		}
		bannerscroll.goToPage(bannerPage, 0, 300)
		bannerTimer=setInterval("bannerScroll()",bannerTime)
	}	
}

function getParameter(){
	return {"pageSize":10};
}

function nextPage(data){
	var div=$("#guessYouLikeList");
	var bottom=$("#bottomLoading");
	for(var i=0;i<data.length;i++){
		var html="";
		html+="<div  class='goods_list_item'>";
		html+="<img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-original='"+data[i].displayIcon+"' onclick=\"window.location.href='"+ctxWeb+"/goodsInfo/simple/"+data[i].id+"';\" />";
		html+="<span>RMB "+data[i].displayPrice+"</span>";
		html+="</div>";
		bottom.before(html)
	}
	//初始化商品列表图片高度
	$("img[data-height=false]",$("#guessYouLikeList")).each(function(){
		$(this).height($(this).width()*0.85)
		$(this).attr("data-height","true")
	})
}

/**
 * 点击跳转到商品搜索页面
 * @param str
 */
function searchKey(str){
	$("#searchKey").val(str);
	document.searchForm.submit();
}

function gotoSearch(){
	
}