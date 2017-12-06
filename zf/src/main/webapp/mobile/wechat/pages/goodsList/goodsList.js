//筛选条件滚动区
var filtrateScroll=null; 
//商品列表滚动区
var goodsWrapper=null;
//筛选条件集合
var filtrateList=new Array();
var myScroll = null;
$(function(){
	//禁止事件冒泡
	//document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	//初始化商品列表滚动区
	$("#noContent").html("暂无内容")
	goodsWrapper=new MyScroll("#goodsWrapper",{
		bottom:$("#listLoadingLi"),
		isImgCache:true,
		loadType:1,
		getParameter:getParameter,
		loadUrl:"./goods/lists",
		loadSuccess:nextPage,
		noDataView:"<a href='#this' style='color:white' onclick='javascript:myScroll.refresh()'>当前暂无内容</a>",
	})
	
	//滑动速度
	var slideTime=300;
	//重置综合筛选top
	$("#zonghe").offset({top:-$("#zonghe").height()});
	//重置筛选条件top 
	$("#filtrate").offset({top:-$("#filtrate").height()});
	//综合排序滑进滑出
	$("#synthesize").on("click",function(){
		//重置筛选条件top
		$("#filtrate").offset({top:-$("#filtrate").height()});
		$("#filtrate").css("display","none");
		if($("#zonghe").css("display")=="block"){
			$('#zonghe').animate({'top': -$("#zonghe").height() }, slideTime,function(){
				$("#zonghe").css("display","none");
			});
		}else{
			$("#zonghe").css("display","block");
			$('#zonghe').animate({'top': '97px' }, slideTime);
		}
	})
	//筛选条件滑进滑出
	$("#filter").on("click",function(){
		//重置综合筛选top
		$("#zonghe").offset({top:-$("#zonghe").height()});
		$("#zonghe").css("display","none");
		if($("#filtrate").css("display")=="block"){
			$('#filtrate').animate({'top': -$("#filtrate").height() }, slideTime,function(){
				$("#filtrate").css("display","none");
				filtrateScroll.destroy();
				filtrateScroll=null;
			});
		}else{
			$("#filtrate").css("display","block");
			$('#filtrate').animate({'top': '97px' }, slideTime,function(){
				if(filtrateScroll==null){
					//创建筛选条件滑动区
					filtrateScroll=new IScroll('#filtrate',{click:true});
				}
			});
		}
	})
	
	//综合排序勾选
	$("li[data-type=item]",$("#zonghe")).each(function(){
		$(this).on("click",function(){
			$("li[data-type=item]",$("#zonghe")).each(function(){
				var iButton=$(this);
				iButton.removeClass("active")
			})
			var iButton=$(this);
			iButton.addClass("active");
			//收起综合排序
			$('#zonghe').animate({'top': -$("#zonghe").height() }, slideTime,function(){
				$("#zonghe").css("display","none");
			});
			var html=$($("span",iButton)[0]).text()+"<i class='iconfont'>&#xe625;</i>";
			$("#synthesize").html(html)
			$("#sortFlag").val(iButton.attr("data-val"))
			//请求查询
			document.goodsListForm.submit();
		})
 	});
	
	//重置筛选项
	$("#reInput").on("click",clearFiltrate);
	
	//$("#changeArrange").on("click",changeArrangeClick);
	
	//列表显示形状切换
	$("#changeArrange").on("click",function(){
		var ico=$("i",$("#changeArrange"))[0];
		var ul=$("ul",$("#goodsWrapper"))[0]
		if($(ico).attr("data-val")=="0"){
			//块状
			$(ico).html("&#xe619;");
			$(ico).attr("data-val","1")
			$(ul).removeClass("goodsList_vertical");
			$(ul).addClass("goodsList_across");
			$("img",$("#goodsWrapper")).each(function(){
				$(this).height($(this).width())
			});
		}else{
			//列表
			$(ico).html("&#xe61b;");
			$(ico).attr("data-val","0")
			$(ul).removeClass("goodsList_across");
			$(ul).addClass("goodsList_vertical");
			$("img",$("#goodsWrapper")).each(function(){
				$(this).height($(this).width())
			});
		}
	});
	
	//筛选项提交
	$("#confirm").on("click",function(){
		/*if(filtrateList.length<=0){
			tip.autoShow("请选择筛选参数");
			return;
		}*/
		//清空原筛选项
		$("#queryParameter").html("");
		//构造筛选项
		var index=0;
		$("span[data-type=filtrate]").each(function(){
			var span=$(this);
			if(span.attr("class")=="active"){
				$("#queryParameter").append("<input type='hidden' name='goodsPropValueIds["+index+"]' value='"+span.attr("data-val")+"' />")
				index++;
			}
		})
		document.goodsListForm.submit();
	});
	
	//初始化筛选项样式
	$("input",$("#queryParameter")).each(function(){
		var input=$(this);
		$("span[data-type=filtrate]",$("#filtrateScroller")).each(function(){
			if($(this).attr("data-val")==input.val())
				$(this).addClass("active")
		}) 
	})
})

