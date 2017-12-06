$(function(){
	//初始化商品列表图片高度
	$("img[data-type=fanPhotoImg]",$("#fanWrapper")).each(function(){
		$(this).height($(this).width()*0.48)
	});
	$("img[data-type=fanSubphotoImg]",$("#fanWrapper")).each(function(){
		$(this).height($(this).width()*0.85)
	});
	$("#suspendingArea").on("click",function(){
		if($("#functionArea").css("display")=="block"){
			$("#functionArea").css("display","none")
			
		}else{
				$("#functionArea").css("display","block");
			}
	});
	
	$("div[data-type=suspend]",$("#functionArea")).each(function(){
		$(this).on("click",function(){
			$("div[data-type=suspend]",$("#functionArea")).each(function(){
				$(this);.removeClass("active")
			})
				$(this);.addClass("active");
		})
	});

})



