<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问题管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			//单个点击事件获取checkbox的值
			$("input[type='checkbox").change(function(e){
				var addUrl = "${ctx}/spm/qa/questionnaire/saveQuestion";
				var dellUrl = "${ctx}/spm/qa/questionnaire/questionDelete";
				var ncid = $(this).attr("questionnaire-id");//问卷Id
				var queId = $(this).attr("que-id");//已选择答案id
				var questionId = $(this).val();//问题Id
				if($(this).attr("checked")=='checked'){
					ajaxBrands(addUrl, ncid, questionId,null);
				}else{
					ajaxBrands(dellUrl, ncid, questionId,queId);
				}
			});
		});
		
		function ajaxBrands(url, ncid, questionId,queId){
			$("#loading").show();
			if(queId != null){
				var data={"id":ncid, "questions[0].id":questionId,"queId":queId};
			}else{
				var data={"id":ncid, "questions[0].id":questionId};
			}
			ajaxRequest(url,"POST",data)
		}
		
		function ajaxRequest(url, type, data){
			$.ajax({
			   type: type,
			   url: url,
			   data: data,
			   success: successResult,
			   error:errorResult
			});
		}
		
		function successResult(data){ 
			$("#loading").hide();
			var result = eval("("+data+")");
			if(result.flag){
				$.jBox.tip('保存成功。', 'success',{
					timeout:1500
				});
			}else{
				$.jBox.tip('保存失败。', 'error');
			}
		}
		
		function errorResult(data){
			$("#loading").hide();
			$.jBox.tip('保存失败,刷新页面在进行操作 。', 'error');
		}
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="baseQuestion" action="${ctx}/spm/qa/baseQuestion/questionSelect?questionnaireId=${questionnaireId}" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
				          <div class="box-tools pull-right">
				            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
				          </div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label">问题名称</label>
									<div class="col-sm-7">
										<form:input path="name" htmlEscape="false" maxlength="200" class="form-control"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">问题类型</label>
									<div class="col-sm-7">
										<form:select path="type" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('spm_qa_base_question_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="answerType" class="col-sm-3 control-label">答案类型</label>
									<div class="col-sm-7">
										<form:select path="answerType" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('spm_qa_base_question_answerType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
							<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()">
								<i class="fa fa-refresh"></i>重置
							</button>
							<button type="submit" class="btn btn-info btn-sm">
								<i class="fa fa-search"></i>查询
							</button>
						</div>
					</div>
				</div>
			</form:form>
			<div class="box box-soild">
				<div class="box-body">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th>&nbsp;</th>
								<th>问题名称</th>
								<th>问题类型</th>
								<th>问题描述</th>
								<th>问题图片介绍</th>
								<th>启用状态</th>
								<th>答案类型</th>
								<th>更新时间</th>
								<th>备注信息</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="baseQuestion">
							<tr>
								<td data-type="checkbox">
									<c:set var="flag" value="0"/>
									<c:forEach items="${quePage.questionnaireQueList}" var="b">
										<c:if test="${baseQuestion.id eq b.baseQuestion.id}">
											<c:set var="flag" value="1"/>
											<c:set var="queId" value="${b.id}"/>
										</c:if>
									</c:forEach>
									<input type="checkBox" name="checkbox" data-name="${ baseQuestion.name}" data-type="${fns:getDictLabel(baseQuestion.type, 'spm_qa_base_question_type', '')}" data-des="${ baseQuestion.description }" <c:if test="${flag eq '1' }"> checked="checked"</c:if> questionnaire-id="${questionnaireId}" que-id="${queId}" value="${baseQuestion.id}" />
									<c:set var="flag" value="0"/>
								</td>
								<td>
									${baseQuestion.name}
								</td>
								<td>
									${fns:getDictLabel(baseQuestion.type, 'spm_qa_base_question_type', '')}
								</td>
								<td>
									${baseQuestion.description}
								</td>
								<td>
									<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(baseQuestion.photo, '|', '')}" data-big data-src="${imgHost }${baseQuestion.photo}" width="21px" height="21px" />
								</td>
								<td>
									<span class="label label-success">${fns:getDictLabel(baseQuestion.activeFlag, 'yes_no', '')}</span>
								</td>
								<td>
									${fns:getDictLabel(baseQuestion.answerType, 'spm_qa_base_question_answerType', '')}
								</td>
								<td>
									<fmt:formatDate value="${baseQuestion.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td title="${baseQuestion.remarks}">
									${fns:abbr(baseQuestion.remarks,15)}
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	            </div>
			</div>
		</section>
	</div>
	<script type="text/javascript">
		$(function(){
			
			
			  $('input[type="checkbox"]').iCheck({
			      checkboxClass: 'icheckbox_minimal-blue'
			    });
			
			  ZF.bigImg();
			  
			  //表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : false,
				"info" : false,
				"autoWidth" : false,
				"multiline" : true,//是否开启多行表格
				"isRowSelect" : false//是否开启行选中
			})
		})
	</script>
	
</body>
</html>