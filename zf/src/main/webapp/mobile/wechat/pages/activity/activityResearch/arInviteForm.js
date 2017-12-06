$(function(){
	$("#onSubmit").on("click",function(){
		formValidate.formFormatSubmit(function(){
	    	if(formValidate.isNull($("#phone"))){
	    		tip.autoShow("请输入手机号码");
	    		return false;
	    	}
	    	if(!formValidate.isPhone($("#phone"))){
	    		tip.autoShow("手机号码格式不正确");
	    		return false;
	    	}
	    	if(formValidate.isNull($("#smsCode"))){
	    		tip.autoShow("请输入短信验证码");
	    		return false;
	    	}
	    	if(formValidate.isNull($("#inviteCode"))){
		    	tip.autoShow("请输入活动邀请码");
		    	return false;
		    }
	    	return true;
	    },document.arInviteForm)
	});
    
    //显示状态提示
    var status=$("#status").val();
    if(status!=null && status.length>0){
    	Constants.tipStatus(status);
    	$("#status").remove();
    };
    
    //获取验证码
    function showtime(m){
    	tip.autoShow("当前测试短信验证码为123456");
    	$("#getSmsCode").html(m + "秒后重新获取");
    	for(var i= 1;i<= m;i++){
    		setTimeout("counter("+i+","+m+")",i*1000);
    	};
    }
    
    $("#getSmsCode").on("click",function(){showtime(30)});
    
});

//定义获取验证码显示数字函数
function counter(t,n){
	if(t == n){
		$("#getSmsCode").html("重新获取") ;
	}else{
		var time =n-t;
		$("#getSmsCode").html(time+"秒后重新获取") ;
	}
}

/*define(function(require,exports,module){
	var a =require('./a')
	a.function(){
		//require是链接外部功能模块接口
		//exports是提供功能模块接口
	}
	exports.a ={}
});*/


