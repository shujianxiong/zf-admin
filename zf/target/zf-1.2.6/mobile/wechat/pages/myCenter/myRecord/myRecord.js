var dataBase=null;//数据源
var myGoodsCollectWrapper = null;
var myFanCollectWrapper = null;
$(function(){
	//点击取消
	$("#cancel").on("click",function(){
		history.go(0);
	})
	//点击确定删除
	$("#remove").on("click",function(){
		var goodsCollectIds=[];
		$("i[data-val='1']",$("#myGoodsCollectWrapper")).each(function(){
			var goodsCollectId = $(this).attr("data-id");
			console.log(goodsCollectId);
			goodsCollectIds.push(goodsCollectId);
		})
		if(goodsCollectIds.length <= 0){
			tip.autoShow("请选择您需要删除的商品");
			return;
		}
		/**
		 * 发送ajax请求根据收藏商品ID删除dataBase中数据项，传入dataBase重绘界面）
		 * @param goodsCollectIds 收藏夾ids
		 */
		var data = "{";
		for(var i=0; i<goodsCollectIds.length; i++){
			data += (i==0 ? "\"goodsCollectList["+i+"]\":\"" + goodsCollectIds[i] + "\"" : ",\"goodsCollectList["+i+"]\":\"" + goodsCollectIds[i] + "\""); 
		}
		data+="}";
		console.log(data);
		ajax.submit("post", ctxWeb+"/member/removeGoodsCollect", $.parseJSON(data), function(data){
			//服务端，收藏夹商品数据更新成功
			if(data.status=="1"){
				tip.autoShow("刪除成功！");
				var goodsNum = $("#goodsNum").text();//获取删除的数据数量重新赋值到文本
				$("#goodsNum").text(goodsNum - goodsCollectIds.length);
				history.go(0);//删除成功从新加载界面
			}else{
				tip.autoShow("删除失败！");
			}
		});
	})
//	$("li","#myRecordListTop").on("click",function(){
//     	$("li","#myRecordListTop").each(function(){
//    		$(this).removeClass("active")
//    	});
//    	$(this).addClass("active");
//    })

    leftTouch.init({
		mainPanel:$("#goodsItemWap"),
		activeClass:"active",
		isActive:true,
		activePanel:$("#myRecordListTop"),
		initCallBack:function(){//leftTouch->init初始化完成后回调，默认初始化收藏商品scroll
			//收藏商品scroll
			myGoodsCollectWrapper=new MyScroll('#myGoodsCollectWrapper',{
				bottom:$("#bottomLoadingGoods"),
				isImgCache:true,
				loadType:3,
				headerHeight:45,
				getParameter:getParameter,
				loadUrl:ctxWeb+"/member/findGoodsCollectList",
				clear:function(){
					$("#oderCondent_goods").children().each(function(){
						if($(this).attr("class")!= "loadingGoods"){
							$(this).remove();
						}
					});
				},
				loadSuccess:nextPageGoods,
				noDataView:"您暂时还沒有收藏记录哦！<a href='../fanList' style='color:red'>快去看看吧！</a>"
			})
		},
		moveCallBack:function(index){
			if(index==0){//
				myGoodsCollectWrapper.active();
				//销毁收藏范scroll
				if(myFanCollectWrapper!=null){
					myFanCollectWrapper.suspend();
				}
			}
			if(index==1){//收藏商品 leftTouch->movey移动到收藏范
				if(myFanCollectWrapper==null){
					myFanCollectWrapper=new MyScroll('#myFanCollectWrapper',{
						bottom:$("#bottomLoadingFan"),
						isImgCache:true,
						loadType:3,
						headerHeight:45,
						getParameter:getParameter,
						clear:function(){
							$("#myFan_Collect").children().each(function(){
								if($(this).attr("class")!= "loadingFan"){
									$(this).remove();
								}
							});
						},
						loadUrl:ctxWeb+"/member/fanCollectList",
						loadSuccess:nextPageFan,
						noDataView:"您暂时还沒有收藏记录哦！<a href='../fanList' style='color:red'>快去看看吧！</a>"
					})
				}else{
					myFanCollectWrapper.active();
				}
				//销毁收藏商品的scroll
				if(myGoodsCollectWrapper!=null){
					myGoodsCollectWrapper.suspend();
				}
			}
		}
	})
	//商品收藏
	$("#myRecordListTop_all").on("click",function(){
		$("#oderCondent_fan").css("display","none");
    	$("#oderCondent_goods").css("display","block");
    	$("#oderCondent_goods").removeClass("edit")
    	$("#removeBox").hide();
		leftTouch.move(0);
	});
	//范收藏
    $("#myRecordListTop_fan").on("click",function(){
    	$("#oderCondent_goods").css("display","none");
    	$("#oderCondent_fan").css("display","block");
    	$("#removeBox").hide();
    	leftTouch.move(1);
	});
    //编辑
    $("#myRecordListTop_edit").on("click",function(){
    	$("#oderCondent_goods").addClass("edit")
    	$("#removeBox").show();
    })
})


