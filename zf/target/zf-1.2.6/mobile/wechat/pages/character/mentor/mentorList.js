$(function(){
	//设置图片区域尺寸
	$("#topPic").height($(this).width()*0.3125);
	//滚动区top
	$("#mentorWarp").css("top",$("#topPic").height()+15);  
	//导师列表上部高度
	$("img",".mentorWorks").each(function(){
		$(this).height($(this).width());
	});

	$("#noContent").html("暂无内容")
	var myScroll=new MyScroll("#mentorWarp",{
		bottom:$("#bottomLoading"),
		isImgCache:true,
		isPage:true,
		headerHeight:30,
		loadType:3,
		getParameter:getParameter,
		loadUrl:"./mentor/list",
		loadSuccess:nextPage,
		clear:function(){
			$(".mentorItem").remove();
		},
		noDataView:$("#noContent")
	})
	
})



function nextPage(list){
	var html="";
	for (var i=0; i<list.length; i++) {
		var mentorVo = list[i];
		html+="<div class='mentorItem'>";
		html+="<div class='headArea' style='background-image: url("+mentorVo.mentor.backgroundPhotoUrl+");'>";
		html+="<span class='shareIcon'><i class='iconfont'>&#xe616;</i></span>";
		html+="<div class='headPic'><img data-type='lazyImg' src='"+ctxMobile+"/img/cachePic.png' data-src='"+mentorVo.mentor.gravatarPhotoUrl+"' onclick=\"goToDetail('"+mentorVo.mentor.id+"');\"/>"
		if(mentorVo.fansFlag == 0){
			html+="<span class='attentionIcon' data-key='0' id='span"+mentorVo.mentor.id+"' onclick=\"mentorFocus('"+mentorVo.mentor.id+"');\" ><i class='iconfont'>&#xe624;</i>关注</span>";
		}else{
			html+="<span class='attentionIcon' data-key='1' id='span"+mentorVo.mentor.id+"' onclick=\"mentorFocus('"+mentorVo.mentor.id+"');\" ><i class='iconfont'>&#xe606;</i>已关注</span>";
		}
		html+="<span class='consultIcon'><i class='iconfont'>&#xe612;</i>咨询</span>";
		html+="</div>";
		html+="<div class='name'>";
		html+="<span>"+mentorVo.mentor.name+"</span>";
		html+="<i class='icon'><img data-type='lazyImg' src='"+ctxMobile+"/pages/character/mentor/images/vip.png'/></i>";
		if(mentorVo.mentor.sex == '1'){
			html+="<i class='icon'><img src='"+ctxMobile+"/pages/character/mentor/images/boy.png'/></i>";
		}else{
			html+="<i class='icon'><img src='"+ctxMobile+"/pages/character/mentor/images/girl.png'/></i>";
		}
		html+="</div>";
		html+="<p><i class='iconfont'>&#xe618;</i>"+mentorVo.mentor.country+"</p>";
		html+="<ul><li>粉丝<span id='fans"+mentorVo.mentor.id+"'>"+mentorVo.fansCount+"</span></li>";
		html+="<li>指导人数"+mentorVo.guideCount+"</li></ul>";
		html+="</div>";
		html+="<div class='mentorIntro'><h2>设计师简介</h2>";
		html+="<p>"+mentorVo.mentor.listSummary+"</p>";
		html+="<div class='mentorWorks'>";
		html+="<ul>";
		html+="<li><img data-type='lazyImg' src='"+mentorVo.mentor.listDisplayPhoto1+"'/></li>";
		html+="<li><img data-type='lazyImg' src='"+mentorVo.mentor.listDisplayPhoto1+"'/></li>";
		html+="</ul>";
		html+="</div>";
		html+="</div>";
		html+="</div>";
	}
	$("#bottomLoading").before(html);
	
	$(".headPic").height($(".headPic").width());
}

function getParameter(){
	
}

/**
 * 跳转到详情页面
 * @param {Object} id
 */
function goToDetail(id){
	window.location.href=ctxWeb+"/mentor/detail?mentorId="+id;
}


/**
 * 关注
 * @param id
 */
function mentorFocus(id){
	ajax.submit("post",ctxWeb+"/member/mentor/focus",{"mentorId":id},function(data){
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