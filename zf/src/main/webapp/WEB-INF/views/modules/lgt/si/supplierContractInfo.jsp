<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商合同管理</title>
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
                                <b>供应商名称</b> <a class="pull-right">${supplierContract.supplier.name}</a>
                              </li>
                              <li class="list-group-item">
                                <b>采购单单号</b> <a class="pull-right">${supplierContract.purchaseOrder.orderNo}</a>
                              </li>
                              <li class="list-group-item">
                                <b>合同编号</b> <a class="pull-right">${supplierContract.contractNo}</a>
                              </li>
                              <li class="list-group-item">
                                <b>合同名称</b> 
                                <shiro:hasPermission name="lgt:si:supplier:contractView">
                                    <a class="pull-right"  href="#"   download="${supplierContract.fileLibrary.name}" href="${imgHost }${supplierContract.fileLibrary.fileUrl}">
                                </shiro:hasPermission>
                                    ${supplierContract.name }
                                <shiro:hasPermission name="lgt:si:supplier:contractView">
                                    </a>
                                </shiro:hasPermission>
                              </li>
                              <li class="list-group-item">
                                <b>生效时间</b> <a class="pull-right"><fmt:formatDate value="${supplierContract.effectStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                              </li>
                              <li class="list-group-item">
                                <b>失效时间</b> <a class="pull-right"><fmt:formatDate value="${supplierContract.effectEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                              </li>
                              <li class="list-group-item">
                                  <b>备注</b><a class="pull-right">${supplierContract.remarks}</a>
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
	<script type="text/javascript">
	function xz(url) {
        return window.open(url);
    }
	</script>
</body>
</html>