/**
 * 切换横排
 */
//function changeArrangeClick(){
//	var claz = $("#showStyle").attr("class");
//	if("goodsList_across" == claz){
//		$("#showStyle").attr("class","goodsList_vertical");
//	}else{
//		$("#showStyle").attr("class","goodsList_across");
//	}
//	setTimeout("goodsWrapper.refresh()",500);
//}
/**
 * 筛选项点击
 * @param superId
 * @param obj
 */
function filtrateClick(superId,propvalueId,obj){
	$("span",$(obj).parent()).each(function(){
		$(this).removeClass("active");
	})
	$(obj).addClass("active");
	//替换原筛选项值
	var isExist=false;
	for(var i=0;i<filtrateList.length;i++){
		if(filtrateList[i].superId==superId){
			filtrateList[i].val=propvalueId;
			isExist=true;
		}
	}
	//新增筛选项
	if(!isExist){
		var filtrateObj={
				"superId":superId,
				"val":propvalueId
		};
		filtrateList.push(filtrateObj);
	}
}

/**
 * 重置筛选项
 */
function clearFiltrate(){
	$("span",$("#filtrateScroller")).each(function(){
		var iButton=$(this);
		iButton.removeClass("active")
 	});
	filtrateList=new Array();
	//清空原筛选项
	$("#queryParameter").html("");
}

/**
 * 获取请求参数
 * @returns
 */
function getParameter(){
	var sortVal=$("#sortFlag").val();
	var keyWord=$("#keyWordText").val();
	
	var param="{\"sort\":\""+sortVal+"\",\"keyWord\":\""+keyWord+"\"";
	var index=0;
	$("input",$("#queryParameter")).each(function(){
		var input=$(this);
		param+=",\"goodsPropValueIds["+index+"]\":\""+input.val()+"\""
		index++;
	})
	param+="}";
	var obj=$.parseJSON(param);
	return obj
}

/**
 * 下一页渲染
 */
function nextPage(list){
	//此处不需要做状态检测
	//状态检测统一处理
	var ul=$("#goodsListUl");
	var loadingLi=$("#listLoadingLi");
	for(var i=0;i<list.length;i++){
		var html="";
		html+="<li onclick=window.location.href='${ctxWeb}/goodsInfo/simple/${goods.id}'>";
		html+="<div class='li_subWarp'>";
		html+="<div class='buyMode'>";
		if(list[i].isBuyable=="1"){
			html+="<span id='saleAble' class='saleAble'>可售</span>";
		}
		html+="</div>";
		html+="<img data-type='lazyImg' data-height='false' src='${ctxMobile}/img/cachePic.png' data-src='${goods.icon}'/>";		
		html+="<div class='price'>";		
		html+="<h3>${goods.name}</h3>";
		html+="<h2><p>RMB&nbsp;${goods.price}</p>";
		if(list[i].isBuyable=="1"){
			html+="<b>已售${goods.sellNum}</b>";
		}
		html+="</li>";
		html=html.replace("${ctxWeb}",ctxWeb); 
		html=html.replace("${goods.id}",list[i].id); 
		html=html.replace("${ctxMobile}",ctxMobile); 
		html=html.replace("${goods.name}",list[i].name);
		html=html.replace("${goods.icon}",list[i].icon);
		html=html.replace("${goods.price}",list[i].price);
		html=html.replace("${goods.sellNum}",list[i].sellNum);
		loadingLi.before(html);
	}
	//初始化商品列表图片高度
	$("img[data-height=false]",$("#goodsWrapper")).each(function(){
		$(this).height($(this).width())
		$(this).attr("data-height","true")
	})
}


