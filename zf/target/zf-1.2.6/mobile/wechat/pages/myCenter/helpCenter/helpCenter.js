$(function(){
	$("li[data-role =more]").css("display","none");
	console.log($("li[data-role =more]"))
	$("#moreBotton").on("click",function(){
		var flag = $(this).attr("data-mark")
		if(flag==0){
			$(this).attr("data-mark","1");
			$(this).html("<i class='iconfont'>&#xe62f;</i>");
			$("li[data-role =more]").css("display","block");
		}else{
			$(this).attr("data-mark","0");
			$(this).html("<i class='iconfont'>&#xe628;</i>");
			$("li[data-role =more]").css("display","none");
		}
	})
	$("#onSubmit").click(function(){
		document.helpCenterForm.submit();
	})
})
