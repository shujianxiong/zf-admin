<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文件目录管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a
					href="${ctx}/bas/fileDir/">文件目录列表</a></small>
				<shiro:hasPermission name="bas:fileDir:edit">
					<small>|</small>
					<small class="menu-active"><i class="fa fa-repeat"></i><a
						href="${ctx}/bas/fileDir/form?id=${fileDir.id}&parent.id=${fileDir.parent.id}">文件目录${not empty fileDir.id?'修改':'添加'}</a></small>
				</shiro:hasPermission>
			</h1>
		</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="fileDir" action="${ctx}/bas/fileDir/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						<div class="box-body">
							<form:hidden path="id" />
							<sys:inputtree url="${ctx}/bas/fileDir/treeData" label="文件目录" tip="请选择文件目录" id="parentFileDir" labelName="parent.name" value="${fileDir.parent.id }" labelValue="${fileDir.parent.name }" name="parent.id" labelWidth="2" inputWidth="9"></sys:inputtree>
							<div class="form-group">
								<label class="col-sm-2 control-label">目录名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="name" tip="请输入目录名称，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<c:choose>
							     <c:when test="${empty fileDir.id }">
									<div class="form-group">
		                                <label class="col-sm-2 control-label">目录编码</label>
		                                <div class="col-sm-9">
		                                   <!--  <div class="input-group"> -->
			                                    <sys:inputverify id="code" name="code" tip="请输入目录编码，必填项且唯一" verifyType="0"  isSpring="true"></sys:inputverify>
		                                        <!-- <span class="input-group-btn">
		                                            <button id="uniqueBtn" type="button" class="btn btn-info btn-flat">唯一判断</button>
		                                        </span>
		                                    </div>  -->
		                                </div>
		                            </div>
							     </c:when>
							     <c:otherwise>
							         <div class="form-group">
                                        <label class="col-sm-2 control-label">目录编码</label>
                                        <div class="col-sm-9">
                                            <form:hidden path="code"/>
                                            <form:input path="code" disabled="true" readonly="true" class="form-control zf-input-readonly"/>
                                        </div>
                                    </div>
							     </c:otherwise>
							</c:choose>
							
                            <div class="form-group">
                                <label class="col-sm-2 control-label">是否公开</label>
                                <div class="col-sm-9 zf-check-wrapper-padding">
                                   <form:radiobuttons path="type" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
                                </div>
                            </div>
							<div class="form-group">
                                <label class="col-sm-2 control-label">目录排序</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="orderNo" name="orderNo" tip="请输入目录排序" verifyType="4"  isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty fileDir.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<sys:userselect height="550" url="${ctx}/bas/fileDir/treeData"
			width="550" isOffice="true" isMulti="false" title="文件目录选择" isTopSelectable="true"
			id="selectDir"></sys:userselect>
	</section>
	</div>
	<script type="text/javascript">
		$(function() {
			
			$(":radio").iCheck({
	            checkboxClass : 'icheckbox_minimal-blue',
	            radioClass : 'iradio_minimal-blue'
	        });
			
			$("#fileDirName").on("click", function() {
				selectDirinit({
					"selectCallBack" : function(list) {
						$("#fileDirId").val(list[0].id);
						$("#fileDirName").val(list[0].text);
					}
				})
			});
			
			$("#code").on("blur", function() {
				var val = $("#code").val();
				ZF.ajaxQuery(false, "${ctx}/bas/fileDir/uniqueCheck",{"code":val} , function(data) {
                    if(data) {
                        $("#loading").hide();
                        ZF.showTip("恭喜您，该目录编码可用！", "info");
                        $("button[type=submit]").attr('disabled',false);
                    } else {
                        ZF.showTip("抱歉, 该目录编码已被使用！", "warning");
                        $("button[type=submit]").attr('disabled',true);
                    }
                });
			});
		});
		
	</script>
	
</body>
</html>