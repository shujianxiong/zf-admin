$(function(){
	$("#noContent").html("暂无内容");
	var myScroll = new MyScroll("#myAttentionWarp",{
		bottom:$("#bottomLoading"),
		isImgCache:true,
		isPage:true,
		clear:clear,
		headerHeight:30,
		getParameter:getParameter,
		loadUrl:ctxWeb+"/member/minicast/attentionList",
		loadSuccess:nextPage,
		loadType:3,
		noDataView:$("#noContent")
	});
});

function nextPage(list){
	for(var i = 0; i <list.length ; i++){
		$("#content").append(builderHtml(list[i]));
	}
	
	bindEvent();
}

function bindEvent(){
	$("span[is_bind_click='0']","#content").each(function(){
		$(this).on('click',function(){
			var $t = $(this);
			var param = {"minicastMemberId":$(this).attr("m_id")};
			var url = ctxWeb+"/member/minicast/cancelAttention";
			ajax.submit("POST", url, param, function(data){
				if(data.status == "1"){
					$t.parent("li").remove();
				}
			}, function(data){
				console.log("error");
			});
		});
		$(this).attr("is_bind_click","1");
	});
}


function builderHtml(obj){
	var html ="";
	html+="<li>";
	html+="<div class='icon'><img src='"+ctx+"/"+obj.minicastMember.gravatar+"'/></div>";
	html+="<p>"+obj.minicastMember.showName+"</p>";
	html+="<p>粉丝:"+obj.minicastMember.minicastFansNum+"</p>";
	html+="<span class='attentionIcon' id='attentionIcon' is_bind_click='0' m_id='"+obj.minicastMember.id+"'>";
	html+="<i class='iconfont'>&#xe606;</i>已关注";
	html+="</span>";
	html+="</li>";
	return html;
}

function getParameter(){
}


function clear(){
	$("#content").html("");
}