/**
 * 上拉刷新情况数据,重新加载
 **/
function clearGoodsCollect(){
	console.log("--------clear--------")
	var div=$("#oderCondent_goods");
	$("#oderCondent_goods")
	$("div",$("#oderCondent_goods")).each(function(){
		if($(this).attr("id")!="headerLoadingGoods"&&$(this).attr("id")!="bottomLoadingGoods")
			$(this).remove();
	})
}

/**
 * 上拉刷新情况数据,重新加载
 **/
function clearFanCollect(){
	console.log("--------clear--------")
	var div=$("#oderCondent_fan");
	$("#oderCondent_fan")
	$("div",$("#oderCondent_fan")).each(function(){
		if($(this).attr("id")!="headerLoadingFan"&&$(this).attr("id")!="bottomLoadingFan")
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
function nextPageGoods(list){
	dataBase = list;
	var div=$("#billDetailUl");
	var loadingLi=$("#bottomLoadingGoods");
	for(var i = 0; i < list.length; i++) {
	        var result = list[i];
	        var html="";
	        html +="<div class='sub_content'>";
	        html +="<div class='oderItem'>";
	        html +=        	"<i class='iconfont' data-val='0' data-id='"+list[i].id+"' onclick=\"check(this,'"+list[i].id+"')\">&#xe627;</i>";
	        html +=        	"<div class='img'><img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+result.goods.icon+"'/></div>";
	        html +=        	"<div class='text' >";
	        html +=        		"<h2 onclick=window.location.href='"+ctxWeb+"/goodsInfo/simple/"+result.goods.id+"'>"+result.goods.name+"</h2>";
	        html +=        		"<p>库存："+result.goods.allExistStock+"</p>";
	        html +=        		"<div class='price'>";
	        html +=        			"<h2>租金:<span>￥"+result.goods.price+"</span></h2>";
	        html +=        		"</div>";
	        html +=        	"</div>";
	        html +=        	"<div class='findAlike' onclick=window.location.href='"+ctxWeb+"/member/findSimilar/"+result.goods.id+"'>找相似</div>";
	        html +=        "</div>";
	        html += "</div>";
	        loadingLi.before(html);
	}
}

/**
 * List拼接html
 * @param list
 */
function nextPageFan(list){
//	dataBase = list;
	var loadingLi=$("#bottomLoadingFan");
	for(var i = 0; i < list.length; i++) {
	        var result = list[i];
	        var html="";
	        html += "<li class='content_main_match_warp'>";
	        html += "<div id='' class='content_main_match_pic'>";
	        html += "	<img  src='"+result.fan.photoUrl+"' />";
	        html += "	<span id='' class='likeNum'>";
	        html += "		<i class='iconfont'>&#xe613;</i>";
	        html += "		<b>1.2万</b>";
        	html += "	</span>";
    		html += "</div>";
			html += "<ul class='content_main_match_subpic'>";
			html += "    <li>";
			html += "        <img data-type='lazyImg' src='"+ctxMobile+"/img/cachePic.png' data-src='"+result.fan.subphotoUrl1+"'/>";
			html += "   </li>";
			html += "   <li>";
			html += "       <img data-type='lazyImg' src='"+ctxMobile+"/img/cachePic.png' data-src='"+result.fan.subphotoUrl2+"'/>";
			html += "  </li>";
			html += " </ul>";
	        html += "</li>";
	        loadingLi.before(html);
	}
}