//悬浮按钮设置点击隐藏
var block = document.getElementById("functionArea")
var guess = document.getElementById("suspendingArea")
var backTop =document.getElementById("backTopButton")

$("#suspendingArea").on("click",function(){
	if($("#functionArea").css("display")=="block"){
		$("#functionArea").css("display","none")
		
	}else{
			$("#functionArea").css("display","block");
		}
})

$("div[data-type=suspend]",$("#functionArea")).each(function(){
	$(this).on("click",function(){
		$("div[data-type=suspend]",$("#functionArea")).each(function(){
			var iButton=$(this);
			iButton.removeClass("active")
		})
			var iButton=$(this);
			iButton.addClass("active");
	})
})
