
$(function(){
	$("#goodsIntroTopPic").height($(window).width())
	
	var goodsId = $("#goodsId").val();
	//构造我猜按钮控制器(暂时去除)
//	var suspendBtn=SuspendBtn(null,"goodsIntro");
	
	//备注：memberId需要动态获取,此处代码需要修改
	var designerId = $("#designerId").val();
	//喜欢操作
	$("#likeBtn").on("click",function(){
		var data_mark = $("#like").attr("data-mark");
		var urllikeBtn= ctxWeb+'/member/likeBtn/'+goodsId;
		ajax.submit('GET',urllikeBtn,null,function(result){
			if(result.status == 1){
				if(data_mark == 1){
					$("#iconfontLike").html('&#xe613;');
					$("#like").text("取消");
					$("#like").attr("data-mark",0);
					tip.autoShow("喜欢成功");
				}else{
					$("#iconfontLike").html('&#xe62b;');
					$("#like").text("喜欢");
					$("#like").attr("data-mark",1);
					tip.autoShow("取消喜欢");
				}
				
			}
		});
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
	//猜你喜欢配置
	recommendGoods.init({
		getParameter:recommendGetParameter,
		nextPage:recommendNextPage,
		nextButton:$("#recommendBtn"),
		clear:recommendClear,
		loadUrl:ctxWeb+"/defaultRecommendGoods"
	});
})

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


