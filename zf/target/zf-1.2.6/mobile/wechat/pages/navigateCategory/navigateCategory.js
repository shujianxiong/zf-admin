$(function(){
	var scroll1=new IScroll("#goodsCategory",{
		click:true, //是否响应click事件
		probeType: 3,
		scrollbars: true,//滚动条可见
        fadeScrollbars: true,//滚动条渐隐
        useTransform: true,//CSS转化
        useTransition: true,//CSS过渡
	});
	
	var scroll2=new IScroll("#fansCategory",{
		click:true, //是否响应click事件
		probeType: 3,
		scrollbars: true,//滚动条可见
        fadeScrollbars: true,//滚动条渐隐
        useTransform: true,//CSS转化
        useTransition: true,//CSS过渡
	});
	
	//初始化分类页
	//设置分类项高度
	$(".sub_content",".content").each(function(){
		$(this).height($(window).width()*0.375)
	});
	$("h2",".goodsCategoryDetail").each(function(){
		$(this).css("line-height",$("#goodsCategoryWarp").height()*0.4+'px')
		console.log($("#goodsCategoryWarp").height())
	});
	//li最多两排
	$("li",".goodsCategoryDetail").each(function(){
		$(this).css("line-height",$("#goodsCategoryWarp").height()*0.3+'px')
	});
	//设置滚动页面区宽度
	var pageNum = $(".subPage");
	var orderItemWrap=$("#navigateCategoryContent");
	orderItemWrap.width($(window).width()*pageNum.length);
	for(var i=0;i<pageNum.length;i++){
		$(pageNum[i]).width($(window).width());
	}
	
	//控制滚动页面
	$("span","#categoryTab").on("click",function(){
		$("span","#categoryTab").each(function(index){
			$(this).removeClass("active")
		})
		$(this).addClass("active");
	})
	
	$("#categoryState").on("click",function(){
		 $("#goodsCategory").animate({left:0});
		 $("#fansCategory").animate({left:$(window).width()});
		 scroll1.refresh();
	});
	
	$("#fanState").on("click",function(){
		 $("#fansCategory").animate({left:0});
		 $("#goodsCategory").animate({left:-$(window).width()});
		 scroll2.refresh();
	});
	//点击分类，展开选项
	$(".sub_content").on("click",function(e){
		for(var i=0;i<e.path.length;i++){
			if(e.path[i].nodeName=="LI")
				return;
		}
		if($(this).attr("data-type")=="1"){
			$(".goodsCategoryDetail",$(this)).fadeIn(500);
			$(this).attr("data-type","0");
			
		}else{
			$(".goodsCategoryDetail",$(this)).fadeOut(500);
			$(this).attr("data-type","1");
		}
		
		e.preventDefault(); 
	})
})

/**
 * 点击跳转到商品搜索页面
 * @param str
 */
function searchKey(str){
	$("#searchKey").val(str);
	document.searchForm.submit();
}
