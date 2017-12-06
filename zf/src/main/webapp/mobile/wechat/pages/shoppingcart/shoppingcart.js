//列表滚动区
var shoppingcartWarpper=null;
var windowHeight=$(window).height();
var dataBase=null;//数据源
//冒泡事件处理(阻止隔层滚动)
var  oldontouchmove;
var isDisabled;
var preventDefault =function(e){
        e = e || window.event;
        e.preventDefault && e.preventDefault();
        e.returnValue = false;
    }
var disableScroll = function(){
    oldontouchmove = window.ontouchmove;
    window.ontouchmove = preventDefault;
    isDisabled = true;
};

var enableScroll = function(){
    if(!isDisabled){
        return;
    }
    window.ontouchmove = oldontouchmove;
    isDisabled = false;
};
//购物车产品对象封装
function ShoppingProduce(shoppoingId,goodsId,produceId,num,check,data){
	this.id=shoppoingId;
	this.goodsId=goodsId;
	this.produceId=produceId;
	this.num=num;
	this.check=check;
	this.data=data;//原始购物车产品数据
}

$(function(){
	//设置图片尺寸
	$(".img","#shoppingcartWarpper").each(function(){
		$(this).height($(this).width())
	});
	// $(".edit",".content_warp").each(function(){
	// 	$(this).height($("div[class=img]").height())
	// });
//	new SuspendBtn(null,"shoppingcart"); 	// 我猜按钮
	
	ajax.submit("post","./shoppingcartApi/list",getParameter(),function(data){
		var array=[];
		var shoppingProduce=null
		if(data.data!=null){
			for(var i=0;i<data.data.length;i++){
				shoppingProduce=new ShoppingProduce(data.data[i].id,data.data[i].produce.goods.id,data.data[i].produce.id,data.data[i].num,false,data.data[i]);
				array.push(shoppingProduce)
			}			
		}
		dataBase=array;
		nextPage(dataBase);
	})
	
	$("#businessTypeBtn").on("click",function(){
		if($("#businessTypeDiv").css("display") == "none"){
			$("#businessTypeDiv").css("display","block");
		}else {
			$("#businessTypeDiv").css("display","none");
		}
	});
	
	// 点击购物车商品类型过滤下拉框
	$("li[data-type=businessType]",$("#businessTypeBtn")).each(function(){
		$(this).on("click",function(){
			$("#businessType").val($(this).attr("data-value"));
			//请求查询
			document.shoppingcartForm.submit();
		});
	});
	
	// 点击“编辑”按钮
	$("#editorBtn").on("click",function(){
		if($("#editorBtn").attr("data-type") == "yes"){
			// 进行编辑
			$("#editorBtn").html("编辑");
			$("div[data-type=editorGoodsInfo]").css("display","block");
			$("div[data-type=editorBuyInfo]",$("#shoppingcartWarpper")).css("display","none");
			$("#editorTotalprice").css("display","none");
			$("#editorPay").css("display","none");
			$("#editorDelete").css("display","block");
			$("#editorCollect").css("display","block");
			$("#editorBtn").attr("data-type","no");	// 设置结束
		}else if($("#editorBtn").attr("data-type") == "no"){
			// 进行选购
			$("#editorBtn").html("选购");
			$("div[data-type=editorGoodsInfo]").css("display","none");
			$("div[data-type=editorBuyInfo]",$("#shoppingcartWarpper")).css("display","block");
			$("#editorTotalprice").css("display","block");
			$("#editorPay").css("display","block");
			$("#editorDelete").css("display","none");
			$("#editorCollect").css("display","none");
			$("#editorBtn").attr("data-type","yes");		// 设置结束
		}return
	});
	
	//初始化完选择器TOP

	//初始化完选择器高度后隐藏 
	
	//$("#goodsPropertySelectDiv").offset({top:$(window).height()});
	$("#goodsPropertySelectDiv").css("display","block");
	$("#goodsPropertyShadeDiv").on("click",function(){
		$("#goodsPropertyShadeDiv").css("display","none");
		document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+0+"px)";
		enableScroll()
	});
	$("i",$("#selected_content_close")).on("click",function(){
		$("#goodsPropertyShadeDiv").css("display","none");
		document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+0+"px)";
		enableScroll()
	})
	
	//头部提示内容
	$("i",$(".hint")).on("click",function(){
		$(this).parent().css("display","none")
	})
	//属性选择器面板确定操作
	$("#selectPropertySubmit").on("click",function(){
		var produces=selectProduce.selectProduces;
		var shoppingGoodsId=$("#shadeTitle").attr("data-shoppingId");//获取原购物车商品ID
		if(produces.length!=1){
			tip.autoShow("请选择产品规则参数!");
			return;
		}
		//产品选择是否重复
		for(var i=0;i<dataBase.length;i++){
			if(dataBase[i].produceId==produces[0].id){
				tip.autoShow("当前规格的产品您已经选择过!");
				return;
			}
		}
		//数量
		var num=$("#sellNumVal").val();
		/**
		 * 发送ajax请求变更服务器购物车产品和数量
		 * @param shoppingProduce.id 购物车产品ID
		 * @param produces[0].id 新的产品ID
		 * @param num 数量
		 */
		var shoppingProduce = getDataByShoppingGoodsId(shoppingGoodsId);
		var newProduceId = produces[0].id;
		var data={"shoppingcartProduceId":shoppingProduce.id, "newProduceId":newProduceId, "num":num};
		ajax.submit("post", "./shoppingcartApi/updateProduceAndNum", data, function(data){
			//服务端，购物车数据更新成功
			if(data.status=="1"){
				//替换商品下产品数据,保留原始商品数据,重置数量，重绘界面
				shoppingProduce.data.produce=produces[0].data;
				shoppingProduce.produceId=produces[0].id;
				shoppingProduce.num=num;
				
				nextPage(dataBase);
				$("#goodsPropertyShadeDiv").css("display","none");
				document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+0+"px)";
			}else{
				tip.autoShow("产品变更失败！");
			}
		});
	});
	// 属性选择器面板数量变更
	$("#minusSellNumBtn").on("click",function(){
		selectProduce.changeNum("#sellNumVal",0);
	})
	$("#addSellNumBtn").on("click",function(){
		selectProduce.changeNum("#sellNumVal",1);
	})
	// 全选操作
	$("#checkAllBtn").on("click",function(){
		checkAll();
	})
	
	// 结算
	$("#editorPay").on("click",function(){
		var shoppingGoodsIds=[];
		var shoppingGoodsNums=[];
		$("i[data-val='1']",$("#shoppingcartWarpper")).each(function(){
			var shoppingGoodsId = $(this).attr("data-id");
			if(shoppingGoodsId != null && shoppingGoodsId != ""){
				shoppingGoodsIds.push(shoppingGoodsId);	
				shoppingGoodsNums.push();
			}
		})
		if(shoppingGoodsIds.length<=0){
			tip.autoShow("请选择您需要结算的商品");
			return;
		}

		// form表单添加参数
		$("#orderConfirmForm").html("");
		var idParamHtml = "";
		var numParamHtml = "";
		for(var i=0; i<shoppingGoodsIds.length; i++){
			idParamHtml = "<input type=\"hidden\" name=\"shoppingcartIds["+i+"]\" value=\""+shoppingGoodsIds[i]+"\"/>";
			numParamHtml = "<input type=\"hidden\" name=\"shoppingcartNums["+i+"]\" value=\""+getDataByShoppingGoodsId(shoppingGoodsIds[i]).num+"\"/>";
			$("#orderConfirmForm").append(idParamHtml);
			$("#orderConfirmForm").append(numParamHtml);
		}
		document.orderConfirmForm.submit();
	});
	
	// 移到收藏夹
	$("#editorCollect").on("click",function(){
		var shoppingGoodsIds=[];
		$("i[data-val='1']",$("#shoppingcartWarpper")).each(function(){
			var shoppingGoodsId = $(this).attr("data-id");
			if(shoppingGoodsId != null && shoppingGoodsId != ""){
				shoppingGoodsIds.push(shoppingGoodsId);				
			}
		})
		if(shoppingGoodsIds.length<=0){
			tip.autoShow("请选择您需要移到收藏夹的商品");
			return;
		}
		/**
		 * 发送ajax请求将服务器购物车产品移动到收藏夹（ajax成功后，根据购物车ID删除dataBase中数据项，传入dataBase重绘界面）
		 * @param shoppingcartIds 购物车ids
		 */
		var data = "{";
		for(var i=0; i<shoppingGoodsIds.length; i++){
			data += (i==0 ? "\"shoppingcartIds["+i+"]\":\"" + shoppingGoodsIds[i] + "\"" : ",\"shoppingcartIds["+i+"]\":\"" + shoppingGoodsIds[i] + "\""); 
		}
		data+="}";
		ajax.submit("post", "./shoppingcartApi/moveToFavorite", $.parseJSON(data), function(data){
			//服务端，购物车数据更新成功
			if(data.status=="1"){
				// 移除数据源中对应记录，重绘界面
				for(var i=0; i<shoppingGoodsIds.length; i++){
					for(var j=0; j<dataBase.length; j++){
						if(shoppingGoodsIds[i] == dataBase[j].id){
							dataBase.splice(j, 1);
							break;
						}
					}
				}
				nextPage(dataBase);
				$('#goodsPropertySelectDiv').animate({'top': windowHeight }, 300,function(){
					$("#goodsPropertyShade").css("display","none");
				});
			}else{
				tip.autoShow("产品移至收藏夹失败！");
			}
		});
	});
	
	// 删除操作
	$("#editorDelete").on("click",function(){
		var shoppingGoodsIds=[];
		$("i[data-val='1']",$("#shoppingcartWarpper")).each(function(){
			var shoppingGoodsId = $(this).attr("data-id");
			shoppingGoodsIds.push(shoppingGoodsId);
		})
		if(shoppingGoodsIds.length<=0){
			tip.autoShow("请选择您需要移到删除的商品");
			return;
		}
		/**
		 * 发送ajax请求将服务器购物车产品删除（ajax成功后，根据购物车ID删除dataBase中数据项，传入dataBase重绘界面）
		 * @param shoppingcartIds 购物车ids
		 */
		var data = "{";
		for(var i=0; i<shoppingGoodsIds.length; i++){
			data += (i==0 ? "\"shoppingcartIds["+i+"]\":\"" + shoppingGoodsIds[i] + "\"" : ",\"shoppingcartIds["+i+"]\":\"" + shoppingGoodsIds[i] + "\""); 
		}
		data+="}";
		ajax.submit("post", "./shoppingcartApi/deleteFromShoppingcart", $.parseJSON(data), function(data){
			//服务端，购物车数据更新成功
			if(data.status=="1"){
				// 移除数据源中对应记录，重绘界面
				for(var i=0; i<shoppingGoodsIds.length; i++){
					for(var j=0; j<dataBase.length; j++){
						if(shoppingGoodsIds[i] == dataBase[j].id){
							dataBase.splice(j, 1);
							break;
						}
					}
				}
				nextPage(dataBase);
				$('#goodsPropertySelectDiv').animate({'top': windowHeight }, 300,function(){
					$("#goodsPropertyShade").css("display","none");
				});
			}else{
				tip.autoShow("产品删除失败！");
			}
		});
	});
});



