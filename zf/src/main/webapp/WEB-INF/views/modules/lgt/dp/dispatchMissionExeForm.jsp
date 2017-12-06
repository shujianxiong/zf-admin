<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>执行确认调货任务管理</title>
	<meta name="decorator" content="adminLte"/>
	
</head>
<script type="text/javascript">
$(document).ready(function() {
	
})
</script>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/lgt/dp/dispatchOrder/callOutList">执行调货出库任务列表</a></small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a>执行调货出库任务表单</a></small>
			</h1>
		</section>
	    <sys:tip content="${message}"/>
	    	<section class="content">
	    	<div class="row">
		    	<div class="col-md-12">
		    	<form:form id="inputForm" modelAttribute="dispatchOrder" action="${ctx}/lgt/dp/dispatchOrder/confirmDispatchOrder" method="post" class="form-horizontal" onsubmit="return formSubmit();">
		    		<div class="box box-success">
			    		<div class="box-header with-border">
				          <h5>执行确认调货任务信息</h5>
				        </div>
				        <sys:tip content="${message}"/>
	   					<form:hidden path="dispatchMission.id"/>
	   					<form:hidden path="dispatchMission.batchNo"/>
	   					<form:hidden path="dispatchMission.startBy.id"/>
				        <div class="box-body">
				        	<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="searchParam" class="col-sm-3 control-label">发起人</label>
				                  <div class="col-sm-7">
										<input name="dispatchMission.startBy.name" type="text" value="${fns:getUserById(dispatchOrder.dispatchMission.startBy.id).name}" class="form-control" readonly="readonly" />
				                  </div>
				        		</div>
			        		</div>
			        		<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="reasonType" class="col-sm-3 control-label">调货原因</label>
				                  <div class="col-sm-7">
				                    <form:select path="dispatchMission.reasonType" class="form-control select2" disabled="true">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('dispatch_mission_reasonType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
				                  </div>
				        		</div>
				        	</div>
				        	<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="missionStatus" class="col-sm-3 control-label">调货状态</label>
				                  <div class="col-sm-7">
				                    <form:select path="dispatchMission.missionStatus" class="form-control select2" disabled="true">
										<form:options items="${fns:getDictList('dispatch_mission_missionStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
				                  </div>
			                   </div>
			                </div>
				        	<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="startTime" class="col-sm-3 control-label">任务发起时间</label>
				                  <div class="col-sm-7">
										<input name="dispatchMission.startTime" id="startTime" value="<fmt:formatDate value="${dispatchOrder.dispatchMission.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="form-control" readonly="readonly"/>
				                  </div>
				                </div>
			                </div>
			                <div class="col-md-4">
			        			<div class="form-group">
				                  <label for="limitTime" class="col-sm-3 control-label">要求完成时间</label>
				                  <div class="col-sm-7">
										<input name="dispatchMission.limitTime" id="limitTime" value="<fmt:formatDate value="${dispatchOrder.dispatchMission.limitTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="form-control" readonly="readonly"/>
				                  </div>
				        		</div>
			        		</div>
			        		<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="remarks" class="col-sm-3 control-label">调入仓库</label>
				                  <div class="col-sm-7">
				                  	<input type="hidden" name="dispatchMission.inWarehouse.id" value="${dispatchOrder.dispatchMission.inWarehouse.id}"/>
				                    <input name="dispatchMission.inWarehouse.name" type="text" value="${dispatchOrder.dispatchMission.inWarehouse.name}" class="form-control" readonly="readonly"/>
				                  </div>
			                   </div>
				        	</div>
			                 <div class="col-md-4">
			        			<div class="form-group">
				                  <label for="endTime" class="col-sm-3 control-label">预计完成时间</label>
				                  <div class="col-sm-7">
										<sys:datetime inputName="dispatchMission.endTime" tip="请选择预计完成时间"  isMandatory="true" id="yqwcsj2"  inputId="endTime" value="${dispatchOrder.dispatchMission.endTime }"></sys:datetime>
				                  </div>
				        		</div>
			        		</div>
			        		<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="remarks" class="col-sm-3 control-label">备注</label>
				                  <div class="col-sm-7">
				                    <form:textarea path="dispatchMission.remarks" maxlength="200"  class="form-control"  disabled="true"/>
				                  </div>
			                   </div>
			                </div>
				        </div>
	                </div>
			    	<div class="box box-success">
			    		<div class="box-header with-border">
				          <h5>调货单信息</h5>
				        </div>
						<div class="box-body">
							<div class="col-md-4">
			        		   <div class="form-group">
			        			  <label for="remarks" class="col-sm-3 control-label">调出仓库</label>
				                  <div class="col-sm-7">
				                    <form:input path="outWarehouse.name" class="form-control" disabled="true"/>
				                  </div>
			                   </div>
			                </div>
			                <div class="col-md-4">
			        		   <div class="form-group">
			        			  <label for="remarks" class="col-sm-3 control-label">调出仓库责任人</label>
				                  <div class="col-sm-7">
				                  	<form:hidden path="outUser.id"/>
				                    <form:input path="outUser.name" class="form-control" disabled="true"/>
				                  </div>
			                   </div>
			                </div>
			           </div>
			        </div>
			                
			                
			    	<div class="box box-success">
			    		<div class="box-header with-border">
				          <h5>物流信息</h5>
				        </div>
						<div class="box-body">
							<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="postTypeId" class="col-sm-3 control-label">物流类型</label>
				                  <div class="col-sm-7">
				                    	<form:radiobuttons id="postTypeId" path="postType" items="${fns:getDictList('lgt_dp_dispatch_order_postType')}" itemLabel="label" itemValue="value" htmlEscape="false" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" />
				                  </div>
			                   </div>
			                </div>
			                
			                <div class="row">
			                	<div class="col-md-4" id="postUserDiv">
				                	<div class="form-group">
				                		<label for="postUserId" class="col-sm-3 control-label">送货人</label>
				                		<div class="col-sm-7">
				                			<div class="input-group">
												<form:hidden id="postUserId" path="postUserId.id" />
												<sys:inputverify name="postUserId.name" id="postUserName" verifyType="0" tip="请选择送货人，必填项" isSpring="true" forbidInput="true" isMandatory="true"></sys:inputverify>
												<span class="input-group-addon" onclick="selectUser();"><i class="fa fa-search"></i></span>
				                			</div>
				                		</div>
				                	</div>
				                </div>
			                </div>
			                
			                <div class="row">
			                	<div class="col-md-4" id="postCompanyDiv" style="display: none;">
				                	<div class="form-group">
				                		<label for="postCompany" class="col-sm-3 control-label">快递公司</label>
				                		<div class="col-sm-7">
				                			<sys:selectverify name="postCompany" tip="请选择快递公司，必填项" verifyType="0" dictName="express_company" id="postCompany" isMandatory="true"></sys:selectverify>
				                		</div>
				                	</div>
				                </div>
				                
				                <div class="col-md-4" id="postNoDiv" style="display: none;">
				                	<div class="form-group">
				                		<label for="postNo" class="col-sm-3 control-label">快递单号</label>
				                		<div class="col-sm-7">
				                			<sys:inputverify name="postNo" id="postNo" verifyType="0" isSpring="true" tip="请输入快递单号，必填项" isMandatory="true"></sys:inputverify>
				                		</div>
				                	</div>
				                </div>
				                
				                <div class="col-md-4" id="posterNameDiv" style="display: none;">
				                	<div class="form-group">
				                		<label for="posterName" class="col-sm-3 control-label">快递员姓名</label>
				                		<div class="col-sm-7">
				                			<sys:inputverify name="posterName" id="posterName" isSpring="true" verifyType="0" tip="请输入快递员姓名，必填项" isMandatory="true"></sys:inputverify>
				                		</div>
				                	</div>
				                </div>
			                </div>
			                <div class="row">
			                	<div class="col-md-4" id="posterTelDiv" style="display: none;">
				                	<div class="form-group">
				                		<label for="posterTel" class="col-sm-3 control-label">快递员电话</label>
				                		<div class="col-sm-7">
				                			<sys:inputverify name="posterTel" id="posterTel" isSpring="true" verifyType="1" tip="请输入正确的手机号，必填项，如：152xxxxxxxx" isMandatory="true"></sys:inputverify>
				                		</div>
				                	</div>
				                </div>
			                </div>
			                
						</div>
					</div>
			    		
			    		
			    	<div class="box box-success">
	    	    		<div class="box-body">
	                	<div class="row">
							<div class="col-sm-12 pull-right">
								 <button id="chooseProductBtn" type="button" class="btn btn-sm btn-success"><i class="fa fa-diamond">选择货品</i></button>
				                 <sys:selectmutil id="productSelect" title="仓库货品选择" url="" isDisableCommitBtn="true" isRefresh="false" width="1200" height="700" ></sys:selectmutil>
							</div>
						</div>
	                	<div class="col-md">
		                   <table id="contentTable" cellspacing="0" class="table table-bordered table-hover table-striped zf-tbody-font-size">
									<thead>
										<tr>
											<th>勾选货品</th>
											<th>产品/货品编号</th>
											<th>需调拨数量</th>
											<th>可调拨数量</th>
										</tr>
									</thead>
									<tbody id="tableList">
										<c:forEach items="${dispatchOrder.dispatchProduceList}" var="prce" varStatus="sta">
											<tr  id="table_${prce.produce.id}">
												<td>
													<div class=" zf-check-wrapper-padding">
														<input id="radio_${prce.produce.id}" type="radio" name="chkItem" data-value="${prce.produce.id}" data-index="${sta.index}" data-actualNum="0"/>
													</div>
												<%-- ${sta.index} --%>
												</td>
												<td>
													${prce.produce.code}
												</td>
												<td>
													${prce.planNum}
												</td>
												<td>
									        		<input id="${sta.index}_dis_prce_id" type="hidden" name="dispatchProduceList[${sta.index }].id" value="${prce.id}"/>
													<input id="${sta.index}_prce_id" type="hidden" name="dispatchProduceList[${sta.index}].produce.id" value="${prce.produce.id}"/>
													<input type="text" id="actualNum_${prce.produce.id}" name="dispatchProduceList[${sta.index}].actualNum" value="${prce.actualNum}" readonly="true" class="form-control actualNum"/>
												</td>
												<%-- <td>
													<c:forEach items="${dispatchMission.dispatchProductList }" var="disProduct" varStatus="index">
														${dis.dispatchProduct.product.code }
														<input type="hidden" name="dispatchProductList[${index.index }].product.id" value="${prce.product.code }"/>
													</c:forEach>
												</td> --%>
											</tr>
											<c:forEach items="${prce.dispatchProductList }" var="disProduct" varStatus="t"> 
												<tr id="tr_${prce.produce.id }">
													<td>
														<input type="hidden" name="dispatchProductList[${t.index }].id" value="${disProduct.id }"/>
														<input type="hidden" name="dispatchProductList[${t.index }].product.id" value="${disProduct.product.id }"/>
														<input type="hidden" name="dispatchProductList[${t.index }].product.wareplace.id" value="${disProduct.product.wareplace.id }"/>
													</td>
													<td>${disProduct.product.code }</td>
													<td>${disProduct.product.goods.name }</td>
													<td class="text-center" style="width:15px;"><span id="" class="close" onclick="delTr(this, '${prce.produce.id}')" title="删除" style="display:block" >&times;</span></td>
												</tr>
											</c:forEach>
										</c:forEach>
									</tbody>
									<tbody id="tableList2">
									</tbody>
									<tfoot>
										<tr class="hide">
											<td>
												<input type="hidden" name="id" value="${dispatchOrder.id}"/>
												<input type="hidden" id="outWareHouseId" name="outWarehouse.id" value="${dispatchOrder.outWarehouse.id}"/>
											</td>
										</tr>
									</tfoot>
								</table>
			                </div>
		                </div>
		                <div class="box-footer">
			            	<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
		   					<div class="pull-right box-tools">
				            	<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save">保存</i></button>
				        	</div>
			            </div>
		            </div>
			        </form:form>
			    </div>
		    </div>
		    
		    <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
			width="550" isOffice="false" isMulti="false" title="人员选择"
			id="selectUser" ></sys:userselect>
		    
	    	</section>
	</div>
<script type="text/javascript">
$(function(){
	// 设置checkbox样式
 	$("input").iCheck({
 		checkboxClass : 'icheckbox_minimal-blue',
		radioClass : 'iradio_minimal-blue'
	}); 
	
 	var checkVal = $("input[type='radio'][name='postType']:checked").val();
 	if(checkVal == 1) {
 		$("#postUserDiv").show();
 		
 		$("#postCompanyDiv").hide();
		$("#postNoDiv").hide();
		$("#posterNameDiv").hide();
		$("#posterTelDiv").hide();
		
		$("#postCompany").attr("data-verify", "true");
		$("#postNo").attr("data-verify", "true");
		$("#posterName").attr("data-verify", "true");
		$("#posterTel").attr("data-verify", "true");
		
		$("#postCompany").removeClass("zf-input-err");
		$("#postNo").removeClass("zf-input-err");
		$("#posterName").removeClass("zf-input-err");
		$("#posterTel").removeClass("zf-input-err");
		
 	} else if(checkVal == 2) {
 		$("#postUserDiv").hide();
 		$("#postUserId").attr("data-verify", "true");
		$("#postUserName").attr("data-verify", "true");
		
		$("#postUserId").removeClass("zf-input-err");
		$("#postUserName").removeClass("zf-input-err");
 		
 		$("#postCompanyDiv").show();
		$("#postNoDiv").show();
		$("#posterNameDiv").show();
		$("#posterTelDiv").show();
		
 	}
	
	$("input[type='radio'][name='postType']").on("ifChecked",function(event){
		var checkCompent = $(this);
		var checkedVal = checkCompent.val();
		confirm("你确定要切换物流配送方式吗？<br/> 如果确定，将清空你已录入的快递信息","info", function() {
			if(checkedVal == "1"){
				$("#postUserDiv").show();
				
				$("#postUserId").attr("data-verify", "false");
				$("#postUserName").attr("data-verify", "false");
				
				$("#postUserId").removeClass("zf-input-err");
				$("#postUserName").removeClass("zf-input-err");
				
				
				
				$("#postCompanyDiv").hide();
				$("#postNoDiv").hide();
				$("#posterNameDiv").hide();
				$("#posterTelDiv").hide();
				
				$("#postCompany").val("");
				$("#postNo").val("");
				$("#posterName").val("");
				$("#posterTel").val("");
				
				
				$("#postCompany").attr("data-verify", "true");
				$("#postNo").attr("data-verify", "true");
				$("#posterName").attr("data-verify", "true");
				$("#posterTel").attr("data-verify", "true");
				
				$("#postCompany").removeClass("zf-input-err");
				$("#postNo").removeClass("zf-input-err");
				$("#posterName").removeClass("zf-input-err");
				$("#posterTel").removeClass("zf-input-err");
				
			}else if(checkedVal == "2"){
				$("#postUserDiv").hide();
				$("#postUserId").val("");
				$("#postUserName").val("");
				
				$("#postCompany").attr("data-verify", "false");
				$("#postNo").attr("data-verify", "false");
				$("#posterName").attr("data-verify", "false");
				$("#posterTel").attr("data-verify", "false");
				
				$("#postCompany").removeClass("zf-input-err");
				$("#postNo").removeClass("zf-input-err");
				$("#posterName").removeClass("zf-input-err");
				$("#posterTel").removeClass("zf-input-err");
				
				$("#postCompanyDiv").show();
				$("#postNoDiv").show();
				$("#posterNameDiv").show();
				$("#posterTelDiv").show();
					
				$("#postUserId").attr("data-verify", "true");
				$("#postUserName").attr("data-verify", "true");
				
				$("#postUserId").removeClass("zf-input-err");
				$("#postUserName").removeClass("zf-input-err");
				
			}
		}, function() {//点击取消的话，需要恢复原样
			checkCompent.iCheck("uncheck");
			checkCompent.parent().siblings().find("input").iCheck("check");
		});
	});
	
	
	$("#postUserName").on("click", function() {
		selectUserinit({
			"selectCallBack" : function(list) {
				$("#postUserId").val(list[0].id);
				$("#postUserName").val(list[0].text);
				$("#postUserId").attr("data-verify","true");
				$("#postUserName").attr("data-verify","true");
				$("#postUserName").removeClass("zf-input-err");
					if($("#postUserNameErr").length>0){
						$("#postUserNameErr").remove();
					}
			}
		})
	});
	
	
	// 选择货品
	$("#chooseProductBtn").on('click',function(){
		var cheched = false;
		var wpId = "";
		$("[name = chkItem]:radio").each(function(){
			if($(this).prop("checked")){
				cheched = true;
				wpId = $(this).attr("data-value");
			}
		});
		if(!cheched){
			ZF.showTip("请先勾选您需要调货的货品！", "info");
		}
		if(cheched){
			$("#productSelectModalUrl").val("${ctx}/lgt/ps/product/select?produce.id="+wpId+"&wareplace.warecounter.warearea.warehouse.id="+$("#outWareHouseId").val()+"&pageKey=dispatchMissionExeForm")//带参数请求URL设置方式
        	$("#productSelectModal").modal('toggle');//显示模态框
		}
	});
	
	$("#productSelectModal #commitBtn").on("click",function () {
		$("#productSelectModal").modal("hide");	
		var wpId = "";
		var data_index = "";
		var product_index = "";
		$("[name = chkItem]:radio").each(function(){
			if($(this).prop("checked")){
				wpId = $(this).attr("data-value");
				data_index = $(this).attr("data-index");
				product_idnex = data_index;
			}
		});
		
		/* $("tr[id='tr_"+wpId+"']",$("#tableList")).each(function(){
			$(this).remove();
		}) */
		
		$("tr>td[class=dataTables_empty]",$("#tableList")).each(function(){
			$(this).remove();
		})
		
		var aNum = $("#actualNum_"+wpId+"").val();
		var count = isNaN(aNum)?0:aNum;
		var content = $("#productSelectModalIframe").contents().find("body");
		$("input[type=checkBox]", content).each(function(){
			if($(this).prop("checked")){
				var selVal = $(this).val();
				if($("#tr_"+selVal).length <= 0) {
					//拼接产品货品的信息
					$("#prouct_"+wpId+"").val($(this).attr("type-code"));
					var html = "<tr id='tr_"+selVal+"'><td></td><td>";
					html +=""+$(this).attr("type-code")+"";
					html +="<input type='hidden' name='dispatchProduceList["+data_index+"].dispatchProductList["+(product_index++)+"].product.id' value='"+selVal+"'>";
					html +="</td><td>"+$(this).attr("data-value")+"</td>";
					html +="<td class='text-center'><span id='' class='close' onclick=\"delTr(this, '"+wpId+"')\" title='删除' style='display:block' >&times;</span></td>";
					html +="</tr>";
					$("#table_"+wpId+"").after(html);
					count++;
				}
			}
		});
		$("#radio_"+wpId+"").attr("data-actualNum",count);
		$("#actualNum_"+wpId+"").val(count);
		
// 		if($("#chooseProductBtnErr").length >  0) {
// 			$("#chooseProductBtnErr").remove();
// 		}
		
		var planNum = $("#actualNum_"+wpId+"").parent().prev().text().trim();
		if(count > planNum) {
			if($("#actualNum_"+wpId+"Err").length<=0) {
				$("#actualNum_"+wpId+"").after("<label id=\"actualNum_"+wpId+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>可调数"+count+"必须<=需调数"+planNum+"</label>")
				$("#actualNum_"+wpId+"").attr("data-verify","false");
			}
		} else {
			if($("#actualNum_"+wpId+"Err").length>0){
				$("#actualNum_"+wpId+"").removeClass("zf-input-err");
				$("#actualNum_"+wpId+"Err").remove();
				$("#actualNum_"+wpId+"").attr("data-verify","true");
			}
		}
		
		//清楚check  table缓存
		window.localStorage.removeItem("dispatchMissionExeForm");
		
	});
	
});
//form表单提交验证货品信息是否添加
function formSubmit(){
	var verify=true;
	var inputs=$("input[data-verify=false]");
	for(var i=0;i<inputs.length;i++){
		console.log("验证未通过的表单input组件："+$(inputs[i]).attr("name"));
		if($(inputs[i]).attr('data-type') == "date"){
			$(inputs[i]).parent().trigger('dp.change');
		}else{
			$(inputs[i]).trigger('change');
		}
		verify=false;
	}
	var selects=$("select[data-verify=false]");
	for(var i=0;i<selects.length;i++){
		console.log("验证未通过的表单select组件："+selects[i]);
		$(selects[i]).trigger('change');
		verify=false;
	}

	//判断货品是否已经选择
	$("input[id^=actualNum]").each(function() {
		if($(this).val() == "" || $(this).val() == "0") {
			ZF.showTip("请选择需要调拨的货品，必选","info");
			verify = false;
// 			if($("#chooseProductBtnErr").length<=0) {
// 				$("#chooseProductBtn").after("<label id=\"chooseProductBtnErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择需要调拨的产品，必选</label>");
// 				verify = false;
// 			}
		}
	});
	
	/* if(verify){
		$("button[type=submit]").attr('disabled',true);
	} */
	
	
	return verify;
};

//新增的模板行直接直接物理删除
function delTr(curTd, wpId) {
	var num = $("#actualNum_"+wpId+"").val();
	var newNum = num-1;
	$("#actualNum_"+wpId+"").val(newNum);
	var planNum = $("#actualNum_"+wpId+"").parent().prev().text().trim();
	if(newNum > planNum) {
		if($("#actualNum_"+wpId+"Err").length<=0) {
			$("#actualNum_"+wpId+"").after("<label id=\"actualNum_"+wpId+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>可调数"+newNum+"必须<=需调数"+planNum+"</label>")
			$("#actualNum_"+wpId+"").attr("data-verify","false");
		} 
	} else {
		if($("#actualNum_"+wpId+"Err").length>0){
			$("#actualNum_"+wpId+"").removeClass("zf-input-err");
			$("#actualNum_"+wpId+"Err").remove();
			$("#actualNum_"+wpId+"").attr("data-verify","true");
		}
	}
	$(curTd).parent("td").parent("tr").remove();
};

function selectUser() {
	selectUserinit({
		"selectCallBack" : function(list) {
			$("#postUserId").val(list[0].id);
			$("#postUserName").val(list[0].text);
			$("#postUserName").attr("data-verify","true");
			$("#postUserName").removeClass("zf-input-err");
				if($("#postUserNameErr").length>0){
					$("#postUserNameErr").remove();
				}
		}
	});
}
</script>
</body>
</html>