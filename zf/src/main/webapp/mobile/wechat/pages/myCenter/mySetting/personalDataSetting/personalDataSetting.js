$(function(){
	//显示状态提示
    var status=$("#status").val();
    if(status!=null&&status.length>0){
    	Constants.tipStatus(status);
    	$("#status").remove();
    }
	//设置属性选择器面板bottom;
	$("#bottomPullUpSelectSex").offset({left:-$(window).width()})
	$("#bottomPullUpSelectSex").css("display","block");
	var selectSexHeight=$("#selectSex").height();
	$("#selectSex").css("bottom",-selectSexHeight+"px");
	$("#bottomPullUpSelectSex").css("display","none");
	$("#bottomPullUpSelectSex").offset({left:0})
	
	//点击身行打开性别选择面板
	$("#sex").on("click",function(){
		$("#bottomPullUpSelectSex").css("display","block");
		$('#selectSex').animate({'bottom': '0px' });
	})
	$(".shade",$("#bottomPullUpSelectSex")).on("click",function(){
		$('#selectSex').animate({'bottom': -selectSexHeight+"px" },300,function(){
			$("#bottomPullUpSelectSex").css("display","none");
		});
	})
	$("#bottomPullUpSelectSize").offset({left:-$(window).width()})
	$("#bottomPullUpSelectSize").css("display","block");
	var selectSizeHeight=$("#selectSize").height();
	$("#selectSize").css("bottom",-selectSizeHeight+"px");
	$("#bottomPullUpSelectSize").css("display","none");
	$("#bottomPullUpSelectSize").offset({left:0})
	
	//点击身行打开身形选择面板
	$("#shape").on("click",function(){
		$("#bottomPullUpSelectSize").css("display","block");
		$('#selectSize').animate({'bottom': '0px' });
	})
	$(".shade",$("#bottomPullUpSelectSize")).on("click",function(){
		$('#selectSize').animate({'bottom': -selectSizeHeight+"px" },300,function(){
			$("#bottomPullUpSelectSize").css("display","none");
		});
	})
	
	//保存个人消息
	$("#onSubmit").click(function(){
		formValidate.formFormatSubmit(function(){
	    	if(formValidate.isNull($("#sexVal"))){
	    		tip.autoShow("请选择性别！");
	    		return false;
	    	}
	    	if(formValidate.isNull($("#shapeVal"))){
	    		tip.autoShow("请选择身材类型！");
	    		return false;
	    	}
	    	return true;
	    },document.personalDataSettingForm)
	})
	
	//给图片重新赋值
	$('#idGravatarFile').localResizeIMG({
	      width: 400,
	      quality: 0.8,
	      success: function (result) {  
			  console.log(result)
			  $("#idGravatarText").val(result.clearBase64)//clearBase64图片的原始地址
			  $("#leftImg").attr("src",result.base64)
	      }
	});
	
	
	//性别选择器选择值
	//初始化筛选项样式
	$("li",$("#UiSex")).each(function(){
		$(this).on("click",function(){
			$("#sexVal").val($(this).attr("date-val-sex"));
			if($(this).attr("date-val-sex") == 1){
				$(".sexPval").text("男");
			}else{
				$(".sexPval").text("女");
			}
			$('#selectSex').animate({'bottom': -$("#selectSex").height()+"px" },300,function(){
				$("#bottomPullUpSelectSex").css("display","none");
			});
		})
			
	})
	
	//身材选择器选择值
	//初始化筛选项样式
	$("li",$("#UiShape")).each(function(){
		$(this).on("click",function(){
			$("#shapeVal").val($(this).attr("date-val-shape"));
			if($(this).attr("date-val-shape") == 1){
				$(".shapePval").text("上宽下窄");
			}else if($(this).attr("date-val-shape") == 2){
				$(".shapePval").text("匀称");
			}else{
				$(".shapePval").text("上窄下宽");
			}
			$('#selectSize').animate({'bottom': -$("#selectSize").height()+"px" },300,function(){
				$("#bottomPullUpSelectSize").css("display","none");
			});
		})
			
	})
	
});