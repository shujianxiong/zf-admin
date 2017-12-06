<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>标签管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">

    <section class="content-header content-header-menu">
				
	</section>
	
	<section class="invoice">
		<div class="table-responsive">
     		<table class="table">
     			<tr>
	                <th width="10%">标签名称</th>
	                <td colspan="3">${tags.name}</td>
              	</tr>
              	<tr>
	                <th width="10%">是否热门</th>
	                <td colspan="3"><span class="label label-primary">${fns:getDictLabel(tags.hotFlag, 'yes_no', '')}</span></td>
              	</tr>
              	<tr>
	                <th width="10%">排序序号</th>
	                <td colspan="3">${tags.orderNo}</td>
              	</tr>
              	<tr>
	                <th width="10%">创建人</th>
	                <td width="40%">${fns:getUserById(tags.createBy.id).name}</td>
	                <th width="10%">创建时间</th>
	                <td><fmt:formatDate value="${tags.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
              	</tr>
              	<tr>
	                <th width="10%">更新人</th>
	                <td width="40%">${fns:getUserById(tags.updateBy.id).name}</td>
	                <th width="10%">更新时间</th>
	                <td><fmt:formatDate value="${tags.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
              	</tr>
              	<tr>
	                <th width="10%">备注</th>
	                <td colspan="3"><p class="text-muted well well-sm no-shadow">${tags.remarks}</p></td>
              	</tr>
              	
     		</table>
     	</div>
     	<div class="row no-print">
       		<div class="col-xs-12">
       			<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
       		</div>
		</div>
	</section>
</div>
</body>
</html>