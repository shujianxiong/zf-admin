<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			/* $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			}); */
		});
	</script>
</head>
<body>
<div class="nav-tabs-custom tab-success">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oa/oaNotify/">通知列表</a></li>
		<li class="active"><a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">通知<shiro:hasPermission name="oa:oaNotify:edit">${oaNotify.status eq '1' ? '查看' : not empty oaNotify.id ? '修改' : '添加'}</shiro:hasPermission><shiro:lacksPermission name="oa:oaNotify:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
</div>
	<div class="content-wrapper">
	    <!-- Content Header (Page header) -->
	    <section class="content-header">
	      <h1>
	        	在线办公
	        <small>通知通告${not empty oaNotify.id?'修改':'添加'}</small>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
        
	    <form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal">
	    <form:hidden path="id"/>
	    <section class="content">
            <div class="row">
	            <div class="col-md-6">
		            <div class="box box-success">
			            <div class="box-header with-border">
			              <h3 class="box-title">通知通告信息</h3>
			              <!-- <div class="box-tools">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			              </div> -->
			            </div>
			            <!-- /.box-header -->
		            	<div class="box-body">
			                <div class="form-group">
			                  <label for="type" class="col-sm-2 control-label">类型</label>
			                  <div class="col-sm-10">
			                    <form:select path="type" class="form-control">
									<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
								<span class="help-inline"><font color="red">*</font> </span>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="title" class="col-sm-2 control-label">标题</label>
			                  <div class="col-sm-10">
			                    <input name="title" pattern="^.*[^\s]+.*$" required maxlength="200" class="form-control" value="${oaNotify.title}"/>
								<span class="help-inline"><font color="red">*</font> </span>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="content" class="col-sm-2 control-label">内容</label>
			                  <div class="col-sm-10">
			                    <textarea name="content" rows="6" pattern="^.*[^\s]+.*$" required maxlength="2000" class="form-control">${oaNotify.content}</textarea>
								<span class="help-inline"><font color="red">*</font> </span>
			                  </div>
			                </div>
			                <c:if test="${oaNotify.status ne '1'}">
			                	<div class="form-group">
				                  <label for="files" class="col-sm-2 control-label">附件</label>
				                  <div class="col-sm-10">
				                    <%-- <form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
									<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true"/> --%>
									
									<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="files" model="true" selectMultiple="true"></sys:fileUpload>
									
				                  </div>
				                </div>
								<div class="form-group">
				                  <label for="status" class="col-sm-2 control-label">状态</label>
				                  <div class="col-sm-10">
				                    <form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal"/>
									<span class="help-inline"><font color="red">*</font> 发布后不能进行操作。</span>
				                  </div>
				                </div>
				                <div class="form-group">
				                  <label for="title" class="col-sm-2 control-label">接收人</label>
				                  <div class="col-sm-10">
				                    <%-- <sys:treeselect id="oaNotifyRecord" name="oaNotifyRecordIds" value="${oaNotify.oaNotifyRecordIds}" labelName="oaNotifyRecordNames" labelValue="${oaNotify.oaNotifyRecordNames}"
										title="用户" url="/sys/office/treeData?type=3" cssClass="input-xxlarge required" notAllowSelectParent="true" checked="true"/>
									<span class="help-inline"><font color="red">*</font> </span> --%>
				                  </div>
				                </div>			                
			                </c:if>
		            	</div>
	            		<c:if test="${oaNotify.status eq '1'}">
		            		<div class="box box-solid">
					    		<div class="box-body">
					    			<div class="form-group">
					                  <label for="files" class="col-sm-2 control-label">接收人</label>
					                  <div class="col-sm-10">
					                    <table id="contentTable" cellspacing="0" class="table table-bordered table-hover table-striped">
											<thead>
												<tr>
												<th>接受人</th>
												<th>接受部门</th>
												<th>阅读状态</th>
												<th>阅读时间</th>
											</tr>
											</thead>
											<tbody>
											<c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
												<tr>
													<td>
														${oaNotifyRecord.user.name}
													</td>
													<td>
														${oaNotifyRecord.user.office.name}
													</td>
													<td>
														${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
													</td>
													<td>
														<fmt:formatDate value="${oaNotifyRecord.readDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
					                  </div>
					                </div>
					    			
					    		</div>
					    	</div>
	            		</c:if>
		            	<div class="box-footer">
		    				<div class="form-actions pull-right">
		    				<c:if test="${oaNotify.status ne '1'}">
		    					<shiro:hasPermission name="oa:oaNotify:edit"><input id="btnSubmit" class="btn btn-info" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
	    					</c:if>
								<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		    				</div>
			            </div>
			            
		            </div>
	            </div>
	        </div>
	    </section>
	    </form:form>
	 </div>
<script type="text/javascript">
	$(function(){
		 //表格初始化
	    var t=$('#contentTable').DataTable({
	      "paging": false,
	      "lengthChange": false,
	      "searching": false,
	      "ordering": false,
	      "info": false,
	      "autoWidth": false
	    });
		 //iCheck for checkbox and radio inputs
	    $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
	      checkboxClass: 'icheckbox_minimal-blue',
	      radioClass: 'iradio_minimal-blue'
	    });
	})
</script>
</body>
</html>