var myScroll;
var tagVal = ""; //保存当前栏目
$(function(){
	$("#bottomLoading").hide();
	//发表小咖秀
	$("#minicast_publish").on('click',function(){
		window.location.href=ctxWeb+"/member/issueMinicastSelecetGoods";
	});
	myScroll = new MyScroll("#minicast_contentWarp",{
		header:$("#headerLoading"),
		bottom:$("#bottomLoading"),
		isImgCache:true,
		isPage:true,
		clear:clear,
		headerHeight:30,
		getParameter:getParameter,
		loadUrl:ctxWeb+"/minicast/ajaxList",
		loadSuccess:nextPage,
		loadType:3,
		noDataView:"<a href='#this' style='color:white' onclick='javascript:myScroll.refresh()'>当前暂无内容,立即刷新</a>",
		isLoading:false//默认第一次不显示loading
	});
	//tab切换
	$("ul[data-type=select] li").each(function(){
		$(this).on('click',function(){
			$("ul[data-type=select] li span").removeClass("active");
			$("span",this).addClass("active");
			tagVal = $(this).attr("dict-val");
			myScroll.isLoading=true;
			myScroll.refresh();
		});
	});
	//'更多'图标切换
	$("#selectCenterMore").on("click",function(){
		var moreCastFlag = $(this).attr("data-mark");
		if (moreCastFlag ==0){
			//更多项收起
			$(this).html("<span class='active'>更多</span><i class='iconfont'>&#xe64a;</i>");
			$(this).attr("data-mark",1);
		}else{
			//更多项展开
			$(this).html("<span class='active'>更多</span><i class='iconfont'>&#xe625;</i>");
			$(this).attr("data-mark",0);
		}
	})
	//控制悬浮顶部类型选择器
	var selectViewTop=$("#selectCenter").offset().top;
	myScroll.scroll.on("scroll",function(){
		if(-this.y>=selectViewTop){
			$("#selectHeader").show()
		}else{
			$("#selectHeader").hide()
		}
	})
})

function nextPage(list){
	for(var i=0;i<list.length;i++){
		console.log(list[i].member.gravatar);
		var html = "";
		html+="<div class='minicast_sub'>";
		html+="<div class='minicast_content'>";
		html+="<div id='' class='show_content_top'>";
		html+="<div class='show_content_top_pic'><span id=''>";
		html+="<img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+ctx+"/"+list[i].member.gravatar+"'/></span></div>";
		html+="<span class='show_content_top_name'>";
		html+="<p>"+list[i].member.showName+"</p>";
		html+="<span id=''><i class='iconfont'>&#xe60e;</i>"+list[i].showTime+"</span>";
		html+="</span>";
		if(list[i].attention){//已关注
			html+="<span class='show_content_top_attention' attention='true' m_id="+list[i].member.id+">";
			html+="<i class='iconfont'>&#xe606;</i>已关注</span>";
		}else{//未关注
			html+="<span class='show_content_top_attention' attention='false' m_id="+list[i].member.id+">";
			html+="<i class='iconfont'>&#xe624;</i>关注</span>";
		}
		html+="</div>";
		//内容 star
		html+="<div class='click_minicast' m_id='"+list[i].id+"'>";
		html+="<p>"+list[i].content+"</p>";
		html+="<div id=''class='minicast_content_tab'>";
		html+="<span>"+list[i].tag+"</span>";
		html+="</div>";
		html+="<div id='' class='minicast_content_pic'>";
		var photoUrls = list[i].photoUrls;
		if(photoUrls != null && photoUrls !=''){
			photos = photoUrls.split(",");
			for(var j =0; j <photos.length;j++){
				if(photos[j] !=null && photos[j] != ''){
					html+="<span id=''><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+ctx+"/"+photos[j]+"'/></span>";
				}
			}
		}
		html+="</div>";
		html+="</div>";
		//内容 end
		html+="<div class='minicast_content_new' onclick=window.location.href='"+ctxWeb+"/goodsInfo/simple/"+list[i].goods1.id+"'>";
		html+= (list[i].goods1.tagss !=null && list[i].goods1.tagss.length>0)?"<span>"+list[i].goods1.tagss[0].name+"</span>":"";
		html+="<img data-type='lazyImg' data-height='false' class='minicastNew' src='"+ctxMobile+"/img/cachePic.png' data-src='"+list[i].goods1.icon+"'/>";
		html+="<div id=''>";
		html+="<h2>"+list[i].goods1.name+"</h2>";
		html+="<h2>RMB "+list[i].goods1.price+"</h2>";
		html+="<p>已有25人跟随购买</p>";
		html+="</div>";
		html+="</div>";
		html+="<div class='minicast_content_like'>";
		if(list[i].like){//已喜欢
			html+="<span class='like' like='true' m_id='"+list[i].id+"'>";
			html+="<i class='iconfont'>&#xe613;</i>已喜欢</span>";
		}else{
			html+="<span class='like' like='false' m_id='"+list[i].id+"'>";
			html+="<i class='iconfont'>&#xe62b;</i>喜欢</span>";
		}
		html+="<span class='comment' m_id='"+list[i].id+"'>";
		html+="<i class='iconfont'>&#xe612;</i>评论</span>";
		html+="<span>";
		html+="<i class='iconfont'>&#xe616;</i>分享</span>";
		html+="</div>";
		html+="</div>";
		if(list[i].minicastLikeList != null && list[i].minicastLikeList.length>0){
			html+="<div  class='minicast_content_pic_bottom'>";
			for(var k = 0;k<list[i].minicastLikeList.length;k++){
				if(k>=5){
					break;
				}
				html+="<span id=''><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+ctx+"/"+list[i].minicastLikeList[k].likeMember.gravatar+"'/></span>";
			}
			html+="<span id='' >"+list[i].likeCount+"</span>";
			html+="</div>";
		}
		html+="</div>";
		$("#minicast_content").append(html);
	}
	setImgHeight();
	$("#bottomLoading").show();
}



