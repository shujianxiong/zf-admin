<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>我的邀请记录</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	
	<table class="table table-bordered table-hover table-striped zf-tbody-font-size">
		<thead>
			<tr>
				<th>邀请码</th>
				<th>使用标记</th>
				<th>使用会员</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ list }" var="inviteCode">
				<tr>
					<td>
						${inviteCode.inviteCode }
					</td>
					<td style="text-align: center;">
						${inviteCode.useFlag}
					</td>
					<td>
						${inviteCode.useMember.name }
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>