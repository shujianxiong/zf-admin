<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商联系人管理</title>
	<meta name="decorator" content="adminLte"/>
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
                        <th width="10%">所属供应商</th>
                        <td colspan="3">${supplierContacts.supplier.name}</td>
                    </tr>
                    <tr>
                        <th width="10%">联系人姓名</th>
                        <td colspan="3">${supplierContacts.name}</td>
                    </tr>
                    <tr>
                        <th width="10%">角色</th>
                        <td colspan="3"><span class="label label-primary">${fns:getDictLabel(supplierContacts.role, 'lgt_si_supplier_contacts_role', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">岗位</th>
                        <td colspan="3"><span class="label label-primary">${fns:getDictLabel(supplierContacts.job, 'lgt_si_supplier_contacts_job', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">联系电话</th>
                        <td colspan="3">${supplierContacts.telephone}</td>
                    </tr>
                    <tr>
                        <th width="10%">所属区域</th>
                        <td colspan="3">${supplierContacts.area.name}</td>
                    </tr>
                    <tr>
                        <th width="10%">联系地址</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${supplierContacts.sysAreaDetail}</p></td>
                    </tr>
                    <tr>    
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${supplierContacts.remarks}</p></td>
                    </tr>
                </table>
            </div>
            <div class="box-footer">
	            <button type="button" class="btn btn-default btn-sm"
	                onclick="javascript:history.go(-1)">
	                <i class="fa fa-mail-reply"></i>返回
	            </button>
	        </div>
        </section>
	</div>
</body>
</html>