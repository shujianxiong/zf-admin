$(function(){
	 //显示状态提示
    var status=$("#status").val();
    if(status!=null&&status.length>0){
    	Constants.tipStatus(status);
    	$("#status").remove();
    }
    $("#onSubmit").click(function(){
		formValidate.formFormatSubmit(function(){
	    	if(formValidate.isNull($("#content"))){
	    		tip.autoShow("请输入您的反馈意见！");
	    		return false;
	    	}
	    	return true;
	    },document.feedbackForm)
	})
	$('#idPhotosFile').localResizeIMG({
      width: 400,
      quality: 1,
      success: function (result) {  
    	  console.log(result)
    	  $("#idPhotosFileText").val(result.clearBase64)
		  $("#photosImg").attr("src",result.base64)
      }
	 });
});