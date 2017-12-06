var produceArray=new Array();//所有产品集合
var propertyArray=new Array();//所有属性集合
var goodsPhotoScroll=null;
var goodsPhotoListScroll=null;
var goodsJudgeWrapper= null;//评论上拉、下拉刷新
//冒泡事件处理(阻止隔层滚动)
var  oldontouchmove;
var isDisabled;
var preventDefault =function(e){
        e = e || window.event;
        e.preventDefault && e.preventDefault();
        e.returnValue = false;
    }
var disableScroll = function(){
    oldontouchmove = $(".shopCart_warp").ontouchmove;
     $(".shopCart_warp").ontouchmove = preventDefault;
    isDisabled = true;
};

var enableScroll = function(){
    if(!isDisabled){
        return;
    }
     $(".shopCart_warp").ontouchmove = oldontouchmove;
    isDisabled = false;
};
$(function(){
	var windowHeight=document.body.clientHeight;
	var goodsId = $("#goodsId").val();
	//关闭页头同时浏览产品和加入购物车块
	$("#hintShow").on("click",function(){
		$("#hint").hide();
	});
	//商品关联了商品需要跳转页面
	$("#JumpHtml").on("click",function(){
		tip.autoShow("关联商品页面,待开放");
	});
	//备注：memberId需要动态获取,此处代码需要修改
	var designerId = $("#designerId").val();
	
	//页面悬浮按钮控制器（暂时去除）
//	new SuspendBtn();
	//关注（取消关注）设计师
	$("#designerAttentionBtn").on("click",function(){
		var attentionFlag = $("#designerAttentionSpan").attr("data-mark");
		var attentionUrl = ctxWeb+'/member/designer/focus/';
		var data={"designerId":designerId};
		ajax.submit('GET', attentionUrl,data, function(result){
			if(result.status == 1){
				if(attentionFlag == 0){
					$("#designerAttentionSpan").text("取消关注");
					$("#designerAttentionSpan").attr("data-mark",1);
					$("#designerAttentionI").html("");
					tip.autoShow("关注成功");
					//取消关注
				}else {
					$("#designerAttentionSpan").text("关注");
					$("#designerAttentionSpan").attr("data-mark",0);
					$("#designerAttentionI").html("&#xe624;");
					tip.autoShow("取消关注");
				}
			}
		});
		//关注
		
	})
	
	//分享操作
	$("#shareBtn").on("click",function(){
		
	})
	
	//收藏操作
	$("#collectionBtn").on("click",function(){
		var data_mark = $("#collect").attr("data-mark");
		var urlcollectionBtn= ctxWeb+'/member/collectionBtn/'+goodsId;
		ajax.submit('GET',urlcollectionBtn,null,function(result){
		if(result.status == 1){
				if(data_mark == 1){
					$("#iconfontCollect").html('&#xe62c;');
					$("#collect").text("取消");
					$("#collect").attr("data-mark",0);
					tip.autoShow("收藏成功");
				}else{
					$("#iconfontCollect").html('&#xe62d;');
					$("#collect").text("收藏");
					$("#collect").attr("data-mark",1);
					tip.autoShow("取消收藏");
				}
			}
		});
	});

	
	//构造商品属性
	$("div[data-type=produce]",$("#goodsPropertyShade")).each(function(){
		//创建产品对象
		var produceObj=new Produce($(this).attr("data-val"),$(this).attr("data-s"),$(this).attr("data-p"))
		$("div[data-type=producePropValue]",$(this)).each(function(){
			var name="";//属性名
			var val="";//属性值
			//封装属性数组
			var propertyObj=null;
			$("span[data-type=propName]",$(this)).each(function(){
				name=$(this).text();
				for(var i=0;i<propertyArray.length;i++){
					if(propertyArray[i].name==name){
						propertyObj=propertyArray[i];
						return;
					}
				}
				propertyObj=new Property(name);
				propertyArray.push(propertyObj);
			})
			$("span[data-type=pvalue]",$(this)).each(function(){
				val=$(this).text();
				propertyObj.add(val);
			})
			//添加组合属性
			produceObj.add(name,propertyObj.getVal(val));
		})
		//添加产品
		produceArray.push(produceObj);
		
		//页面移除保留数据
		$(this).remove();
		
	})
	//添加属性选择DOM
	propertySelectDOM();
	
	//点击选择产品款式尺码
	var maxHeight=windowHeight*0.7;
	var goodsPropertySelectDivHeight=$("#goodsPropertySelectDiv").height();
	//初始化完选择器高度后隐藏
	//$("#goodsPropertyShade").css("display","none");
	//$("#goodsPropertySelectDiv").offset({top:windowHeight});
	$("#goodsPropertySelectBtn").on("click",function(){
		$("#goodsPropertyShadeDiv").css("display","block");
		document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+0+"px)";
	});
	//购物车按钮点击展示属性选择器
	$("#addShopCarBtn").on("click",function(){
		$("#goodsPropertyShadeDiv").css("display","block");
		document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+-$('#goodsPropertySelectDiv').height()+"px)";
		disableScroll();
		//设置图片尺寸
		$(".img").each(function(){
			$(this).height($(this).width())
		});
	});
	//立即租赁或购买钮点击展示属性选择器
	$("#addNowBtn").on("click",function(){
		$("#goodsPropertyShadeDiv").css("display","block");
		document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+-$('#goodsPropertySelectDiv').height()+"px)";
		disableScroll();
		//设置图片尺寸
		$(".img").each(function(){
			$(this).height($(this).width())
		});
	});
	
	//点击选择产品款式尺码遮罩
	$("#goodsPropertyShadeDiv,#selected_content_close").on("click",function(){
		document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+0+"px)";
		enableScroll()
		$("#goodsPropertyShadeDiv").css("display","none");
			//filtrateScroll.destroy();
			//filtrateScroll=null;
	})
	
	//增加数量事件绑定
	$("#minusSellNumBtn").on("click",function(){
		selectProduce.changeNum(-1)
	})
	//减少数量事件绑定
	$("#addSellNumBtn").on("click",function(){
		selectProduce.changeNum(1)
	})
	//购买数量发生变化时
	$("#sellNumVal").on("change",function(){
		var sellNum=$(this).val();
		try{
			sellNum=parseInt(sellNum);
			if(isNaN(sellNum)){
				sellNum=1;
			}
			if(sellNum<0)
				sellNum=-sellNum
			$(this).val(sellNum)
		}catch(e){
			$(this).val(1)
		}
	});
	//商品属性选择器
	$("#selectPropertySubmit").on("click",function(){
		var produces = selectProduce.getProduces();
		if(produces.length!=1){
			tip.autoShow("请选择商品属性参数!");
			return;
		}
		var sellNum=$("#sellNumVal").val();
		var serviceType=selectProduce.getServiceType();
		if(serviceType=="-1"){
			tip.autoShow("请选择购买方式!");
			return;
		}

		var data={"produce.id":produces[0].id,"num":sellNum,"businessType":serviceType}
		var shoppingCart = ctxWeb+'/member/shoppingCartApi/addToShoppingcart';
		ajax.submit('POST',shoppingCart,data,function(result){
			if(result.status == 1){
				tip.autoShow("加入购物车成功");
			}
		});
		document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+0+"px)";
		enableScroll()
		$("#goodsPropertyShadeDiv").css("display","none");
	});
	
	//点击获取购买方式
	$("span",$("#serviceTypeDiv")).on("click",function(){
		if($(this).attr("class")=="textTabWhiteDisabled"){
			return;
		}
		$("span",$("#serviceTypeDiv")).each(function(){
			$(this).removeClass("active");
		})
		$(this).addClass("active");
	});
	
	
	//点击切换详情和评论效果
	$("#tab_one").on("click",function(){
		if($(this).attr("class")=="active"){
			return;
		}
		$(this).addClass("active");
		$("#tab_two").removeClass("active");
		$("#display_one").show();
		$("#display_two").hide();
	});
	//点击进入评论
	$("#tab_two").on("click",function(){
		if($(this).attr("class")=="active"){
			return;
		}
		$(this).addClass("active");
		$("#tab_one").removeClass("active");
		$("#display_two").show();
		$("#display_one").hide();
	});
	
	//点击获取标签样式
	$("label",$("#pingjiaWarp")).on("click",function(){
		if($(this).attr("class")=="active"){
			return;
		}
		$("label",$("#pingjiaWarp")).each(function(){
			$(this).removeClass("active");
		})
		$(this).addClass("active");
	});
	
	//商品展示图轮播效果
	var bannerPic = $(".slide");
	$("#viewport").height($("#viewport").width());
	$("#goodsPhotoScroll").width($("#viewport").width()*bannerPic.length);
	$(".slide").width($("#viewport").width());
	$("#indicator").width(26*bannerPic.length-18)
	if($("#goodsPhotoWrapper").length>0){
		goodsPhotoScroll = new IScroll('#goodsPhotoWrapper', {
			click:true,
			probeType: 3,
			scrollX: true,
			scrollY: false,
			momentum: false,
			snap: true,
			snapSpeed: 400,
			indicators: {
				el: document.getElementById('indicator'),
				resize: false
			}
		});
	}
	$(".painting").lazyload({effect : "fadeIn"});
	
	//商品描述配置图片配置延迟加载
	$("img",$(".goodsDetail_imageDetail_main")).each(function(){
		var src=$(this).attr("src")
		var img=$(this);
		img.attr("src","");
		img.attr("data-original",src);
		img.attr("data-type","lazyImg");
	})
	$("img[data-type=lazyImg]").lazyload({effect : "fadeIn"});
	
	//图册浏览
	//$("#bigPicviewport").offset({top:windowHeight});
	var bannerPic = $(".bigPic_slide");
	$("#bigPicWrapper").height(document.body.clientWidth);
	$("#bigPicWrapper").css("margin-top",-document.body.clientWidth/2);
	$("#bigPicScroller").width(document.body.clientWidth*bannerPic.length);
	bannerPic.width(document.body.clientWidth);
	$("p",$("#bigPicviewport")).each(function(){
		var text=$(this).text();
		var textArray=text.split("/");
		imgMax=parseInt(textArray[1]);
	})
	$(".painting").on("click",function(){
		$(".bigPic_painting",$("#bigPicScroller")).each(function(){
			if($(this).attr("data-src")=="")
				return;
			$(this).css("background-image","url("+$(this).attr("data-src")+")");
			$(this).attr("data-src","");
		})
		
		//$("#bigPicviewport").css("display","block");
			document.getElementById("bigPicviewport").style.webkitTransform = "translateY("+-$('#bigPicviewport').height()+"px)";
			if(goodsPhotoListScroll==null){
				goodsPhotoListScroll = new IScroll('#bigPicWrapper', {
					click:true,
					probeType: 3,
					scrollX: true,
					scrollY: false,
					momentum: false,
					snap: true,
					snapSpeed: 400,
					bounce:false
				});
				goodsPhotoListScroll.on("scrollEnd",goodsPhotoListScrollEnd)
			}
	});
	$("#bigPicviewport").on("click",function(){
			document.getElementById("bigPicviewport").style.webkitTransform = "translateY("+0+"px)";
			goodsPhotoListScroll.destroy();
			goodsPhotoListScroll=null;
			$("p",$("#bigPicviewport")).each(function(){
				$(this).text("1/"+imgMax);
			})
	});
	
	//猜你喜欢配置
	recommendGoods.init({
		getParameter:recommendGetParameter,
		nextPage:recommendNextPage,
		nextButton:$("#recommendBtn"),
		clear:recommendClear,
		loadUrl:ctxWeb+"/defaultRecommendGoods"
	});
	
})

