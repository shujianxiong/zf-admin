$(function(){
	//初始化商品列表图片高度
	$("img[data-type=fanPhotoImg]",$("#fanWrapper")).each(function(){
		$(this).height($(this).width()*0.48)
	})
	$("img[data-type=fanSubphotoImg]",$("#fanWrapper")).each(function(){
		$(this).height($(this).width()*0.85)
	})
	
})



