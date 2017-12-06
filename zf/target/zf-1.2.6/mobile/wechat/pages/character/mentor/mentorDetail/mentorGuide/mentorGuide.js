var commentScroll = null;

$(function(){
	//设置图片自适应高度
	$("img",".img").each(function(){
		$(this).height($(this).width()*1.333)
	});
	$("img",".showComment_new").each(function(){
		$(this).height($(this).width())
	});
	$("li",".item").each(function(){
		$(this).height($(this).width()*0.7)
	})
	
	var publishTime = $("#publishTime").attr("data-val");
	
	$("#publishTime").text(pastTime(publishTime));
	
//	var publishTime = $("#publishTime").attr("data-val");
	
	$("#commentTime").text(pastTime($("#commentTime").attr("data-val")));
//	commentScroll=new MyScroll('#contentWrap',{
//		bottom:$("#bottomLoading"),
//		isImgCache:true,
//		isPage:true,
//		loadType:1,
//		headerHeight:45,
//		getParameter:getParameter,
//		loadUrl:ctxWeb+"/mentor/contentList",
//		loadSuccess:nextPage,
//		noDataView:"暂无内容"
//	});
	
})


function getParameter(){
	
}

function nextPage(){
	
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