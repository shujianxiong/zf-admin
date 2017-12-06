<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购任务编辑</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body >
<div class="conent-wrapper sub-content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header content-header-menu">
		<h1>
			<small>
				<i class="fa-list-style"></i><a href="${ctx}/lgt/po/purchaseMission/list">采购任务列表</a>
			</small>
			<shiro:hasPermission name="lgt:po:purchaseMission:edit">
				<small>|</small>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/po/purchaseMission/form?id=${purchaseMission.id}">采购任务<c:if test="${empty purchaseMission.id}">添加</c:if><c:if test="${not empty purchaseMission.id}">修改</c:if></a>
				</small>
			</shiro:hasPermission>
		</h1>
	</section>
	
	<sys:tip content="${message}"/>
	
    <section class="content">
	    <form:form id="inputForm" modelAttribute="purchaseMission" action="${ctx}/lgt/po/purchaseMission/save" method="post" onsubmit="return submit();" class="form-horizontal">
	    <form:hidden path="id"/>
	    <input type="hidden" name="token" value="${token }" />
	    <!-- 任务 -->
	    <div class="row">
	    	<div class="col-md-12">
	            <div class="box box-success">
		            <div class="box-header with-border zf-query">
		            	<h5>采购任务</h5>
		              	<div class="box-tools">
		                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		              	</div>
		            </div>
		            <!-- /.box-header -->
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="style" class="col-sm-3 control-label">任务编号</label>
									<div class="col-sm-7">
										<input id="batchNo" name="batchNo" type="text" class="form-control" disabled="disabled" placeholder="采购任务编号,系统自动生成" value="${purchaseMission.batchNo }">
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">任务状态</label>
									<div class="col-sm-7">
										<input value="${fns:getDictLabel(purchaseMission.missionStatus, 'lgt_po_purchase_mission_missionStatus', '')}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
					   </div>
					   <div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label class="col-sm-3 control-label">备注信息</label>
									<div class="col-sm-7"> 
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control" cssStyle="width:820px;height:80px;"/>
									</div>
								</div>
							</div>
						</div>
						<c:if test="${not empty purchaseMission.missionStatus }">
							<div class="row">
							     <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">审批人</label>
                                        <div class="col-sm-7"> 
                                            ${fns:getUserById(purchaseMission.checkBy.id).name}
                                        </div>
                                    </div>
                                </div>
	                           <%--  <div class="col-md-4">
	                                <div class="form-group">
	                                    <label class="col-sm-3 control-label">审批结果</label>
	                                    <div class="col-sm-7"> 
	                                        <span class="label label-primary">${fns:getDictLabel(purchaseMission.missionStatus, 'lgt_po_purchase_mission_missionStatus', '' )}</span>
	                                    </div>
	                                </div>
	                            </div> --%>
	                        </div>
	                        <div class="row">
	                            <div class="col-md-4">
	                                <div class="form-group">
	                                    <label class="col-sm-3 control-label">审批备注</label>
	                                    <div class="col-sm-7"> 
	                                        <form:textarea path="checkRemarks" htmlEscape="false" disabled="true" rows="4" maxlength="255" class="form-control" cssStyle="width:820px;height:80px;"/>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
						</c:if>
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
	            <div class="row">
					<div class="col-sm-12 pull-right">
						 <button id="chooseProduceBtn" type="button" class="btn btn-sm btn-success"><i class="fa fa-diamond">选择产品</i></button>
					</div>
				</div>
           		<div class="col-md">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th>产品编码</th>
								<th>产品全称</th>
								<th>采购数量</th>
								<th>采购备注</th>
								<th width="10">&nbsp;</th>
							</tr>
						</thead>
						<tbody id="builderTbody">
							<c:forEach items="${purchaseMission.detailList }" var="detail" varStatus="status">
							<tr id="${detail.produce.id}">
			   					<td>
					   				<input type="hidden" id="${detail.produce.id }_id" name="detailList[${status.index }].id" value="${detail.id }"/>
			   						<span id="${detail.produce.id }_pcode">${detail.produce.code }</span>
			   						<input type="hidden" id="${detail.produce.id }_pid" name="detailList[${status.index }].produce.id" value="${detail.produce.id }"/>
			   					</td>
			   					<td>
			   						<span id="${detail.produce.id }_pname">${detail.produce.goods.name } ${detail.produce.name }</span>
			   					</td>
			   					<td>
			   						<input type="text" id="${detail.produce.id }_num" name="detailList[${status.index }].num"  value="${detail.num}" maxlength="9" placeholder="此项为必填项，请输入产品的采购数量" class="form-control"/>
			   					</td>
					   			<td>
					   				<textarea name="detailList[${status.index }].remarks" rows="1" maxlength="200" class="form-control">${detail.remarks }</textarea>
					   			</td>
					   			<td>
					   				<span data-type="hideBtn" class="close" title="删除" style="display:block;float: left;" onclick="recordTrHide('${detail.produce.id }');">&times;</span>
					   				<input type="hidden" id="${detail.produce.id}_delFlag" name="detailList[${status.index }].delFlag" value="${detail.delFlag }"/>
					   			</td>
					   		</tr>
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
	            	<button type="button" class="btn btn-info btn-sm" onclick="submitForm();"><i class="fa fa-save">保存</i></button>
	        	</div>
            </div>
        </div>
		</form:form>
	</section>
  	<sys:selectmutil id="produceSelect" title="采购产品选择" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
</div>
	
