<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>属性详情</title>
	<meta name="decorator" content="adminLte"/>
	
</head>
<body>
	<div class="content-warpper sub-content-wrapper">
		
		<sys:tip content="${message}"/>
		<section class="content">
			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
				<thead>
					<tr>
						<th class="text-center">属性名</th>
						<th class="text-center">属性值</th>
					</tr>
				</thead>
				<tbody id="lgtpsPropvalueListTbody">
					<c:forEach items="${fileProps }" var="fileProp">
						<tr>
							<td class="text-center">
								${fileProp.property.propName }
							</td>
							<td class="text-center">
								<c:choose>
									<c:when test="${fileProp.property.valueType == '0'}">
										${fileProp.pvalue }
									</c:when>
									<c:otherwise>
										${fileProp.propvalue.pvalueName }
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</section>
	</div>
</body>