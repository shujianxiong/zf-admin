var bigcastId = "";		// 保存首页大咖周范对应的大咖的ID
var jobId = "";
var myScroll;
var bigcastFiltrateTop;
$(function(){
	bigcastId = $("#bigcastId").val();
	
	//设置选择器top
	$("#bigcastFiltrate").offset({left:-$(window).width()})
	$("#bigcastFiltrate").css("display","block");
	bigcastFiltrateTop=$("#bigcastFiltrate").offset().top-$("#filtrateContent").height()-$("#filtrateButton").height();
	$("#bigcastFiltrate").css("display","none");
	$("#bigcastFiltrate").offset({left:0,top:bigcastFiltrateTop});
	
	
	$("li[data-type=more]").on("click",function(){
		if($("#bigcastFiltrate").css("display")=="none"){
			$("#bigcastFiltrate").css("display","block");
			$('#bigcastFiltrate').animate({'top': 90 }, 300,function(){
				
			});
		}else{
			$("#bigcastFiltrate").css("display","block");
			$('#bigcastFiltrate').animate({'top': bigcastFiltrateTop }, 300,function(){
				$("#bigcastFiltrate").css("display","none");
			});
		}
	})
	
	$("#noContent").html("暂无内容")
	myScroll=new MyScroll("#bigcastWarp",{
		header:$("#headerLoading"),
		bottom:$("#listLoadingLi"),
		isImgCache:true,
		headerHeight:30,
		loadType:3,
		getParameter:getParameter,
		loadUrl:"./bigcast/list",
		loadSuccess:nextPage,
		clear:function(){
			$("#bigcastListView").html("");
		},
		noDataView:"<a href='#this' style='color:white' onclick='javascript:myScroll.refresh()'>当前暂无内容,立即刷新</a>",
		isLoading:false
	})
	
	$("span[data-type=select]").on("click",function(){
		spanSelect($(this));
	})
	
	$("li[data-type=select]").on("click",function(){
		liSelect($(this))
		myScroll.isLoading=true;
		myScroll.refresh();
	})
	
	$("#confirmReset").on("click",function(){
		$("span[data-type=select]").each(function(){
			$(this).removeClass("active");
			jobId="";
		})
		$("li[data-type=select]").each(function(){
			if($(this).text()=="全部")
				$(this).addClass("active");
		})
	})
	
	$("#confirmSub").on("click",function(){
		$('#bigcastFiltrate').animate({'top': bigcastFiltrateTop }, 300,function(){
			$("#bigcastFiltrate").css("display","none");
			myScroll.isLoading=true;
			myScroll.refresh();
		});
	})
})

function liSelect(obj){
	$("li[data-type=select]").each(function(){
		$(this).removeClass("active");
	})
	if(obj.attr("class")=="active"){
		jobId="";
		obj.removeClass("active");
	}else{
		jobId=obj.attr("data-val")
		obj.addClass("active");
	}
	$("span[data-type=select]").each(function(){
		if($(this).text()==obj.text()){
			$(this).addClass("active");
			return;
		}else{
			$(this).removeClass("active")
		}
	});
	$('#bigcastFiltrate').animate({'top': bigcastFiltrateTop }, 300,function(){
		$("#bigcastFiltrate").css("display","none");
		myScroll.isLoading=true;
		myScroll.refresh();
	});
}

function spanSelect(obj){
	$("span[data-type=select]").each(function(){
		$(this).removeClass("active");
	})
	if(obj.attr("class")=="active"){
		jobId="";
		obj.removeClass("active");
	}else{
		jobId=obj.attr("data-val")
		obj.addClass("active");
	}
	$("li[data-type=select]").each(function(){
		if($(this).text()==obj.text()){
			$(this).addClass("active");
		}else{
			$(this).removeClass("active")
		}
	})
}

function getParameter(){
	return {"bigcastId":bigcastId, "jobId":jobId}
}

