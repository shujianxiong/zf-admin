var goodsPhotoListScroll=null;
$(function(){
	$("#noContent").html("该商品暂无评论信息！")
	var windowHeight=document.body.clientHeight;
	//重置标签样式
	var defaultSummaryVal=$("#summaryId").val();
	$("label",$("#pingjiaTag")).each(function(){
		if($(this).attr("data-type-summary")==defaultSummaryVal){
			$(this).addClass("active");
		}else{
			$(this).removeClass("active");
		}
		$(this).on("click",function(){
			var summaryId = $(this).attr("data-type-summary");
			var goodsId = $("#goodsId").val();
			window.location.href=ctxWeb+"/goodsDetailComment/"+goodsId+"/"+summaryId;
		})
	})
	//重置wrapper高度
	var wrapperHeight=$("#pingjiaTag").height()-$("#headerLoading").height()
	$("#myGoodsCommentWrapper").offset({top:wrapperHeight});
	//评论wrapper
	//初始化商品评论滚动区
	 var myScroll=new MyScroll("#myGoodsCommentWrapper",{
		 	isImgCache:true,//启用图片延迟加载
	 		clear:clear,//顶部刷新清空原始数据
	 		loadType:3,//加载数据类型:0 不加载 1底部加载 2顶部刷新 3底部加载且顶部刷新 ，整型
	 		headerHeight:$("#headerLoading").height(),//下拉刷新加载框显示高度,动态获取
			getParameter:getParameter,//传值参数
			bottom:$("#bottomLoading"),//配置底部区
			loadUrl:ctxWeb+"/goods/findGoodsJudge",
			loadSuccess:nextPage,//请求成功配置数据
			noDataView:$("#noContent")//请求没有数据提示需在function里面配置$("#noContent").html("显示内容")
		})
	
	//图册浏览
	$("#bigPicviewport").offset({top:windowHeight});
	
	$("#bigPicviewport").on("click",function(){
		$("#bigPicviewport").animate({top: windowHeight }, 400,function(){
			$("#bigPicviewport").css("display","none");
			goodsPhotoListScroll.destroy();
			goodsPhotoListScroll=null;
		});
	});
	
})



/**
 * 获取请求参数
 * @returns
 */
function getParameter(){
	var summaryId = $("#summaryId").val();
	var goodsId = $("#goodsId").val();
	var param ="{\"goodsId\":\""+goodsId+"\",\"summaryId\":\""+summaryId+"\"}";
	var obj=$.parseJSON(param);
	console.log(obj)
	return obj
}

/**
 * 上拉刷新情况数据,重新加载
 **/
function clear(){
	$("li",$("#goodsCommentList")).each(function(){
		if($(this).attr("id")!="headerLoading"&&$(this).attr("id")!="bottomLoading")
			$(this).remove();
	})
}

/**
 * List拼接html
 * @param list
 */
function nextPage(list){
	var ul=$("#goodsCommentList");
	var loadingLi=$("#bottomLoading");
    for(var i = 0; i < list.length; i++) {
    	var result = list[i];
    	var level = "普通会员";//先用文字代替后期需要修改
    	if(result.member.level == 1){
    		level = "普通会员";
    	}
    	if(result.member.level == 2){
    		level = "黄金会员";
    	}
    	if(result.member.level == 3){
    		level = "钻石会员";
    	}
    	if(result.hideFlag == 1){//匿名
			gravatar = ""+ctxMobile+"/img/head.png";
		}else{
			gravatar = ctx+"/"+result.member.gravatar;
		}
        var html="";
        html +="<li>";
        html +="<div id='' class='content_item'>";
        html +="    <div id='' class='content_item_top'>";
        html +="		<div class='pic'>";
        html +="			<span id=''>";
	    html +="				<img src='"+gravatar+"'/>";
    	html +="			</span>";
	    html +="		</div>";
	    if(result.hideFlag == 1){//匿名
    	html +="		<span class='name'>";
		html +="			<p>匿名评论</p>";
		html +="			<span>"+level+"</span>";
		html +="		</span>";
	    }else{
    	html +="		<span class='name'>";
		html +="			<p>"+result.member.name+"</p>";
		html +="			<span>"+level+"</span>";
		html +="		</span>";
	    }
    	html +="	</div>";
    	html +="	<p class='pingjiaText'>"+result.judgeContent+"</p>";
    	html +="	<p class='pingjiaAttribute'> "+result.judgeTime+"</p>";
    	html +="	<div id='' class='content_pic'>";
    	if(list[i].judgePhotos != null && list[i].judgePhotos.length > 0){
    		for(var j = 0; j < list[i].judgePhotos.length; j++) {
       		 	var photos = list[i].judgePhotos[j];
       		 html +="		<span id=''><img data-key='_"+list[i].id+"' data-type='lazyImg' src='"+ctxMobile+"/img/cachePic.png' data-src='"+photos.photoUrl+"' onclick=\"showPhotos("+j+",'"+list[i].id+"')\" /></span>";
       	 	}
    	}
    	html +="	</div>";
        html +="</div>";
        html +="</li>";
        loadingLi.before(html);
    }
}

//查看图册
var imgMax=0;
function showPhotos(index,id){
	//获得当前列表内所有图片
	var array=$("img[data-key=_"+id+"]",$("#goodsCommentList"));
	if(array.length<=0)
		return;
	
	//输出内容
	imgMax=array.length;
	var div=$("#bigPicScroller");
	div.html("");
	var html="";
	for(var i=0;i<array.length;i++){
		html+="<div class='bigPic_slide'>";
		html+="<div class='bigPic_painting' data-index='"+i+"' style='background-image: url("+array[i].src+");'></div>";
		html+="</div>";
	}
	div.html(html)
	//设置宽高
	var bannerPic = $(".bigPic_slide");
	$("#bigPicWrapper").height(document.body.clientWidth);
	$("#bigPicWrapper").css("margin-top",-document.body.clientWidth/2);
	$("#bigPicScroller").width(document.body.clientWidth*bannerPic.length);
	bannerPic.width(document.body.clientWidth);
	$("p",$("#bigPicviewport")).each(function(){
		var _index=index+1;
		console.log(_index)
		var text=$(this).text(_index+"/"+array.length);
	})
	//设置scroll,显示
	$("#bigPicviewport").css("display","block");
	$("#bigPicviewport").animate({top: 0 }, 400,function(){
		if(goodsPhotoListScroll==null){
			goodsPhotoListScroll = new IScroll('#bigPicWrapper', {
				click:true,
				probeType: 3,
				scrollX: true,
				scrollY: false,
				momentum: false,
				snap: true,
				snapSpeed: 400,
				bounce:false
			});
			goodsPhotoListScroll.goToPage(index, 0, 0)
			goodsPhotoListScroll.on("scrollEnd",goodsPhotoListScrollEnd)
		}else{
			goodsPhotoListScroll.goToPage(index, 0, 0)
			goodsPhotoListScroll.refresh();
		}
	});
}

function goodsPhotoListScrollEnd(){
	var imgIndex=this.currentPage.pageX+1;
	$("p",$("#bigPicviewport")).each(function(){
		var text=$(this).text(imgIndex+"/"+imgMax);
	})
}
