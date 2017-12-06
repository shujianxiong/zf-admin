<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调货任务修改管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
			<section class="content-header content-header-menu">
				<h1>
					<small><i class="fa-list-style"></i><a href="${ctx}/lgt/dp/dispatchMission/">调货任务列表</a></small>
					
		        	<shiro:hasPermission name="lgt:dp:lgtPsDispatchMission:edit"><small>|</small><small  class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/dp/dispatchMission/form">调货任务修改</a></small></shiro:hasPermission>
				</h1>
			</section>
			<sys:tip content="${message}"/>
	    	<section class="content">
	    	<div class="row">
		    	<div class="col-md-6">
			        <form:form id="inputForm" modelAttribute="dispatchMission" action="${ctx}/lgt/dp/dispatchMission/save" method="post" class="form-horizontal" onsubmit="return submitForm();">
		    		<div class="box box-success">
			    		<div class="box-header with-border zf-query">
							<h5>请完善表单填写</h5>
							<div class="box-tools">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
							</div>
						</div>
	   					<form:hidden path="id"/>
				        <div class="box-body">
			        		<sys:inputtree id="inWarehouse" name="inWarehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" inputWidth="9" labelWidth="2" label="调入仓库" labelValue="" labelName="inWarehouse.name" value="" tip="请选择仓库" title="调入仓库"></sys:inputtree>
		        			<div class="form-group">
			                  <label for="reasonType" class="col-sm-2 control-label">调货类型</label>
			                  <div class="col-sm-9">
			                    <form:select path="reasonType" class="form-control select2">
			                    	<form:option value="" label="请选择"/>
									<form:options items="${fns:getDictList('dispatch_mission_reasonType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
			                  </div>
			        		</div>
		        			<div class="form-group">
			                  <label for="limitTime" class="col-sm-2 control-label">要求完成时间</label>
			                  <div class="col-sm-9">
									<sys:datetime inputId="limitTime" inputName="limitTime" tip="请选择要求完成时间，必选项" value="${dispatchMission.limitTime}" id="limitTimeId" isMandatory="true" minDate="${dispatchMission.startTime }"></sys:datetime>
			                  </div>
			        		</div>
		        			<div class="form-group">
			                  <label for="remarks" class="col-sm-2 control-label">备注</label>
			                  <div class="col-sm-9">
			                    <form:textarea path="remarks" rows="3" maxlength="200" class="form-control"/>
			                  </div>
		                   </div>
			            </div>
		                
		                <div class="box-body">
		                	<div class="col-md">
			                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
										<thead>
											<tr>
												<th>仓库名称</th>
												<th>仓库责任人</th>
												<th>产品名称</th>
												<th>需调拨数量</th>
												<th></th>
											</tr>
										</thead>
										<tbody id="tableList">
										<c:forEach items="${dispatchMission.dispatchOrderList}" var="dis" varStatus="sta">
										<tr>
											<td>
												${dis.outWarehouse.name}
											</td>
											<td>
												${fns:getUserById(dis.outUser.id).name}
											</td>
											<td>
												${dis.dispatchProduce.produce.goods.name}--${dis.dispatchProduce.produce.name}
											</td>
											<td>
												<input id="${sta.index}_produceid" type="hidden" name="dispatchOrderList[${sta.index}].id" value="${dis.id}"/>
												<input type="text" id="actualNum" name="dispatchOrderList[${sta.index}].dispatchProduce.planNum" value="${dis.dispatchProduce.planNum}" style="width: 40px;"/>
											</td>
											<td class="text-center" style="width:15px;"><span id="" class="close" onclick="delTr(this);" title="删除" style="display:block;" >&times;</span></td>
										</tr>
										</c:forEach>
										</tbody>
									</table>
			                </div>
		                </div>
				        <div class="box-footer">
				        	<div class="pull-left box-tools">
								<button type="button" class="btn btn-default btn-sm"
									onclick="javascript:history.go(-1)">
									<i class="fa fa-mail-reply"></i>返回
								</button>
							</div>
							<div class="pull-right box-tools">
								<c:if test="${dispatchMission.id eq null }">
									<button type="button" class="btn btn-default btn-sm"
										onclick="ZF.resetForm()">
										<i class="fa fa-refresh"></i>重置
									</button>
								</c:if>
								<button type="submit" class="btn btn-info btn-sm">
									<i class="fa fa-save"></i>保存
								</button>
							</div>
			            </div>
			            </form:form>
			    	</div>
			    </div>
		    </div>
	    	</section>
	</div>

