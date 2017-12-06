<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购订单货品编辑</title>
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
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/po/purchaseOrderExe/form?id=${purchaseOrder.id}">采购订单货品编辑</a>
				</small>
			</shiro:hasPermission>
		</h1>
	</section>
	
	<sys:tip content="${message}"/>
	
    <section class="content">
	    <form:form id="inputForm" modelAttribute="purchaseOrder" action="${ctx}/lgt/po/purchaseOrderExe/save" method="post" onsubmit="" class="form-horizontal">
	    <form:hidden path="id"/>
	    <form:hidden path="purchaseMission.id"/>
	    <form:hidden path="supplier.id"/>
	    <input type="hidden" name="token" value="${token }" />
	    <!-- 任务 -->
	    <div class="row">
	    	<div class="col-md-12">
	            <div class="box box-success">
		            <div class="box-header with-border zf-query">
		            	<h5>采购订单</h5>
		              	<div class="box-tools">
		                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		              	</div>
		            </div>
		            <!-- /.box-header -->
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">任务编号</label>
									<div class="col-sm-7">
										<input value="${purchaseOrder.purchaseMission.batchNo}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">采购单编号</label>
									<div class="col-sm-7">
										<input value="${purchaseOrder.orderNo}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">采购单状态</label>
									<div class="col-sm-7">
										<input value="${fns:getDictLabel(purchaseOrder.orderStatus, 'lgt_po_purchase_order_orderStatus', '')}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">供应商</label>
									<div class="col-sm-7">
										<input value="${purchaseOrder.supplier.name}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">采购员工</label>
									<div class="col-sm-7">
										<input value="${fns:getUserById(purchaseOrder.purchaseUser.id).name}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">应付采购金额</label>
									<div class="col-sm-7">
										<input value="${purchaseOrder.payableAmount}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">实付采购金额</label>
									<div class="col-sm-7">
										<input id="paidAmountInput" name="paidAmount" disabled="disabled" value="${purchaseOrder.paidAmount}" maxlength="12" class="form-control"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">要求完成时间</label>
									<div class="col-sm-7">
										<fmt:formatDate var="requiredTimeVar" value="${purchaseOrder.requiredTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										<input value="${requiredTimeVar}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">实际完成时间</label>
									<div class="col-sm-7">
										<fmt:formatDate var="finishTimeVar" value="${purchaseOrder.finishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
										<input value="${finishTimeVar}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">结算金价</label>
									<div class="col-sm-7">
										<input id="clearingGoldpriceInput" disabled="disabled" name="clearingGoldprice" value="${purchaseOrder.clearingGoldprice}" maxlength="12" class="form-control"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
							<button type="button" class="btn btn-info btn-sm" onclick="showExportModal()">
								<i class="fa fa-search"></i>货品导出
							</button>
						</div>
					</div>
	            </div>
            </div>
        </div>
	    <!-- 明细 -->
	    <div class="box box-soild">
           	<div class="box-header with-border zf-query">
            	<h5>采购产品明细</h5>
              	<div class="box-tools">
              		<div class="pull-left">
	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
              		</div>
	            </div>
            </div>
			<div class="box-body">
				<div class="table-reponsive">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
							    <th>产品样图</th>
								<th>产品编号</th>
                                <th colspan="2">产品名称</th>
                                <th colspan="2">产品规格</th>
                                <th>需采量</th>
                                <th>实采量</th>
                                <th>备注</th>
								<th width="10">&nbsp;</th>
							</tr>
						</thead>
						<tbody id="builderTbody">
							<c:forEach items="${purchaseOrder.purchaseProduceList }" var="ppe" varStatus="ppeStatus">
								<tr style="background-color: #cccccc;" id="${ppe.id }" data-index="${ppeStatus.index }" data-pcode="${ppe.produce.code }" data-num="${fn:length(ppe.purchaseProductList)}">
			   					    <td><img onerror="imgOnerror(this);" src="${imgHost }${ppe.produce.goods.samplePhoto}" data-big data-src="${imgHost }${ppe.produce.goods.samplePhoto}" width="20px;" height="20px;"/></td>
			   					    <td>
			   					        
	                                    <input type="hidden" name="purchaseProduceList[${ppeStatus.index }].id" value="${ppe.id }"/>
	                                    <input type="hidden" name="purchaseProduceList[${ppeStatus.index }].realityPrice" value="${ppe.realityPrice }"/>
	                                    <input type="hidden" name="purchaseProduceList[${ppeStatus.index }].backNum" value="${ppe.backNum }"/>
	                                    <input type="hidden" name="purchaseProduceList[${ppeStatus.index }].produce.id" value="${ppe.produce.id}"/>
	                                    <input type="hidden" name="purchaseProduceList[${ppeStatus.index }].produce.goods.category.id" value="${ppe.produce.goods.category.id}"/>
	                                    ${ppe.produce.code }
	                                </td>
	                                <td colspan="2">${fns:abbr(ppe.produce.goods.name, 40) }</td>
	                                <td colspan="2">${ppe.produce.name }</td>
	                                <td>${ppe.requiredNum }</td>
	                                <td id="inNum_${ppe.id }">${empty ppe.inNum ? 0 : ppe.inNum }</td>
	                                <td>${ppe.remarks }</td>
	                               	<td><span data-type="hideBtn" class="close" title="新增货品" style="display:block;float: left;" onclick="addProduct(this, '${ppe.produce.id}','${ppe.produce.pricePurchase}');"><i class="fa fa-plus"></i></span></td>
						   		</tr>
						   		<tr>
						   		  <th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
						   		  <th>录入批次</th>
						   		  <th>货品编码</th>
						   		  <th>货品克重</th>
						   		  <th>货品采购价</th>
						   		  <th>货品证书编号</th>
						   		  <th>货品存放货位</th>
						   		  <th>货品是否合格</th>
						   		  <th>货品备注</th>
						   		  <th><button type="button" class="btn btn-info btn-sm" onclick="showImportModal('${purchaseOrder.id}','${ppe.id}')"><i class="fa fa-save">导入</i></button></th>
						   		</tr>
						   		<c:forEach items="${ppe.purchaseProductList }" var="ppt" varStatus="pptStatus">
							   		<tr>
							   		    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							   		    <td>${ppt.inBatchNo }</td>
							   		    <td>
							   			     ${ppt.product.code }
							   			<%-- <input disabled="disabled" type="text" data-name="${ppe.id}_productCode" name="purchaseProduceList[${ppeStatus.index }].purchaseProductList[${pptStatus.index }].product.code" value="${ppt.product.code }" title="货品编码" placeholder="货品编码" class="form-control zf-input-readonly" style="font-size:12px;" maxlength="6"/> --%>
							   			</td>
							   			<td>
							   			     ${ppt.weight }
							   			<%-- <input disabled="disabled" type="text" data-name="${ppe.id}_we" name="purchaseProduceList[${ppeStatus.index }].purchaseProductList[${pptStatus.index }].weight" value="${ppt.weight }" title="货品克重" placeholder="货品克重，四位小数" class="form-control zf-input-readonly" style="font-size:12px;" maxlength="6"/> --%>
							   			</td>
							   			<td>
							   			     <%-- <input disabled="disabled" type="text" data-name="${ppe.id}_pprice" name="purchaseProduceList[${ppeStatus.index }].purchaseProductList[${pptStatus.index }].pricePurchase" value="${ppt.supplierBatchNo }" title="货品采购价" placeholder="货品采购价，两位小数" class="form-control zf-input-readonly" style="font-size:12px;" maxlength="32"/> --%>
							   			     ${ppt.pricePurchase }
						   			    </td>
							   			<td>
							   			     <%-- <input disabled="disabled" type="text" data-name="${ppe.id}_cn" name="purchaseProduceList[${ppeStatus.index }].purchaseProductList[${pptStatus.index }].certificateNo" value="${ppt.certificateNo }" title="货品证书编号" placeholder="货品证书编号" class="form-control zf-input-readonly" style="font-size:12px;" maxlength="50"/> --%>
							   			     ${ppt.certificateNo }
							   			</td>
							   			<td>
							   				<%-- <div class="input-group" style="width:320px" title="货品存放货位">
							   					<input disabled="disabled" type="hidden" data-name="${ppe.id}_wp" name="purchaseProduceList[${ppeStatus.index }].purchaseProductList[${pptStatus.index }].wareplace.id" value="${ppt.wareplace.id }"/>
							   					<input disabled="disabled" type="text" value="${ppt.wareplace.warecounter.warearea.warehouse.name } ${ppt.wareplace.warecounter.warearea.name } ${ppt.wareplace.warecounter.code } ${ppt.wareplace.code }" placeholder="货品存放货位" class="form-control zf-input-readonly" style="font-size:12px;" readOnly/>
							   					<span class="input-group-addon" onclick="selectWareplace(this, '${ppe.produce.id}');"><i class="fa fa-search"></i></span>
							   				</div> --%>
							   				${ppt.wareplace.warecounter.warearea.warehouse.code }-${ppt.wareplace.warecounter.warearea.code }-${ppt.wareplace.warecounter.code }-${ppt.wareplace.code }
							   			</td>
							   			<td> 
							   			     ${fns:getDictLabel(ppt.regularFlag, 'yes_no', '')  }
							   			</td>
							   			<td title="${ppt.remarks }"> 
							   			     <%-- <input  disabled="disabled" type="text" data-name="${ppe.id}_re" name="purchaseProduceList[${ppeStatus.index }].purchaseProductList[${pptStatus.index }].remarks" value="${ppt.remarks }" title="货品备注" placeholder="货品备注" class="form-control zf-input-readonly" style="font-size:12px;" maxlength="255"/> --%>
							   			     ${fns:abbr(ppt.remarks, 15) }
							   			</td>
							   			<td>
							   			     <%-- <span data-type="hideBtn" class="close pull-right" title="删除货品" style="display:block;float: left;" onclick="delProduct(this,'${ppe.id }');"><i class="fa fa-minus"></i></span> --%>
							   			</td>
							   		</tr>
						   		</c:forEach>
						   		<tr data-index="${ppe.id}-whiteTr"><td colspan="10"></td></tr>
						   		<tr><td colspan="10"></td></tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 底部操作 -->
		<div class="box zf-box-mul-border">
           	<div class="box-footer">
            	<div class="pull-left box-tools">
	        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	        	</div>
  				<div class="pull-right box-tools">
  				    <!-- <button type="button" class="btn bg-navy btn-sm" onclick="geneScanCode();"><i class="fa fa-plus">生成电子码</i></button> -->
	            	<button type="button" class="btn btn-info btn-sm" onclick="return submitForm();"><i class="fa fa-save">保存</i></button>
	        	</div>
            </div>
        </div>
		</form:form>
	</section>
  	<div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="录入要导出货品的录入批次编号" aria-hidden="true">
       <div class="modal-dialog" style="width:30%;height:35%;" >
	          <div class="modal-content" style="width:100%;height:100%;">
	             <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                      <span aria-hidden="true">&times;</span></button>
	                <h4 class="modal-title">录入批次编号</h4>
	             </div>
	             <div class="modal-body">
	                <div>
	                  <label for="geneNum">录入批次</label>
	                  <div id="newInBatchNo" >
	                  
	                  <input type="text"  style="width:50%" maxlength="10" id="inBatchNo"  placeholder="请输入货品所属录入批次" value="" name="inBatchNo" onkeyup="this.value=this.value.replace(/[^\d]/g,'') "/>
	                  <span data-type="hideBtn" class="close" title="新增批次"  onclick="addInBatchNo();"><i class="fa fa-plus"></i></span> <br/>
	                  <input type="text"  id="inBatchNoList"  readonly="readonly" style="width:50%;margin-top: 10px;border:none"/>
	                  </div>
	                </div>
	             </div>
	             <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	                <button type="button" class="btn btn-primary" id="commitBtn" onclick="exportFile('${purchaseOrder.id}')">确认导出</button>
	             </div>
	          </div><!-- /.modal-content -->
        </div><!-- /.modal -->
       </div>
	<div id="geneteModal1" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="导入采购批次" aria-hidden="true">
		<form id="inputForm1" action="${ctx}/lgt/po/purchaseProductImport/importFile"  enctype="multipart/form-data"  method="post" class="form-horizontal" onsubmit="return importFile();">
			<input name ="purchaseOrderId" hidden id="purchaseOrderId">
			<input name ="produceId" hidden id="produceId">
			<div class="modal-dialog" style="width:30%;height:45%;" >
				<div class="modal-content" style="width:100%;height:100%;">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">批量导入模板信息</h4>
					</div>
				<div class="box-body">
			<div class="form-group">
				<label class="col-sm-2 control-label">上传文件</label>
				<div class="col-sm-9">
					<input type="file" id="inputFile" name="file" accept="application/vnd.ms-excel">
					<p class="help-block text-red">
						文件只限Excel文本文件,后缀为.xlsx<br/>
					</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">内容格式</label>
				<div class="col-sm-9">
					<p class="help-block text-red">
						第一列：货品克重，第二列：货品采购价，第三列：货品证书编号，第四列：货品是否合格(1或0)，第五列：货品备注
					</p>
					<table class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<!--  <thead>
                             <tr>
                                 <th>第一列：国家</th>
                                 <th>第二列：省</th>
                                 <th>第三列：市</th>
                                 <th>第四列：区</th>
                             </tr>
                         </thead> -->
						<tbody>
						<tr>
							<td>2.3652</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td>569.00</td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td>ZS1012902</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td>1</td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td>货品采购导入</td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
				<div class="box-footer">
			<div class="pull-right box-tools">
				<button type="submit"  class="btn btn-info btn-sm"><i class="fa fa-save"></i>导入</button>
			</div>
		</div>
				</div>
	</div>
		</form>
	</div>
