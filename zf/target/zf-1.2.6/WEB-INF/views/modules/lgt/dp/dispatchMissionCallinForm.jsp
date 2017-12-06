<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>确认货品到货列表</title>
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
				<small><i class="fa-list-style"></i><a href="${ctx}/lgt/dp/dispatchOrder/pendingStockList">执行调货任务入库列表</a></small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a>执行调货任务入库表单</a></small>
			</h1>
		</section>
	    <sys:tip content="${message}"/>
		<section class="content">
		    <%-- <div class="row">
		    	<div class="col-md-12">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>请选择要调入的仓库</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <!-- /.box-header -->
						<sys:tip content="${message}"/>
						<form:form modelAttribute="dispatchProduct" id="selectWareplace">
					        <div class="box-body">
						        <div class="row">
									<div class="col-md-4">
										<sys:inputtree name="inWareplace.warecounter.warearea.id" url="${ctx}/lgt/ps/warearea/wareareaListData" id="warearea" label="仓库区域" labelValue="" labelWidth="3" inputWidth="7" 
											labelName="inWareplace.warecounter.warearea.name" value="" tip="请选择区域" postData="{\"warehouse.id\":\"${dispatchMission.inWarehouse.id }\"}" isQuery="true" onchange="changeWarearea"></sys:inputtree>
									</div>
									<div class="col-md-4">
										<sys:inputtree name="inWareplace.warecounter.id" url="${ctx}/lgt/ps/warecounter/warecounterListData" id="warecounter" label="所属货架" labelValue="" labelName="inWareplace.warecounter.code" labelWidth="3" inputWidth="7" value="" tip="请选择货架"
											postParam="{postName:[\"warearea.id\"],inputId:[\"wareareaId\"]}" isQuery="true" onchange="changeWarecounter"></sys:inputtree>
									</div>
									<div class="col-md-4">
										<sys:inputtree name="inWareplace.id" url="${ctx}/lgt/ps/wareplace/wareplaceListData" id="wareplace" label="所属货位" labelValue="" labelName="inWareplace.code" labelWidth="3" inputWidth="7" value="" tip="请选择货位"
											postParam="{postName:[\"warecounter.id\"],inputId:[\"warecounterId\"]}" isQuery="true"></sys:inputtree>
									</div>
								</div>
				        	</div>
				        	<div class="box-footer">
	   							<div class="pull-right box-tools">
			            			<button type="button" id="setWareplace" class="btn btn-sm btn-success"><i class="fa fa-diamond">确定</i></button>
			        			</div>
		            		</div>
				        </form:form>
		            </div>
	            </div>
            </div> --%>
            <form:form id="inputForm" modelAttribute="dispatchOrder" action="${ctx}/lgt/dp/dispatchOrder/saveProductStock" method="post" class="form-horizontal" onsubmit="return formSubmit();">
	            <div class="box box-success">
	            	<div class="box-header with-border zf-query">
		            	<h5>选择货位</h5>
		              	<div class="box-tools">
		              		<div class="pull-left">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		              		</div>
			            </div>
		            </div>
					<div class="box-body">
						<div class="row">
							<div class="col-sm-12 pull-right">
								 <button id="chooseWareplaceButton" type="button" class="btn btn-sm btn-success"><i class="fa fa-diamond">选择货位</i></button>
					             <sys:selectmutil id="wareplaceSelect" title="仓库货位选择" url="" isDisableCommitBtn="true" width="1200" height="700" isRefresh="true" ></sys:selectmutil>
							</div>
						</div>
	                	<div class="col-md">
		                   <table id="contentTable" cellspacing="0" class="table table-bordered table-hover table-striped zf-tbody-font-size">
									<thead>
										<tr>
											<th></th>
											<th>产品名称</th>
											<th>调出仓库</th>
											<th>仓库责任人</th>
											<th>需要调拨的数量</th>
											<th>可调拨的数量</th>
											<!-- <th>备注</th> -->
											<th>对应货品编码</th>
											<th>存放货位</th>
<!-- 											<th>选择货位</th> -->
										</tr>
									</thead>
									<tbody id="tableList">
										<c:forEach items="${page.list}" var="duce" varStatus="index">
											<tr>
												<td class="hide">
													<!-- 调货产品记录ID -->
													<c:if test="${index.index eq 0 }">
														<!-- 对应的调货单记录ID -->
														<input type="hidden" name="id" value="${duce.dispatchOrder.id }"/>
														<input type="hidden" name="outUser.id" value="${duce.dispatchOrder.outUser.id }"/>
														<input type="hidden" name="outWarehouse.id" value="${duce.dispatchOrder.outWarehouse.id }"/>
														<!-- 对应的任务记录ID -->
														<input type="hidden" name="dispatchMission.id" value="${duce.dispatchOrder.dispatchMission.id }"/>
													</c:if>
												</td>
												<td>
													<div class="zf-check-wrapper-padding">
														<input type="radio" name="chkItem" id="ck_${index.index }" data-index = "${index.index }" data-produce = "${duce.produce.id}" value="${duce.id }" class="minimal"/>
													</div>
												</td>
												<td>${duce.produce.goods.name} ${duce.produce.name }</td>
												<td>
													${duce.dispatchOrder.outWarehouse.name}
												</td>
												<td>
													${duce.dispatchOrder.outUser.name}
												</td>
												
												<td>${duce.planNum }</td>
												<td>${duce.actualNum }</td>
												<%-- <td>${duce.actualRemarks }</td> --%>
												<td>
													<input type="hidden" name="dispatchProduceList[${index.index}].produce.id" value="${duce.produce.id }"/>
													<c:forEach items="${duce.dispatchProductList }" var="dct" varStatus="i">
														${dct.product.code }<br/>
														<input type="hidden" id="dispatchProductId_${index.index + i.index}" name="dispatchProduceList[${index.index }].dispatchProductList[${i.index}].id" value="${dct.id }"/>
														<input type="hidden" id="productId_${index.index + i.index }" name="dispatchProduceList[${index.index }].dispatchProductList[${i.index}].product.id" value="${dct.product.id }"/>
														<input type="hidden" id="inWareplaceId_${index.index + i.index}" class="hiddenInWareplace" name="dispatchProduceList[${index.index }].dispatchProductList[${i.index}].product.wareplace.id" />
													</c:forEach>
												</td>
												<td id="td_${index.index }"></td>
											</tr>
										</c:forEach>
									</tbody>
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
	    </section>
	</div>
