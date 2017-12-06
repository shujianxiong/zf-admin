<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品分类管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/category/list">分类列表</a></small>
	        
	        <shiro:hasPermission name="lgt:ps:lgtPsCategory:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/category/form?id=${category.id}">${empty category.id ? '新建':'修改' }分类</a></small></shiro:hasPermission>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<div class="row">
	    		<div class="col-md-6">
	    			<form:form id="inputForm" modelAttribute="category" action="${ctx}/lgt/ps/category/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
	    				<form:hidden path="id"/>
		    			<div class="box box-success">
		    				<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				              <div class="box-tools">
				                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
				                </button>    
				              </div>
		    				</div>
		    				<div class="box-body">
		    					
    							<sys:inputtree name="parent.id" url="${ctx}/lgt/ps/category/categoryData" id="category" label="父分类" labelValue="${category.parent.categoryName}" labelWidth="2" inputWidth="9" labelName="parent.categoryName" verifyType="-1" value="${category.parent.id}" tip="请选择父分类"></sys:inputtree>
	    						
	    						<div class="form-group">
	    							<label class="col-sm-2 control-label">分类名称</label>
									<div class="col-sm-9">
										<sys:inputverify id="categoryNameInput" name="categoryName" tip="请输入分类名称，必填项" verifyType="0" isSpring="true" ></sys:inputverify>
									</div>
	    						</div>
	    						
	    						<div class="form-group">
	    							<label class="col-sm-2 control-label">分类标记</label>
									<div class="col-sm-9">
										<sys:inputverify id="categoryTagInput" name="categoryTag" tip="请输入分类标记，必填项" verifyType="0" isSpring="true"></sys:inputverify>
									</div>
	    						</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">分类图标<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:明星穿搭详情">?</span></label>
									<div class="col-sm-9">
										<form:hidden id="categoryIcon" path="categoryIcon" htmlEscape="false" maxlength="255" class="form-control"/>
										<sys:fileUpload input="categoryIcon" model="true" selectMultiple="false"></sys:fileUpload>
									</div>
								</div>
	    						<div class="form-group">
                                    <label class="col-sm-2 control-label">使用范围</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="useRange" tip="请选择使用范围" verifyType="0" dictName="useRange" id="useRange"></sys:selectverify>
                                    </div>
                                </div>
	    						
	    						<div class="form-group">
	    							<label class="col-sm-2 control-label">排序序号</label>
									<div class="col-sm-9">
										<sys:inputverify id="orderNoInput" maxlength="8" name="orderNo" tip="请输入正确的序号,整数，必填项" verifyType="4" isSpring="true"></sys:inputverify>
									</div>
	    						</div>
	    						
	    						<div class="form-group">
	    							<label class="col-sm-2 control-label">备注信息</label>
									<div class="col-sm-9"> 
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
									</div>
	    						</div>
		    				</div>
		    				<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
		    					    <c:if test="${empty category.id }">
						        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					    </c:if>
				               		<shiro:hasPermission name="lgt:ps:lgtPsCategory:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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