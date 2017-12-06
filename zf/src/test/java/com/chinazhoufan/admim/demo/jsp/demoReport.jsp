<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>搜索统计报表</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>


</head>
<body>
<head>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/mi/searchRecord/list">搜索记录列表</a></li>
		<li class="active"><a href="${ctx}/crm/mi/searchRecord/statistics">搜索记录统计</a></li>
	</ul>
	<br>
	<br/>
	<script type="text/javascript">
			$(function(){
				var data = ${datas};
	        	
				new iChart.Column2D({
					render : 'canvasDiv',
					data: data,
					title : '关键词访问占比',
					showpercent:true,
					decimalsnum:2,
					width : 800,
					height : 400,
					coordinate:{
						background_color:'#fefefe',
						scale:[{
							 position:'left',	
							 start_scale:0,
							 end_scale:40,
							 scale_space:8,
							 listeners:{
								parseText:function(t,x,y){
									return {text:t+"%"}
								}
							}
						}]
					}
				}).draw();
		});
				
	</script>
</head>
<body>
	<div id='canvasDiv'></div>
	<div class='ichartjs_info'>
	</div>
</body>
</html>