function nextPage(list){
	var content=$("#bigcastListView");
	for(var i=0;i<list.length;i++){
		var html="<div class='bigcastItem'>";
		html+="<div data-height='false' class='headArea' style='background-image: url("+list[i].backgroundPhotoUrl+");'>";
		if(list[i].fansFlag=="0")
			html+="<span data-key='0' id='span"+list[i].id+"' onclick=\"bigCastFocus('"+list[i].id+"')\" class='attentionIcon'><i class='iconfont'>&#xe624;</i>关注</span>";
		else
			html+="<span data-key='1' id='span"+list[i].id+"' onclick=\"bigCastFocus('"+list[i].id+"')\" class='attentionIcon'><i class='iconfont'>&#xe606;</i>已关注</span>";
		if(list[i].periodFlag=="1"){
			html+="<span class='currentBigcast'>本期大咖</span>";
		}
		html+="<div class='headPic'><img data-type='lazyImg' src='${ctxMobile}/img/cachePic.png' data-src="+list[i].avatarUrl+" onclick=\"goToDetail('"+list[i].id+"');\"/></div>";
		html+="<div class='name'>";
		html+="<span>"+list[i].name +"</span>";
		if(list[i].sex=="1")
			html+="<i class='icon'><img src="+ctxMobile+"/pages/character/bigcast/images/boy.png /></i>";
		else
			html+="<i class='icon'><img src="+ctxMobile+"/pages/character/bigcast/images/girl.png /></i>";
		html+="</div>";
		html+="<p><i class='iconfont'>&#xe618;</i>"+list[i].country+"</p>";
		html+="<ul>";
		html+="<li>粉丝<span id='fans"+list[i].id+"'>"+list[i].fansCount+"</span></li>";
		html+="<li>周范经历25周</li>";
		html+="</ul>";
		html+="<div class='labelArea'>";
		if(list[i].jobList!=null){
			for(var j=0;j<list[i].jobList.length;j++){
				html+="<span data-vl='"+list[i].jobList[j].id+"'>"+list[i].jobList[j].name+"</span>";	
			}
		}
		html+="</div>";
		html+="</div>";
		html+="<div class='bigcastIntro'>";
		html+="<h2>大咖简介</h2>";
		html+=list[i].summary;
		html+="<div class='bigcastWorks'>";
		html+="<ul id='bigcastWorks'>";
		html+="<li onclick=window.location.href='"+list[i].displayPhotoHref1+"'><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src="+list[i].displayPhotoUrl1+"/></li>";
		html+="<li onclick=window.location.href='"+list[i].displayPhotoHref2+"'><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src="+list[i].displayPhotoUrl2+"/></li>";
		html+="<li onclick=window.location.href='"+list[i].displayPhotoHref3+"'><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src="+list[i].displayPhotoUrl3+"/></li>";
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
	$("img[data-height=false]",".bigcastWorks").each(function(){
		$(this).height($(this).width()*1.3);
		$(this).attr("data-height","true");
	});
	$(".headPic").height($(".headPic").width());
	$(".minicastNew").height($(".minicastNew").width());
	myScroll.isLoading=false;
}

function bigCastFocus(id){
	ajax.submit("post","./member/bigcast/focus",{"bigcastId":id},function(data){
		if(data.status=="1"){
			var obj=$("#span"+id);
			var numObj=$("#fans"+id);
			var val=parseInt(numObj.text());
			if(obj.attr("data-key")=="1"){
				obj.attr("data-key","0");
				$("#span"+id).html("<i class='iconfont'>&#xe624;</i>关注</span>")
				//数量减少
				val--;
			}else{
				obj.attr("data-key","1");
				$("#span"+id).html("<i class='iconfont'>&#xe606;</i>已关注</span>")
				//数量增加
				val++;
			}
			numObj.text(val)
		}
	})
}

function goToDetail(id){
	window.location.href=ctxWeb+"/bigcastWeekFan?bigcastId="+id;
}