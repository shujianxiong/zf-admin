<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工报警中心管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/msg/uw/myWarning/list">预警列表</a></small>
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/uw/myWarning/toDeal?id=${warning.id}">预警处理</a></small>
			</h1>
		</section>
		
		<section class="invoice">
		    <p class="lead">预警信息详情</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">警报类别</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warning.category,'msg_uw_warning_category','')}</span></td>
                        <th width="10%">警报类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warning.type,'msg_uw_warning_type','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">标题</th>
                        <td>${warning.title}</td>
                        <th width="10%">警报状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warning.status,'msg_uw_warning_status','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">推送时间</th>
                        <td><fmt:formatDate value="${warning.pushTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <th width="10%">查看时间</th>
                        <td><fmt:formatDate value="${warning.viewTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">发送用户</th>
                        <td>${fns:getUserById(warning.sendUser.id).name}</td>
                        <th width="10%">接收用户</th>
                        <td>${fns:getUserById(warning.receiveUser.id).name}</td>
                     </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="5"><p class="text-muted well well-sm no-shadow">${warning.remarks }</p></td>
                    </tr>
                </table>
            </div>
		</section>
		<section class="invoice">
			<div class="row">
				<div class="col-md-12">
					<form:form id="inputForm" modelAttribute="warning" action="${ctx}/msg/uw/myWarning/finish" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
						<form:hidden path="id"/>
						<div class="box box-success">
							<div class="box-header with-border">
								<h5>处理备注录入表单</h5>
							</div>
							<div class="box-body">
							     <div class="row">
                                    <div class="col-md-4">
										<div class="form-group">
											<label for="remarks" class="col-sm-2 control-label">处理备注</label>
											<div class="col-sm-9">
												<form:textarea path="dealResultRemarks" htmlEscape="false" rows="4" maxlength="255" class="form-control" style="margin: 0px -886.766px 0px 0px; width: 1243px; height: 86px;" />
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="box-footer">
			    				<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
				               		<shiro:hasPermission name="msg:uw:warning:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        	</div>
				            </div>
						</div>
					</form:form>
				</div>
			</div>
		</section>
	</div>	
		
</body>
</html>