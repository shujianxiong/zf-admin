<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问卷管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
        
        <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <p class="lead">问卷详情</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">问卷名称</th>
                        <td colspan="3">${questionnaire.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">问卷类别</th>
                        <td><span class="label label-primary">${fns:getDictLabel(questionnaire.type,'spm_qa_questionnaire_type','')}</span></td>
                        <th width="10%">问卷状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(questionnaire.status,'spm_qa_questionnaire_status','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">问卷标题</th>
                        <td colspan="3">${questionnaire.title }</td>
                    </tr>
                    <tr>
                        <th width="10%">问卷说明</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${questionnaire.description }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">是否奖励积分</th>
                        <td><span class="label label-primary">${fns:getDictLabel(questionnaire.rewardPointFlag,'yes_no','')}</span></td>
                        <c:if test="${questionnaire.rewardPointFlag eq '1' }">
                            <th width="10%">奖励积分数量</th>
                            <td>
                                ${questionnaire.rewardPointNum }
                            </td>
                        </c:if>
                    </tr>
                </table>
            </div>
        </section>

		<section class="invoice">
            <p class="lead">问卷问题</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>问题名称</th>
                            <th>问题类型</th>
                            <th>问题描述</th>
                            <th>问题分值</th>
                            <th>问题顺序层级</th>
                        </tr>
                    </thead>
                    <tbody id="contentTable">
	                    <c:forEach items="${questionnaire.questionnaireQueList }" var="questionnaireQue">
                            <tr>
                                <td title="${questionnaireQue.baseQuestion.name }">
                                    ${fns:abbr(questionnaireQue.baseQuestion.name,32) }
                                </td>
                                <td>
                                    ${fns:getDictLabel(questionnaireQue.baseQuestion.type,'spm_qa_base_question_type','') }
                                </td>
                                <td title="${questionnaireQue.baseQuestion.description }">
                                    ${fns:abbr(questionnaireQue.baseQuestion.description,48) }
                                </td>
                                <td>
                                    ${questionnaireQue.point }
                                </td>
                                <td>
                                    ${questionnaireQue.levelNum }
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="box-footer">
                <button type="button" class="btn btn-default btn-sm"
                    onclick="javascript:history.go(-1)">
                    <i class="fa fa-mail-reply"></i>返回
                </button>
            </div>
        </section>
	</div>
</body>
</html>