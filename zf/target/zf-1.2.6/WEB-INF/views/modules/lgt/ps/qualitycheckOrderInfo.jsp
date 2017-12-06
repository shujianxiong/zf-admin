<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品质检单管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		
		<section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <p class="lead">质检单详情</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">质检员</th>
                        <td>${qualitycheckOrder.qcUser.name}</td>
                        <th width="10%">质检类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.qcBusinessType,'lgt_ps_qualitycheck_order_qcType', '')}</span></td>
                        <th width="10%">质检状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.qcStatus,'lgt_ps_qualitycheck_order_qcStatus', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">是否称重</th>
                        <td><span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.weighFlag,'yes_no', '')}</span></td>
                        <th width="10%">是否检验外观</th>
                        <td><span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.codecheckFlag,'yes_no', '')}</span></td>
                        <th width="10%">是否核对裸石编码</th>
                        <td><span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.codecheckFlag,'yes_no', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">质检时间</th>
                        <td><fmt:formatDate value="${qualitycheckOrder.qcTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <th width="10%">完成时间</th>
                        <td><fmt:formatDate value="${qualitycheckOrder.finishTime}"  pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <th width="10%">质检结果</th>
                        <td><span class="label label-primary">${fns:getDictLabel(qualitycheckOrder.qcResult,'lgt_ps_qualitycheckOrder_qcResult', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${qualitycheckOrder.remarks }</p></td>
                    </tr>
                </table>
            </div>
        </section>
		
		 <section class="invoice">
            <p class="lead">质检详情</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th class="hide"></th>
                            <th>货品编码</th>
                            <th>货品原重数据</th>
                            <th>货品称重数据</th>
                            <th>货品称重结果</th>
                            <th>货品质检外观</th>
                            <th>原裸石编码</th>
                            <th>核对裸石编码</th>
                            <th>裸石编码核对结果</th>
                            <th>质检凭证</th>
                            <th>质检结果</th>
                            <th>损耗估算</th>
                            <th>备注信息</th>
                        </tr>
                    </thead>
                    <tbody id="contentTable">
                        <c:forEach items="${qualitycheckOrder.qualitycheckDetailList }" var="qtd"  varStatus="index">
                            <tr>
                                <td>${qtd.product.code } </td>
                                <td>${qtd.weightOriginal } </td>
                                <td>${qtd.weightCheck} </td>
                                <td>${fns:getDictLabel(qtd.weightResult, 'lgt_ps_qualitycheckDetail_weightResult', '')} </td>
                                <td>${fns:getDictLabel(qtd.surfaceCheck, 'lgt_ps_qualitycheckDetail_surfaceCheck', '')} </td>
                                <td>${qtd.codeOriginal }</td>
                                <td>${qtd.codeCheck} </td>
                                <td>${fns:getDictLabel(qtd.codeResult, 'lgt_ps_qualitycheckDetail_codeResult', '')} </td>
                                <td>${qtd.qcVoucher}</td>
                                <td>${fns:getDictLabel(qtd.qcResult, 'lgt_ps_qualitycheckOrder_qcResult', '')} </td>
                                <td>${qtd.lossEvaluation}</td>
                                <td>${qtd.remarks}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="box-footer">
                <div class="pull-left box-tools">
                   <button type="button" class="btn btn-default btn-sm"
                      onclick="javascript:history.go(-1)">
                      <i class="fa fa-mail-reply"></i>返回
                   </button>
                </div>
           </div>
        </section>
	</div>
</body>
</html>