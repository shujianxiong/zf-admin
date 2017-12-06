var contentScroll = null;
var contentListType = $("#contentListType").val();
var headPic = $(".headPic img").attr("src"); //导师头像
var name = $(".name span").text(); //导师头像
$(function(){
	//设置图片区域尺寸
	$(".articleItem").height($(window).width()*0.5);
	$(".headPic").height($(".headPic").width());
	$(".subPage","#ContentWarp").each(function(){
		$(this).css("top",$("#mentorTopPart").height()+26)
	});
	//$("#mentorDetailList").css("top",$("#mentorTopPart").height());
	$(".content_top_pic").each(function(){
		$(this).height($(this).width());
	})
	
	
	$("li[data-type='nav']").each(function(){
		if($(this).attr("data-val") == $("#contentListType").val()){
			$(this).attr("class","active");
		}
	})
	
	$("li[data-item='guide']").on("click",function(){
		var mentorId = $("#mentorId").val();
		window.location.href=ctxWeb+"/mentor/detail?mentorId="+mentorId+"&contentListType=1";
		
	});
    $("li[data-item='hotcollocation']").on("click",function(){
		var mentorId = $("#mentorId").val();
		window.location.href=ctxWeb+"/mentor/detail?mentorId="+mentorId+"&contentListType=2";
	});
	
	$("li[data-item='article']").on("click",function(){
		var mentorId = $("#mentorId").val();
		window.location.href=ctxWeb+"/mentor/detail?mentorId="+mentorId+"&contentListType=3";
	});
	
	var noDataString = "";
	if(contentListType == '3'){
		noDataString = "当前导师暂无干货文章";
	}else if(contentListType == '2'){
		noDataString = "当前导师暂无热门穿搭";
	}else{
		noDataString = "当前导师暂无历史指导";
	}
	
	contentScroll=new MyScroll('#mentorWrap',{
		bottom:$("#bottomLoading"),
		isImgCache:true,
		isPage:true,
		loadType:1,
		headerHeight:45,
		getParameter:getParameter,
		loadUrl:ctxWeb+"/mentor/contentList",
		loadSuccess:nextPage,
		noDataView:noDataString
	});
	
	var mentorWorksViewTop=$("#mentorDetailList").offset().top;
	contentScroll.scroll.on("scroll",function(){
		if(-this.y>=mentorWorksViewTop){
			$("#topSelectView").show()
		}else{
			$("#topSelectView").hide()
		}

	})
	
	
})



function nextPage(list){
	var html = "";
	if(contentListType == '1'){
		var guide;
		for (var i=0;i<list.length;i++) {
			guide=list[i];
			photoUrlsArray = guide.displayPhotos.split("|");
			html+="<div class='contentItem'>";
			html+="<div class='content_top'>"
			html+="<div class='content_top_pic'><img src='"+headPic+"'/></div>"
			html+="<span class='content_top_name'>";
			html+="<p>"+name+"</p>";
			html+="<span><i class='iconfont'>&#xe60e;</i>"+pastTime(guide.publishTime)+"<b>(第8周)</b></span></span>";
			html+="</div>";
			html+="<p>"+guide.mentorContent+"</p>";
			html+="<div class='contentItem_pic' onclick='window.location.href='${ctxWeb}/mentor/guide'>";
			for (var j=1;j<3;j++) {//因第一个元素为空，索引从1开始且最多只显示两张图片
				if(photoUrlsArray[j] != undefined && photoUrlsArray[j] != null){
					html+="<span><img src='"+photoUrlsArray[j]+"'/></span>";
				}
			}
			html+="</div>";
			html+="</div>";
		}
		$("#historyGuideWarp").after(html);
		
	}else if(contentListType == '2'){
		var hotCollocation;
		for (var i=0;i<list.length;i++) {
			hotCollocation = list[i];
			photoUrlsArray = hotCollocation.displayPhotos.split("|");
			html+="<div class='contentItem'>";
			html+="<div class='content_top'>";
			html+="<div class='content_top_pic'><img src='"+headPic+"'/></div>";
			html+="<span class='content_top_name'>";
			html+="<p>"+name+"</p>";
			html+="<span><i class='iconfont'>&#xe60e;</i>"+pastTime(hotCollocation.publishTime)+"<b>(第8周)</b></span></span>";
			html+="</div>";
			html+="<p>"+hotCollocation.description+"</p>";
			html+="<div class='contentItem_pic'>";
			for (var j=1;j<5;j++) {//因第一个元素为空，索引从1开始且最多只显示四张图片
				if(photoUrlsArray[j] != undefined && photoUrlsArray[j] != null){
					html+="<span><img src='"+photoUrlsArray[j]+"'/></span>";
				}
			}
			html+="</div>";
			html+="</div>";
		}
		$("#hotWareWarp").after(html);
	}else if(contentListType == '3'){
		var mtArticle;
		for (var i=0;i<list.length;i++) {
			mtArticle = list[i];
			html+="<div class='articleItem' style='background-image: url("+mtArticle.listDisplayPhoto+")'>";
			html+="<span class='articleLike' data-key='0'><i class='iconfont'>&#xe62b;</i>1</span>";
			html+="<div class='time'><i class='iconfont'>&#xe60e;</i><p>"+mtArticle.publishTime.substr(0,10)+"</p>";
			html+="</div>";
			html+="<h2>"+mtArticle.title+"——"+mtArticle.subtitle+"</h2>";
			html+="</div>";
		}
		$("#articleWarp").after(html);
		$(".articleItem").height($(".articleItem").width()/2);
		//$(".contentItem_pic").height($(".contentItem_pic").width()*0.7);
	}else{
		
	}
}

function getParameter(){
	var mentorId = $("#mentorId").val();
	//contentListType：查询类型‘1’历史指导，‘2’热门穿搭，‘3’干货文章
	var param="{\"contentListType\":\""+contentListType+"\",\"mentorId\":\""+mentorId+"\"}";
	var obj=$.parseJSON(param);
	return obj
}


/**
 * 发布时间转换
 * @param {Object} publishDate
 */
function pastTime(publishDate){
	var now = new Date(); 
	var publishTime = new Date(publishDate);
	var pastTime=now.getTime()-publishTime.getTime();
	var pastSecond = parseInt(pastTime/1000);
	if(pastSecond <60*60){ //一小时内
		return parseInt(pastSecond/60)+"分钟前";
	}else if(pastSecond < 60*60*24){ //一天内
		return parseInt(pastSecond/60/60)+"小时前";
	}else if(pastSecond < 60*60*24*5){ //五天内
		return parseInt(pastSecond/60/60/24)+"天前";
	}else{
		return publishDate.substr(0,10);
	}
}


/**
 * 关注
 * @param id
 */
function mentorFocus(id){
	ajax.submit("post",ctxWeb+"/member/mentor/focus",{"mentorId":id},function(data){
		if(data.status=="1"){
			var obj=$("#attentionIcon");
			var numObj=$("#span"+id);
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