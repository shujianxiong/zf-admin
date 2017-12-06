

$(function(){
	// 为租赁方案选择按钮绑定事件
	$("i[data-type=selectBtn]").each(function(){
		$(this).on("click",function(){
			$("i[data-type=selectBtn]").each(function(){
				$(this).html("&#xe627;");
			});
			$(this).html("&#xe622;");
			$("#hirePlanId").val($(this).attr("data-value"));
		});
	});
	
	// 确定
	$("#submitBtn").on("click",function(){
		if($("#hirePlanId").val()!=null && $("#hirePlanId").val()!=""){
			document.hirePlanForm.submit();
		}else{
			tip.autoShow("请选择租赁方案！");
		}
	});
	
	// 取消
	$("#cancelBtn").on("click",function(){
		$("#hirePlanId").val("");
		document.hirePlanForm.submit();
	});
});