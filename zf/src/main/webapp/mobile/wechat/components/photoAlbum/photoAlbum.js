var goodsPhotoScroll=null;
$(function(){
	//图册浏览
	//$("#bigPicviewport").offset({top:windowHeight});
	var bannerPic = $(".bigPic_slide");
	$("#bigPicWrapper").height(document.body.clientWidth);
	$("#bigPicWrapper").css("margin-top",-document.body.clientWidth/2);
	$("#bigPicScroller").width(document.body.clientWidth*bannerPic.length);
	bannerPic.width(document.body.clientWidth);
//	$("p",$("#bigPicviewport")).each(function(){
//		var text=$(this).text();
//		var textArray=text.split("/");
//		imgMax=parseInt(textArray[1]);
//	})
	$("#button").on("click",function(){
//		$(".bigPic_painting",$("#bigPicScroller")).each(function(){
//			if($(this).attr("data-src")=="")
//				return;
//			$(this).css("background-image","url("+$(this).attr("data-src")+")");
//			$(this).attr("data-src","");
//		})
//		
		//$("#bigPicviewport").css("display","block");
		$("#bigPicviewport").css("-webkit-transform","translateY("+-$('#bigPicviewport').height()+"px)")
//			document.getElementById("bigPicviewport").style.webkitTransform = "translateY("+-$('#bigPicviewport').height()+"px)";
			var goodsPhotoListScroll = new IScroll('#bigPicWrapper', {
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
	});
//	$("#bigPicviewport").on("click",function(){
//			document.getElementById("bigPicviewport").style.webkitTransform = "translateY("+0+"px)";
//			goodsPhotoListScroll.destroy();
//			goodsPhotoListScroll=null;
//			$("p",$("#bigPicviewport")).each(function(){
//				$(this).text("1/"+imgMax);
//			})
//	});
	//图册序号变更
//	var imgMax=0;
//	function goodsPhotoListScrollEnd(){
//		var imgIndex=this.currentPage.pageX+1;
//		$("p",$("#bigPicviewport")).each(function(){
//			var text=$(this).text(imgIndex+"/"+imgMax);
//		})
//	}
})