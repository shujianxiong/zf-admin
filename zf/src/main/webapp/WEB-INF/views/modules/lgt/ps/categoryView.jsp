<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品分类详情</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<sys:tip content="${message}"/>
        
	    <form:form id="inputForm" modelAttribute="category" action="${ctx}/lgt/ps/category/view" method="post" class="form-horizontal">
	    <section class="content">
            <div class="row">
            	<div class="col-md-6">
		            <div class="box box-primary">
		            	<div class="box-body box-profile">
							<ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>父分类名称</b> 
                                    <a class="pull-right">${empty category.parent.categoryName ?'无':category.parent.categoryName}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>分类名称</b> 
                                    <a class="pull-right">${category.categoryName}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>分类标记</b> 
                                    <a class="pull-right">${category.categoryTag}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>使用范围</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(category.useRange,'useRange', '') }</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>排序序号</b> 
                                    <a class="pull-right">${category.orderNo}</a>
                                </li>
                                
                                 <li class="list-group-item">
                                    <b>创建人</b> 
                                    <a class="pull-right">${fns:getUserById(category.createBy.id).name}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>创建时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${category.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                 <li class="list-group-item">
                                    <b>更新人</b> 
                                    <a class="pull-right">${fns:getUserById(category.updateBy.id).name}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${category.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注信息</b> 
                                    <a class="pull-right">${category.remarks}</a>
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
	    </form:form>
	 </div>
</body>
</html>