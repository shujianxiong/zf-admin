<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
<section class="content-header content-header-menu">
		<h1>
			<small><i class="fa-area"></i><a href="${ctx}/sys/area/listByType?isDistrict=1">区域列表</a></small>
			
			<shiro:hasPermission name="sys:area:edit">
			     <small>|</small>
			     <small class="menu-active"><i class="fa fa-repeat"></i><a href="form?id=${area.id}&parent.id=${area.parent.id}">区域${not empty area.id?'修改':'添加'}</a>
			     </small>
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:area:import">
               <small>|</small>
               <small>
                   <i class="glyphicon glyphicon-import"></i>
                   <a href="${ctx }/sys/area/importForm">区域批量导入</a>
               </small>
            </shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="area" action="${ctx}/sys/area/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						<div class="box-body">
							<form:hidden path="id" />
							<div class="form-group">
								<label class="col-sm-2 control-label">上级区域</label>
								<div class="col-sm-9">
									<form:hidden id="areaId" path="parent.id" />
									<form:input id="areaName" path="parent.name"
										htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
										placeholder="选择上级区域" readonly="true"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">区域名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="name" tip="请输入区域名称，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">区域编码</label>
								<div class="col-sm-9">
									<sys:inputverify id="code" name="code" tip="请输入区域编码，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">区域类型</label>
								<div class="col-sm-9">
									<form:select path="type" class="form-control">
										<form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
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
		    					<c:if test="${empty area.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="sys:area:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<sys:userselect height="550" url="${ctx}/sys/area/treeData"
			width="550" isOffice="true" isMulti="false" title="区域选择" isTopSelectable="true"
			id="selectArea"></sys:userselect>
	</section>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#areaName").on("click", function() {
				selectAreainit({
					"selectCallBack" : function(list) {
						$("#areaId").val(list[0].id);
						$("#areaName").val(list[0].text);
					}
				})
			});
		});
	</script>
	
</body>
</html>