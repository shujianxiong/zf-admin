<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域信息</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
 	<div class="content-wrapper sub-content-wrapper">
	    <section class="content">
            <div class="row">
            	<div class="col-md-4">
		            <div class="box box-primary">
		            	<div class="box-body box-profile">
		            	    <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>上级区域</b> 
                                    <a class="pull-right">${area.parent.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>区域名称</b> 
                                    <a class="pull-right">${area.name}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>区域编码</b> 
                                    <a class="pull-right">${area.code}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>区域类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(area.type, 'sys_area_type', '无')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
	                                <b>创建人</b> 
	                                <a class="pull-right">${fns:getUserById(area.createBy.id).name }</a>
	                            </li>
	                            <li class="list-group-item">
	                                <b>创建时间</b> 
	                                <a class="pull-right"><fmt:formatDate value="${area.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
	                            </li>
	                            
	                            <li class="list-group-item">
	                                <b>更新人</b> 
	                                <a class="pull-right">${fns:getUserById(area.updateBy.id).name }</a>
	                            </li>
	                            <li class="list-group-item">
	                                <b>更新时间</b> 
	                                <a class="pull-right"><fmt:formatDate value="${area.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
	                            </li>
	                            
	                            <li class="list-group-item">
	                                <b>备注</b> 
	                                <a class="pull-right">${area.remarks}</a>
	                            </li>
                                
                                
                            </ul>
		            	</div>
		            	
		            	<div class="box-footer">
								<button type="button" class="btn btn-default btn-sm"
									onclick="javascript:history.go(-1)">
									<i class="fa fa-mail-reply"></i>返回
								</button>
							</div>
		            	
		            </div>
	            </div>
	        </div>
	    </section>
	 </div>
</body>
</html>