<script type="text/javascript">
		function submitForm(){
			if($("#reasonType").select2("val") == null || $("#reasonType").select2("val") == ""){
				ZF.showTip("请选择调货类型！", "info");
					return false;
				}
			if($("#limitTime").val() == null || $("#limitTime").val() == ""){
				ZF.showTip("请选择要求完成的时间！", "info");
					return false;
			}
			var $inWarehouseId = $("#inWarehouseId").val();
			if($inWarehouseId == null || $inWarehouseId == ""){
				ZF.showTip("请先选择要调入的仓库！", "info");
				return;
			}
			confirm("确定要提交该信息吗？", "info", function(){inputForm.submit();}, null);
		}
		
		$(function(){
			/* $("#limitTime").datepicker({
				  format: 'yyyy-mm-dd hh:mm:ss'
			}); */
			// 选择产品
			$("#chooseProduceButton").on('click',function(){
				$("#produceSelectModalUrl").val("${ctx}/lgt/ps/produce/select")//带参数请求URL设置方式
	        	$("#produceSelectModal").modal('toggle');//显示模态框
			});
			
			// Modal<iframe>回调事件,获取弹出框选择的货品信息
			$("#produceSelectModal").on("hide.bs.modal",function () {
				var content = $("#produceSelectModalIframe").contents().find("body");
				$("input[type=checkBox]", content).each(function(){
					if($(this).prop("checked")){
						//重新选择产品清空原来数据
						$("tr",$("#tableList")).each(function(){
							$(this).remove();
						})
						iframeSelected($(this).val())   					
					}
				});
			});
		});
			
		function iframeSelected(produceId){
			var $inWarehouseId = $("#inWarehouseId").val();
			if($inWarehouseId == null || $inWarehouseId == ""){
				ZF.showTip("请先选择要调入的仓库！", "info");
				return;
			}
			var dataList={"produce.id":produceId};//静态模拟数据
			var url="${ctx}/lgt/dp/dispatchMission/ajax/queryProudceStock/1";
			ZF.ajaxQuery(true,url,dataList,function(data){
				var dataobj = JSON.parse(data);
				console.log(dataobj);
		    	var loadingLi=$("#tableList");
		    	var iRecordTrArr = $("#tableList").children();
				var trCount = iRecordTrArr.length;
		    	var html="";
				for(var i = 0; i < dataobj.length; i++) {
				        var result = dataobj[i];
				        if($inWarehouseId != result.warehouse.id){//判断调入仓库与调出仓库不能一样，去除与调入仓库一样的数据
				        	html +="<tr>";
				        	html +="<td>"+result.warehouse.name+",库存数："+result.stockWarehouse+"</td>";
				        	html +="<td>"+result.warehouse.responsibleUser.name+",电话:"+result.warehouse.responsibleMobile+"</td>";
				        	html +="<td>"+result.produce.goods.name+"--"+result.produce.name+"</td>";
				        	if(result.stockWarehouse == 0){
				        		html +="<td><input type='text' name=''  value='' disabled='disabled'></td>";
				        	}else{
				        		html +="<td>"+
				        		"<input type='text' name='dispatchOrderList["+trCount+"].dispatchProduce.planNum'  value='' id='planNum'></td>";
				        	}
				        	html +="<input id='"+result.id+"_whproduceid' type='hidden' name='dispatchOrderList["+trCount+"].whProduce.id' value='"+result.id+"'/>";
				        	html +="<input id='"+result.id+"_wid' type='hidden' name='dispatchOrderList["+trCount+"].outWarehouse.id' value='"+result.warehouse.id+"'/>";
				        	html +="<input id='"+result.id+"_produceid' type='hidden' name='dispatchOrderList["+trCount+"].dispatchProduce.produce.id' value='"+result.produce.id+"'/>";
				        html +="</tr>";
				        trCount++;
				        }
				}
				loadingLi.append(html);
			});
		};
		
		//新增的模板行直接直接物理删除
		function delTr(curSpan) {
			$(curSpan).parent("td").parent("tr").remove();
		};
</script>

</body>

</html>