<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>IP白名单管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	    <sys:tip content="${message}"/>
	  
	    	<section class="content">
	    		<div class="row">
	    			<div class="col-md-6">
	    				<div class="box box-primary">
			    			<div class="box-body box-profile">
			    			
			    			    <ul class="list-group list-group-unbordered">
	                                <li class="list-group-item">
	                                    <b>创建时间</b> 
	                                    <a class="pull-right"><fmt:formatDate value="${ipConfig.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
	                                </li>
	                                <li class="list-group-item">
	                                    <b>IP地址</b> 
	                                    <a class="pull-right">${ipConfig.ip }</a>
	                                </li>
	                                <li class="list-group-item">
	                                    <b>是否启用</b> 
	                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(ipConfig.activeFlag,'yes_no','')}</span></a>
	                                </li>
	                                <li class="list-group-item">
	                                    <b>创建人</b> 
	                                    <a class="pull-right">${fns:getUserById(ipConfig.createBy.id).name }</a>
	                                </li>
	                                <li class="list-group-item">
                                        <b>更新人</b> 
                                        <a class="pull-right">${fns:getUserById(ipConfig.updateBy.id).name }</a>
                                    </li>
	                                <li class="list-group-item">
                                        <b>更新时间</b> 
                                        <a class="pull-right"><fmt:formatDate value="${ipConfig.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                    </li>
	                                <li class="list-group-item">
	                                    <b>备注</b> 
	                                    <a class="pull-right">${ipConfig.remarks }</a>
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