<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>扫描电子码管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <sys:tip content="${message}"/>
    
    <form:form id="inputForm" modelAttribute="scanCode" action="${ctx}/bas/scanCode/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-4">
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            <ul class="list-group list-group-unbordered">
	                           <li class="list-group-item">
	                               <b>电子码</b> 
	                               <a class="pull-right">${scanCode.code}</a>
	                           </li>
	                           <li class="list-group-item">
	                               <b>业务类型</b> 
	                               <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(scanCode.type, 'bas_scan_code_type', '')}</span></a>
	                           </li>
	                           
	                           <li class="list-group-item">
	                               <b>创建者</b> 
	                               <a class="pull-right">${fns:getUserById(scanCode.createBy.id).name}</a>
	                           </li>
	                           <li class="list-group-item">
	                               <b>创建时间</b> 
	                               <a class="pull-right"><fmt:formatDate value="${scanCode.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
	                           </li>
	                           
	                           <li class="list-group-item">
                                   <b>更新者</b> 
                                   <a class="pull-right">${fns:getUserById(scanCode.updateBy.id).name}</a>
                               </li>
                               <li class="list-group-item">
                                   <b>更新时间</b> 
                                   <a class="pull-right"><fmt:formatDate value="${scanCode.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                               </li>
	                           
	                           <li class="list-group-item">
	                               <b>备注</b> 
	                               <a class="pull-right">${scanCode.remarks }</a>
	                           </li>
                            </ul>
                        </div>
                        
                        <div class="box-footer">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
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