<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>问题管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
	
	$(function(){
		$("#answerType").on("change",function(){
			$("#answersTbody").html("");
			
		})
		$("#questionType").on("change",function(){
			$("#answersTbody").html("");
			if($(this).select2("val")=="4"){
				$("#isYesAnswer").text("是否正确答案")
			}else{
				$("#isYesAnswer").text("")
			}
		})
	})
		
	function addRow(){
		var questionType=$("#questionType").select2("val");
		var answerType=$("#answerType").select2("val");
		if(answerType==null||answerType==""){
			ZF.showTip("请选择答案类型","warning")
			return;
		}
		if(answerType=="3"){
			ZF.showTip("输入类答案无须新增答案项","info")
			return;
		}
		var temp="<tr><td><input data-verify-answer type=\"text\" class=\"form-control\"/></td><td></td><td class='text-center' style='width:15px;'><span class='close' onclick='delRow(this);' title='删除' style='display:block' >&times;</span></td></tr>"
		if(questionType=="4")
			temp="<tr><td><input data-verify-answer type=\"text\" class=\"form-control\"/></td><td align=\"center\"><input data-verify-check type=\"$inputType\" value=\"0\" name=\"answerInput\" /></td><td class='text-center' style='width:15px;'><span class='close' onclick='delRow(this);' title='删除' style='display:block' >&times;</span></td></tr>"
		var html="";
		if(answerType=="1"&&questionType=="4"){
			html=temp.replace("$inputType","radio");
		}
		else if(answerType=="2"&&questionType=="4"){
			html=temp.replace("$inputType","checkbox");
		}
		else
			html=temp;
		var tr=$(html);
		$("#answersTbody").append(tr);
		
		$("input",tr).iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		$("input",tr).on("ifChecked",function(){
			$(this).val("1");
		})
		$("input",tr).on("ifUnchecked",function(){
			$(this).val("0");
		})
	}
	
	function delRow(obj){
		$(obj).parent().parent().remove();
	}
	
	function formSubmit(){
		var temp="<input type=\"hidden\" data-type=\"formHidden\" name=\"$name\" value=\"$val\" />";
		$("[data-type=formHidden]").remove();
		var form=$("#inputForm");
		var isSubmit=ZF.formSubmit();
		if(!isSubmit)
			return false;
		var questionType=$("#questionType").select2("val");
		var verifys=$("[data-verify-answer]");
		var checks=$("[data-verify-check]");
		if(questionType=="4"&&checks.length<=0){
			ZF.showTip("请选择正确答案","warning")
			return false;
		}
		for(var i=0;i<verifys.length;i++){
			var val=$(verifys[i]).val()
			if(val==""){
				ZF.showTip("第[ "+(i+1)+" ]行答案未填写","warning")
				return false;
			}
			if(questionType=="4"){
				var hidden=temp.replace("$name","answerList["+i+"].correctFlag").replace("$val",$(checks[i]).val())
				form.append(hidden);
			}
			var hidden=temp.replace("$name","answerList["+i+"].name").replace("$val",val)
			form.append(hidden);
		}
		confirm("问题一旦提交将无法修改，您确认提交吗？","info",function(){
			form.submit();
		})
		return true;
	}
	
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small>
					<i class="fa-list-style"></i><a href="${ctx}/spm/qa/baseQuestion/list">问题列表</a>
				</small>
				<shiro:hasPermission name="spm:qa:baseQuestion:edit">
					<small>|</small>
					<small class="menu-active">
						<i class="fa fa-repeat"></i><a href="${ctx}/spm/qa/baseQuestion/form?id=${baseQuestion.id}">问题<shiro:hasPermission name="spm:qa:baseQuestion:edit">${not empty baseQuestion.id?'修改':'添加'}</shiro:hasPermission></a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<form:form id="inputForm" modelAttribute="baseQuestion" action="${ctx}/spm/qa/baseQuestion/save" method="post" class="form-horizontal">
			<!--<form:hidden path="id"/>-->
			<div class="row">
		    	<div class="col-md-6">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>问题设置</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
    						<div class="form-group">
    							<label class="col-sm-2 control-label">问题类型</label>
								<div class="col-sm-9">
									<form:select id="questionType" path="type" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:options items="${fns:getDictList('spm_qa_base_question_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
    						</div>
    						<%-- <div class="form-group">
    							<label class="col-sm-2 control-label">问题背景图</label>
								<div class="col-sm-9">
									<form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
									<sys:ckfinder input="photo" type="images" uploadPath="/spm/qa/baseQuestion" selectMultiple="false"/>
								
								    <form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="photo" model="true" selectMultiple="false"></sys:fileUpload>
								    
								</div>
    						</div> --%>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">答案类型</label>
								<div class="col-sm-9">
									<form:select path="answerType" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:options items="${fns:getDictList('spm_qa_base_question_answerType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">问题</label>
								<div class="col-sm-9">
									<sys:inputverify name="name" id="name" verifyType="0" tip="请输入问题名称,必填项" isSpring="true"></sys:inputverify>
								</div>
    						</div>
    						<div class="form-group" id="answerListDiv" style="display: ;">
    							<label class="col-sm-2 control-label"></label>
								<div class="col-sm-9">
									<table id="contentTable" class="table table-hover table-bordered table-striped zf-tbody-font-size" style="width:100%;">
										<thead>
											<tr>
												<th class="hide"></th>
												<th>答案</th>
												<th id="isYesAnswer" width="60"></th>
												<th width="10">&nbsp;</th>
											</tr>
										</thead>
										<tbody id="answersTbody">
											
										</tbody>
										<tfoot>
											<tr>
												<td colspan="2">
													<button type="button" id="addBtn" class="btn btn-sm btn-success" onclick="addRow();"><i class="fa fa-plus">新增</i></button>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">问题描述</label>
								<div class="col-sm-9">
									<textarea name="description" rows="4" maxlength="255" class="form-control input-xxlarge">${baseQuestion.description }</textarea>
								</div>
    						</div>
    						
    						<!-- <div class="form-group">
    							<label class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<textarea name="remarks" rows="4" maxlength="255" class="form-control input-xxlarge">${baseQuestion.remarks }</textarea>
								</div>
    						</div> -->
		    			</div>
		    			<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
			               		<button type="button" class="btn btn-info btn-sm" onclick="formSubmit()"><i class="fa fa-save"></i>保存</button>
				        	</div>
	    				</div>
	    			</div>
    			</div>
    		</div>		
            </form:form>
        </section>
	</div>
	<script type="text/javascript">
		$(function() {
			$("input").iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
		});
		
		
		function submitForm(){
			$("#inputForm").submit();			
		}
	</script>
</body>
</html>