/**
 * 获取请求参数
 * @returns
 */
function getParameter(){
	var businessType	= $("#businessType").val();			// 购物车商品类型
	var param="{\"businessType\":\""+businessType+"\"}";
	return $.parseJSON(param);
}

/**
 * 下一页渲染
 */
function nextPage(list){
	/**此处不需要做状态检测 状态检测统一处理*/
	var shoppingcartList = $("#shoppingcartWarpper");
	//购物车产品类型去重
	var n = {};
	var businessTypeArr = new Array();							// 购物车产品类型
	for(var i=0; i<list.length; i++){
		if(!n[list[i].data.businessType]){
			n[list[i].data.businessType] = true; 				//存入hash表
			businessTypeArr.push(list[i].data.businessType); 	//把数组的当前项push到无重复数组里面
		}
	}
	var html = "";
	if(($("#businessType").val()==null || $("#businessType").val()=="") && businessTypeArr.length <= 0){
		html = "<p style=\"margin-left: 10px;\">您的购物车空空如也！</p>";
	}else {
		//此处进行类型的固定排序
		var businessTypeSortArr = [["11","租赁"],["21","购买"],["12","预租"],["22","预购"]];	// 产品类型排序顺序<对应数据字典bus_businessType>
		for(var s=0; s<businessTypeSortArr.length; s++){
			for(var i=0; i<businessTypeArr.length; i++){
				if(businessTypeArr[i] == businessTypeSortArr[s][0]){
					var type = businessTypeSortArr[s][0];
					var str  = businessTypeSortArr[s][1];
					html += "<div class=\"head\">";
					html += 	"<i data-val='0' data-type=\"chooserAllI\" class='iconfont' onclick=\"serviceCheckAll(this,'"+type+"')\">&#xe627;</i>";
					html += 	"<span service-type='"+type+"'>"+str;
					html += 	"</span>";
					html += "</div>";
					for(var j=0; j<list.length; j++){
						if(list[j].data.businessType == businessTypeArr[i]){
							html += "<div class=\"content_warp\">";
							html += 	"<ul>";
							html += 		"<li>";
							html += 			"<div class='icon'>";
							if(list[j].check){
								html +=				"<i data-type='"+type+"' data-val='1' data-id='"+list[j].id+"' class='iconfont' onclick=\"check(this,'"+list[j].id+"')\">&#xe622;</i>";
							}else{
								html +=				"<i data-type='"+type+"' data-val='0' data-id='"+list[j].id+"' class='iconfont' onclick=\"check(this,'"+list[j].id+"')\">&#xe627;</i>";
							}
							html +=		        "</div>";
							html += 			"<div class=\"img\"><img src=\""+list[j].data.produce.goods.displayPhoto+"\"/></div>";
							html += 			"<div data-type=\"editorGoodsInfo\" class=\"text\" style=\"display: block;\" onclick=''>";
							html += 				"<h2>"+list[j].data.produce.goods.displayTitle+"</h2>";
							html += 				"<p>"+list[j].data.produce.produceName+"</p>";
							html += 				"<span class=\"Stock\">[库存：<b>"+list[j].data.produce.existStock+"件]</b></span>";
							html += 				"<h2>押金:<span>￥"+list[j].data.produce.hireDeposit+"</span></h2>";
							html += 				"<h2>购买价:<span>￥"+list[j].data.produce.buyPrice+"</span></h2>";
							html += 			"</div>";
							html += 			"<div data-type=\"editorBuyInfo\" class=\"edit\" style=\"display: none;\">";
							html += 				"<div data-type=\"operatorNum\" class=\"inputArea\">";
							html += 					"<b onclick=\"changeNum(0,this,'"+list[j].id+"')\">-</b>";
							html += 					"<input type=\"tel\" data-value=\""+list[j].data.produce.existStock+"\" value=\""+list[j].num+"\"/>";
							html += 					"<b onclick=\"changeNum(1,this,'"+list[j].id+"')\">+</b>";
							html += 				"</div>";
							html += 				"<div class='selected_area' onclick=\"showPropertyPanel('"+list[j].id+"','"+list[j].data.produce.goods.id+"','"+list[j].data.produce.goods.displayPhoto+"')\">";
							html += 					"<p>"+list[j].data.produce.produceName+"</p>";
							html += 					"<i class=\"iconfont\">&#xe628;</i>";
							html += 				"</div>";
							html += 			"</div>";
							html += 		"</li>";
							html += 	"</ul>";
							html += "</div>";
						}
					}
				}
			}
		}
	}
	shoppingcartList.html(html);
	
	//设置图片尺寸,多选按钮图标位置
	$(".img","#shoppingcartWarpper").each(function(){
		$(this).height($(this).width())
	});
}


