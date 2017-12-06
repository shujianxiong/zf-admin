$(function(){
	 //显示状态提示
    var status=$("#status").val();
    if(status!=null&&status.length>0){
    	Constants.tipStatus(status);
    	$("#status").remove();
    }
	$("#onSubmit").click(function(){
		formValidate.formFormatSubmit(function(){
	    	if(formValidate.isNull($("#userCode"))){
	    		tip.autoShow("请输入用户名");
	    		return false;
	    	}
	    	return true;
	    },document.loginForm)
	})
});
