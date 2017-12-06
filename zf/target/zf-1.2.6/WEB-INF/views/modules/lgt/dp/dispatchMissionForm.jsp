<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>添加调货任务管理</title>
	<meta name="decorator" content="adminLte"/>
	
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small ><i class="fa-list-style"></i><a href="${ctx}/lgt/dp/dispatchMission/">调货任务列表</a></small>
				
	        	<shiro:hasPermission name="lgt:dp:lgtPsDispatchMission:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/dp/dispatchMission/form?id=${dispatchMission.id}">调货任务${not empty dispatchMission.id?'修改':'添加'}</a></small></shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}"/>
	    	<section class="content">
		    <form:form id="inputForm" modelAttribute="dispatchMission" action="${ctx}/lgt/dp/dispatchMission/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
		    <div class="row">
		    	<div class="col-md-12">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>调货任务</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <!-- /.box-header -->
						
	   					<form:hidden path="id"/>
	   					<input type="hidden" id="missionStatus" name="missionStatus" value="1" >
	   					<!-- 发起人 -->
	   					<input name="startBy.id" type="hidden" value="${dispatchMission.startBy.id } "/>
						<input name="startBy.name" type="hidden" value="${fns:getUserById(dispatchMission.startBy.id).name}" class="form-control" readonly="readonly"/>
							
				        <div class="box-body">
				        	<div class="col-md-4">
				        		<c:choose>
				        			<c:when test="${empty dispatchMission.id }">
				        				<sys:inputtree id="inWarehouse" name="inWarehouse.id" verifyType="true" url="${ctx}/lgt/ps/warehouse/warehouseListData" inputWidth="7" labelWidth="3" label="调入仓库" labelValue="" labelName="inWarehouse.name" value="" tip="请选择仓库" title="调入仓库"></sys:inputtree>
				        			</c:when>
				        			<c:otherwise>
				        				<sys:inputtree id="inWarehouse" name="inWarehouse.id" verifyType="true" url="${ctx}/lgt/ps/warehouse/warehouseListData" inputWidth="7" labelWidth="3" label="调入仓库" labelValue="" labelName="inWarehouse.name" value="" tip="请选择仓库" title="调入仓库" isReadOnly="true"></sys:inputtree>
				        			</c:otherwise>
				        		</c:choose>
								
							</div>
				        	<div class="col-md-4">
				        		<div class="form-group">
					        		<label class="col-sm-3 control-label">调入负责人</label>
									<div class="col-sm-7">
										<div class="input-group">
						        			<form:hidden id="inUserId" path="inUser.id" />
											<sys:inputverify name="inUser.name" id="inUserName" verifyType="0" tip="请选择调入负责人，必填项" isSpring="true" forbidInput="true"></sys:inputverify>
											<span class="input-group-addon" onclick="selectUser();"><i class="fa fa-search"></i></span>
										</div>
									</div>
				        		</div>
				        	</div>
			        		<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="reasonType" class="col-sm-3 control-label">调货类型</label>
				                  <div class="col-sm-7">
									<sys:selectverify name="reasonType" tip="请选择调货类型，必填项" verifyType="true" dictName="dispatch_mission_reasonType" id="reasonType"></sys:selectverify>
				                  </div>
				        		</div>
				        	</div>
				        	<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="startTime" class="col-sm-3 control-label">任务发起时间</label>
				                  <div class="col-sm-7">
										<sys:datetime id="startTimeId" inputName="startTime" tip="" inputId="startTime" value="${dispatchMission.startTime}" defaultDate="${dispatchMission.startTime}"></sys:datetime>
				                  </div>
				                </div>
			                </div>
			                <div class="col-md-4">
			        			<div class="form-group">
				                  <label for="limitTime" class="col-sm-3 control-label">要求完成时间</label>
				                  <c:set value="${dispatchMission.startTime}" var="test"></c:set>
				                  <div class="col-sm-7">
										<sys:datetime inputId="limitTime" inputName="limitTime" tip="请选择要求完成时间，必选项" value="${dispatchMission.limitTime}" isMandatory="true" id="yqwcsj" minDate="${dispatchMission.startTime}"></sys:datetime>
				                  </div>
				        		</div>
			        		</div>
			        		<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="remarks" class="col-sm-3 control-label">备注</label>
				                  <div class="col-sm-7">
				                    <form:textarea path="remarks" rows="3" maxlength="200" class="form-control"/>
				                  </div>
			                   </div>
			                </div>
				        </div>
		            </div>
	            </div>
            </div>
            
            <div class="box box-success">
            	<div class="box-header with-border zf-query">
	            	<h5>选择产品</h5>
	              	<div class="box-tools">
	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              	</div>
	            </div>
				<div class="box-body">
	                <div class="row">
						<div class="col-sm-12 pull-right">
							 <button id="chooseProduceButton" type="button" class="btn btn-sm btn-success"><i class="fa fa-diamond">选择产品</i></button>
				             <sys:selectmutil id="produceSelect" title="仓库产品选择" url="" isDisableCommitBtn="true" width="1200" height="700" isRefresh="false" ></sys:selectmutil>
						</div>
					</div>
                	<div class="col-md">
	                   <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>产品名称</th>
									<th>调出仓库</th>
									<th>仓库负责人</th>
									<th>负责人电话</th>
									<th>库存数量</th>
									<th>警戒库存</th>
									<th>需要调拨的数量</th>
									<!-- <th>可调拨的数量</th> -->
									<!-- <th>备注</th> -->
									<th>&nbsp;</th>
								</tr>
							</thead>
							<tbody id="tableList">
								<c:forEach items="${dispatchMission.dispatchOrderList}" var="dis" varStatus="sta">
									<tr id="tr_${dis.whProduce.id}">
							        	<td>${dis.dispatchProduce.produce.goods.name}--${dis.dispatchProduce.produce.name}</td>
							        	<td>${dis.outWarehouse.name}</td>
							        	<td>${fns:getUserById(dis.outUser.id).name}</td>
							        	<td>${dis.outWarehouse.responsibleMobile}</td>
							        	<td>${dis.dispatchProduce.produce.stockWarehouse }</td>
							        	<c:choose>
							        		<c:when test="${empty dis.dispatchProduce.produce.stockWarning }">
							        			<td>未设置</td>
							        		</c:when>
							        		<c:otherwise>
							        			<td>${dis.dispatchProduce.produce.stockWarning }</td>
							        		</c:otherwise>
							        	</c:choose>
										<td>
											<input type="text" name="dispatchOrderList[${sta.index }].dispatchProduce.planNum" value="${dis.dispatchProduce.planNum }" class="form-control" data-type="item" id="${dis.id }"></td>
								        	<input id="${dis.id }_whproduceid" type="hidden" name="dispatchOrderList[${sta.index }].whProduce.id" value="${dis.whProduce.id }"/>
								        	<input id="${dis.id }_wid" type="hidden" name="dispatchOrderList[${sta.index }].outWarehouse.id" value="${dis.outWarehouse.id }"/>
								        	<input id="${dis.id }_produceid" type="hidden" name="dispatchOrderList[${sta.index }].dispatchProduce.produce.id" value="${dis.dispatchProduce.produce.id }"/>
										</td>
										<td class="text-center" style="width:15px;"><span id="" class="close" onclick="delTr(this);" title="删除" style="display:block;" >&times;</span></td>
									</tr>
								</c:forEach>
						</tbody>
				</table>
	         </div>
             <div class="box-footer">
          	<div class="pull-left box-tools">
       		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
       	</div>
					<div class="pull-right box-tools">
           	<button type="submit" class="btn btn-info btn-sm" ><i class="fa fa-save">保存</i></button>
       	</div>
         	</div>
            </div>
        </div>
  </form:form>
  <sys:userselect height="550" url="${ctx}/sys/office/userTreeData" width="550" isOffice="false" isMulti="false" title="人员选择" id="selectUser" ></sys:userselect>
 </section>
