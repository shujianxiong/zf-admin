$(function(){
	$("#onSubmit").on("click",function(){
		formValidate.formFormatSubmit(function(){
	    	if(formValidate.isNull($("#telephone"))){
	    		tip.autoShow("请输入手机号码");
	    		return false;
	    	}
	    	if(!formValidate.isPhone($("#telephone"))){
	    		tip.autoShow("手机号码格式不正确");
	    		return false;
	    	}
	    	if(formValidate.isNull($("#vaildataCode"))){
	    		tip.autoShow("请输入短信验证码");
	    		return false;
	    	}
	    	return true;
	    },document.getBackPasswordForm)
	});
    
    //显示状态提示
    var status=$("#status").val();
    if(status!=null&&status.length>0){
    	Constants.tipStatus(status);
    	$("#status").remove();
    }
    
});



