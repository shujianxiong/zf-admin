<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购任务审批</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body >
<div class="conent-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
		<h1>
			<small>
				<i class="fa-list-style"></i><a href="${ctx}/lgt/po/purchaseMission/list">采购任务列表</a>
			</small>
			<shiro:hasPermission name="lgt:po:purchaseMission:edit">
				<small>|</small>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/po/purchaseMission/form?id=${purchaseMission.id}">采购任务审批</a>
				</small>
			</shiro:hasPermission>
		</h1>
	</section>
	
	<section class="invoice">
        <p class="lead">任务信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">批次编号</th>
                    <td>${purchaseMission.batchNo }</td>
                </tr>
                <tr>
                    <th width="10%">任务状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(purchaseMission.missionStatus, 'lgt_po_purchase_mission_missionStatus', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td><p class="text-muted well well-sm no-shadow">${purchaseMission.remarks }</p></td>
                 </tr>
             </table>
         </div>
   </section>
   <section class="invoice">
          <p class="lead">产品明细</p>
          <div class="table-responsive">
              <table class="table">
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
                         <c:forEach items="${purchaseMission.detailList }" var="detail" varStatus="status">
                         <tr id="${detail.produce.id}">
                         	 <td>
                         	 	<img onerror="imgOnerror(this);" src="${imgHost }${detail.produce.goods.samplePhoto}" data-big data-src="${imgHost }${detail.produce.goods.samplePhoto}" width="20px" height="20px" />
                         	 </td>
                             <td>
                                 <span id="${detail.produce.id }_pcode">${detail.produce.code }</span>
                             </td>
                             <td>
                                 ${detail.produce.goods.name } ${detail.produce.name }
                             </td>
                             <td>
                                 ${detail.num}
                             </td>
                             <td>
                                 ${detail.remarks }
                             </td>
                         </tr>
                        </c:forEach>
                    </tbody>
             </table>
         </div>
      </section>
    <form:form id="inputForm" modelAttribute="purchaseMission" action="${ctx}/lgt/po/purchaseMission/saveCheckResult" method="post"  class="form-horizontal">
	    <form:hidden path="id"/>
	    <input type="hidden" id="missionStatus" name="missionStatus" value=""/>
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
											    <input type="radio" name="missionStatus" value="1" checked="checked"/>审核通过&nbsp;&nbsp;
											    <input type="radio" name="missionStatus" value="0" />审核拒绝
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
		  				    <button type="button" onclick="return formSubmit(0);" class="btn btn-default btn-sm" ><i class="fa fa-thumbs-o-down">审批拒绝</i></button>
			            	<button type="button" onclick="return formSubmit(1);" class="btn btn-success btn-sm" ><i class="fa fa-thumbs-o-up">审批通过</i></button>
			        	</div>
		            </div>
		        </div>
			 </section>
		</form:form>
</div>
	
<script type="text/javascript">
	$(function() {
		ZF.bigImg();
	    
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
		$("#missionStatus").val(type);
		$("#inputForm").submit();
	}
</script>
</body>
</html>