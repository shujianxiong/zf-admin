var type = "buy";
var myScroll = null;
var error= "";
$(function(){
	$("span",".nav").first().addClass("active");
	error = $("#error").val();
	if(error !=null && error !=''){
		tip.autoShow(error);
	}
	initTab();
	myScroll = new MyScroll("#selectContentWarp",{
		header:$("#headerLoading"),
		bottom:$("#bottomLoading"),
		isImgCache:true,
		isPage:true,
		clear:clear,
		headerHeight:30,
		getParameter:getParameter,
		loadUrl:ctxWeb+"/member/minicast/buyHistory",
		loadSuccess:nextPage,
		loadType:3,
		noDataView:"<a href='#this' style='color:white' onclick='javascript:myScroll.refresh()'>当前暂无内容,立即刷新</a>",
		isLoading:false//默认第一次不显示loading
	});
	// 点击下一步触发
	$("#next_1").on('click',next);
});

//下一步  提交
function next(){
	$("#issueMinicastForm").html("");
	var i = 1;
	$("i", "#content").each(function(){
		if(i>3){
			return;
		}
		if($(this).hasClass("selected")){
			$("#issueMinicastForm").append("<input type='hidden' name='goods"+i+".id' value='"+$(this).attr("g_id")+"'>");
			$("#issueMinicastForm").append("<input type='hidden' name='goods"+i+".name' value='"+$(this).attr("g_name")+"'>");
			$("#issueMinicastForm").append("<input type='hidden' name='goods"+i+".icon' value='"+$(this).attr("g_img")+"'>");
			i++;
		}
	});
	
	getType();
	if(type == null || type == ''){
		tip.autoShow("请选择小咖秀商品来源");
		return false;
	}
	$("#issueMinicastForm").append("<input type='hidden' name='minicastGoodsSource' value='"+type+"'>");
	
	if($("input[name^='goods']").length+1 <4){
		tip.autoShow("至少选择一个商品");
		return false;
	}
	
	$("#issueMinicastForm").submit();
}

function getType(){
	$("li","#select-type").each(function(){
		if($("span",this).first().hasClass("active")){
			type = $("span",this).first().attr("type");
			return ;
		}
	});
}


function initTab(){
	$("li",".nav").each(function(){
		$(this).on('click',function(){
			$("span",".nav").removeClass("active");
			$("span",this).first().addClass("active");
			myScroll.isLoading=true;
			myScroll.refresh();
		});
	});
}




function nextPage(list){
	for(var i=0;i<list.length ;i++){
		var html = builderHtml(list[i]);
		$("#content").append(html);
	}
	initImg();
	bindEvent();
}

function bindEvent(){
	$("li[bind_click='0']",$("#content")).each(function(){
		$(this).on('click',function(){
			var i = 0;
			$("li[bind_click='1']",$("#content")).each(function(){
				if($("i",this).first().hasClass("selected")){
					i++;
				}
			});
			if(i<3){
				$("i",this).first().toggleClass("selected");
			}else{
				if($("i",this).first().hasClass("selected")){
					$("i",this).first().toggleClass("selected");
				}else{
					tip.autoShow("最多只能选择3个商品");
				}
			}
		});
		$(this).attr("bind_click","1");
	});
}

function builderHtml(obj){
	var html ="";
		html+="<li bind_click='0'>";
		html+="<div id=''>";
		html+="<img data-type='lazyImg' data-height='false' src='"+ctxMobile+"/img/cachePic.png' data-src='"+obj.icon+"'/>";
		html+="<i class='' g_id='"+obj.goodsId+"' g_img='"+obj.icon+"' g_name='"+obj.name+"'></i>";
		html+="<p>"+obj.name+"</p>";
		html+="</div>";
		html+="</li>";
	myScroll.isLoading=false;
	return html;
}

function getParameter(){
	getType();
	var parameter = {"type":type};
	console.log("-------parameter--------");
	console.log(parameter);
	return parameter;
}

function clear(){
	console.log("--------clear------------------");
	$("#content").html("");
}

function initImg(){
	//初始化商品列表图片高度
	$("img[data-height=false]",$("#content")).each(function(){
		$(this).height($(this).width());
		$(this).attr("data-height","true")
	})
}

