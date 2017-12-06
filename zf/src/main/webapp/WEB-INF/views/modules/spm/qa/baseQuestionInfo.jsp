<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问题详情</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<div class="pad margin no-print">
			<div class="callout callout-info" style="margin-bottom: 0!important;text-align: center;font-size: 12px;">
				<h4>问题项详情</h4>
				<hr class="zf-hr">
			</div>
		</div>
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<ul class="timeline">
						<c:set var="idx" value="${fn:split('A,B,C,D,E,F,G,H,I,J,K,L,M,N', ',')}"></c:set>
							<li>
								<i class="fa fa-fw fa-question-circle bg-blue"></i>
								<div class="timeline-item">
									<span class="time"><i class="fa fa-clock-o"></i></span>
									<h3 class="timeline-header"><strong>${baseQuestion.name }</strong></h3>
									<div class="timeline-body">
										<c:choose>
											<c:when test="${baseQuestion.type eq '4' }">
												<c:forEach items="${baseQuestion.answerList }" var="answer" varStatus="stats">
													<c:choose>
														<c:when test="${answer.correctFlag eq '1' }">
															<strong class="text-danger">${idx[stats.index]} . ${answer.name }</strong><br/>
														</c:when>
														<c:otherwise>
															<strong>${idx[stats.index]} . ${answer.name }</strong><br/>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:forEach items="${baseQuestion.answerList }" var="answer" varStatus="stats">
													<strong>${idx[stats.index]} . ${answer.name }</strong><br/>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</li>
					</ul>
					<div style="margin-left: 60px;margin-right: 15px;">
						<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					</div>
				</div>
			</div>
			
    		<sys:selectmutil height="600" url="${ctx }/crm/mi/member/form?id=${respondents.member.id }" width="1200" isDisableCommitBtn="false" title="会员详情查看" id="select" ></sys:selectmutil>
		</section>
	</div>
	
	<script type="text/javascript">
		$(function(){
			$("#memberInfo").on("click",function(){
				$("#selectModal").modal('toggle');//显示模态框
			})
		})
	</script>
	
	
	
</body>
</html>