function getDictLable(value){
	for(var i=0;i<tags.length;i++){
		if(tags[i].value==value){
			return tags[i].label;
		}
	}
}
function setImgHeight(){
	$("span",".minicast_content_pic_bottom").each(function(){
		$(this).height($(this).width());
		$(this).css("line-height",$(this).height()+"px");
	});
	//初始化商品列表图片高度
	$("img[data-height=false]",$("#minicast_content")).each(function(){
		$(this).height($(this).width());
		$(this).attr("data-height","true");
	})
	//设置头部图片高度
	$("img",".minicast_header").each(function(){
		$(this).height($(this).width()*0.375);
	});
	//关注/取消关注
	$(".show_content_top_attention").each(function(){
		$(this).on('click',function(){
			var t = $(this);
			var isAtt = $(this).attr("attention");
			var param = {"minicastMemberId":$(this).attr("m_id")};
			var url = ctxWeb+"/member/minicast/";
			url+=(isAtt=="true")?"cancelAttention":"attention";
			ajax.submit("POST", url, param, function(data){
				if(data.status == "1"){
					if(isAtt=="true"){
						tip.autoShow("取消关注");
						t.html("<i class='iconfont'>&#xe60e;</i>关注");
						t.attr("attention","false");
					}else{
						tip.autoShow("关注成功");
						t.html("<i class='iconfont'>&#xe60e;</i>已关注");
						t.attr("attention","true");
					}
				}
			}, function(data){
				console.log("error");
			});
		});
	});
	
	$(".like").each(function(){
		$(this).on('click', function(){
			var t = $(this);
			var isLike = $(this).attr("like");
			var param = {"minicastId":$(this).attr("m_id")};
			var url = ctxWeb+"/member/minicast/";
			url+=(isLike=="true")?"cancelLike":"like";
			ajax.submit("POST", url, param, function(data){
				if(data.status == "1"){
					if(isLike=="true"){
						tip.autoShow("取消喜欢");
						t.html("<i class='iconfont'>&#xe60e;</i>喜欢</span>");
						t.attr("like","false");
					}else{
						tip.autoShow("已喜欢");
						t.html("<i class='iconfont'>&#xe60e;</i>已喜欢</span>");
						t.attr("like","true");
					}
				}
			}, function(data){
				console.log("error");
			});
		});
	});
	
	//点击小咖秀内容
	$(".click_minicast").each(function(){
		$(this).on('click',function(){
			window.location.href=ctxWeb+"/minicast/"+$(this).attr("m_id");
		});
	});
	$(".comment").each(function(){
		$(this).on('click',function(){
			window.location.href=ctxWeb+"/minicast/"+$(this).attr("m_id");
		})
	});
}



function compToDate(startDate, endDate){
	if(typeof(startDate)=="string") {
      	startDate=new Date(startDate.replace(/-/,'/'));
    }
	if(typeof(endDate)=="string") {
     	endDate=new Date(endDate.replace(/-/,'/'));
    }
	var showDate = "";
	var ss = parseInt((endDate.getTime()-startDate.getTime())/1000); //秒
	var min = parseInt(ss/60);		//分
	var hour = parseInt(min/60);	//小时
	var day = parseInt(hour/24);	//天
	if(day>0){
		showDate = day+"天前";
	}else if(hour > 0){
		showDate = hour+"小时前";
	}else if(min > 0){
		showDate = min+"分钟前";
	}else{
		showDate = ss+"秒前";
	}
	return showDate;
}


function getParameter(){
	var parame = {"tagVal":tagVal}
	return parame;
}

function clear(){
	$("#minicast_content").html("");
}