//图册序号变更
var imgMax=0;
function goodsPhotoListScrollEnd(){
	var imgIndex=this.currentPage.pageX+1;
	$("p",$("#bigPicviewport")).each(function(){
		var text=$(this).text(imgIndex+"/"+imgMax);
	})
}

//属性对象 适配页面
//js中 对象首字母大写，对象内部方法下划线打头
//name 属性名
function Property(name){
	this.name=name;//属性名
	this.selectVal=null;//选中属性值对象
	this.vals=new Array();//属性值集合
	this.add=function(val){//val 属性值
		var propvalue={}
		for(var i=0;i<this.vals.length;i++){
			if(this.vals[i].val==val)//重复属性值不添加
				return;
		}
		propvalue.val=val;//属性值
		propvalue.status=0;//0 可选  1禁止选择
		propvalue.isCheck=false;//是否选中
		this.vals.push(propvalue);
	};
	this.getVal=function(val){//获得属性值对象
		for(var i=0;i<this.vals.length;i++){
			if(val==this.vals[i].val)
				return this.vals[i];
		}
	}
}

//产品对象 适配业务
function Produce(id,s,price){
	this.id=id;//产品ID
	this.s=s;//库存
	this.price=price;//价格
	this.producePropvalues=new Array();//产品组合属性
	this.add=function(name,val){
		var producePropvalue={}
		producePropvalue.name=name;//属性名
		producePropvalue.propVal=val;//属性值
		this.producePropvalues.push(producePropvalue);
	}
}
//属性选择器
var selectProduce={
		selectProperty:new Array(),//已选择属性对象
		_getPropertyByName:function(name){
			for(var i=0;i<propertyArray.length;i++){
				if(propertyArray[i].name==name)
					return propertyArray[i]
			}
		},
		_validateProperty:function(val,producePropvalues){
			for(var j=0;j<producePropvalues.length;j++){
				if(val==producePropvalues[j].propVal.val){
					return true;
				}
			}
			return false;
		},
		_getSelectOther:function(name){
			var array=[];
			for(var i=0;i<this.selectProperty.length;i++){
				if(this.selectProperty[i].name==name)
					continue;
				for(var j=0;j<this.selectProperty[i].vals.length;j++){
					if(this.selectProperty[i].vals[j].isCheck)
						array.push(this.selectProperty[i].vals[j])
				}
			}
			return array;
		},
		_getSeletctProduceFilter:function(propertys){//根据已选择属性，获取可选产品
			var array=[];
			for(var i=0;i<produceArray.length;i++){
				var isAdd=true;
				for(var j=0;j<propertys.length;j++){
					if(!this._validateProperty(propertys[j].val,produceArray[i].producePropvalues)){
						isAdd=false;
						break;
					}
				}
				if(isAdd){
					array.push(produceArray[i])
				}
			}
			return array;
		},
		_propertyFilter:function(property){
			var propertyOther=this._getSelectOther(property.name);//获得其它已选择属性
			var produces=this._getSeletctProduceFilter(propertyOther);//根据其它已选择属性获得可选产品
			//将当前属性下所有属性值变更为不可选，排除已选择
			for(var i=0;i<property.vals.length;i++){
				property.vals[i].status=1;
			}
			for(var i=0;i<produces.length;i++){
				for(var j=0;j<produces[i].producePropvalues.length;j++){
					if(produces[i].producePropvalues[j].name==property.name){
						produces[i].producePropvalues[j].propVal.status=0;//可选择
					}
				}
			}
			
		},
		cancelSelect:function(propVal){//取消选中
			//属性值对象 取消选中状态
			propVal.isCheck=false;
			//移除已选中属性值
			for(var i=0;i<this.selectProperty.length;i++){
				if(this.selectProperty[i].selectVal.val==propVal.val){
					this.selectProperty.splice(i,1);
					break;
				}
			}
		},
		select:function(property,propVal){//选中
			//单选模式,将已选择属性值更换为未选择
			for(var i=0;i<property.vals.length;i++){
				if(property.vals[i].val!=propVal.val&&property.vals[i].isCheck){
					this.cancelSelect(property.vals[i])
					break;
				}
			}
			property.selectVal=propVal;
			//属性值对象 变更选中状态
			propVal.isCheck=true;
			this.selectProperty.push(property);
		},
		getProduces:function(){//获取当前选择项可选择的产品集合
			var array=[];
			for(var i=0;i<produceArray.length;i++){
				var isAdd=true;
				for(var j=0;j<this.selectProperty.length;j++){
					if(!this._validateProperty(this.selectProperty[j].selectVal.val,produceArray[i].producePropvalues)){
						isAdd=false;
						break;
					}
				}
				if(isAdd){
					array.push(produceArray[i])
				}
			}
			return array;
		},
		showPrice:function(produce){
			$("#selectPrice").text("￥"+produce.price)
		},
		showStock:function(produce){
			$("#selectStock").text("库存"+produce.s+"件")
		},
		getServiceType:function(){
			var serviceType="-1";
			$("span",$("#serviceTypeDiv")).each(function(){
				if($(this).attr("class")=="active"){
					serviceType=$(this).attr("date-val");
					return;
				}
			})
			return serviceType;//error 任何模式均未选择
		},
		getStock:function(){//获取当前可选产品库存
			var stock=0;
			var produces=this.getProduces();
			for(var i=0;i<produces.length;i++){
				stock=stock+parseInt(produces[i].s);
			}
			return stock;
		},
		changeNum:function(type){
			var sellNum=$("#sellNumVal").val();
			var stock=this.getStock();
			if(type==1){
				if(sellNum>=stock)
					return;
				//加
				sellNum++;
			}else{
				if(sellNum<=1)
					return;
				//减
				sellNum--;
			}
			$("#sellNumVal").val(sellNum)
		},
		propertyClick:function(name,val){
			var property=this._getPropertyByName(name);
			//属性值对象
			var propVal=property.getVal(val)
			//属性取消选中
			if(propVal!=null&&propVal.isCheck)
				this.cancelSelect(propVal)
			else if(propVal!=null)
				this.select(property,propVal)
			//属性点击后,判断每个属性下属性值是否可选
			for(var i=0;i<propertyArray.length;i++){
				this._propertyFilter(propertyArray[i]);
			}
			var produces=this.getProduces();
			//获得当前属性组合后可选择产品
			if(this.getProduces().length==1){
				this.showPrice(produces[0])
				this.showStock(produces[0])
			}
		}
}

