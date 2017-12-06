<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购任务分单编辑</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body >
<div class="content-wrapper sub-content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header content-header-menu">
		<h1>
			<small>
				<i class="fa-list-style"></i><a href="${ctx}/lgt/po/purchaseMissionSplit/list">采购任务分单列表</a>
			</small>
			<shiro:hasPermission name="lgt:po:purchaseMissionSplit:edit">
				<small>|</small>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/po/purchaseMissionSplit/splitForm?id=${purchaseMission.id}">采购任务分单</a>
				</small>
			</shiro:hasPermission>
		</h1>
	</section>
	
	<sys:tip content="${message}"/>
	
    <section class="content">
	    <form:form id="inputForm" modelAttribute="purchaseMission" action="${ctx}/lgt/po/purchaseMissionSplit/save" method="post"  class="form-horizontal">
	    <form:hidden path="id"/>
	    <input type="hidden" name="token" value="${token }" />
	    <input type="hidden" id="pmId" value="${purchaseMission.id }" />
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
					</div>
	            </div>
            </div>
        </div>
	    <!-- 明细 -->
	    <div class="box box-soild">
           	<div class="box-header with-border zf-query">
            	<h5>采购任务产品</h5>
              	<div class="box-tools">
              		<div class="pull-left">
	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
              		</div>
	            </div>
            </div>
			<div class="box-body">
	            <div class="table-responsive">
				<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
					<thead>
						<tr>
							<th width="150px">产品编号</th>
							<th width="400px">商品名称</th>
							<th width="280px">产品规格</th>
							<th width="200px">采购数量/待分配数量</th>
							<th>采购备注</th>
							<th width="90px">分配供应商</th>
						</tr>
					</thead>
					<tbody id="builderTbody">
					</tbody>
				</table>
				</div>
			</div>
		</div>
		<!-- 采购人 -->
	    <div class="box box-soild">
           	<div class="box-header with-border zf-query">
            	<h5>采购人设置</h5>
              	<div class="box-tools">
              		<div class="pull-left">
	                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
              		</div>
	            </div>
            </div>
			<div class="box-body">
	            <div class="table-responsive">
				<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
					<thead>
						<tr>
							<th style="width:640px">供应商</th>
							<th style="width:500px">对应采购人</th>
							<th>要求完成时间</th>
						</tr>
					</thead>
					<tbody id="builderTbodyUserSet">
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
  	<sys:selectmutil id="supplierSelect" title="选择供应商" url="${ctx}/lgt/si/supplier/select?pageKey=purchaseMissionSplitForm" isDisableCommitBtn="true" width="1200" height="700" isRefresh="false"></sys:selectmutil>
  	<sys:userselect id="inventoryUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
  	
  	<form:form id="submitForm" modelAttribute="purchaseMission" action="${ctx}/lgt/po/purchaseMissionSplit/splitSave" method="post">
  		<input type="hidden" name="id" value="${purchaseMission.id}"/>
  		<input type="hidden" name="token" value="${token }" />
  		<div id="submitFormDiv"></div>
	</form:form>
</div>
	
