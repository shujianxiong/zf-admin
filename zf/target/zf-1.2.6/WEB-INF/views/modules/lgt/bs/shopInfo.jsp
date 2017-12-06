<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验店管理</title>
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
			<p class="lead">基本信息</p>
			<div class="table-responsive">
	     		<table class="table">
	     			<tr>
		                <th width="10%">体验店名称</th>
		                <td colspan="3">${shop.name}</td>
	              	</tr>
	              	<tr>
		                <th width="10%">联系电话</th>
		                <td>${shop.tel}</td>
		                <th width="10%">地址</th>
		                <td>${shop.area.name}</td>
	              	</tr>
	              	<tr>
		                <th width="10%">地址详情</th>
		                <td colspan="3">${shop.areaDetail}</td>
	              	</tr>
	              	<tr>
		                <th width="10%">是否可自提</th>
		                <td colspan="3"><span class="label label-primary">${fns:getDictLabel(shop.selfPickFlag, 'yes_no', '')}</span></td>
	              	</tr>
	              	<tr>
		                <th width="10%">创建人</th>
		                <td width="40%">${fns:getUserById(shop.createBy.id).name}</td>
		                <th width="10%">创建时间</th>
		                <td><fmt:formatDate value="${shop.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	              	</tr>
	              	<tr>
		                <th width="10%">更新人</th>
		                <td width="40%">${fns:getUserById(shop.updateBy.id).name}</td>
		                <th width="10%">更新时间</th>
		                <td><fmt:formatDate value="${shop.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	              	</tr>
	              	<tr>
		                <th width="10%">备注</th>
		                <td colspan="3"><p class="text-muted well well-sm no-shadow">${shop.remarks}</p></td>
	              	</tr>
	              	
	     		</table>
	     	</div>
		</section>
		
		<section class="invoice">
			<p class="lead">宣传图</p>
			<div class="row margin-bottom">
				<div class="col-sm-6">
	              <img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${fn:replace(shop.photoUrl, '|', '')}" alt="Photo">
	            </div>
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