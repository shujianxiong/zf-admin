var photoListScroll=null;
var hotList=new Array();//热门评论
$(function(){
	$("img",".showComment_condent_sub").each(function(){
		$(this).height($(this).width()*0.666);
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
				console.log("data:");
				console.log(data);
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
						tip.autoShow("喜欢成功");
						t.html("<i class='iconfont'>&#xe60e;</i>已喜欢</span>");
						t.attr("like","true");
					}
				}
			}, function(data){
				console.log("error");
			});
		});
	});
	
	$(".showComment_new", ".showComment_recommend").each(function(){
		$(this).on('click',function(){
			window.location.href=ctxWeb+"/goodsInfo/simple/"+$(this).attr("g_id");
		});
	});

	var myScroll = new MyScroll("#minicast_contentWarp",{
		bottom:$("#bottomLoading"),
		isImgCache:true,
		isPage:true,
		clear:clear,
		headerHeight:30,
		getParameter:getParameter,
		loadUrl:ctxWeb+"/minicast/commentList",
		loadSuccess:nextPage,
		loadType:3,
		noDataView:"暂无评论"
	});
	ajaxHotComment();
	$("#commentSubmit").on('click', commentSubmit);
	
	initImgHeight();
	
	//图册浏览
	var windowHeight=$(window).height();
	$("#bigPicviewport").offset({top:windowHeight});
	var bannerPic = $(".bigPic_slide");
	$("#bigPicWrapper").height($(window).width());
	$("#bigPicWrapper").css("margin-top",-$(window).width()/2);
	$("#bigPicScroller").width($(window).width()*bannerPic.length);
	bannerPic.width($(window).width());
	$("p",$("#bigPicviewport")).each(function(){
		var text=$(this).text();
		var textArray=text.split("/");
		imgMax=parseInt(textArray[1]);
	})
	$("#commentImg").on("click",function(){
		$(".bigPic_painting",$("#bigPicScroller")).each(function(){
			if($(this).attr("data-src")=="")
				return;
			$(this).css("background-image","url("+$(this).attr("data-src")+")");
			$(this).attr("data-src","");
		})
		
		$("#bigPicviewport").css("display","block");
		$("#bigPicviewport").animate({top: 0 }, 400,function(){
			if(photoListScroll==null){
				photoListScroll = new IScroll('#bigPicWrapper', {
					click:true,
					probeType: 3,
					scrollX: true,
					scrollY: false,
					momentum: false,
					snap: true,
					snapSpeed: 400,
					bounce:false
				});
				photoListScroll.on("scrollEnd",photoListScrollEnd)
			}
		});
	});
	$("#bigPicviewport").on("click",function(){
		$("#bigPicviewport").animate({top: windowHeight }, 400,function(){
			$("#bigPicviewport").css("display","none");
			photoListScroll.destroy();
			photoListScroll=null;
			$("p",$("#bigPicviewport")).each(function(){
				$(this).text("1/"+imgMax);
			})
		});
	});
	//调用延迟加载
	$("img[data-type=lazyImg]").unveil();
});

function initImgHeight(){
	//初始化图片高度
	$("img[data-height=false]",$("#minicast_contentWarp")).each(function(){
		$(this).height($(this).width())
		$(this).attr("data-height","true")
	})
}

function nextPage(list){
	var commentDoc = $("#com");
	for(var i=0;i<list.length;i++){
		if($.inArray(list[i].id,hotList) <=-1){
			var html = builderHtml(list[i]);
			commentDoc.append(html);
		}
	}
	initImgHeight();
	bindEvent();
}

//绑定初始化数据后的事件:评论点赞
function bindEvent(){
	$("span[b_click=false]").each(function(){
		$(this).on('click', commentClick);
		$(this).attr("b_click","true");
	});
	
}

function commentClick(event){
	
	var t = $(this);
	t.unbind();
	var h_l = parseInt(t.attr("h_level"))+1;
	var param = {"commentId":$(this).attr("c_id")};
	ajax.submit("POST", ctxWeb+"/member/minicast/commentLike", param, function(data){
		if(data.status == "1"){
			t.attr("h_level",h_l);
			t.html("<i class='iconfont'>&#xe60e;</i>"+h_l);
		}
	}, function(data){
		t.on('click',commentClick);
		console.log("error");
	});
}

function clear(){
	$("#com").html("");
}

function getParameter(){
	var parameter = {"minicastId":$("#minicastId").val()};
	return parameter;
}

/**加载热门评论*/
function ajaxHotComment(){
	var parameter = {"minicastId":$("#minicastId").val()};
	ajax.submit("POST", ctxWeb+"/minicast/hotCommentHotList", parameter, function(data){
		if(data.status == "1"){
			var commentDoc = $("#hot");
		    var list = data.data;
		    if(list != null){
				for(var i=0;i<list.length;i++){
					hotList.push(list[i].id);
					var html = builderHtml(list[i]);
					commentDoc.append(html);
					
				}
		    }else{
		    	$("#showComment_comment_tab").hide();
		    }
		}
	}, function(data){
		console.log("error");
	});
}
/**
 * 
 * @param obj 评论对象
 * @param isHost true ：热门评论
 * @returns html
 */
function builderHtml(obj){
	var html = "";
	html+="<li class='showComment_comment_condent' c_id='"+obj.id+"'>";
	html+="<div class='comment_condent_user'>";
	html+="<span class='user_pic'><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+ctx+"/"+obj.member.gravatar+"'/></span>";
	html+="<div class=''>";
	html+="<h4>"+obj.showTime+"</h4>";
	html+="</div>";
	html+="<span class='user_praise' b_click=false c_id='"+obj.id+"' h_level='"+obj.hotLevel+"'>";
	html+="<i class='iconfont'>&#xe60e;</i>"+obj.hotLevel;
	html+="</span>";
	html+="</div>";
	html+="<p>"+obj.content+"</p>";
	html+="</li>";
	return html;
}

function commentSubmit(){
	if(!checkSubComment()){
		return false;
	}
	var parameter = $("#commentForm").serialize();
	ajax.submit("POST", ctxWeb+"/member/minicast/comment", parameter, function(data){
		if(data.status == "1"){
			console.log(data.obj);
			tip.autoShow("评论成功");
			var obj = data.data;
			var html = builderHtml(obj);
			$("#com").prepend(html);
			$("#content").val("");
		}
	}, function(data){
		console.log("error");
	});
}

function checkSubComment(){
	if(formValidate.isNull($("#content"))){
		tip.autoShow("请输入评论内容");
		return false;
	}
	if(formValidate.isNull($("#minicastId"))){
		tip.autoShow("不存在当前小咖秀");
		return false;
	}
	return true;
}

//图册序号变更
var imgMax=0;
function photoListScrollEnd(){
	var imgIndex=this.currentPage.pageX+1;
	$("p",$("#bigPicviewport")).each(function(){
		var text=$(this).text(imgIndex+"/"+imgMax);
	})
}

