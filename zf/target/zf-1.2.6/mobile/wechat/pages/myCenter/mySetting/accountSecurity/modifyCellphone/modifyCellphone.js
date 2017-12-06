$(function(){
	 //显示状态提示
    var status=$("#status").val();
    if(status!=null&&status.length>0){
    	Constants.tipStatus(status);
    	$("#status").remove();
    }
	$("#onSubmitVerify").click(function(){
		formValidate.formFormatSubmit(function(){
			if(!formValidate.isPhone($("#telephone"))){
	    		tip.autoShow("手机号码格式不正确");
	    		return false;
	    	}
	    	if(formValidate.isNull($("#vaildataCode"))){
	    		tip.autoShow("请输入验证码！");
	    		return false;
	    	}
	    	return true;
	    },document.verifyCellphoneForm)
	})
	
	$("#onSubmitReset").click(function(){
		formValidate.formFormatSubmit(function(){
	    	if(formValidate.isNull($("#telephone"))){
	    		tip.autoShow("请输入新手机号！");
	    		return false;
	    	}
	    	if(!formValidate.isPhone($("#telephone"))){
	    		tip.autoShow("手机号码格式不正确");
	    		return false;
	    	}
	    	if(formValidate.isNull($("#vaildataCode"))){
	    		tip.autoShow("请输入验证码！");
	    		return false;
	    	}
	    	return true;
	    },document.resetCellphoneForm)
	})
});