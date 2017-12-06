<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调研活动管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			editor = CKEDITOR.replace( 'ruleDetail', {
	            on: {
	                instanceReady: function( ev ) {
	                    this.dataProcessor.writer.setRules( 'p', {
	                        indent: false,
	                        breakBeforeOpen: false,   //<p>之前不加换行
	                        breakAfterOpen: false,    //<p>之后不加换行
	                        breakBeforeClose: false,  //</p>之前不加换行
	                        breakAfterClose: false    //</p>之后不加换行7
	                    });
	                }
	            }
	        });
		});
		
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
	<section  class="content-header content-header-menu">
		<h1>
			<small><i class="fa-list-style"></i><a href="${ctx}/spm/ac/activityResearch/list">活动列表</a></small>
			
			<shiro:hasPermission name="spm:ac:activityResearch:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ac/activityResearch/form?id=${activityResearch.id}">活动${not empty activityResearch.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="activityResearch" action="${ctx}/spm/ac/activityResearch/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						<div class="box-body">
							<form:hidden path="id" />
							<form:hidden path="activity.id"/>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="activity.name" tip="请输入活动名称，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="activity.activityType" tip="请选择活动类型，必填项" verifyType="0" dictName="SPM_AC_ACTIVITY_TYPE" id="activityTypeID"></sys:selectverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动模板</label>
								<div class="col-sm-9">
									<div class="input-group">
										<form:hidden path="activity.acActivityTemplate.id" id="acActivityTemplateId"/>
										<form:input path="activity.acActivityTemplate.name" id="acActivityTemplateName"  htmlEscape="false" maxlength="50" placeholder="请选择"  class="form-control zf-input-readonly" readonly="true"  onclick="selectActivityTemplate();"/>
										<span class="input-group-addon" onclick="selectActivityTemplate();"><i class="fa fa-search"></i></span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动标题</label>
								<div class="col-sm-9">
									<sys:inputverify name="activity.title" id="title" verifyType="0" tip="请输入活动标题，必填项" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动副标题</label>
								<div class="col-sm-9">
									<sys:inputverify name="activity.subtitle" id="subtitle" verifyType="0" tip="请输入活动副标题，必填项" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
	    						<label class="col-sm-2 control-label">分享小图</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="shareSPhoto" path="activity.shareSPhoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
									<sys:ckfinder input="shareSPhoto" type="images" uploadPath="/spm/ac/activity" selectMultiple="false" readonly="false" maxHeight="100" maxWidth="100"/> --%>

									<form:hidden id="shareSPhoto" path="activity.shareSPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="shareSPhoto" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
	    					</div>
	    					<div class="form-group">
	    						<label class="col-sm-2 control-label">分享中图</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="shareMPhoto" path="activity.shareMPhoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
									<sys:ckfinder input="shareMPhoto" type="images" uploadPath="/spm/ac/activity" selectMultiple="false" readonly="false" maxHeight="100" maxWidth="100"/> --%>
									
									<form:hidden id="shareMPhoto" path="activity.shareMPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="shareMPhoto" model="true" selectMultiple="false"></sys:fileUpload>
									
								</div>
	    					</div>
	    					<div class="form-group">
								<label class="col-sm-2 control-label">简介</label>
								<div class="col-sm-9">
									<form:textarea path="activity.summary" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">介绍</label>
								<div class="col-sm-9">
									<form:textarea path="activity.introduce" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">规则详情</label>
								<div class="col-sm-9">
									<%-- <form:textarea path="ruleDetail" htmlEscape="false" rows="3" maxlength="200" class="form-control"/> --%>
									<textarea name="activity.ruleDetail" id="ruleDetail" maxlength="200">${activityResearch.activity.ruleDetail }</textarea>
								</div>
							</div>
	    					<div class="form-group">
								<label class="col-sm-2 control-label">奖励积分</label>
								<div class="col-sm-9">
									<sys:inputverify id="rewardPoint" name="activity.rewardPoint" tip="请输入奖励积分，必填项" maxlength="10" verifyType="4"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">问卷</label>
								<div class="col-sm-9">
									<div class="input-group">
										<form:hidden path="questionnaire.id" id="questionnaireId"/>
										<form:input path="questionnaire.name" class="form-control zf-input-readonly"   htmlEscape="false" maxlength="50" placeholder="请选择"  readonly="true" id="questionnaireName"  onclick="selectQuestionnaire();"/>
										<span class="input-group-addon" onclick="selectQuestionnaire();"><i class="fa fa-search"></i></span>
									</div>
								</div>
							</div>
							
	    					<div class="form-group">
								<label class="col-sm-2 control-label">奖品</label>
								<div class="col-sm-9">
									<div class="input-group">
										<form:hidden path="activity.rewardPrize.id" id="rewardPrizeId"/>
										<form:input path="activity.rewardPrize.name" class="form-control zf-input-readonly"   htmlEscape="false" maxlength="50" placeholder="请选择"  readonly="true" id="rewardPrizeName"  onclick="selectPrize();"/>
										<span class="input-group-addon" onclick="selectPrize();"><i class="fa fa-search"></i></span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">开始时间</label>
								<div class="col-sm-9">
									<sys:datetime id="startTimeId" inputName="activity.startTime" tip="请选择开始时间，必填项" isMandatory="true" value="${activityResearch.activity.startTime }" inputId="startTime"></sys:datetime>
								</div>
							</div>
	    					<div class="form-group">
								<label class="col-sm-2 control-label">结束时间</label>
								<div class="col-sm-9">
									<sys:datetime id="endTimeId" inputName="activity.endTime" tip="请选择结束时间，必填项" isMandatory="true" value="${activityResearch.activity.endTime }" minDate="${activityResearch.activity.startTime }" inputId="endTime"></sys:datetime>
								</div>
							</div>
	    					<div class="form-group">
								<label class="col-sm-2 control-label">启用状态</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="activity.activeFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" class="minimal"  htmlEscape="false" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-9">
									<form:textarea path="activity.remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty activityResearch.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="spm:ac:activityResearch:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<sys:selectmutil id="select" title="活动模板列表" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
	</section>
	</div>
<script type="text/javascript">
	$(function() {
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
	});
	
	function selectActivityTemplate() {
		var url="${ctx}/spm/ac/acActivityTemplate/select";
		$(".modal-title").text("选择活动模板");
		$("#selectModalUrl").val(url);
		$("#commitBtn").unbind("click");
		$("#commitBtn").on("click",function () {
			var content = $("#selectModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
					//重新选择产品清空原来数据
					$("tr",$("#tableList")).each(function(){
						$(this).remove();
					})
					$("#acActivityTemplateId").val($(this).val());
					$("#acActivityTemplateName").val($(this).attr("data-name"));
					
					$("#selectModal").modal('hide');
				}
			});
		});
		$("#selectModal").modal('toggle');
	}
	
	function selectPrize() {
		var url="${ctx}/spm/pr/prize/select?status=3";
		$(".modal-title").text("选择奖品")
		$("#selectModalUrl").val(url);
		$("#commitBtn").unbind("click");
		$("#commitBtn").on("click",function () {
			var content = $("#selectModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
					//重新选择产品清空原来数据
					$("tr",$("#tableList")).each(function(){
						$(this).remove();
					})
					$("#rewardPrizeId").val($(this).val());
					$("#rewardPrizeName").val($(this).attr("data-name"));
					
					$("#rewardPrizeName").removeClass("zf-input-err");
					$("#rewardPrizeName").attr("data-verify","true");
					
					if($("#rewardPrizeErr").length > 0) {
						$("#rewardPrizeErr").remove();
					}
					
    				$("#selectModal").modal('hide');
				}
			});
		});
		$("#selectModal").modal('toggle');
	}
	
	
	function selectQuestionnaire() {
		var url="${ctx}/spm/qa/questionnaire/select";
		$(".modal-title").text("选择问卷")
		$("#selectModalUrl").val(url);
		$("#commitBtn").unbind("click");
		$("#commitBtn").on("click",function () {
			var content = $("#selectModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
					//重新选择产品清空原来数据
					$("tr",$("#tableList")).each(function(){
						$(this).remove();
					})
					$("#questionnaireId").val($(this).val());
					$("#questionnaireName").val($(this).attr("data-name"));
					
					$("#questionnaireName").removeClass("zf-input-err");
					$("#questionnaireName").attr("data-verify","true");
					
					if($("#questionnaireErr").length > 0) {
						$("#questionnaireErr").remove();
					}
					
    				$("#selectModal").modal('hide');
				}
			});
		});
		$("#selectModal").modal('toggle');
	}
	
	function formSubmit() {
		var verify=true;
		var inputs=$("input[data-verify=false]");
		for(var i=0;i<inputs.length;i++){
			if($(inputs[i]).attr('data-type') == "date"){
				$(inputs[i]).parent().trigger('dp.change');
			}else{
				$(inputs[i]).trigger('change');
			}
			verify=false;
		}
		var selects=$("select[data-verify=false]");
		for(var i=0;i<selects.length;i++){
			$(selects[i]).trigger('change');
			verify=false;
		}
		
		var intro = CKEDITOR.instances.ruleDetail.getData();
		if(intro.length <= 0) {
			ZF.showTip("请填写规则详情，必填项!", "info");
			verify = false;
		}
		
		var st = $("#startTime").val();
		var et = $("#endTime").val();
		if(st == null || st == "") {
			ZF.showTip("请先选择活动开始时间","info");
			verify = false;
		}
		if(st > et) {
			ZF.showTip("活动结束时间必须大于开始时间!", "info");
			verify = false;
		}
		
		return verify;
		
		
	}
</script>
</body>
</html>