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
				<th>变动积分</th>
				<th>变动时间</th>
				<th>变动原因</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ point.pointDetailList }" var="pointDetail">
				<tr>
					<td>
						${pointDetail.changePoint }
					</td>
					<td style="text-align: center;">
						${pointDetail.changeTime}
					</td>
					<td>
						${pointDetail.changeReasonType }
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>