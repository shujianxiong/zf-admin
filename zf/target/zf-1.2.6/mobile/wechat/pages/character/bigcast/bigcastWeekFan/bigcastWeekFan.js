var bcFanScroll = null;

$(function(){
	//设置图片区域尺寸
	$(".content_top_pic").height($(".content_top_pic").width());
	$(".content_top_pic img").height($(".content_top_pic img").width());
	//设置选择器top
	
	
	$(".headPic").height($(".headPic").width());
	$(".fansArea img").height($(".fansArea img").width());
	
	$("img[data-type='lazyImg']").height($("img[data-type='lazyImg']").width());
	

	
	//初始化大咖范Scroll	
	bcFanScroll=new MyScroll('#bigcastWeekFanWarp',{
					bottom:$("#bcFanLoading"),
					isImgCache:true,
					isPage:true,
					loadType:1,
					headerHeight:45,
					getParameter:getParameter,
					clear:function(){
						$(".contentItem").remove();
					},
					loadUrl:ctxWeb+"/bigcast/bcFansList",
					loadSuccess:loadData,
					noDataView:"暂无内容"
				})
	
});

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
 * 参数获取
 * @returns
 */
function getParameter(){
	var bigcastId = $("#bigcastId").val();//大咖ID
	var param="{\"bigcastId\":\""+bigcastId+"\"}";
	var obj=$.parseJSON(param);
	return obj
}

/**
 * 数据加载
 * @param list
 */
function loadData(list){
	var html = "";
	for (var i=0; i<list.length; i++) {
		var bcFan = list[i];
		var photoUrlsArray = new Array();
		photoUrlsArray = bcFan.photoUrls.split("|");
		html+="<div class='contentItem'><div class='content_top'><div class='content_top_pic' >"
		html+="<img data-type='lazyImg' src="+bcFan.bigcast.avatarUrl+"/></div>";
		html+="<span class='content_top_name'>";
		html+="<p>"+bcFan.bigcast.name+"</p>";
		html+="<span>"
		html+="<i class='iconfont'>&#xe60e;</i>"+pastTime(bcFan.publishDate);
		html+="<b>(第"+bcFan.publishWeeknum+"周)</b></span></span></div>";
		html+="<p>"+bcFan.summary+"</p>";
		html+="<div class='contentItem_pic'>";
		for (var j=1; j<photoUrlsArray.length, j<4; j++) {//因第一个元素为空，索引从1开始且最多只显示三张图片
			html+="<span><img data-type='lazyImg' src='"+photoUrlsArray[j]+"'/></span>";
		}
		html+="</div>";
		html+="</div>";
	}
	$("#bcFanLoading").before(html);
}

/**
 * 关注
 * @param id
 */
function bigCastFocus(id){
	ajax.submit("post","./member/bigcast/focus",{"bigcastId":id},function(data){
		if(data.status=="1"){
			var obj=$("#attentionIcon");
			var numObj=$("#fansNum");
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
