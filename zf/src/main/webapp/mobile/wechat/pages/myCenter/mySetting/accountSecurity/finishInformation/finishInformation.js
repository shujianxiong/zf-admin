$(function(){
	$("div",".operateArea").each(function(){
		$(this).height($(this).width()) 
	})
	 //显示状态提示
    var status=$("#status").val();
    if(status!=null&&status.length>0){
    	Constants.tipStatus(status);
    	$("#status").remove();
    }
	$("#onSubmit").click(function(){
		formValidate.formFormatSubmit(function(){
	    	if(formValidate.isNull($("#name"))){
	    		tip.autoShow("请输入您的真实姓名！");
	    		return false;
	    	}
	    	if(formValidate.isNull($("#idCard"))){
	    		tip.autoShow("请输入您的身份证号码！");
	    		return false;
	    	}
	    	if(!isCard($("#idCard").val())){
				tip.autoShow("您输入的身份证号码格式不正确！");		
				return false;
			}
	    	return true;
	    },document.finishInformationForm)
	})
	 $('#idCardLeftFile').localResizeIMG({
      width: 400,
      quality: 1,
      success: function (result) {  
		  console.log(result)
		  $("#idCardLeftText").val(result.base64)
		  $("#leftImg").attr("src",result.base64)
      }
	 });
	
	$('#idCardRightFile').localResizeIMG({
	      width: 400,
	      quality: 1,
	      success: function (result) {  
	    	  console.log(result)
	    	  $("#idCardRightText").val(result.base64)
	    	  $("#rightImg").attr("src",result.base64)
	      }
	 });
	
});

function isCard(str){ 
	var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	return reg.test(str);
}
