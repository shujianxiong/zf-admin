$(function() {
	var lefOffSize = 300;
	var topOffSize = 300;
	$("img").mouseover(function(e){
    	var imgSrc = $(this).attr("data-src");
    	var maxImg ="<div id='max' style='width:"+lefOffSize+"px;height:"+topOffSize+"px;position:absolute;'><img src='"+imgSrc+"'></div>";
    	//在body中添加元素
    	$("body").append(maxImg);
    	//设置层的top和left坐标，并动画显示层
    	var winWidth = $(window).width();
    	var winHeight = $(window).height();
    	var pageX = e.pageX;
    	var pageY = e.pageY;
//    	console.log(pageX+"-"+pageY+"-"+lefOffSize+"-"+winWidth);
    	if((pageX+lefOffSize < winWidth)&&(winHeight - topOffSize - pageY >= 0)){//右边宽度足够 &&下面高度足够
    		$("#max").css("top", pageY+20).css("left",pageX+10).show('slow');
    	}else if((pageX+lefOffSize < winWidth)&&(pageY - topOffSize >= 0)){ //右边宽度足够 &&上面高度足够
    		$("#max").css("top", (pageY - topOffSize)).css("left",e.pageX+10).show('slow');
    	}else if((pageX - lefOffSize >= 0)&&(winHeight - topOffSize - pageY >= 0)){ //左边边宽度足够 下面高度足够
    		$("#max").css("top", e.pageY+20).css("left",(pageX - lefOffSize)).show('slow');
    	}else if((pageX - lefOffSize >= 0)&&(pageY - topOffSize >= 0)){//左边边宽度足够&&上面面高度足够
    		$("#max").css("top", (pageY - topOffSize)).css("left",(pageX - lefOffSize)).show('slow');
    	}else{
    		$("#max").css("top", pageY+20).css("left",pageX+10).show('slow');
    	}
    	
  	}).mouseout(function(){
  		//鼠标移开删除大图所在的层
    	$("#max").remove();
  	}).mousemove(function(e){
  		//鼠标移动时改变大图所在的层的坐标
    	//$("#max").css("top", e.pageY+20).css("left",e.pageX+10);
  		var winWidth = $(window).width();
    	var winHeight = $(window).height();
    	var pageX = e.pageX;
    	var pageY = e.pageY;
//    	console.log(pageX+"-"+pageY+"-"+lefOffSize+"-"+winWidth);
    	if((pageX+lefOffSize < winWidth)&&(winHeight - topOffSize - pageY >= 0)){//右边宽度足够 &&下面高度足够
    		$("#max").css("top", pageY+20).css("left",pageX+10);
    	}else if((pageX+lefOffSize < winWidth)&&(pageY - topOffSize >= 0)){ //右边宽度足够 &&上面高度足够
    		$("#max").css("top", (pageY - topOffSize)).css("left",e.pageX+10);
    	}else if((pageX - lefOffSize >= 0)&&(winHeight - topOffSize - pageY >= 0)){ //左边边宽度足够 下面高度足够
    		$("#max").css("top", e.pageY+20).css("left",(pageX - lefOffSize));
    	}else if((pageX - lefOffSize >= 0)&&(pageY - topOffSize >= 0)){//左边边宽度足够&&上面面高度足够
    		$("#max").css("top", (pageY - topOffSize)).css("left",(pageX - lefOffSize));
    	}else{
    		$("#max").css("top", pageY+20).css("left",pageX+10);
    	}
  	});
});