$(function(){
	
	//关注，取消关注
	$("#attentionIcon").on("click",function(){
		var attentionFlag = $("#attentionIcon").attr("data-mark");
		if(attentionFlag==0){
			$(this).attr("data-mark",1);
			$(this).html('<i class="iconfont">&#xe606;</i>已关注');
			$("#remind").css("display","block");
			$("#remindText").text("关注成功")
			$("#remindConfirm").css("display","none");
		}else{
			$(this).attr("data-mark",0);
			$("#remind").css("display","block");
			$("#remindText").text("取消关注？")
			$("#remindConfirm").css("display","block");
		}
		$("#remindClosed").on("click",function(){
			$("#remind").css("display","none")
		})
		$("#remindConfirm").on("click",function(){
			$("#remind").css("display","none");
			$("#attentionIcon").html('<i class="iconfont">&#xe624;</i>关注');
		})
	})
	
	$("#noContent").html("暂无内容")
	var myScroll=new MyScroll("#designerWarp",{
		bottom:$("#listLoadingLi"),
		isImgCache:true,
		headerHeight:30,
		loadType:3,
		getParameter:getParameter,
		loadUrl:"./designer/list",
		loadSuccess:nextPage,
		clear:function(){
			$("#designerWarpListView").html("");
		},
		noDataView:$("#noContent")
	})
})

function getParameter(){
	
}

function nextPage(list){
	var content=$("#designerWarpListView");
	for(var i=0;i<list.length;i++){
		var html="<div class='designerItem'>";
		html+="<div data-height='false' class='headArea' style='background-image: url("+list[i].designer.displayPhoto+");'>";
		if(list[i].designer.fansFlag=="0")
			html+="<span class='attentionIcon' id='attentionIcon' ><i class='iconfont'>&#xe624;</i>关注</span>";
		else
			html+="<span class='attentionIcon' id='attentionIcon' ><i class='iconfont'>&#xe606;</i>已关注</span>";
		html+="<div class='headPic'>";
		html+="<img src='"+list[i].designer.gravatarPhotoUrl+"' onclick=\"goToDetail('"+list[i].designer.id+"');\"/>";
		html+="</div>";
		html+="<div class='name'>";
		if(list[i].designer.sex=="1")
			html+="<span>"+list[i].designer.name+"</span><i class='icon'><img src='"+ctxMobile+"/pages/character/designer/images/boy.png'/></i>";
		else
			html+="<span>"+list[i].designer.name+"</span><i class='icon'><img src='"+ctxMobile+"/pages/character/designer/images/girl.png'/></i>";
		html+="</div>";
		html+="<p><i class='iconfont'>&#xe618;</i>"+list[i].designer.country+"</p>";
		html+="<ul>";
		html+="<li>粉丝"+list[i].fansCount+"</li>";
		html+="<li>作品热度"+list[i].goodsHotLevelSum+"</li>";
		html+="<li>作品数量"+list[i].goodsCount+"</li>";
		html+="</ul>";
		html+="<div class='labelArea'>";
		if(list[i].designerCategoryList!=null){
			for(var j=0;j<list[i].designerCategoryList.length;j++){
				html+="<span>"+list[i].designerCategoryList[j].category.name+"</span>";
			}
		}
		html+="</div>";
		html+="</div>";
		html+="<div class='designerIntro'>";
		html+="<h2>设计师简介</h2>";
		html+="<p>"+list[i].designer.introduction+"</p>";
		html+="<div class='designerWorks'>";
		html+="<ul id='designerWorks'>";
		if(list[i].goodsList!=null){
			for(var j=0;j<list[i].goodsList.length;j++){
				html+="<li onclick=window.location.href='"+ctxWeb+"/goodsInfo/simple/"+list[i].goodsList[j].id+"'><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+list[i].goodsList[j].displayIcon+"' />";
				html+="<h3>￥"+list[i].goodsList[j].displayPrice+"</h3>";
				html+="</li>";
			}
		}
		html+="</ul>";
		html+="</div>";
		html+="</div>";
		html+="</div>";
		content.append(html);
	}
	$(".headArea[data-height=false]").each(function(){
		$(this).css("min-height",$(window).width()*0.64);
		$(this).attr("data-height","true");
	})
	$("img[data-height=false]","#designerWorks").each(function(){
		$(this).height($(this).width()*1.3);
		$(this).attr("data-height","true");
	});
	$(".headPic").height($(".headPic").width());
	$(".minicastNew").height($(".minicastNew").width());
}


function goToDetail(id){
	window.location.href=ctxWeb+"/designer/detail?designerId="+id;
}