//打开属性选择器面板
function showPropertyPanel(shoppingGoodsId,goodsId,goodsImg){
	var defaultData=getDataByShoppingGoodsId(shoppingGoodsId);
	$("#shadeTitle").attr("data-shoppingId",shoppingGoodsId);//保存购物车商品ID
	ajax.submit("post","./shoppingcartApi/getGoodsAndProduces",{"goodsId":goodsId},function(data){
		//重置数量选择器数量
		$("#sellNumVal").val(defaultData.num);
		//构造属性和产品对象
		$("#goodsPropertyImg").attr("src",goodsImg)
		var goods=new Goods(goodsId,data);
		var g=data.data;
		if(g.produces==null||g.produces.length<=0){
			tip.autoShow("当前商品没有相关规格可选")
			return;
		}
		var produce=null;
		var property=null 
		for(var i=0;i<g.produces.length;i++){
			produce=new Produce(g.produces[i].id,goodsId,g.produces[i].existStock,g.produces[i].buyPrice);
			for(var x=0;x<g.produces[i].producePropValues.length;x++){
				var producePropValue=g.produces[i].producePropValues[x];
				var name=producePropValue.property.propName;
				var val=producePropValue.propvalue==null?producePropValue.pvalue:producePropValue.propvalue.pvalueName;
				property=getProperty(name,goods);
				property.add(val);
				produce.add(name,property.getVal(val));
				produce.data=g.produces[i];
			}
			goods.produces.push(produce);
		}
		//选择器面板初始化
		selectProduce.init(function(){return [goods]});
		//初始化原始选中项
		for(var i=0;i<defaultData.data.produce.producePropValues.length;i++){
			var producePropValue=defaultData.data.produce.producePropValues[i];
			var name=producePropValue.property.propName;
			var val=producePropValue.propvalue==null?producePropValue.pvalue:producePropValue.propvalue.pvalueName;
			selectProduce.propertyClick(name,val,goods);
		}
		//绘制面板
		propertySelectDOM(goods);
		var SelectScroll =new IScroll("#goodsPropertySelectDiv",{click:true});
		//展开面板
		$("#goodsPropertyShade").css("display","block");
		$("#goodsPropertyShadeDiv").css("display","block");
		document.getElementById("goodsPropertySelectDiv").style.webkitTransform = "translateY("+-$('#goodsPropertySelectDiv').height()+"px)";
		disableScroll();
		
	//设置图片尺寸
	$(".img").each(function(){
		$(this).height($(this).width())
	});
	})
}