</div>
	
<script type="text/javascript">
	// 采购订单对象

	var purchaseOrder = null;
	var currentWareplaceSelector = null;	// 当前货位选择按钮
	$(function(){
		ZF.bigImg();

		purchaseOrder = ${fns:toJson(purchaseOrder)};
		
		// Modal<iframe>回调事件,获取弹出框选择的货品信息
		$("#wareplaceSelectModal #commitBtn").on("click",function () {
			$("#wareplaceSelectModal").modal("hide");		
			var content = $("#wareplaceSelectModalIframe").contents().find("body");
			var index = $("input[name = chkItem]:checked").attr("data-index");
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
					//重新选择产品清空原来数据
					$($(currentWareplaceSelector).parent().children()[0]).val($(this).val());
					$($(currentWareplaceSelector).parent().children()[1]).val($(this).attr("data-name"));
				}
			});
		});
	});

	// 添加货品
	function addProduct(obj, produceId, pricePurchase){
		var tr = $(obj).parent().parent();
		var ppid = tr.prop("id");
		
		// 更新页面对应产品“实采量”显示
		var inNum = $("#inNum_"+ppid).text();
		$("#inNum_"+ppid).text(parseInt(inNum)+1);
	
		var rowspanNum = $(tr).attr("data-num");
		rowspanNum++;
		$(tr).attr("data-num", parseInt(rowspanNum));// 设置rowspan
		
		// 插入tr
		var subTrHtmlTmpl ="<tr data-name='"+ppid+"_newTr'>"
							+"<td></td>"
							+"<td></td>"
							+"<td><input type=\"text\" readonly=\"readonly\" data-name=\""+ppid+"_product.code\" value=\"\" title=\"货品编码\" placeholder=\"货品编码\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"6\"/></td>"
							+"<td><input type=\"text\" data-name=\""+ppid+"_we\" value=\"\" title=\"货品克重\" placeholder=\"录入货品克重，四位小数\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"6\"/></td>"
							+"<td><input type=\"text\" data-name=\""+ppid+"_pprice\" value=\""+pricePurchase+"\" title=\"货品采购价\" placeholder=\"录入货品采购价，两位小数\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"8\"/></td>"
							+"<td><input type=\"text\" data-name=\""+ppid+"_cn\" value=\"\" title=\"货品证书编号\" placeholder=\"录入货品证书编号\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"15\"/></td>"
							+"<td>"
								+"<div class=\"input-group\" title=\"货品存放货位\">"
									+"<input type=\"hidden\" data-name=\""+ppid+"_wp\" value=\"\"/>"
									+"<input type=\"text\" value=\"\" placeholder=\"货品存放货位\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" readOnly/>"
								+"</div>"
							+"</td>"
							+"<td><select data-name=\""+ppid+"_rf\" class='form-control select2'><option value=''>请选择</option><c:forEach items='${fns:getDictList("yes_no")}' var='d'><option value='${d.value}' ${d.value eq 1 ?'selected':''}>${d.label}</option></c:forEach></select></td>"
							+"<td><input type=\"text\" data-name=\""+ppid+"_re\" value=\"\" title=\"货品备注\" placeholder=\"录入货品备注\" class=\"form-control zf-input-readonly\" style=\"font-size:12px;\" maxlength=\"50\"/></td>"
							+"<td><span data-type=\"hideBtn\" class=\"close pull-right\" title=\"删除货品\" style=\"display:block;float: left;\" onclick=\"delProduct(this,'"+ppid+"');\"><i class=\"fa fa-minus\"></i></span></td>"
						+"</tr>";
		$("tr[data-index="+ppid+"-whiteTr]").prev().after(subTrHtmlTmpl);
		$("select","#builderTbody").select2();
		// 重置行记录name值
		resetTrNameIndex(ppid, parseInt(rowspanNum));
	}
	
	//新增批次
	function addInBatchNo(){
		var inBatchNo = $("#inBatchNo").val();
		var inBatchNoList = $("#inBatchNoList").val();
	    if(inBatchNo ==null || inBatchNo == ""){
            ZF.showTip("请输入录入批次","danger");
			return false;
		}
	    //转Array
	    var inBatchNoArray = inBatchNoList.split(",");
	    for(var id in inBatchNoArray){
	    	if(inBatchNo===inBatchNoArray[id]){
	    		ZF.showTip("录入批次数据重复！","danger");
		    	return false;
	    	}
	    }
		if(inBatchNoList=="") {
			$("#inBatchNoList").val(inBatchNo);
		} else {
			$("#inBatchNoList").val(inBatchNoList+"_"+inBatchNo);
		}
	}

	// 删除货品
	function delProduct(obj, ppid){
		// 更新页面对应产品“实采量”显示
		var inNum = $("#inNum_"+ppid).text();
        $("#inNum_"+ppid).text(parseInt(inNum)-1);
		
		var rowspanNum = $("#"+ppid).attr("data-num");
		rowspanNum-- ;
		$("#"+ppid).attr("data-num", parseInt(rowspanNum));	// 设置rowspan
		
		$(obj).parent().parent().remove();
		// 重置行记录name值
		resetTrNameIndex(ppid, parseInt(rowspanNum));
	}
	
	// 重置页面某行货品记录的各隐藏域的name的序号(新增、删除记录时调用)
	function resetTrNameIndex(ppid, trNum){
		var ppeIndex = $("#"+ppid).attr("data-index");
		for(var i=0; i<trNum; i++){
			$($("input[data-name="+ppid+"_pprice]")[i]).prop("name","purchaseProduceList["+ppeIndex+"].purchaseProductList["+i+"].pricePurchase");
			$($("input[data-name="+ppid+"_sc]")[i]).prop("name","purchaseProduceList["+ppeIndex+"].purchaseProductList["+i+"].scanCode");
			$($("input[data-name="+ppid+"_cn]")[i]).prop("name","purchaseProduceList["+ppeIndex+"].purchaseProductList["+i+"].certificateNo");
			$($("input[data-name="+ppid+"_wp]")[i]).prop("name","purchaseProduceList["+ppeIndex+"].purchaseProductList["+i+"].wareplace.id");
			$($("input[data-name="+ppid+"_we]")[i]).prop("name","purchaseProduceList["+ppeIndex+"].purchaseProductList["+i+"].weight");
			$($("select[data-name="+ppid+"_rf]")[i]).prop("name","purchaseProduceList["+ppeIndex+"].purchaseProductList["+i+"].regularFlag");
			$($("input[data-name="+ppid+"_re]")[i]).prop("name","purchaseProduceList["+ppeIndex+"].purchaseProductList["+i+"].remarks");
		}
	}
	
	// 设置货品货位
	function selectWareplace(obj, produceId){
		currentWareplaceSelector = obj;
		$("#wareplaceSelectModalUrl").val("${ctx}/lgt/ps/wareplace/wareplaceSelect?modalWhDisplayFlag=true");	// 带参数请求URL设置方式
    	$("#wareplaceSelectModal").modal('toggle');		// 显示模态框
	}
	
	// 检查表单数据
	function checkData(){
		// 检查实付采购金额
	/* 	var paidAmountInput = $("#paidAmountInput").val();
		if(paidAmountInput == null || paidAmountInput == ""){
			ZF.showTip("订单实付采购金额未设置，请检查！","danger");
			return false;
		}
		if(!/^(-?\d+)(\.\d+)?$/.test(paidAmountInput)){
			ZF.showTip("订单实付采购金额必须为浮点数，请检查！","danger");
			return false;
		}
		if(parseFloat(paidAmountInput)>=1000000000){
			ZF.showTip("订单实付采购金额必须小于10亿，请检查！","danger");
			return false;
		}
		// 检查结算金价
		var clearingGoldpriceInput = $("#clearingGoldpriceInput").val();
		if(clearingGoldpriceInput == null || clearingGoldpriceInput == ""){
			ZF.showTip("订单结算金价未设置，请检查！","danger");
			return false;
		}
		if(!/^(-?\d+)(\.\d+)?$/.test(clearingGoldpriceInput)){
			ZF.showTip("订单结算金价必须为浮点数，请检查！","danger");
			return false;
		}
		if(parseFloat(clearingGoldpriceInput)>=1000000000){
			ZF.showTip("订单结算金价必须小于10亿，请检查！","danger");
			return false;
		} */
		// 检查订单包含的产品、货品
		for(var i=0; i<purchaseOrder.purchaseProduceList.length; i++){
			var ppid = purchaseOrder.purchaseProduceList[i].id;
			var produceCode = $("#"+ppid).attr("data-pcode");
			// （如果实际采购数量>0）检查实际采购价格
			/* if(parseInt($("#tdRealityNum"+ppid).html())>0){
				var realityPrice = $("#"+ppid+"_rp").val();
				if(realityPrice == null || realityPrice == ""){
					ZF.showTip("["+produceCode+"] 产品实际采购价格未设置，请检查！","danger");
					return false;
				}
				if(!/^(-?\d+)(\.\d+)?$/.test(realityPrice)){
					ZF.showTip("["+produceCode+"] 产品实际采购价格必须为浮点数，请检查！","danger");
					return false;
				}
				if(parseFloat(realityPrice)>=1000000000){
					ZF.showTip("["+produceCode+"] 产品实际采购价格必须小于10亿，请检查！","danger");
					return false;
				}
			} */
			//var trNum = parseInt($("#inNum_"+ppid).html());
			var trNum = $("tr[data-name="+ppid+"_newTr]").length;
			for(var j=0; j<trNum; j++){
				var trNumTip = j+1;
				
				// 检查货品克重
                var we = $($("input[data-name="+ppid+"_we]")[j]).val();
                if(we == null || we == ""){
                    ZF.showTip("["+produceCode+"]["+trNumTip+"] 货品克重未设置，请检查！","danger");
                    return false;
                }
                if(!/^(-?\d+)(\.\d+)?$/.test(we)){
                    ZF.showTip("["+produceCode+"]["+trNumTip+"] 货品克重必须为浮点数，请检查！","danger");
                    return false;
                }
				
				// 检查货品采购价
				var sbn = $($("input[data-name="+ppid+"_pprice]")[j]).val();
				if(sbn == null || sbn == ""){
					ZF.showTip("["+produceCode+"]["+trNumTip+"] 货品采购价未设置，请检查！","danger");
					return false;
				}
				// 检查货品证书编号
				/* var cn = $($("input[data-name="+ppid+"_cn]")[j]).val();
				if(cn == null || cn == ""){
					ZF.showTip("["+produceCode+"]["+trNumTip+"] 货品证书编号未设置，请检查！","danger");
					return false;
				}  */
				// 检查货品电子码
				/* var sc = $($("input[data-name="+ppid+"_sc]")[j]).val();
				if(sc == null || sc == ""){
					ZF.showTip("["+produceCode+"]["+trNumTip+"] 货品电子码未设置，请检查！","danger");
					return false;
				} */
				// 检查货品货位
				/* var wp = $($("input[data-name="+ppid+"_wp]")[j]).val();
				if(wp == null || wp == ""){
					ZF.showTip("["+produceCode+"]["+trNumTip+"] 货品存放货位未设置，请检查！","danger");
					return false;
				} */
				
			}
		}
		return true;
	}
	
	function submitForm(){
		if(checkData()){
			$("#inputForm").submit();
		}
	}
	
	function showExportModal(){
		$("#geneteModal").modal('toggle');
	}
    function showImportModal(orderId,produceId){
        $("#purchaseOrderId").val(orderId);
        $("#produceId").val(produceId);
        $("#geneteModal1").modal('toggle');
    }

    function exportFile(purchaseOrderId) {
    	 var inBatchNo = $("#inBatchNo").val();
	     var inBatchNos = $("#inBatchNoList").val();
	     if(inBatchNo ==null || inBatchNo == ""){
	            ZF.showTip("请输入录入批次","danger");
				return false;
		 }
	     if(inBatchNos ==null || inBatchNos == ""){
	    	 inBatchNos= inBatchNo;
		 }
        window.location.href = "${ctx}/lgt/po/purchaseProductExport/export?id="+purchaseOrderId+"&inBatchNos="+inBatchNos;
        $("#geneteModal").modal('hide'); 
    };
		function importFile() {
            var file = $("#inputFile").val();
            if(file == null || file == "") {
                ZF.showTip("请先上传模板Excel表!", "info");
                return false;
            }
            $("#inputForm1").submit();
		};

</script>
</body>
</html>