<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统业务参数表管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<sys:tip content="${message}"/>	
	<section class="content">
		<div class="row">
			<div class="col-md-4">
				<div class="box box-primary">
					<div class="box-body box-profile">
					
					   <ul class="list-group list-group-unbordered">
                           <li class="list-group-item">
                               <b>参数编码</b> 
                               <a class="pull-right">${config.code }</a>
                           </li>
                           <li class="list-group-item">
                               <b>参数类型</b> 
                               <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(config.configType,'sys_config_type','')}</span></a>
                           </li>
                           
                           <li class="list-group-item">
                               <b>参数值</b> 
                               <a class="pull-right">${config.configValue }</a>
                           </li>
                           <li class="list-group-item">
                               <b>参数说明</b> 
                               <a class="pull-right">${config.description }</a>
                           </li>
                           
                           <li class="list-group-item">
                               <b>备注</b> 
                               <a class="pull-right">${config.remarks }</a>
                           </li>
                       </ul>
					</div>
					<div class="box-footer">
	    				<div class="pull-left box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
			        	</div>
		            </div>
				</div>
			</div>
		</div>
	</section>	
	
</div>

	
</body>
</html>