//数量变更
function changeNum(type,obj,id){
	var data=getDataByShoppingGoodsId(id);
	var input=$("input",$(obj).parent())[0];
	var val=$(input).val();
	if(type==1){
		//增加
		val++
		if(val<=data.data.produce.existStock){
			$(input).val(val)
			data.num=val;
		}
	}else{
		//减少
		val--;
		if(val>0){
			$(input).val(val)
			data.num=val;
		}
	}
	count();
}

//根据ID获取源数据
function getDataByProduceId(id){
	for(var i=0;i<dataBase.length;i++){
		if(dataBase[i].produceId==id)
			return dataBase[i];
	}
}

//根据ID获取源数据
function getDataByShoppingGoodsId(id){
	for(var i=0;i<dataBase.length;i++){
		if(dataBase[i].id==id)
			return dataBase[i];
	}
}

//选择操作
function check(obj,shoppingGoodsId){
	var data=getDataByShoppingGoodsId(shoppingGoodsId);
	obj=$(obj);
	var val=obj.attr("data-val");
//	console.log(shoppingGoodsId)
	if(val=="0"){
		//选中
		obj.attr("data-val","1")
		obj.html("&#xe622;");
		data.check=true;
	}else{
		obj.attr("data-val","0")
		obj.html("&#xe627;");
		data.check=false;
	}
	//计算金额
	count();
}

