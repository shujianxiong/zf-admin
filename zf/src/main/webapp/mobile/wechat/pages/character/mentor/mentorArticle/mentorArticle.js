var allContentScroll = null;
var xzfxContentScroll = null;
var xqzbContentScroll = null;
var chzdContentScroll = null;
var category = '';

$(function(){
	//设置图片区域尺寸
	$("#topPic").height($("#topPic").width()*0.3125);
	//选择区top
	$(".mentorTop").css("top",$("#topPic").height());  
	//关注，取消关注
	
	
//	$(".articleLike","#mentorWarp").each(function(){
//		$(this).on("click",function(){
//			console.log($(this).html())
//			var attentionFlag = $(this).attr("data-mark");
//			if(attentionFlag==0){
//				$(this).attr("data-mark",1);
//				$(this).html('<i class="iconfont active">&#xe613;</i>');
//				$("#remind").css("display","block");
//				$("#remindText").text("收藏成功")
//				$("#remindConfirm").css("display","none");
//			}else{
//				$(this).attr("data-mark",0);
//				$("#remind").css("display","block");
//				$("#remindText").text("取消收藏？")
//				$("#remindConfirm").css("display","block");
//				$(this).html('<i class="iconfont">&#xe62b;</i>');
//			}
//			$("#remindClosed").on("click",function(){
//				$("#remind").css("display","none")
//			})
//			$("#remindConfirm").on("click",function(){
//				$("#remind").css("display","none");
//			})
//		})
//	})
	
	var noDataViewString = "暂无内容";
	
	
	leftTouch.init({
		mainPanel:$("#mentorWarp"),
		activeClass:"active",
		isActive:true,
		activePanel:$("#mentorTop"),
		initCallBack:function(){//leftTouch->init初始化完成后回调，默认初始化全部文章scroll
			allContentScroll=new MyScroll('#allContent',{
				bottom:$("#allBottomLoading"),
				isImgCache:true,
				isPage:true,
				loadType:3,
				headerHeight:54,
				getParameter:getParameter,
				loadUrl:ctxWeb+"/mentor/articleList",
				clear:function(){
						$("#allContent .articleItem").remove();
				},
				loadSuccess:nextPage,
				noDataView:noDataViewString
			})
		},
		moveCallBack:function(index){
			if(index==0){//全部内容
				statusIndex = index;
				category = '';
				allContentScroll.active();
				//暂停星座风向scroll
				if(xzfxContentScroll!=null){
					xzfxContentScroll.suspend();
				}
				//销毁心情坐标scroll
				if(xqzbContentScroll!=null){
					xqzbContentScroll.suspend();
				}
				//销毁场合之道scroll
				if(chzdContentScroll!=null){
					chzdContentScroll.suspend();
				}
			}
			else if(index==1){//星座风向
				statusIndex = index;
				category = 1;
				if(xzfxContentScroll==null){//从未创建星座风向scroll
					xzfxContentScroll=new MyScroll('#xzfxContent',{
						bottom:$("#xzfxBottomLoading"),
						isImgCache:true,
						loadType:3,
						headerHeight:54,
						getParameter:getParameter,
						loadUrl:ctxWeb+"/mentor/articleList",
						clear:function(){
							$("#xzfxContent .articleItem").remove();
						},
						loadSuccess:nextPage,
						noDataView:noDataViewString
					})
				}else {
					xzfxContentScroll.active();
				}
				//销毁全部、心情坐标、场合之道scroll
				if(allContentScroll != null){
					allContentScroll.suspend();
				}
				if(xqzbContentScroll != null){
					xqzbContentScroll.suspend();
				}
				if(chzdContentScroll != null){
					chzdContentScroll.suspend();
				}
			}
			else if(index == 2){//心情坐标
				statusIndex = index;
				category = 2;
				if(xqzbContentScroll==null){//从未创建心情坐标scroll
					xqzbContentScroll=new MyScroll('#xqzbContent',{
						bottom:$("#xqzbBottomLoading"),
						isImgCache:true,
						loadType:3,
						headerHeight:54,
						getParameter:getParameter,
						loadUrl:ctxWeb+"/mentor/articleList",
						clear:function(){
							$("#xqzbContent .articleItem").remove();
						},
						loadSuccess:nextPage,
						noDataView:noDataViewString
					})
				}else {
					xqzbContentScroll.active();
				}
				//销毁全部、星座风向、场合之道scroll
				if(allContentScroll != null){
					allContentScroll.suspend();
				}
				if(xzfxContentScroll != null){
					xzfxContentScroll.suspend();
				}
				if(chzdContentScroll != null){
					chzdContentScroll.suspend();
				}
				
			}
			else if(index == 3){//场合之道
				statusIndex = index;
				category = 3;
				if(chzdContentScroll==null){//从未创建场合之道scroll
					chzdContentScroll=new MyScroll('#chzdContent',{
						bottom:$("#chzdBottomLoading"),
						isImgCache:true,
						loadType:3,
						headerHeight:54,
						getParameter:getParameter,
						loadUrl:ctxWeb+"/mentor/articleList",
						clear:function(){
							$("#chzdContent .articleItem").remove();
						},
						loadSuccess:nextPage,
						noDataView:noDataViewString
					})
				}else {
					chzdContentScroll.active();
				}
				//销毁全部、星座风向、心情坐标scroll
				if(allContentScroll != null){
					allContentScroll.suspend();
				}
				if(xzfxContentScroll != null){
					xzfxContentScroll.suspend();
				}
				if(xqzbContentScroll != null){
					xqzbContentScroll.suspend();
				}
			}
		}
	})
	
	$("#allContentLi").on("click",function(){
		leftTouch.move(0);
	});
    $("#xzfxContentLi").on("click",function(){
    	leftTouch.move(1);
	});
	$("#xqzbContentLi").on("click",function(){
    	leftTouch.move(2);
	});
	$("#chzdContentLi").on("click",function(){
    	leftTouch.move(3);
	});
	
})




function getParameter(){
	//category：文章类别‘1’星座风向，‘2’心情坐标，‘3’场合之道
	var param="{\"category\":\""+category+"\"}";
	var obj=$.parseJSON(param);
	return obj
}

function nextPage(list){
	var html="";
	for (var i=0;i<list.length;i++) {
		var mtArticle = list[i];
		html+="<div class='articleItem' style='background-image: url("+mtArticle.listDisplayPhoto+")'>";
		html+="<span class='articleLike' data-mark='0'><i class='iconfont'>&#xe62b;</i>3</span>";
		html+="<div class='time'><i class='iconfont'>&#xe60e;</i>";
		html+="<p>"+pastTime(mtArticle.publishTime)+"</p>";
		html+="</div>";
		html+="<h2>"+mtArticle.title+"———"+mtArticle.subtitle+"</h2>";
		html+="</div>";
	}
	if(category == '1'){
		$("#xzfxBottomLoading").before(html);
	}else if(category == '2'){
		$("#xqzbBottomLoading").before(html);
	}else if(category == '3'){
		$("#chzdBottomLoading").before(html);
	}else{
		$("#allBottomLoading").before(html);
	}
	//设置文章块高度
	$(".articleItem","#mentorWarp").each(function(){
	$(this).height($(this).width()*0.5)
	});
	
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