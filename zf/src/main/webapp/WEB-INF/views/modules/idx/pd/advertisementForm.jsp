<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>广告管理</title>
	<meta name="decorator" content="adminLte"/>
</head>

<body>
	<div class="content-wrapper sub-content-wrapper">
	    <section class="content-header content-header-menu">
	    	<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/idx/pd/advertisement/">广告列表</a></small>
				<shiro:hasPermission name="idx:pd:advertisement:edit">
				    <small>|</small>
				    <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/pd/advertisement/form?id=${advertisement.id}">广告${not empty advertisement.id?'修改':'添加'}</a></small>
				</shiro:hasPermission>
			</h1>
	    </section>
	    
	    <sys:tip content="${message}"/>

		<section class="content">
			<form:form id="inputForm" onsubmit="return ZF.formSubmit()" modelAttribute="advertisement" action="${ctx}/idx/pd/advertisement/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="row">
		    	<div class="col-md-6">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>广告添加</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">广告名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="name" tip="请输入广告名称， 必填项" verifyType="0" isSpring="true" isMandatory="true"></sys:inputverify>
								</div>
    						</div>
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">广告类型</label>
								<div class="col-sm-9">
								    <sys:selectverify name="type" tip="请选择广告 类型，必选项" verifyType="0" dictName="idx_pd_advertisement_type" id="type"></sys:selectverify>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">展示区域</label>
								<div class="col-sm-9">
								    <sys:selectverify name="displayArea" tip="请选择展示区域，必选项" verifyType="0" dictName="idx_pd_advertisement_displayArea" id="displayArea"></sys:selectverify>
								</div>
    						</div>
							<div class="control-group">
    							<label class="col-sm-2 control-label">展示图</label>
								<div class="col-sm-9">
									<form:hidden id="dpPhoto" path="dpPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="dpPhoto" model="true" selectMultiple="false"></sys:fileUpload>
								</div>
							</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">链接地址</label>
								<div class="col-sm-9">
									<sys:inputverify id="url" name="url" tip="请输入广告链接地址" verifyType="99" isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
    						</div>
							<div class="form-group">
    							<label class="col-sm-2 control-label">排列序号</label>
								<div class="col-sm-9">
									<sys:inputverify id="orderNo" name="orderNo" maxlength="8" tip="请输入正确的序号,整数，必填项" verifyType="0" isSpring="true" isMandatory="true"></sys:inputverify>
								</div>
    						</div>
							
							<div class="form-group">
    							<label class="col-sm-2 control-label">启用状态</label>
								<div class="col-sm-9">
								    <sys:selectverify name="usableFlag" tip="请选择启用状态，必选项" verifyType="0" dictName="yes_no" id="usableFlag"></sys:selectverify>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<textarea name="remarks" rows="4" maxlength="255" class="form-control input-xxlarge">${advertisement.remarks }</textarea>
								</div>
    						</div>
						</div>
						<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
	    					    <c:if test="${empty advertisement.id}">
	    					       <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
	    					    </c:if>
			               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
				        	</div>
	    				</div>
		            </div>
	            </div>
            </div>
            </form:form>
        </section>
	</div>
</body>
</html>