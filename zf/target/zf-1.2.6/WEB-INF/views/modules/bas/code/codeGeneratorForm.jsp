<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务编码生成器管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
   	        <small><i class="fa-list-style"></i><a href="${ctx}/bas/code/codeGenerator">编码生成器列表</a></small>
	        <small>|</small>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bas/code/codeGenerator/form?id=${codeGenerator.id}">编码生成器${not empty codeGenerator.id?'修改':'新增'}</a></small>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
    	<section class="content">
    		<div class="row">
    			<div class="col-md-6">
    				<form:form id="inputForm" modelAttribute="codeGenerator" action="${ctx}/bas/code/codeGenerator/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
						<form:hidden path="id"/>
	    				<div class="box box-success">
			    			<div class="box-header with-border zf-query">
			    				<h5>业务编码信息</h5>
			    			</div>  
			    			
			    			<div class="box-body">
			    				<div class="form-group">
									<label for="codeHandle" class="col-sm-2 control-label">生成器说明须知</label>
									<div class="col-sm-9" style="color: green">
										1.最终生成编码由“前缀+日期值+中缀+主值+后缀”组成，其中前缀、中缀、后缀可以为空，主值不足主值长度的部分前面用0填充。<br/>
										2.主值为该生成器生成的最后一个编码的主值取值，为0或为空表示该生成器暂未使用过。<br/>
										3.自增主值每次使用自增加1，随机自增主值每次使用自增加1至9中随机一个数，带日期的编码每天主值初始化为1。<br/>
										4.随机类型主值每次产生一个随机数（不足主值长度的部分用9填充），产生的编码不排除重复的可能，需要在调用代码中处理或对应数据库字段设置唯一性限制。
									</div>
								</div>
								<div class="form-group">
								<label for="codeHandle" class="col-sm-2 control-label">生成器代码</label>
								<div class="col-sm-9">
									<sys:inputverify name="codeHandle" id="codeHandle" verifyType="0" tip="请输入生成器代码，必填项" isSpring="true"></sys:inputverify>
								</div>
								</div>
			    				<div class="form-group">
									<label for="codeName" class="col-sm-2 control-label">编码名称</label>
									<div class="col-sm-9">
										<sys:inputverify name="codeName" id="codeName" verifyType="0" tip="请输入编码名称，必填项" isSpring="true"></sys:inputverify>
									</div>
								</div>
			    				<div class="form-group">
									<label for="prefix" class="col-sm-2 control-label">前缀</label>
									<div class="col-sm-9">
										<form:input path="prefix"  maxlength="100" class="form-control" placeholder="请输入前缀"/>
									</div>
								</div>
			    				<div class="form-group">
									<label for="dateType" class="col-sm-2 control-label">日期类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="dateType" tip="请选择日期类型，必填项" verifyType="0" dictName="bas_code_generator_dateType" id="dateType"></sys:selectverify>
									</div>
								</div>
			    				<div class="form-group">
									<label for="midfix" class="col-sm-2 control-label">中缀</label>
									<div class="col-sm-9">
										<form:input path="midfix"  htmlEscape="false" maxlength="10" class="form-control"  placeholder="请输入中缀值"/>
									</div>
								</div>
			    				<div class="form-group">
									<label for="mainValueType" class="col-sm-2 control-label">主值随机类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="mainValueType" tip="请选择主值随机类型，必填项" verifyType="0" dictName="bas_code_generator_mainValueType" id="mainValueType"></sys:selectverify>
									</div>
								</div>
			    				<div class="form-group">
									<label for="mainValueLength" class="col-sm-2 control-label">主值长度</label>
									<div class="col-sm-9">
										<sys:inputverify name="mainValueLength" id="mainValueLength" verifyType="4" tip="请输入主值长度，必填项且必须录入正整数" isSpring="true"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label for="mainValueLength" class="col-sm-2 control-label">主值起始值</label>
									<div class="col-sm-9">
										<sys:inputverify name="mainValue" id="mainValue" verifyType="4" isMandatory="false" tip="请输入主值长度，必须录入正整数" isSpring="true"></sys:inputverify>
									</div>
								</div>
			    				<div class="form-group">
									<label for="postfix" class="col-sm-2 control-label">后缀</label>
									<div class="col-sm-9">
										<form:input path="postfix"  htmlEscape="false" maxlength="10" class="form-control" placeholder="请输入后缀"/>
									</div>
								</div>
			    				<div class="form-group">
									<label for="remarks" class="col-sm-2 control-label">备注信息</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"  placeholder="请输入备注"/>
									</div>
								</div>
			    			</div>
			    			<div class="box-footer">
					        	<div class="pull-left box-tools">
				        			<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
				               		<shiro:hasPermission name="bas:code:codeGenerator:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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