//构造属性选择器DOM
function propertySelectDOM(){
	$("#propertySelect").html("");
	//添加属性选择DOM
	for(var i=0;i<propertyArray.length;i++){
		var propertyDiv=$("<div></div>")
		var html="";
		html+="<div class=goodsDetail_text_line><span></span><p>"+propertyArray[i].name+"</p></div>";
		html+="<div class=goodsDetail_property_selec ><ul>";
		for(var j=0;j<propertyArray[i].vals.length;j++){
			if(propertyArray[i].vals[j].isCheck){
				html+="<li onclick=propertyClick('"+propertyArray[i].name+"','"+propertyArray[i].vals[j].val+"')>";
				html+="<span class=active>";
			}else if(propertyArray[i].vals[j].status==1){
				html+="<li>";
				html+="<span class=textTabWhiteDisabled>";
			}else if(propertyArray[i].vals[j].status==0){
				html+="<li onclick=propertyClick('"+propertyArray[i].name+"','"+propertyArray[i].vals[j].val+"')>";
				html+="<span>";
			}
			html+=propertyArray[i].vals[j].val+"</span></li>";
		}
		html+="</ul></div>";
		propertyDiv.append(html)
		$("#propertySelect").append(propertyDiv);
	}
}

//属性点击
//obj 点击对象，propName 点击项属性名，propVal 点击项属性值
function propertyClick(propName,propVal){
	selectProduce.propertyClick(propName,propVal);
	//重绘选择区DOM
	propertySelectDOM();
}

/**
 * 点击跳转到商品搜索页面
 * @param str
 */
function searchKey(str){
	$("#searchKey").val(str);
	document.searchForm.submit();
}


function recommendGetParameter(){
	return {pageSize:6,serviceType:""}
}

function recommendClear(){
	$("#recommendList").html("");
}

function recommendNextPage(data){
	var ul=$("#recommendList");
	var html="";
	for(var i=0;i<data.length;i++){
		html+="<li><img data-type='"+i+"' data-height='false' src='"+data[i].displayIcon+"' onclick=\"window.location.href='"+ctxWeb+"/goodsInfo/simple/"+data[i].id+"';\" />";
		html+=		"<div>"+data[i].displayTitle+"</div>";
		html+=			"<p>会员价<b>￥"+data[i].displayPrice+"</b></p>";
		html+="</li>";
	}
	ul.html(html);
	//初始化商品列表图片高度
	$("img[data-height=false]",$("#recommendList")).each(function(){
		$(this).height($(this).width())
		$(this).attr("data-height","true")
	})
}