<script type="text/javascript">
		$(function(){
			// 设置checkbox样式
    		$('input').iCheck({
    			checkboxClass : 'icheckbox_minimal-blue',
    			radioClass : 'iradio_minimal-blue'
			});
    		//
    		/* $("input[name = chkItem]").on('ifChecked',function(){
    			// — 将输入框的状态设置为checked
    			$("#wareareaName").val("");
				$("#wareareaId").val("");
				$("#warecounterName").val("");
				$("#warecounterId").val("");
				$("#wareplaceName").val("");
				$("#wareplaceId").val("");
    		}); */
    		
    		// 选择产品
    		$("#chooseWareplaceButton").on('click',function(){
    			var flag = false;
    			var produceId = "";
    			$("input[name = chkItem]:radio").each(function() {
    				if($(this).prop("checked")){
    					produceId = $(this).attr("data-produce");
            			flag = true;
    				}
    			});
				
    			if(!flag) {
    				ZF.showTip("请先勾选货品！", "info");
    				return false;
    			}
    			
    			$("#wareplaceSelectModalUrl").val("${ctx}/lgt/ps/wareplace/wareplaceSelect?produce.id="+produceId+"&warecounter.warearea.warehouse.id=${dispatchMission.inWarehouse.id}&modalWhDisplayFlag=false")//带参数请求URL设置方式
            	$("#wareplaceSelectModal").modal('toggle');//显示模态框
    		});
    		
    		// Modal<iframe>回调事件,获取弹出框选择的货品信息
    		$("#wareplaceSelectModal #commitBtn").on("click",function () {
    			$("#wareplaceSelectModal").modal("hide");		
    			var content = $("#wareplaceSelectModalIframe").contents().find("body");
    			var index = $("input[name = chkItem]:checked").attr("data-index");
    			$("input[type=radio]", content).each(function(){
    				if($(this).prop("checked")){
    					var place = $(this).attr("data-name");
    					var wareplaceId = $(this).val();
    					$("#inWareplaceId_"+index).val(wareplaceId);
    					$("#td_"+index).html(place);
    				}
    			});
    		});
    		
    		
			/* $("#chooseWareplaceButton").on("click", function() {
				$("#wareareaName").val("");
				$("#wareareaId").val("");
				$("#warecounterName").val("");
				$("#warecounterId").val("");
				$("#wareplaceName").val("");
				$("#wareplaceId").val("");
			});
			
			$("#setWareplace").on("click", function() {
				if($("#wareareaName").val().length <= 0 || $("#warecounterName").val().length <= 0 || $("#wareplaceName").val().length <= 0) {
					ZF.showTip("请先选择货位", "info");
					return false;
				}
				var place = $("#wareareaName").val()+"-"+$("#warecounterName").val()+"-"+$("#wareplaceName").val();
				var index = $("input[name = chkItem]:checked").attr("data-index");
				$(".hiddenInWareplace").val($("#wareplaceId").val());
				$("#td_"+index).html(place);
			}); */
		});
		
		/* //点击仓库选择时，需清空区域、货架、货位
		function changeWarehouse(){
			$("#wareareaName").val("");
			$("#wareareaId").val("");
			$("#warecounterName").val("");
			$("#warecounterId").val("");
			$("#wareplaceName").val("");
			$("#wareplaceId").val("");
		}
		//点击区域选择时，需清空货架、货位
		function changeWarearea(){
			$("#warecounterName").val("");
			$("#warecounterId").val("");
			$("#wareplaceName").val("");
			$("#wareplaceId").val("");
		}
		//点击货架选择时，需清空货位
		function changeWarecounter(){
			$("#wareplaceName").val("");
			$("#wareplaceId").val("");
		} */
		
		function formSubmit() {
			var flag = false;
			$("input[name = chkItem]:radio").each(function() {
				if($(this).prop("checked")){
        			flag = true;
				}
			});
			
			if(!flag) {
				ZF.showTip("请先勾选货品，选择货位！", "info");
				return false;
			}
			
			$(".hiddenInWareplace").each(function() {
				if($(this).val().length <= 0) {
					ZF.showTip("请先给每个货品选择货位！", "info");
					flag = false;
				}
			});
			
			return flag;
		}
		
		function iframeSelected() {
			
		}
</script>

</body>
</html>