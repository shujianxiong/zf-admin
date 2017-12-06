<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购订单审批</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body >
<div class="conent-wrapper sub-content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header content-header-menu">
		<h1>
			<small>
				<i class="fa-list-style"></i><a href="${ctx}/lgt/po/purchaseOrderExe/list">采购订单列表</a>
			</small>
			<shiro:hasPermission name="lgt:po:purchaseOrderExe:edit">
				<small>|</small>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/po/purchaseOrderExe/checkExeForm?id=${purchaseOrder.id}">采购订单审批</a>
				</small>
			</shiro:hasPermission>
		</h1>
	</section>
	
	<section class="content-header content-header-menu">
            
    </section>
    
    <section class="invoice">
        <p class="lead">基本信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">供应商</th>
                    <td colspan="3">${purchaseOrder.supplier.name}</td>
                </tr>
                <tr>
                    <th width="10%">任务编号</th>
                    <td>${purchaseOrder.purchaseMission.batchNo}</td>
                    <th width="10%">采购单号</th>
                    <td>${purchaseOrder.orderNo}</td>
                </tr>
                <tr>
                    <th width="10%">采购状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(purchaseOrder.orderStatus, 'lgt_po_purchase_order_orderStatus', '')}</span></td>
                    <th width="10%">采购员工</th>
                    <td>${fns:getUserById(purchaseOrder.purchaseUser.id).name}</td>
                </tr>
                <tr>
                    <th width="10%">应付采购金额</th>
                    <td><span class="text-red">${purchaseOrder.payableAmount}</span></td>
                    <th width="10%">要求完成时间</th>
                    <td>
                        <fmt:formatDate var="requiredTimeVar" value="${purchaseOrder.requiredTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        ${requiredTimeVar}
                    </td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${purchaseOrder.remarks }</p></td>
                </tr>
            </table>
        </div>
    </section>
	<section class="invoice">
            <p class="lead">采购产品信息</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>产品编码</th>
                            <th>商品名称</th>
                            <th>产品规格</th>
                            <th>要求采购数量</th>
                            <th>备注</th>
                        </tr>
                    </thead>
                    <tbody id="contentTable">
                        <c:forEach items="${purchaseOrder.purchaseProduceList }" var="ppe">
                           <tr>
                               <td>${ppe.produce.code }</td>
                               <td>${ppe.produce.goods.name }</td>
                               <td>${ppe.produce.name }</td>
                               <td>${ppe.requiredNum }</td>
                               <td>${ppe.remarks }</td>
                           </tr>
                         </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
	
	<form:form id="inputForm" modelAttribute="purchaseOrder" action="${ctx}/lgt/po/purchaseOrderExe/saveExeCheckResult" method="post"  class="form-horizontal">
           <form:hidden path="id"/>
           <input type="hidden" id="orderStatus" name="orderStatus" value=""/>
           <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-success">
                            <div class="box-body">
                                <!-- <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group zf-check-wrapper-padding">
                                            <label for="style" class="col-sm-3 control-label">审批结果</label>
                                            <div class="col-sm-7">   
                                                <input type="radio" name="orderStatus" value="1" checked="checked"/>审核通过&nbsp;&nbsp;
                                                <input type="radio" name="orderStatus" value="0" />审核拒绝
                                            </div> 
                                        </div>
                                    </div>
                                </div> -->
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="style" class="col-sm-3 control-label">审批备注</label>
                                            <div class="col-sm-7">
                                                <form:textarea id="checkRemarks" path="checkRemarks" cssClass="form-control" rows="3" maxlength="200" cssStyle="width:820px;height:80px;"/>
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="box zf-box-mul-border">
                    <div class="box-footer">
                        <div class="pull-left box-tools">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                        </div>
                        <div class="pull-right box-tools">
                            <button type="button" onclick="formSubmit(0);" class="btn btn-default btn-sm" ><i class="fa fa-thumbs-o-down">审批拒绝</i></button>
                            <button type="button" onclick="formSubmit(1);" class="btn btn-success btn-sm" ><i class="fa fa-thumbs-o-up">审批通过</i></button>
                        </div>
                    </div>
                </div>
             </section>
        </form:form>
</div>
	
<script type="text/javascript">
$(function() {
    
    $('input').iCheck({
        checkboxClass : 'icheckbox_minimal-blue',
        radioClass : 'iradio_minimal-blue'
    });
});

function formSubmit(type) {
    var remarks = $("#checkRemarks").val();
    if(remarks == null || remarks == "" || remarks == undefined) {
        ZF.showTip("请输入审批备注", "info");
        return false;
    }
    $("#orderStatus").val(type);
    $("#inputForm").submit();
}
</script>
</body>
</html>