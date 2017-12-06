$(function(){
	/**
	 * 点击获取验证码
	 */
	$("#captchaBtn").on("click",function(){
		if(formValidate.isNull($("#telephone"))){
	    	tip.autoShow("请输入手机号码");
	    	return false;
	    }
		if(!formValidate.isPhone($("#telephone"))){
			tip.autoShow("手机号码格式不正确");
			return false;
		}
		var dataKey=$("#captchaBtn").attr("data-key");
		if(dataKey!=0)
			return;
		var phone=$("#telephone").val();
		var url=ctxWeb+"/login/getsms/"+phone;
		ajax.submit("post",url,[],function(data){
			if(data.status==Constants.SUCCESS){
				tip.autoShow("验证码为："+data.message)
				$("#captchaBtn").css({
	             	"background-color": "#dedede",
	                 "border-color": "#a1a1a1"
	             });
				$("#captchaBtn").attr("data-key","1");
				setSmsCodeTime();
				timer=setInterval("setSmsCodeTime()",1000);
			}
			if(data.status==Constants.PARAMETER_ISNULL)
				tip.autoShow("请填写手机号")	
		})
	});

	
})

/**
	 * 获取短信验证码
	 */
	var time=5;
	var timer;
	function setSmsCodeTime(){
		if(time<=0){
			time=5
			$("#captchaBtn").text("获取验证码");
	        $("#captchaBtn").css({
	            "background-color": "#f4c158",
	            "border-color": "#f4c158"
	        });
	        $("#captchaBtn").attr("data-key","0");
			clearInterval(timer);
		}else{
			time--;
			$("#captchaBtn").text(time+"s");
		}
	}