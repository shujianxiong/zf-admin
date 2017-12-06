<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问卷添加问题</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small>
					<i class="fa-list-style"></i><a href="${ctx}/spm/qa/questionnaire/">问卷列表</a>
				</small>
				<small>|</small>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/spm/qa/questionnaire/addQueform?id=${questionnaire.id}">关联问题</a>
				</small>
			</h1>
		</section>
		<section class="content">
			<form:form id="inputForm" modelAttribute="questionnaire" action="${ctx}/spm/qa/questionnaire/saveQuestion" method="post" class="form-horizontal" onsubmit="return formSubmit();">
				<form:hidden path="id"/>
				<div class="box box-success">
					<div class="box-header with-border zf-query">
						<h5>问卷基本信息</h5>
						<div class="box-tools pull-right">
				          	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				        </div>
					</div>
					<div class="box-body">
						<div class="col-md-4">
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">问卷名称</label>
								<div class="col-sm-8">
									<input type="text" value="${questionnaire.name }" readonly="readonly" class="form-control" />
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="type" class="col-sm-2 control-label">问卷类型</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" value="${fns:getDictLabel(questionnaire.type,'spm_qa_questionnaire_type','') }" readonly="readonly"/>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="type" class="col-sm-2 control-label">问卷标题</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" value="${questionnaire.title }" readonly="readonly"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box box-success">
					<div class="box-header with-border zf-query">
						<h5>问卷问题设置列表</h5>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-sm-12 pull-right">
					            <button type="button" class="btn btn-sm btn-success" id="chooseQueBtn"><i class="fa fa-hand-pointer-o">选择问题</i></button>
							</div>
						</div>
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped zf-tbody-font-size">
								<thead>
									<tr>
										<th>问题名称</th>
										<th>问题类型</th>
										<th>问题描述</th>
										<th>问题分值</th>
										<th>问题顺序层级</th>
										<th width="10">&nbsp;</th>
									</tr>
								</thead>
								<tbody id="tBody">
									<c:forEach items="${questionnaire.questionnaireQueList }" var="questionnaireQue" varStatus="status">
										<tr data-value="${questionnaireQue.baseQuestion.id }">
											<td class="hide">
												<input id="questionnaireQueList${ status.index}_id" type="hidden" name="questionnaireQueList[${status.index }].id" value="${ questionnaireQue.id }" />
												<input id="questionnaireQueList${ status.index}_delFlag" type="hidden" name="questionnaireQueList[${status.index }].delFlag" value="0" />
												<input type="hidden" name="questionnaireQueList[${status.index }].baseQuestion.id" value="${ questionnaireQue.baseQuestion.id }" />
											</td>
											<td>
												${questionnaireQue.baseQuestion.name }
											</td>
											<td>
												${fns:getDictLabel(questionnaireQue.baseQuestion.type, 'spm_qa_base_question_type', '')}
											</td>
											<td>
												${questionnaireQue.baseQuestion.description}
											</td>
											<td>
												<input type="text" id="questionnaireQueList${status.index }_point" data-verify="true" maxlength="8" data-type="point" name="questionnaireQueList[${status.index }].point" 
														class="form-control" value="${questionnaireQue.point }"/>
											</td>
											<td>
												<input type="text" id="questionnaireQueList${status.index }_levelNum" data-verify="false" maxlength="8" data-type="levelNum" name="questionnaireQueList[${status.index }].levelNum" 
														class="form-control" value="${questionnaireQue.levelNum }"/>
											</td>
											<td>
												<span id="questionnaireQueList${ status.index}" data-type='delBtn' style='display:block;' class='close' title='删除'>&times;</span>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="box-footer">
    					<div class="pull-left box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
			        	</div>
    					<div class="pull-right box-tools">
		               		<shiro:hasPermission name="spm:qa:questionnaire:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
			        	</div>
    				</div>
				</div>
			</form:form>
			<sys:selectmutil id="baseQuestionSelect" title="问卷问题选择" url="${ctx}/spm/qa/baseQuestion/questionSelect?questionnaireId=${ questionnaire.id}&pageKey=addQuestionnaireQueForm" isDisableCommitBtn="true" width="1200" height="700" isRefresh="false"></sys:selectmutil>
		</section>
	</div>
	<script type="text/javascript">
		$(function(){
			
			//绑定删除事件
        	$("span[data-type='delBtn']").on("click",function(){
				var prefix = $(this).prop("id");
				var id = $("#"+prefix+"_id");
				var delFlag = $("#"+prefix+"_delFlag");
				if (id.val() == ""){
					$(this).parent().parent().remove();
				}else if(delFlag.val() == "0"){
					delFlag.val("1");
					$(this).html("&divide;").attr("title", "撤销删除");
				}else if(delFlag.val() == "1"){
					delFlag.val("0");
					$(this).html("&times;").attr("title", "删除");
				}
				
			});
	   		// 选择问题
			$("#chooseQueBtn").on('click',function(){
	        	$("#baseQuestionSelectModal").modal('toggle');//显示模态框
			});
	   		
			$("input[data-type=levelNum]").each(function(){
	   			if($(this).val()!=null&&$(this).val()!=undefined&&$(this).val()!=""){
					$(this).attr("data-verify",true);
				}
	   		});
	   		
			//给input绑定change事件
			$("input[data-type=point]").on("change",function(){
				ZF.formVerify(false, 4, $(this).val())?$(this).attr("data-verify","true"):$(this).attr("data-verify","false");
				var id=$(this).attr("id");
				if(!ZF.formVerify(false,"4",$(this).val())){
					$(this).addClass("zf-input-err");
					if($("#"+id+"Err").length<=0)
						$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>问题分值必须为正整数</label>")
					$(this).attr("data-verify","false");
				}else{
					if($("#"+id+"Err").length>0){
						$(this).removeClass("zf-input-err");
						$("#"+id+"Err").remove();
						$(this).attr("data-verify","true");
					}
				}
			});
			
			//给input绑定change事件
			$("input[data-type=levelNum]").on("change",function(){
				ZF.formVerify(true, 4, $(this).val())?$(this).attr("data-verify","true"):$(this).attr("data-verify","false");
				var id=$(this).attr("id");
				if(!ZF.formVerify(true,"4",$(this).val())){
					$(this).addClass("zf-input-err");
					if($("#"+id+"Err").length<=0)
						$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>问题顺序层级不得为空，且必须为正整数</label>")
					$(this).attr("data-verify","false");
				}else{
					if($("#"+id+"Err").length>0){
						$(this).removeClass("zf-input-err");
						$("#"+id+"Err").remove();
						$(this).attr("data-verify","true");
					}
				}
			});
			
			$("#baseQuestionSelectModal #commitBtn").on("click",function(){
				
	        	var content = $("#baseQuestionSelectModalIframe").contents().find("body");
				var questionArray = new Array();
				var question = new Array();
				//先获取数据
				$("input[type=checkBox]", content).each(function(){
					if($(this).prop("checked")){
	    				question.push($(this).val()); //问题ID
	    				question.push($(this).attr("data-name")); //问题名称
	    				question.push($(this).attr("data-type")); //问题类型
	    				question.push($(this).attr("data-des")); //问题描述
	    				questionArray.push(question);
	    				question = []; //清空数组
					}
				});
				
				//过滤掉已有数据
				questionArray = checkExsit(questionArray);
				
				var trLength=$("#tBody").children('tr').length; //表格已有tr长度
				//当questionArray有数据时循环遍历
				if(questionArray!=null && questionArray!=undefined &&questionArray.length>0){
					for(var i=trLength;i<questionArray.length+trLength;i++){
						var question = questionArray[i-trLength];
						var html = "<tr data-value='"+question[0]+"'>";
						html+="<td style='display:none;'>";
						html+="<input type='hidden' id='questionnaireQueList"+i+"_id' name='questionnaireQueList["+i+"].id' />";
						html+="<input type='hidden' name='questionnaireQueList["+i+"].baseQuestion.id' value='"+question[0]+"' />";
						html+="</td>";
						html+="<td>"+question[1]+"</td>";
						html+="<td>"+question[2]+"</td>";
						html+="<td>"+question[3]+"</td>";
						html+="<td><input type='text' id='questionnaireQueList"+i+"_point' data-verify='true' maxlength='8' data-type='point' name='questionnaireQueList["+i+"].point' class='form-control'></td>";
						html+="<td><input type='text' id='questionnaireQueList"+i+"_levelNum' data-verify='false' maxlength='8' data-type='levelNum' name='questionnaireQueList["+i+"].levelNum' class='form-control'></td>";
						html+="<td><span id='questionnaireQueList"+i+"' data-type='delBtn' style='display:block;' class='close' title='删除'>&times;</span></td>";
						html+="</tr>";
						$("#tBody").append(html);
					}
				}

	        	$("#baseQuestionSelectModal").modal('toggle'); //关闭模态框
	        	
	        	//重新绑定删除事件
	        	$("span[data-type='delBtn']").unbind("click");
       	     	$("span[data-type='delBtn']").on("click",function(){
					var prefix = $(this).prop("id");
					var id = $("#"+prefix+"_id");
					var delFlag = $("#"+prefix+"_delFlag");
					if (id.val() == ""){
						$(this).parent().parent().remove();
					}else if(delFlag.val() == "0"){
						delFlag.val("1");
						$(this).html("&divide;").attr("title", "撤销删除");
					}else if(delFlag.val() == "1"){
						delFlag.val("0");
						$(this).html("&times;").attr("title", "删除");
					}
					
				});
	        	
				//给input绑定change事件
				$("input[data-type=point]").on("change",function(){
					ZF.formVerify(false, 4, $(this).val())?$(this).attr("data-verify","true"):$(this).attr("data-verify","false");
					var id=$(this).attr("id");
					if(!ZF.formVerify(false,"4",$(this).val())){
						$(this).addClass("zf-input-err");
						if($("#"+id+"Err").length<=0)
							$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>问题分值必须为正整数</label>")
						$(this).attr("data-verify","false");
					}else{
						if($("#"+id+"Err").length>0){
							$(this).removeClass("zf-input-err");
							$("#"+id+"Err").remove();
							$(this).attr("data-verify","true");
						}
					}
				});	
				
				//给input绑定change事件
				$("input[data-type=levelNum]").on("change",function(){
					ZF.formVerify(true, 4, $(this).val())?$(this).attr("data-verify","true"):$(this).attr("data-verify","false");
					var id=$(this).attr("id");
					if(!ZF.formVerify(true,"4",$(this).val())){
						$(this).addClass("zf-input-err");
						if($("#"+id+"Err").length<=0)
							$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>层级不得为空，且必须为正整数</label>")
						$(this).attr("data-verify","false");
					}else{
						if($("#"+id+"Err").length>0){
							$(this).removeClass("zf-input-err");
							$("#"+id+"Err").remove();
							$(this).attr("data-verify","true");
						}
					}
				});
				
				
				//清楚check  table缓存
				window.localStorage.removeItem("addQuestionnaireQueForm");
			});
			
		});
		
		//过滤已有数据
		function checkExsit(questionArray){
			
			$("#tBody").children('tr').each(function(){
				if(questionArray != null && questionArray!=undefined &&questionArray.length>0){
					for(var i=0;i<questionArray.length;i++){
						if(questionArray[i][0]==$(this).attr("data-value")){
							questionArray.splice(i,1);
						}
					}
				}		
			})
			
			return questionArray;
		}
		
		function formSubmit(){
			var verify=true;
			var inputs=$("input[data-verify=false]",$("#tBody"));
			for(var i=0;i<inputs.length;i++){
				$(inputs[i]).trigger('change');
				verify=false;
			}
			return verify;
		}
		
	</script>
</body>
</html>