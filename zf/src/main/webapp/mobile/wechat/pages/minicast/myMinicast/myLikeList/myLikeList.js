$(function(){
	$("#noContent").html("暂无内容");
	var myScroll = new MyScroll("#myMinicastLikeWarp",{
		bottom:$("#bottomLoading"),
		isImgCache:true,
		isPage:true,
		clear:clear,
		headerHeight:30,
		getParameter:getParameter,
		loadUrl:ctxWeb+"/member/minicast/likeList/"+$("#minicastId").val(),
		loadSuccess:nextPage,
		loadType:3,
		noDataView:$("#noContent")
	});
});

function nextPage(list){
	for(var i=0;i<list.length;i++){
		$("#content").append(builderHtml(list[i]));
	}
	bindEvent();
}

function bindEvent(){
	$("span[is_bindCk='0']","#content").each(function(){
		var t = $(this);
		t.attr("is_bindCk","1");
		$(this).on('click',function(event){
			attention(t);
			event.stopPropagation();
		});
		
	});
	
	$("li","#content").each(function(){
		if($(this).attr("is_bindCk")=='0'){
			$(this).on('click',function(e){
				window.location.href=ctxWeb+"/minicast/hisMinicast/"+$(this).attr("m_id");
			});
			$(this).attr("is_bindCk","1");
		}
	});
}

//关注/取消关注
function attention(t){
	var isAtt = $(t).attr("attention");
	var param = {"minicastMemberId":t.attr("m_id")};
	var url = ctxWeb+"/member/minicast/";
	
	url+=(isAtt=="true")?"cancelAttention":"attention";
	ajax.submit("POST", url, param, function(data){
		if(data.status == "1"){
			if(isAtt=="true"){
				t.html("<i class='iconfont'>&#xe606;</i>关注");
				t.attr("attention","false");
			}else{
				t.html("<i class='iconfont'>&#xe624;</i>已关注");
				t.attr("attention","true");
			}
		}
	}, function(data){
		console.log("error");
	});
}

function builderHtml(obj){
	var html = "";
	html+="<li is_bindCk='0' m_id='"+obj.likeMember.id+"'>";
	html+="<div class='icon'><img data-height=false src='"+ctx+"/"+obj.likeMember.gravatar+"'/></div>";
	html+="<p>"+obj.likeMember.showName+"</p>";
	html+="<p>粉丝:"+obj.likeMember.minicastFansNum+"</p>";
	if(obj.likeMember.like){
		html+="<span class='attentionIcon' is_bindCk='0' attention='true' m_id='"+obj.likeMember.id+"'>";
		html+="<i class='iconfont'>&#xe606;</i>已关注";
		html+="</span>";
	}else{
		html+="<span class='attentionIcon' is_bindCk='0' attention='false' m_id='"+obj.likeMember.id+"'>";
		html+="<i class='iconfont'>&#xe624;</i>关注";	
		html+="</span>";
	}
	html+="</li>";
	return html;
}

function clear(){
	$("#content").html("");
}

function getParameter(){
	
}
