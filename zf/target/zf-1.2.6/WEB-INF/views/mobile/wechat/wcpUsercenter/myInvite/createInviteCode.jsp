<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成邀请码</title>
</head>
<body>
	
	<b>最多可以创建${ createNum}个</b>
	<form action="../member/createInviteCode" method="post">
		<label>生成数量</label>
		<input type="hidden" name="activityId" value="${ activityId}"/>
		<input type="text" name="createNum" value="${ createNum}"/>
		<button type="submit">生成</button>
	</form>
	
</body>
</html>