//单业务下全选
function serviceCheckAll(obj,type){
	var val=$(obj).attr("data-val");
	if(val=="0"){
		$(obj).attr("data-val","1")
		$(obj).html("&#xe622;");
		$("i[data-type='"+type+"']",".icon").each(function(){
			if($(this).attr("data-val")=="1")
				return;
			check(this,$(this).attr("data-id"))
		})
	}else{
		$(obj).attr("data-val","0")
		$(obj).html("&#xe627;");
		$("i[data-type='"+type+"']",".icon").each(function(){
			if($(this).attr("data-val")=="0")
				return;
			check(this,$(this).attr("data-id"))
		})
	}
	count();
}

//全部选中或取消
function checkAll(){
	var btn=$("#checkAllBtn");
	if(btn.attr("data-val")=="0"){
		btn.attr("data-val","1");
		btn.html("&#xe622;");
		//数据源全选
		for(var i=0;i<dataBase.length;i++){
			dataBase.check=true;
		}
		//界面全选
		$("i[data-val='0']",$("#shoppingcartWarpper")).each(function(){
			$(this).attr("data-val","1");
			$(this).html("&#xe622;");
		})
	}else{
		btn.attr("data-val","0");
		btn.html("&#xe627;");
		//数据源全选
		for(var i=0;i<dataBase.length;i++){
			dataBase.check=false;
		}
		//界面全选
		$("i[data-val='1']",$("#shoppingcartWarpper")).each(function(){
			$(this).attr("data-val","0");
			$(this).html("&#xe627;");
		})
	}
	count();
}

