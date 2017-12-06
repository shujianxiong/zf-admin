<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购任务详情</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body >
<div class="conent-wrapper sub-content-wrapper">
	
	<section class="content-header content-header-menu">
            
    </section>
    
    <section class="invoice">
        <p class="lead">任务信息信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">任务编号</th>
                    <td>${purchaseMission.batchNo }</td>
                </tr>
                <tr>
                    <th width="10%">任务状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(purchaseMission.missionStatus, 'lgt_po_purchase_mission_missionStatus', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${purchaseMission.remarks }</p></td>
                </tr>
                <tr>
                    <th width="10%">审批人</th>
                    <td colspan="3">${fns:getUserById(purchaseMission.checkBy.id).name }</td>
                </tr>
                <tr>
                    <th width="10%">审批备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${purchaseMission.checkRemarks }</p></td>
                </tr>
            </table>
        </div>
    </section>
	
	<section class="invoice">
       <p class="lead">采购产品明细</p>
       <div class="table-responsive">
           <table class="table table-striped">
               <thead>
                   <tr>
                       <th>样图</th>
                       <th>产品编码</th>
                       <th>产品全称</th>
                       <th>采购数量</th>
                       <th>采购备注</th>
                   </tr>
               </thead>
               <tbody id="contentTable">
                   <c:forEach items="${purchaseMission.detailList }" var="detail">
                    <tr>
                        <td><img onerror="imgOnerror(this);" src="${imgHost }${detail.produce.goods.samplePhoto}" data-big data-src="${imgHost }${detail.produce.goods.samplePhoto}" width="20px" height="20px" /></td>
                        <td>${detail.produce.code }</td>
                        <td>${detail.produce.goods.name } ${detail.produce.name }</td>
                        <td>${detail.num}</td>
                        <td title="${detail.remarks}">${fns:abbr(detail.remarks,50)}</td>
                    </tr>
                   </c:forEach>
               </tbody>
           </table>
       </div>
       
       <div class="box-footer">
           <div class="pull-left box-tools">
               <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
           </div>
       </div>
   </section>
</div>

	<script type="text/javascript">
	  $(function () {
		ZF.bigImg();
	  });
	</script>

</body>
</html>