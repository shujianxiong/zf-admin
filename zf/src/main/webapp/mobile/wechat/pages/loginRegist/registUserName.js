$(function(){
	$("#onSubmit").click(function(){
		var $passWord = $("#passWord").val();
		var $rePassWord = $("#rePassWord").val();
		formValidate.formFormatSubmit(function(){
			if(formValidate.isNull($("#nickname"))){
	    		tip.autoShow("请输入昵称");
	    		return false;
	    	}
			if(formValidate.isNull($("#passWord"))){
	    		tip.autoShow("请输入登录密码");
	    		return false;
	    	}
			if($passWord.length < 6 || $passWord.length > 14){
				tip.autoShow("密码长度6~14位,数字,字母,至少包含两种");		
				return false;
			}
			if(!checkPassword($passWord)){
				tip.autoShow("密码必须是字母和数字组合");		
				return false;
			}
			if(formValidate.isNull($("#rePassWord"))){
	    		tip.autoShow("请确认登录密码");
	    		return false;
	    	}
			if($rePassWord != $passWord){
				tip.autoShow("两次密码输入不一致");		
				return false;
			}
	    	return true;
	    },document.registForm)
	})
	
	//显示状态提示
    var status=$("#status").val();
    if(status!=null&&status.length>0){
    	Constants.tipStatus(status);
    	$("#status").remove();
    }
});

function checkPassword(str){ 
	var reg = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{6,}$/;
	return reg.test(str);
}