//金额计算
function count(){
	var allMoney=0;
	if($("i[data-val='1']",$("#shoppingcartWarpper")).length<=0){
		$("#allMoneySpan").text("￥0")
	}
	$("i[data-val='1']",$("#shoppingcartWarpper")).each(function(){
		var shoppingGoodsId = $(this).attr("data-id");
		if(shoppingGoodsId != null){
			var data=getDataByShoppingGoodsId(shoppingGoodsId);
			//根据data中数据显示总计金额（租赁/预租计算租赁押金，购买/预购计算购买金额）
			if($(this).attr("data-type") == "11" || $(this).attr("data-type") == "12"){
				allMoney += data.data.produce.hireDeposit*data.num;
			}else if($(this).attr("data-type") == "21" || $(this).attr("data-type") == "22"){
				allMoney += data.data.produce.buyPrice*data.num;
			}
		}
	})
	$("#allMoneySpan").text("￥"+allMoney)
}

function getProperty(name,goods){
	for(var i=0;i<goods.propertys.length;i++){
		if(goods.propertys[i].name==name)
			return goods.propertys[i];
	}
	var property=new Property(name);
	goods.propertys.push(property);
	return property;
}

//构造属性选择器DOM
function propertySelectDOM(goods){
	$("#propertySelect").html("");
	$("h2",$("#shadeTitle")).each(function(){
		$(this).text(selectProduce.selectProduces[0].data.goods.displayTitle)
	})
	$("span",$("#shadeTitle")).each(function(){
		$(this).text("库存"+selectProduce.getStock()+"件")
	})
	$("p[data-type=hireDeposit]",$("#shadeTitle")).each(function(){
		$(this).text("押金:￥"+selectProduce.selectProduces[0].data.hireDeposit)
	})
	$("p[data-type=buyPrice]",$("#shadeTitle")).each(function(){
		$(this).text("购买价:￥"+selectProduce.selectProduces[0].data.buyPrice)
	})
	
	//添加属性选择DOM
	for(var i=0;i<goods.propertys.length;i++){
		var propertyDiv=$("<div></div>")
		var html="";
		html+="<div class=goodsDetail_text_line><span></span><p>"+goods.propertys[i].name+"</p></div>";
		html+="<div class=goodsDetail_property_selec ><ul>";
		for(var j=0;j<goods.propertys[i].vals.length;j++){
			if(goods.propertys[i].vals[j].isCheck){
				html+="<li onclick=\"propertyClick('"+goods.propertys[i].name+"','"+goods.propertys[i].vals[j].val+"')\" >";
				html+="<span class=active>";
			}else if(goods.propertys[i].vals[j].status==1){
				html+="<li>";
				html+="<span class=textTabWhiteDisabled>";
			}else if(goods.propertys[i].vals[j].status==0){
				html+="<li onclick=\"propertyClick('"+goods.propertys[i].name+"','"+goods.propertys[i].vals[j].val+"')\" >";
				html+="<span>";
			}
			html+=goods.propertys[i].vals[j].val+"</span></li>";
		}
		html+="</ul></div>";
		propertyDiv.append(html)
		$("#propertySelect").append(propertyDiv);
	}
	
}

//属性点击
//obj 点击对象，propName 点击项属性名，propVal 点击项属性值
function propertyClick(propName,propVal){
	if(selectProduce.goodsArray.length<=0)
		return;
	var goods=selectProduce.goodsArray[0];
	selectProduce.propertyClick(propName,propVal,goods);
	//重绘选择区DOM
	propertySelectDOM(goods);
}
//阻止事件冒泡
//	$("#goodsPropertySelectDiv").on("touch",function(){
// 		preventDefault()
// });