<script type="text/javascript">
	var datatables = null;
	var idx = 0;	//行记录序列 
	var row = {};	//行记录对象
	var dataSource = []; // 表格数据源
	var dataSupplier = [];	//已选择的供应商数据源
	var orders = [];	// 构建采购供应商 
	
	$(function(){
		// 选择产品
		$("#chooseProduceBtn").on('click',function(){
			$("#produceSelectModalUrl").val("${ctx}/lgt/ps/produce/select?pageKey=purchaseMissionForm");	// 带参数请求URL设置方式
	        $("#produceSelectModal").modal('toggle');							// 显示模态框
		});
		// 选择产品Modal<iframe>回调事件
		$("#produceSelectModal #commitBtn").on("click",function(){
			$("#produceSelectModal").modal("hide");								// 隐藏模态框
			var content = $("#produceSelectModalIframe").contents().find("body");
			$("input[type=checkBox]", content).each(function(){
				if($(this).prop("checked")){
    				iframeSelected($(this).val(), $(this).attr("data-code"), $(this).attr("data-fullname"));
				}
			});
			
			//清楚check  table缓存
			window.localStorage.removeItem("purchaseMissionForm");
		});
		
	});
	
	// iframe选择产品后回调方法
	function iframeSelected(produceId, produceCode, produceFullname){
		var iRecordTrArr = $("#builderTbody").children();
		var trCount = iRecordTrArr.length;
		var appendHtml = ""; 
		
		// 当前要添加的采购产品明细数据是否已存在
		var existFlag = false;
		for(var i=0; i<trCount; i++){
			if($(iRecordTrArr[i]).prop("id") == produceId){
				existFlag = true;
				// 显示隐藏的行
				$(iRecordTrArr[i]).show();
			   	$("#"+$(iRecordTrArr[i]).prop("id")+"_delFlag").val("0");
			}
		}
		if(!existFlag){
		   	appendHtml	+=
		   		"<tr id='"+produceId+"'>"+
					"<td>"+
	   					"<input type='hidden' id='"+produceId+"_id' name='detailList["+trCount+"].id'/>"+
	   					"<span id='"+produceId+"_pcode'>"+produceCode+"</span>"+
						"<input type='hidden' id='"+produceId+"_pid' name='detailList["+trCount+"].produce.id' value='"+produceId+"'/>"+
					"</td>"+
					"<td>"+
	   					"<span id='"+produceId+"_pname'>"+produceFullname+"</span>"+
					"</td>"+
					"<td>"+
						"<input data-type=\"tel\" data-verify=\"false\" placeholder=\"此项为必填项，请输入产品的采购数量\" id=\""+produceId+"_num\" name=\"detailList["+trCount+"].num\" type=\"text\" value=\"\" maxlength=\"9\" class=\"form-control\"/>"+
					"</td>"+
		   			"<td>"+
		   				"<textarea name=\"detailList["+trCount+"].remarks\" rows=\"1\" maxlength=\"255\" class=\"form-control\"></textarea>"+
		   			"</td>"+
		   			"<td>"+
		   				"<span data-type='delBtn' onclick=\"recordTrDel('"+produceId+"');\" class='close' title='删除' style='display:block;float: left;'>&times;</span>"+
		   				"<input type='hidden' id='"+produceId+"_delFlag' name='detailList["+trCount+"].delFlag' value='0'/>"+
		   			"</td>"+
		   		"</tr>";
		   	trCount++;
		}
		$("#builderTbody").append(appendHtml);
	}
	
	// 隐藏任务明细，并设置任务明细为删除状态（delFlag=1）
	function recordTrHide(pid){
	   	$("#"+pid).hide();
	   	$("#"+pid+"_delFlag").val("1");
	   	resetTrNameIndex();
	}
	// 删除任务明细（删除明细对应的tr）
	function recordTrDel(pid){
		$("#"+pid).remove();
   		resetTrNameIndex();
	}
	
	// 重置页面某行盘点记录的各隐藏域的name的序号(删除某条盘点记录时调用)
	function resetTrNameIndex(){
		var iRecordTrArr = $("#builderTbody").children();
		for(var i=0; i<iRecordTrArr.length; i++){
			$("#"+$(iRecordTrArr[i])[0].id+"_id").prop("name","detailList["+i+"].id");
			$("#"+$(iRecordTrArr[i])[0].id+"_pid").prop("name","detailList["+i+"].produce.id");
			$("#"+$(iRecordTrArr[i])[0].id+"_num").prop("name","detailList["+i+"].num");
			$("#"+$(iRecordTrArr[i])[0].id+"_remarks").prop("name","detailList["+i+"].remarks");
			$("#"+$(iRecordTrArr[i])[0].id+"_delFlag").prop("name","detailList["+i+"].delFlag");
		}
	}
	
	// 提交表单
	function submitForm(){
		if(verifyPruchaseNum()){
			$("#inputForm").submit();
		}
	}
	
	// 判断未隐藏行是否已填采购数量
	function verifyPruchaseNum(){
		var iRecordTrArr = $("#builderTbody").children();
		var recordCount = 0;
		for(var i=0; i<iRecordTrArr.length; i++){
			if($("#"+$(iRecordTrArr[i])[0].id+"_delFlag").val() == "0"){
				recordCount++ ;
				var numVar = $("#"+$(iRecordTrArr[i])[0].id+"_num").val();
				var testVar = /^[1-9]\d*$/;		// 正整数
				if(!testVar.test(numVar)){
					var pcode = $("#"+$(iRecordTrArr[i])[0].id+"_pcode").html();
					ZF.showTip("["+pcode+"] 产品采购数量不能为空且必须为正整数！", "info");
					return false;
				}
			}
		}
		if(recordCount <= 0){
			ZF.showTip("请选择要采购的产品！", "info");
			return false;
		}
		return true;
	}
	
</script>
</body>
</html>