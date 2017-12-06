var dataBase=null;//数据源
$(function(){
	$("#noContent").html("您暂时还沒有浏览过任何商品哦！")
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
	var defaultGoodsStatusVal = $("#goodsStatus").val();
	$("li",$("#myRecordListTop")).each(function(){
		if($(this).attr("data-type")==defaultGoodsStatusVal){
			$(this).addClass("active");
		}else{
			$(this).removeClass("active");
		}
		if($(this).attr("data-type") != 2){
			$(this).on("click",function(){
				var goodsStatus = $(this).attr("data-type");
				window.location.href=ctxWeb+"/member/myScanRecord/"+goodsStatus;
			})
		}
		
    })
    $("#myRecordListTop_all").on("click",function(){
    	$(".goodsItem").removeClass("edit")
    	$("#removeBox").hide();
    });
    $("#myRecordListTop_edit").on("click",function(){
    	$(".goodsItem").addClass("edit")
    	$("#removeBox").show();
    })

	//我的收藏列表wrapper
	//初始化我的收藏列表滚动区
     var myScroll=new MyScroll("#myGoodsViewWrapper",{
    	isImgCache:true,//启用图片延迟加载
 		clear:clear,//顶部刷新清空原始数据
 		loadType:3,//加载数据类型:0 不加载 1底部加载 2顶部刷新 3底部加载且顶部刷新 ，整型
 		headerHeight:30,//下拉刷新加载框显示高度
		getParameter:getParameter,//传值参数
		bottom:$("#bottomLoading"),//配置底部区
		loadUrl:ctxWeb+"/member/findGoodsViewList",
		loadSuccess:nextPage,//请求成功配置数据
		noDataView:$("#noContent")//请求没有数据提示需在function里面配置$("#noContent").html("显示内容")
	})

})


/**
 * 上拉刷新情况数据,重新加载
 **/
function clear(){
	console.log("--------clear--------")
	var div=$("#oderCondent_goods");
	$("#oderCondent_goods")
	$("li",$("#oderCondent_goods")).each(function(){
		if($(this).attr("id")!="headerLoading"&&$(this).attr("id")!="bottomLoading")
			$(this).remove();
	})
}
/**
 * 获取请求参数
 * @returns
 */
function getParameter(){
	var goodsStatus = $("#goodsStatus").val();
	var param = {"goodsStatus":goodsStatus};
	return param
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

//判断浏览商品的时间间隔
var flag = true;
function compToDate(startDate, endDate){
	if(typeof(startDate)=="string") {
      	startDate=new Date(startDate().replace(/\-/g, "\/"));
    }
	if(typeof(endDate)=="string") {
     	endDate=new Date(endDate.replace(/\-/g, "\/"));
    }
	var showDate = "";
	var ss = parseInt((startDate.getTime()-endDate.getTime())/1000); //秒

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

/**
 * List拼接html
 * @param list
 */
function nextPage(list){
	var nowDate = new Date();
	dataBase = list;
	var loadingLi=$("#bottomLoading");
	var n = {};
	var businessTypeArr = new Array();	// 同一浏览时间
	//获取同一时间浏览的
	for(var i=0; i<list.length; i++){
		if(!n[compToDate(nowDate, list[i].createDate)]){
			n[compToDate(nowDate, list[i].createDate)] = true; 				//存入hash表
			businessTypeArr.push(compToDate(nowDate, list[i].createDate)); 	//把数组的当前项push到无重复数组里面
		}
	}
	console.log(businessTypeArr);
	for(var j=0; j<businessTypeArr.length; j++){
		var html = "";
 		html +="<li>"
        html +=		"<div class='time'>";
        html +=		"<i data-val='0' data-type=\"chooserAllI\" class='iconfont' onclick=\"checkAll(this,'"+businessTypeArr[j]+"')\">&#xe627;</i>";
        html +=			"<p>"+businessTypeArr[j]+"</p>";
        html +=		"</div>";
        html +=	"<div class='oderCondent' divDate='"+businessTypeArr[j]+"'>";
        html +=	"</div>";
        html +=	"</li>";
        loadingLi.before(html);
	}
	//循环拼接同一浏览时间的数据
	for(var i=0;i<list.length; i++){
		html ="";
		var showDate = compToDate(nowDate, list[i].createDate);
		html +=		"<div class='oderItem'>";
        html +=        	"<i class='iconfont' data-val='0' data-time='"+showDate+"' data-id='"+list[i].id+"' onclick=\"check(this,'"+list[i].id+"')\">&#xe627;</i>";
        html +=        	"<div class='img'><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+list[i].goods.icon+"'/></div>";
        html +=        	"<div class='text' >";
        html +=        		"<h2 onclick=window.location.href='"+ctxWeb+"/goodsInfo/simple/"+list[i].goods.id+"'>"+list[i].goods.name+"</h2>";
        html +=        		"<p>库存："+list[i].goods.allExistStock+"</p>";
        html +=        		"<div class='price'>";
        html +=        			"<h2>租金:<span>￥"+list[i].goods.price+"</span></h2>";
        html +=        		"</div>";
        html +=        	"</div>";
        html +=        	"<div class='findAlike' onclick=window.location.href='"+ctxWeb+"/member/findSimilar/"+list[i].goods.id+"'>找相似</div>";
        html += 	"</div>";
        $("div[divDate='"+showDate+"']").append(html);
	}
}


function checkAll(obj,data){
	var val=$(obj).attr("data-val");
	if(val=="0"){
		$(obj).attr("data-val","1")
		$(obj).html("&#xe622;");
		$("i[data-time='"+data+"']",".oderItem").each(function(){
			if($(this).attr("data-val")=="1")
				return;
			check(this,$(this).attr("data-id"))
		})
	}else{
		$(obj).attr("data-val","0")
		$(obj).html("&#xe627;");
		$("i[data-time='"+data+"']",".oderItem").each(function(){
			if($(this).attr("data-val")=="0")
				return;
			check(this,$(this).attr("data-id"))
		})
	}
}
