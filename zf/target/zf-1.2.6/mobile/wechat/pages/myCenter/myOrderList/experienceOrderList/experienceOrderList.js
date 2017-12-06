window.onload = function(){ 
//	$('#myOrderList_orderItemWrap').width()= $(window).width()+'px'
	var pageNum = document.getElementsByClassName("subPage")
	var orderItemWrap =document.getElementById("myOrderList_orderItemWrap")
	orderItemWrap.style.width = $(window).width()*pageNum.length+'px';
	for(var i=0;i<pageNum.length;i++){
		pageNum[i].style.width =$(window).width()+'px'
	}
//	$(".subPage","#myOrderList_orderItemWrap").each(function(){
//		$(this).width()=$(window).width()+'px'
//	})
	 $("li","#myorderListTop").on("click",function(){
     	$("li","#myorderListTop").each(function(){
    		$(this).removeClass("active")
    	});
    	$(this).addClass("active");
    })
    $("#allOrderButton").on("click",function(){
		 $("#myOrderList_orderItemWrap").animate({left:0});
	});
    $("#waittingPayEarnest").on("click",function(){
		$("#myOrderList_orderItemWrap").animate({left:-$(window).width()+'px'});
	});
    $("#waittingReceiving").on("click",function(){
		$("#myOrderList_orderItemWrap").animate({left:-$(window).width()*2+'px'});
	});
	$("#outReceiving").on("click",function(){
		$("#myOrderList_orderItemWrap").animate({left:-$(window).width()*3+'px'});
	});
} 

    	
