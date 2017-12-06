
/**
 * 初始化函数
 */
$(function(){

	var selectArea = new MobileSelectArea();
	selectArea.init({trigger:'#txt_area',value:$('#txt_area').val(),eventName:'click',data:ctx+'/mobile/wechat/pages/address/data.json'});
	
    $(".address_button").click(function(){
		formValidate.formFormatSubmit(function(){
	    	if(formValidate.formDataNotNull(document.addressForm)){
	    		if(!formValidate.isPhone($("#telephone"))){
    				tip.autoShow("号码格式不正确");
    				return false;
    			}
	    		return true;
	    	}
	    	return false;
	    },document.addressForm)
	})
	
	if(document.getElementById("defaultFlag").value == "1"){
		$("#checkBoxI").attr("data-val","1")
    	$("#checkBoxI").html("&#xe622;");
	}else{
		$("#checkBoxI").attr("data-val","0")
    	$("#checkBoxI").html("&#xe627;");
	}
	
    //勾选操作
    $("#checkBoxI").on("click",function(){
    	if($(this).attr("data-val")=="0"){
    		$(this).attr("data-val","1")
    		$(this).html("&#xe622;");
    		//设置表单input hidden值
    		document.getElementById("defaultFlag").value = "1";
    		$("#defaultFalg").val("1");
    	}else{
    		$(this).attr("data-val","0")
    		$(this).html("&#xe627;");
    		//设置表单input hidden值
    		document.getElementById("defaultFlag").value = "0";
    		$("#defaultFalg").val("0");
    	}
    })

});

