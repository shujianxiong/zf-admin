

$(function(){
	// 为保险方案选择按钮绑定事件
	$("i[data-type=selectBtn]").each(function(){
		$(this).on("click",function(){
			$("i[data-type=selectBtn]").each(function(){
				$(this).html("&#xe627;");
			});
			$(this).html("&#xe622;");
			$("#hireInsuranceId").val($(this).attr("data-value"));
		});
	});
	
	// 确定
	$("#submitBtn").on("click",function(){
		if($("#hireInsuranceId").val()!=null && $("#hireInsuranceId").val()!=""){
			document.hireInsuranceForm.submit();
		}else{
			tip.autoShow("请选择租赁方案！");
		}
	});
	
	// 取消
	$("#cancelBtn").on("click",function(){
		$("#hireInsuranceId").val("");
		document.hireInsuranceForm.submit();
	});
	$("i",".con_warp").each(function(){
		$(this).css("line-height",$(".con_left").height()+'px')
	})
});