<script type="text/javascript">
	var userSetTable=null;
	function MyTable(tableId,data){
		var me=this;
		var table=$(tableId);
		var trHtmlTempl="<tr><td colspan=\"2\"><div class=\"input-group\" style=\"width:700px\"><input type=\"text\" readOnly name=\"supplier$trId\" data-id=\"\" data-name=\"supplierInputTag\" placeholder=\"选择供应商，必填项\" class=\"form-control zf-input-readonly\" /><span class=\"input-group-addon\"><i class=\"fa fa-search\"></i></span></div></td><td class=\"text-red\" data-num=\"0\"><input name=\"purchaseNum$trId\" type=\"text\" value=\"\"  placeholder=\"待分配采购数量，必填项\" class=\"form-control\" /></td><td class=\"text-left\"><i class=\"fa fa-minus\"></i></td></tr>"
		//新增行，并且绑定行删除事件和供应商选择事件
		this.addRow=function(eventTr,trId){
			var codeTd=eventTr.children("td").eq(0);
			var rowspan=parseInt(codeTd.attr("rowspan"))+1;
			codeTd.attr("rowspan",rowspan);
			eventTr.children("td").eq(4).attr("rowspan",rowspan);
			var htmlTempl=trHtmlTempl.replace("$trId",trId).replace("$trId",trId);
			var tr=$(htmlTempl);
			$(".fa-minus",tr).on("click",function(){
				me.delRow(tr,eventTr,trId);
			});
			$(".input-group-addon",tr).on("click",function(){
				me.selectSupplier(tr, trId);
			});
			$("input[name=purchaseNum"+trId+"]",tr).on("change",function(){
				me.setPurchaseNum($(this),eventTr,trId);
			});
			eventTr.after(tr);
		}
		//删除行
		this.delRow=function(eventTr,addTr,trId){
			eventTr.remove();
			var codeTd=addTr.children("td").eq(0);
			var rowspan=parseInt(codeTd.attr("rowspan"))-1;
			codeTd.attr("rowspan",rowspan);
			addTr.children("td").eq(4).attr("rowspan",rowspan);
			me.countPurchaseNum(addTr,trId);
			// 绘制“采购人设置”表单
			userSetTable.drawTable();
		}
		//选择供应商
		this.selectSupplier=function(tr, trId){
			$("#commitBtn").unbind("click");
			$("#commitBtn").on("click",function () {
				$("#supplierSelectModal").modal("hide");						// 隐藏模态框
				var content = $("#supplierSelectModalIframe").contents().find("body");	// 获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
				$("input[type=radio]", content).each(function(){
    				if($(this).prop("checked")){
	    				// 选中供应商
	    				$("input[name=supplier"+trId+"]", tr).val($(this).attr("data-name"));
	    				$("input[name=supplier"+trId+"]", tr).attr("data-id",$(this).val());
	    				// 绘制“采购人设置”表单
	    				userSetTable.drawTable();
    				}
    			});

				//清楚check  table缓存
				window.localStorage.removeItem("purchaseMissionSplitForm");
			});
			$("#supplierSelectModal").modal("toggle");
		}
		//设置采购数量
		this.setPurchaseNum=function(inputObj,tr,trId){
			var reg = new RegExp("^[0-9]*$");
		 	var num=inputObj.val();
		 	//验证
		 	if(!reg.test(inputObj.val())||parseInt(num)<0){
		 		inputObj.addClass("zf-input-err");
		 		ZF.showTip("采购数量填写格式不正确，必须为正整数","danger");
		 		inputObj.val("");
		 		return;
		 	}
		 	var newNum=me.countPurchaseNum(tr,trId);
		 	if(newNum<0){
		 		inputObj.addClass("zf-input-err");
		 		ZF.showTip("采购数量不能超出待分配数量","danger");
// 		 		inputObj.val("0");
		 		return;
	 		}
		 	inputObj.removeClass("zf-input-err");
		}
		//重新计算采购数量
		this.countPurchaseNum=function(tr,trId){
			var trNums=tr.children("td").eq(3).text().split("/");
		 	var maxNum=parseInt(trNums[0].trim());
		 	var purchaseNum=parseInt(trNums[1].trim());
		 	
			//重新计算待分配数量
		 	var newNum=maxNum;
		 	var inputs=$("input[name=purchaseNum"+trId+"]");
		 	for(var i=0;i<inputs.length;i++){
		 		newNum=newNum-parseInt(($(inputs[i]).val()==null||$(inputs[i]).val()=="") ? 0 : $(inputs[i]).val());
		 	}
		 	if(newNum==0)
		 		tr.children("td").eq(3).html("<font color=\"black\">"+maxNum+"/"+newNum+"</font>");		 		
		 	else
		 		tr.children("td").eq(3).html("<font color=\"black\">"+maxNum+"/</font>"+newNum);
		 	//检测是否全部分配完成 data-distribution为母tr中数量分配是否完成的标记 true为完成
		 	newNum==0?tr.attr("data-distribution","true"):tr.attr("data-distribution","false");
		 	return newNum;
		};
		//拿到所有的采购产品
		this.getPurchaseProduces=function(){
			var results=[];
			for(var i=0; i<data.length; i++){
				var trId=data[i].produce.id;
				if($("#"+trId).attr("data-distribution")=="false"){
					ZF.showTip("["+data[i].produce.code+"] 采购数量未完成分配，请检查！","danger");
					return;
				}
				var numInputs=$("input[name=purchaseNum"+trId+"]");
				var supplierInputs=$("input[name=supplier"+trId+"]");
				if(numInputs.length!=supplierInputs.length){
					ZF.showTip("程序出现错误，请稍后再尝试！","danger");
					return;
				}
				
// 				var obj=[];
				for(var j=0; j<numInputs.length; j++){
					if($(numInputs[j]).val()==null || $(numInputs[j]).val()=="" || $(numInputs[j]).val()==0){
						ZF.showTip("["+data[i].produce.code+"] 分配数量不能为空或为0，请检查！","danger");
						return;
					}
					var purchaseProduce={};
					if($(supplierInputs[j]).attr("data-id")==""){
						ZF.showTip("["+data[i].produce.code+"] 采购未完成供应商设置，请检查！","danger");
						return;
					}
					// 验证同产品下供应商重复
					for(var k=0; k<j; k++){
						if($(supplierInputs[k]).attr("data-id")==$(supplierInputs[j]).attr("data-id")){
							ZF.showTip("["+data[i].produce.code+"] 同产品下供应商设置重复，请检查！","danger");
							return;
						}
					}
					purchaseProduce.produceId	= trId;
					purchaseProduce.produceName	= data[i].produce.name;
					purchaseProduce.num			= $(numInputs[j]).val();
					purchaseProduce.supplierId	= $(supplierInputs[j]).attr("data-id");
					purchaseProduce.supplierName= $(supplierInputs[j]).val();
// 					obj.push(purchaseProduce);
					results.push(purchaseProduce);
				}
			}
			return results;
		};
		//绘制表格
		this.drawTable=function(tbodyId){
			var tbodyHtmlTempl= "<tr id=\"$produceId\" data-rowIndex=\"0\" data-distribution=\"false\">";
			    tbodyHtmlTempl+="<td rowspan=\"1\">$produceCode</td>";
			    tbodyHtmlTempl+="<td title=\"$goodsName\">$goodsName</td>";
			    tbodyHtmlTempl+="<td>$produceName</td>";
			    tbodyHtmlTempl+="<td class=\"text-red\"><font color=\"black\">$num/</font>$num</td>";
			    tbodyHtmlTempl+="<td rowspan=\"1\" title=\"$remtitle\">$remarks</td>";
			    tbodyHtmlTempl+="<td><i class=\"fa fa-plus\"></i></td>";
			    tbodyHtmlTempl+="</tr>";
			for(var i=0;i<data.length;i++){
				var tr=tbodyHtmlTempl.replace("$produceId",data[i].produce.id);
				tr=tr.replace("$produceCode",data[i].produce.code);
				tr=tr.replace("$goodsName",data[i].produce.goods.name).replace("$goodsName",data[i].produce.goods.name.sub(0,55));
				tr=tr.replace("$produceName",data[i].produce.name);
				tr=tr.replace("$num",data[i].num).replace("$num",data[i].num);
				tr=tr.replace("$remtitle",data[i].remarks);
				if(data[i].remarks != null && data[i].remarks != "" && data[i].remarks.length > 13){
					tr=tr.replace("$remarks",data[i].remarks.substring(0,13)+"...");
				}else if(data[i].remarks==undefined){
                    tr=tr.replace("$remarks","");
				}else {
					tr=tr.replace("$remarks",data[i].remarks);
				}
				
				var trObj=$(tr);
				$(".fa-plus",trObj).on("click",function(){
					var trRow=$(this).parent().parent();
					me.addRow(trRow,trRow.attr("id"));
				});
				$(tbodyId).append(trObj);
			}
		};
	}
	
	
	function UserSetTable(tbodyId, data){
		var me=this;
		// 绘制“采购人设置”表格
		this.drawTable = function(){
			var suppliers = $("input[data-name=supplierInputTag]");
			var data=me.filter(suppliers);
			$(tbodyId).html("");//清空
			var trHtmlTempl= "<tr id=\"$supplierId\" data-name=\"$supplierName\" data-tag=\"supplierTrTag\" data-selected=\"false\">";
				trHtmlTempl+="<td>$supplierName</td>";
				trHtmlTempl+="<td><div class=\"input-group\"><input type=\"text\" readOnly value=\"\" data-tag=\"userInputTag\" data-id=\"\" placeholder=\"选择采购人，必填项\" class=\"form-control zf-input-readonly\" /><span class=\"input-group-addon\"><i class=\"fa fa-search\"></i></span></div></td>";
				trHtmlTempl+="<td><input type=\"text\" value=\"\" data-tag=\"requiredTimeInputTag\" data-id=\"\" htmlEscape=\"false\" placeholder=\"请选择要求完成时间\" maxlength=\"255\" class=\"form-control\"/></td>";
				trHtmlTempl+="</tr>";
			for(var i=0; i<data.length; i++){
				var tr=trHtmlTempl.replace("$supplierId",data[i].supplierId);
				tr=tr.replace("$supplierName",data[i].supplierName);
				tr=tr.replace("$supplierName",data[i].supplierName);
				$(tbodyId).append($(tr));
			}
			$("span",$(tbodyId)).on("click",function(){
				me.showUserSelect($(this).parent().parent().parent());
			});
			$("input[data-tag=requiredTimeInputTag]").datetimepicker({
				locale:'zh-cn',
				format:'LTS',
				minDate:new Date().toLocaleDateString() + " " + new Date().getHours()+ ":" + new Date().getMinutes()+ ":" + new Date().getSeconds()
			});
		};
		//供应商去重过滤
		this.filter=function(supplierInputs){
			var results=[];
			for(var i=0;i<supplierInputs.length;i++){
				var supplierId=$(supplierInputs[i]).attr("data-id");
				var supplierName=$(supplierInputs[i]).val();
				if(supplierId==""||supplierId.length<=0)
					continue;
				var isFilter=false;
				for(var j=0;j<results.length;j++){
					if(results[j].supplierId==supplierId){
						isFilter=true;
						break;
					}
				}
				if(isFilter)
					continue;
				var obj={};
				obj.supplierId=supplierId;
				obj.supplierName=supplierName;
				results.push(obj);
			}
			return results;
		};
		// 显示人员选择器
		this.showUserSelect=function(tr){
			inventoryUserinit({
	 	    	 "selectCallBack":function(list){
	   	 			if(list.length>0){
						$("input[data-tag=userInputTag]", $(tr)).val(list[0].text);
						$("input[data-tag=userInputTag]", $(tr)).attr("data-id",list[0].id);
						$(tr).attr("data-selected","true");
	 	    	 	}
	 	    	 }
	    	});
		}
		this.getSupplierAndUser=function(){
			var supplierTrs = $("tr[data-tag=supplierTrTag]");
			var userInputs = $("input[data-tag=userInputTag]");
			var requiredTimeInputs = $("input[data-tag=requiredTimeInputTag]");
			if(supplierTrs.length!=userInputs.length || supplierTrs.length!=requiredTimeInputs.length){
				ZF.showTip("程序出现错误，请稍后再尝试！","danger");
				return;
			}
			
			var results = [];
			for(var i=0; i<supplierTrs.length; i++){
				if($(supplierTrs[i]).attr("data-selected")=="false"){
					ZF.showTip("["+$(supplierTrs[i]).attr("data-name")+"] 供应商未设置对应采购人，请检查！","danger");
					return;
				}
				if($(requiredTimeInputs[i]).val() == null || $(requiredTimeInputs[i]).val() == ""){
					ZF.showTip("["+$(supplierTrs[i]).attr("data-name")+"] 供应商未设置对应要求完成时间，请检查！","danger");
					return;
				}
				var supplierAndUser={};
				supplierAndUser.supplierId = $(supplierTrs[i]).attr("id");
				supplierAndUser.supplierName = $(supplierTrs[i]).attr("data-name");
				supplierAndUser.userId = $(userInputs[i]).attr("data-id");
				supplierAndUser.userName = $(userInputs[i]).val();
				supplierAndUser.requiredTime = $(requiredTimeInputs[i]).val();
				results.push(supplierAndUser);
			}
			return results;
		}
	}
	
	var table=null;
	$(function(){
		var pmId = $("#pmId").val();
		//获取采购明细
		ZF.ajaxQuery(true,"${ctx}/lgt/po/purchaseMissionSplit/purchaseMissionWithDetailData?id="+pmId,null,function(data){
			table=new MyTable("#contentTable",data.detailList);
			table.drawTable("#builderTbody");
			userSetTable=new UserSetTable("#builderTbodyUserSet");
		})
	})
	
	// 封装数据，提交表单
	function submitForm(){
		var orderProduceData = table.getPurchaseProduces();
		if(orderProduceData==null)
			return;
		var orderData = userSetTable.getSupplierAndUser();
		if(orderData==null)
			return;
		$("#submitFormDiv").html("");
		for(var i=0; i<orderData.length; i++){
			var inputTmple = "<input type=\"hidden\" name=\"orderList["+i+"].supplier.id\" value=\""+orderData[i].supplierId+"\"/>";
			inputTmple += "<input type=\"hidden\" name=\"orderList["+i+"].purchaseUser.id\" value=\""+orderData[i].userId+"\"/>";
			inputTmple += "<input type=\"hidden\" name=\"orderList["+i+"].requiredTime\" value=\""+orderData[i].requiredTime+"\"/>";
			var index = 0;
			for(var j=0; j<orderProduceData.length; j++){
				if(orderProduceData[j].supplierId == orderData[i].supplierId){
					inputTmple += "<input type=\"hidden\" name=\"orderList["+i+"].purchaseProduceList["+index+"].produce.id\" value=\""+orderProduceData[j].produceId+"\"/>";
					inputTmple += "<input type=\"hidden\" name=\"orderList["+i+"].purchaseProduceList["+index+"].requiredNum\" value=\""+orderProduceData[j].num+"\"/>";
					index++;
				}
			}
			$("#submitFormDiv").append(inputTmple);
		}

		confirm("是否确认分单？<br\>确认后，该采购任务将针对不同供应商拆分成不同采购订单，同时采购任务变为采购中状态，确认后分单操作不能回退！","warning",function(){
			$("#submitForm").submit();
		});
		
	}
</script>
</body>
</html>