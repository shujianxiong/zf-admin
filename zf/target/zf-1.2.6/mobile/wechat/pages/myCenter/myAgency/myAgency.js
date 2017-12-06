var dataBase=null;//数据源
var goodsViewWrapper=null;
$(function(){
	//点击取消
	$("#cancel").on("click",function(){
		history.go(0);
	})
	//点击确定删除
	$("#remove").on("click",function(){
		var goodsViewIds=[];
		$("i[data-val='1']",$("#myGoodsViewWrapper")).each(function(){
			var goodsViewId = $(this).attr("data-id");
			console.log(goodsViewId);
			goodsViewIds.push(goodsViewId);
		})
		if(goodsViewIds.length <= 0){
			tip.autoShow("请选择您需要删除的商品");
			return;
		}
		/**
		 * 发送ajax请求根据浏览商品ID删除dataBase中数据项，传入dataBase重绘界面）
		 * @param goodsViewIds 收藏夾ids
		 */
		var data = "{";
		for(var i=0; i<goodsViewIds.length; i++){
			data += (i==0 ? "\"goodsViewList["+i+"]\":\"" + goodsViewIds[i] + "\"" : ",\"goodsViewList["+i+"]\":\"" + goodsViewIds[i] + "\""); 
		}
		data+="}";
		console.log(data);
		ajax.submit("post", ctxWeb+"/member/removeGoodsView", $.parseJSON(data), function(data){
			//服务端，收藏夹商品数据更新成功
			if(data.status=="1"){
				tip.autoShow("刪除成功！");
				var goodsViewNum = $("#goodsViewNum").text();//获取删除的数据数量重新赋值到文本
				$("#goodsViewNum").text(goodsViewNum - goodsViewIds.length);
				history.go(0);
				// 移除数据源中对应记录，重绘界面
			}else{
				tip.autoShow("删除失败！");
			}
		});
	})
	$("li","#myRecordListTop").on("click",function(){
     	$("li","#myRecordListTop").each(function(){
    		$(this).removeClass("active")
    	});
    	$(this).addClass("active");
    })
    $("#myRecordListTop_all").on("click",function(){
    	$("#oderCondent_fan").css("display","none");
    	$("#oderCondent_goods").css("display","block");
    	$(".goodsItem").removeClass("edit")
    	$("#removeBox").hide();
    });
    $("#myRecordListTop_fan").on("click",function(){
    	tip.autoShow("功能待完善");
    	$("#oderCondent_goods").css("display","none");
    	$("#oderCondent_fan").css("display","block");
    })	
    $("#myRecordListTop_edit").on("click",function(){
    	$(".goodsItem").addClass("edit")
    	$("#removeBox").show();
    })

	//我的收藏列表wrapper
	//初始化我的收藏列表滚动区
	goodsViewWrapper=new IScroll('#myGoodsViewWrapper',{
		click:true, //是否响应click事件
		probeType: 3,
		scrollbars: true,//滚动条可见
        fadeScrollbars: true,//滚动条渐隐
        useTransform: true,//CSS转化
        useTransition: true,//CSS过渡
	});
	
	myScroll.init({
		scroll:goodsViewWrapper,
		isBottomLoad:true,
		isRefresh:true,
		isImgCache:true,
		clear:clear,
		headerHeight:86,
		getParameter:getParameter,
		bottom:$("#bottomLoading"),//配置底部区
		loadUrl:ctxWeb+"/member/findGoodsViewList",
		loadSuccess:nextPage
	});

})


/**
 * 上拉刷新情况数据,重新加载
 **/
function clear(){
	console.log("--------clear--------")
	var div=$("#oderCondent_goods");
	$("#oderCondent_goods")
	$("div",$("#oderCondent_goods")).each(function(){
		if($(this).attr("id")!="headerLoading"&&$(this).attr("id")!="bottomLoading")
			$(this).remove();
	})
}
/**
 * 获取请求参数
 * @returns
 */
function getParameter(){
	return null;
}

//选择操作
function check(obj,id){
	var data=getDataById(id);
	obj=$(obj);
	var val=obj.attr("data-val");
	if(val=="0"){
		//选中
		obj.attr("data-val","1")
		obj.html("&#xe622;");
		//data.check=true;
	}else{
		obj.attr("data-val","0")
		obj.html("&#xe627;");
		//data.check=false;
	}
}


//根据ID获取源数据
function getDataById(id){
	for(var i=0;i<dataBase.length;i++){
		if(dataBase[i].id==id)
			return dataBase[i];
	}
}

/**
 * List拼接html
 * @param list
 */
function nextPage(list){
	dataBase = list;
	var div=$("#billDetailUl");
	var loadingLi=$("#bottomLoading");
	for(var i = 0; i < list.length; i++) {
	        var result = list[i];
	        var html="";
	        html +="<div class='oderItem'>";
	        html +=        	"<i class='iconfont' data-val='0' data-id='"+list[i].id+"' onclick=\"check(this,'"+list[i].id+"')\">&#xe627;</i>";
	        html +=        	"<div class='img'><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+result.goods.icon+"'/></div>";
	        html +=        	"<div class='text' >";
	        html +=        		"<h2 onclick=window.location.href='"+ctxWeb+"/goodsInfo/simple/"+result.goods.id+"'>"+result.goods.name+"</h2>";
	        html +=        		"<p>库存："+result.goods.allExistStock+"</p>";
	        html +=        		"<div class='price'>";
	        html +=        			"<h2>租金:<span>￥"+result.goods.displayPrice+"</span></h2>";
	        html +=        		"</div>";
	        html +=        	"</div>";
	        html +=        	"<div class='findAlike' onclick=window.location.href='"+ctxWeb+"/member/findSimilar/"+result.goods.id+"'>找相似</div>";
	        html +=        "</div>";
	        loadingLi.before(html);
	}
}