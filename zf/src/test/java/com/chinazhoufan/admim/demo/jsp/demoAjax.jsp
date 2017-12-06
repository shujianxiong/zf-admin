<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
</head>
<body>
	<script type="text/javascript">
	
		function judge(dietId, judgeId, level){
			var data="{\"level\":\""+level+"\"}";
			console.log(data);
			ZF.ajaxQuery(true,"${ctx}/hrm/di/myDiet/judge/"+dietId,$.parseJSON(data),function(data){
				if(data.status=="0"){
					ZF.showTip(data.message,"warning");
				}else{
					clearLevels(dietId);
					setLevels(dietId, level);
					$("#scoreDiv_"+dietId).text(data.score);
					$("#statusSpan_"+dietId).text("已评价");
					$("#statusSpan_"+dietId).removeClass("label label-primary").addClass("label label-success");
				}
			})
	  	}
		
	</script>
</body>
</html>