</div>

<script type="text/javascript">
	
	$(function(){
		
		$("#inUserName").on("click", function() {
			selectUserinit({
				"selectCallBack" : function(list) {
					$("#inUserId").val(list[0].id);
					$("#inUserName").val(list[0].text);
					$("#inUserName").attr("data-verify","true");
					$("#inUserName").removeClass("zf-input-err");
   					if($("#inUserNameErr").length>0){
   						$("#inUserNameErr").remove();
   					}
				}
			})
		}); 
		
		// 选择产品
		$("#chooseProduceButton").on('click',function(){
			var inWarehouseVal = $("#inWarehouseName").attr("data-verify");
			if(inWarehouseVal == "false") {
				$("#inWarehouseName").addClass("zf-input-err");
				ZF.showTip("请先选择调入仓库", "info");
				return false;
			}
			$("#produceSelectModalUrl").val("${ctx}/lgt/ps/produce/select?pageKey=dispatchMissionForm")//带参数请求URL设置方式
        	$("#produceSelectModal").modal('toggle');//显示模态框
		});
		
		// Modal<iframe>回调事件,获取弹出框选择的货品信息
		$("#produceSelectModal #commitBtn").on("click",function () {
			$("#produceSelectModal").modal("hide");		
			var content = $("#produceSelectModalIframe").contents().find("body");
			var produceIdArr = [];
			$("input[type=checkBox]", content).each(function(){
				if($(this).prop("checked")){
					//重新选择产品清空原来数据
					$("tr>td[class=dataTables_empty]",$("#tableList")).each(function(){
						$(this).remove();
					})
					produceIdArr.push($(this).val());
				}
			});
			iframeSelected(produceIdArr);   		
			
			//清楚check  table缓存
			window.localStorage.removeItem("dispatchMissionForm");
		});
		
		//表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"order": [[ 4, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},//第14列和第0列不排序
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:7}
            ],
			"ordering" : false,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){},//行取消选中回调
			"addRow":{
				"eventId":"#addRow",
				"getData":function(){
				},
				"callBack":function(){
					console.log("行添加结束")
				}
				
			}
		});
		
	});
	
	function iframeSelected(produceIdArr){
		console.log(produceIdArr);
		var $inWarehouseId = $("#inWarehouseId").val();
		if($inWarehouseId == null || $inWarehouseId == ""){
			ZF.showTip("请先选择要调入的仓库！", "info");
			return;
		}
		var dataList={"param":$inWarehouseId+"="+produceIdArr.join()};
		var url="${ctx}/lgt/dp/dispatchMission/ajax/queryProudceStock";
		ZF.ajaxQuery(true,url,dataList,function(data){
			var dataobj = JSON.parse(data);
	    	var loadingLi=$("#tableList");
	    	var iRecordTrArr = $("#tableList").children();
			var trCount = iRecordTrArr.length;
	    	var html="";
			for(var i = 0; i < dataobj.length; i++) {
			        var result = dataobj[i];
			        if($inWarehouseId != result.warehouse.id  && $("#tr_"+result.id).length <= 0){//判断调入仓库与调出仓库不能一样，去除与调入仓库一样的数据
			        	html +="<tr id='tr_"+result.id+"'>";
			        	html +="<td>"+result.produce.goods.name+" "+result.produce.name+"</td>";
			        	html +="<td>"+result.warehouse.name+"</td>";
			        	html +="<td>"+result.warehouse.responsibleUser.name+"</td>";
			        	html +="<td>"+result.warehouse.responsibleMobile+"</td>";
			        	html +="<td>"+result.stockWarehouse+"</td>";
			        	if(result.stockWarning == undefined || result.stockWarning == null || result.stockWarning == ""){
			        		html +="<td>未设置</td>";
			        	}else{
			        		html +="<td>"+result.stockWarning+"</td>";
			        	}
			        	html +="<td><input type='text' name='dispatchOrderList["+trCount+"].dispatchProduce.planNum' data-verify='false' class='form-control' data-type='item' id='"+result.id+"'></td>";
			        	html +="<input id='"+result.id+"_whproduceid' type='hidden' name='dispatchOrderList["+trCount+"].whProduce.id' value='"+result.id+"'/>";
			        	html +="<input id='"+result.id+"_wid' type='hidden' name='dispatchOrderList["+trCount+"].outWarehouse.id' value='"+result.warehouse.id+"'/>";
			        	html +="<input id='"+result.id+"_produceid' type='hidden' name='dispatchOrderList["+trCount+"].dispatchProduce.produce.id' value='"+result.produce.id+"'/>";
			        	html +="<td class='text-center' style='width:15px;'><span id='' class='close' onclick='delTr(this);' title='删除' style='display:block' >&times;</span></td>";
			        html +="</tr>";
			        trCount++;
			     }
			}
			loadingLi.append(html);
			if($("#chooseProduceButtonErr").length>0) {
				$("#chooseProduceButtonErr").remove();
			}
			
		 	$("input[data-type=item]").each(function(){
				if($(this).val()!=null&&$(this).val()!=undefined&&$(this).val()!=""){
					$(this).attr("data-verify",true);
				}
			});
			
			//给input绑定change事件
			$("input[data-type=item]").on("change",function(){
				var id=$(this).attr("id");
				var stockRealNum = $(this).val();
				var stockNum = $(this).parent().prev().prev().text();
				if(!ZF.formVerify(true, "4",stockRealNum) || stockRealNum <= 0){//数字非空验证
					$(this).addClass("zf-input-err");
					if($("#"+id+"Err").length<=0) {
						$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>不得为空，且必须要大于0</label>")
					}
					$(this).attr("data-verify","false");
				} else {
					if($("#"+id+"Err").length>0){
						$(this).removeClass("zf-input-err");
						$("#"+id+"Err").remove();
						$(this).attr("data-verify","true");
					}  else {
						$(this).attr("data-verify","true");
					}
				}
			});
		});
	};
	
	function formSubmit(){
		var verify=true;
		$("input[data-verify=false]").each(function() {
			if($(this).attr('data-type') == "date"){
				$(this).parent().trigger('dp.change');
			}else{
				$(this).trigger('change');
			}
			verify=false;
		});
		
		$("select[data-verify=false]").each(function() {
			$(this).trigger('change');
			verify=false;
		});
		
		if($("#tableList>tr>td").length <= 1) {//默认（暂无数据行）
			/* ZF.showTip("请选择需要调拨的产品", "info"); */
			if($("#chooseProduceButtonErr").length<=0) {
				$("#chooseProduceButton").after("<label id=\"chooseProduceButtonErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择需要调拨的产品，必选</label>");
				verify = false;
			}
		}
		return verify;
	};
	
	function selectUser() {
		selectUserinit({
			"selectCallBack" : function(list) {
				$("#inUserId").val(list[0].id);
				$("#inUserName").val(list[0].text);
				$("#inUserName").attr("data-verify","true");
				$("#inUserName").removeClass("zf-input-err");
					if($("#inUserNameErr").length>0){
						$("#inUserNameErr").remove();
					}
			}
		});
	}
</script>
<script type="text/javascript">
$(document).ready(function() {
	$('.date-picker').datepicker({
        language: 'zh-CN',
        autoclose: true,
        todayHighlight: true
    });
});
</script>
<script type="text/javascript">
//新增的模板行直接直接物理删除
function delTr(curSpan) {
	$(curSpan).parent("td").parent("tr").remove();
};
</script>
</body>

</html>