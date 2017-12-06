<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>答卷详细信息</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<div class="pad margin no-print">
			<div class="callout callout-info" style="margin-bottom: 0!important;text-align: center;font-size: 12px;">
				<h4>${ respondents.questionnaire.name}</h4>
				答卷人：${respondents.member.name }<i id="memberInfo" class="fa fa-search" title="点击查看答题人详情"></i>
				<hr class="zf-hr">
				答卷时间：<fmt:formatDate value="${respondents.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/> ~ <fmt:formatDate value="${respondents.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</div>
		</div>
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<ul class="timeline">
						<c:set var="idx" value="${fn:split('A,B,C,D,E,F,G,H,I,J,K', ',')}"></c:set>
						<c:forEach items="${ respondents.respondentsAnsList}" var="respondentsAns" varStatus="status">
							<li>
								<i class="fa fa-fw fa-question-circle bg-blue"></i>
								<div class="timeline-item">
									<span class="time"><i class="fa fa-clock-o"></i><fmt:formatDate value="${respondentsAns.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<h3 class="timeline-header"><strong>${ status.index +1 }.${respondentsAns.questionnaireQue.baseQuestion.name }</strong></h3>
									<div class="timeline-body" id="answer${status.index }">
										<c:choose>
											<c:when test="${respondentsAns.questionnaireQue.baseQuestion.answerType eq '3' }">
												<strong class="text-danger">${respondentsAns.answerText }</strong>
											</c:when>
											<c:otherwise>
												<c:forEach items="${questionnaireQueList }" var="questionnaireQue">
													<c:if test="${questionnaireQue.id eq respondentsAns.questionnaireQue.id  }">
														<c:forEach items="${questionnaireQue.baseAnswerList }" var="allAnswer" varStatus="anstatus">
															<c:choose>
																<c:when test="${respondentsAns.baseAnswer.name eq allAnswer.name }">
																	 <strong class="text-danger">${idx[anstatus.index]} . ${respondentsAns.baseAnswer.name }</strong> 
																	<br>
																</c:when>
																<c:otherwise>
																	${idx[anstatus.index]} . ${allAnswer.name }
																	<br>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</li>
						</c:forEach>
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