$(function(){
	//配置列表图片配置延迟加载
	$("img",$(".oderItem")).each(function(){
		var src=$(this).attr("src")
		var img=$(this);
		img.attr("src","");
		img.attr("data-original",src);
		img.attr("data-type","lazyImg");
	})
	$("img[data-type=lazyImg]").lazyload({effect : "fadeIn"});
})