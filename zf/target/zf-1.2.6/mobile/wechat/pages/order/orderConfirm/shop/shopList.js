$(function(){
	$(".below").height($(".below").width()*0.5);
	$("i",".selected").each(function(){
		$(this).css("line-height",$(".left").height()+'px')
	});
	$(".right").height($(".left").height());
})