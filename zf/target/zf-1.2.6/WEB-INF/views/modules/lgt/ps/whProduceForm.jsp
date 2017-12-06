<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>仓库库存设置</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header">
			<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/whProduce/list">仓库库存设置列表</a></small>
 				<small>|</small>
 	        	<shiro:hasPermission name="lgt:ps:product:edit"><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/whProduce/form">&nbsp;仓库库存修改设置</a></small></shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<div class="content-wrapper sub-content-wrapper">
				<div class="row">
					<div class="col-md-12">
						<form:form id="inputForm" modelAttribute="whProduce" action="${ctx}/lgt/ps/whProduce/batchSave" method="post" class="form-horizontal" onsubmit="return formSubmit();">
							<div class="box box-success">
								<div class="box-header with-border zf-query">
									
								</div>
								<div class="box-body">
										<div class="col-md-4">
											<c:choose>
												<c:when test="${ not empty whProduce.id}">
													<sys:inputtree name="warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="监控仓库" labelValue="" labelWidth="2" inputWidth="8"
											 				labelName="warehouse.name" value="" tip="请选择仓库" onchange="warehouseChange" isReadOnly="true" ></sys:inputtree>
												</c:when>
												<c:otherwise>
													<sys:inputtree name="warehouse.id" url="${ctx}/lgt/ps/warehouse/warehouseListData" id="warehouse" label="监控仓库" labelValue="" labelWidth="2" inputWidth="8"
											 				labelName="warehouse.name" value="" tip="请选择仓库" onchange="warehouseChange" ></sys:inputtree>
											 	</c:otherwise>
											</c:choose>
											</div>
											<div class="col-md-4">
												<div class="form-group">
													<label for="updateBy.name" class="col-sm-2 control-label">录入员工</label>
													<div class="col-sm-8">
														<form:hidden path="updateBy.id"/>
															<input name="updateBy.name" readonly="readonly" value="${whProduce.updateBy.name}" maxlength="64" class="form-control"/>
													</div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="form-group">
													<label for="updateDate" class="col-sm-2 control-label">录入时间</label>
													<div class="col-sm-8">
														<form:hidden path="updateDate"/>
														<input id="updateDate" readonly="readonly" value="<fmt:formatDate value="${whProduce.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" maxlength="64" class="form-control"/>
													</div>
												</div>
										</div>
								</div>
							</div>
							<div class="box box-success">
								<div class="box-header with-border zf-query">
									<h5>产品监控设置列表</h5>
								</div>
								<div class="box-body">
									<c:if test="${empty whProduce.produce.id  }">
										<div class="row">
											<div class="col-sm-12 pull-right">
									            <button type="button" class="btn btn-sm btn-success" id="chooseProduceBtn"><i class="fa fa-hand-pointer-o">选择产品</i></button>
											</div>
										</div>
									</c:if>
									
									<div class="table-responsive">
										<table class="table table-bordered table-hover table-striped zf-tbody-font-size">
											<thead>
												<tr>
													<th>产品编码</th>
													<th>（商品）产品名称</th>
													<th>标准库存</th>
													<th>安全库存</th>
													<th>警戒库存</th>
													<c:if test="${ empty whProduce.produce.id  }"><th width="10">&nbsp;</th></c:if>
												</tr>
											</thead>
											<tbody id="tBody">
												<c:if test="${not empty whProduce.produce.id  }">
													<tr>
														<td style="display: none;">
															<input type="hidden" name="produceLists[0].id" value="${ whProduce.produce.id }" />
														</td>
														<td>
															${whProduce.produce.code }
														</td>
														<td>
															${whProduce.produce.goods.name}${whProduce.produce.name }
														</td>
														<td>
															<input id="stockStandard" type="text" data-verify="false" maxlength="5" data-type="item" name="produceLists[0].stockStandard" 
																	class="form-control" value="${whProduce.stockStandard }"/>
														</td>
														<td>
															<input id="stockSafe" type="text" data-verify="false" maxlength="5" data-type="item" name="produceLists[0].stockSafe" 
																	class="form-control" value="${whProduce.stockSafe }"/>
														</td>
														<td>
															<input id="stockWarning" type="text" data-verify="false" maxlength="5" data-type="item" name="produceLists[0].stockWarning" 
																	class="form-control" value="${whProduce.stockWarning }"/>
														</td>
													</tr>
												</c:if>
											</tbody>
										</table>
									</div>
								</div>
								<div class="box-footer">
			    					<div class="pull-left box-tools">
						        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
						        	</div>
			    					<div class="pull-right box-tools">
			    						<c:if test="${empty whProduce.id  }">
						        			<button type="button" class="btn btn-default btn-sm" onclick="resetForm()"><i class="fa fa-refresh"></i>重置</button>
			    						</c:if>
					               		<shiro:hasPermission name="lgt:ps:whProduce:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
						        	</div>
			    				</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
      		<sys:selectmutil id="produceSelect" title="仓库产品选择" url="" isDisableCommitBtn="true" width="1200" height="700" isRefresh="false"></sys:selectmutil>
		</section>
	</div>
<script>
	var warehouseName=null;
	$(function(){
   		// 选择产品
		$("#chooseProduceBtn").on('click',function(){
			if($("#warehouseId").val() == null || $("#warehouseId").val() == ""){
				ZF.showTip("请先选择要监控的仓库！", "info");
				return false;
			}else{
        		$("#produceSelectModalUrl").val("${ctx}/lgt/ps/whProduce/select?warehouse.id="+$("#warehouseId").val()+"&pageKey=whProduceForm")//带参数请求URL设置方式
	        	$("#produceSelectModal").modal('toggle');//显示模态框
			}
		});
		
   		$("#warehouseSpan").on("click",function(){
   			warehouseId=$("#warehouseId").val();
   			warehouseName=$("#warehouseName").val();
   			return false;
   		})
   		
   		//给span绑定click事件,点击删除该行
		$("span[data-type='delBtn']").on("click",function(){
			$(this).parent().parent().remove();
		});
   		
   		$("input[data-type=item]").each(function(){
   			if($(this).val()!=null&&$(this).val()!=undefined&&$(this).val()!=""){
				$(this).attr("data-verify",true);
			}
   		});
   		
   		//给input绑定change事件
		$("input[data-type=item]").on("change",function(){
			ZF.formVerify(true, 4, $(this).val())?$(this).attr("data-verify","true"):$(this).attr("data-verify","false");
			var id=$(this).attr("id");
			if(!ZF.formVerify(true,"4",$(this).val())){
				$(this).addClass("zf-input-err")
				if($("#"+id+"Err").length<=0)
					$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>监控数据不得为空，且必须为正整数</label>")
				$(this).attr("data-verify","false");
			}else{
				if($("#"+id+"Err").length>0){
					$(this).removeClass("zf-input-err");
					$("#"+id+"Err").remove();
					$(this).attr("data-verify","true");
				}
			}
		});
   		
   		
		//点击提交按钮，关闭模态框
		$("#produceSelectModal #commitBtn").on("click",function(){
        	$("#produceSelectModal").modal('toggle');//关闭模态框	
        	var content = $("#produceSelectModalIframe").contents().find("body");
			var produceArray = new Array();
			//先获取数据
			$("input[type=checkBox]", content).each(function(){
				if($(this).prop("checked")){
					var produce = new Array();
    				var produceId = $(this).parent().parent().parent().attr("id");
    				produce.push(produceId);
    				$(this).parent().parent().parent().children('td').each(function(){
    					if($(this).attr("data-type") != "checkbox"){
        					produce.push($(this).text());
    					}
    				});
    				produceArray.push(produce);
				}
			});
			//过滤掉已有数据
			produceArray = checkExsit(produceArray);
			
			var curLen =  $("#tBody").children('tr').length;
			//当produceArray有数据时才遍历
			if(produceArray != null && produceArray!=undefined &&produceArray.length>0){
				//拼接html
				for(var i=0;i<produceArray.length;i++){
					var produce = produceArray[i];
					var html="";
					var index = curLen == 0 ? i : curLen+i;
					html+="<tr data-value='"+produce[0]+"'>";
					for(var j=0;j<produce.length;j++){
						if(j<1){
							html+="<td style='display:none'><input type='hidden' name='produceLists["+index+"].id' value='"+produce[j]+"'/></td>";
						}else if(j<3){
							html+="<td>"+produce[j]+"</td>";
						}else if(j<4){
							html+="<td><input id='"+i+"StockStandard' type='text' data-verify='false' data-type='item' name='produceLists["+index+"].stockStandard' class='form-control' value='"+produce[j]+"'/></td>";
						}else if(j<5){
							html+="<td><input id='"+i+"StockSafe' type='text' data-verify='false' data-type='item' name='produceLists["+index+"].stockSafe' class='form-control' value='"+produce[j]+"'/></td>";
						}else{
							html+="<td><input id='"+i+"StockWarning' type='text' data-verify='false' data-type='item' name='produceLists["+index+"].stockWarning' class='form-control' value='"+produce[j]+"'/></td>";
						}
					}
					html+="<td><span data-type='delBtn' style='display:block;' class='close' title='删除'>&times;</span></td>";
					html+="</tr>";
					$("#tBody").append(html);
				}
				//给span绑定click事件,点击删除该行
				$("span[data-type='delBtn']").on("click",function(){
					$(this).parent().parent().remove();
				});
				$("input[data-type=item]").each(function(){
		   			if($(this).val()!=null&&$(this).val()!=undefined&&$(this).val()!=""){
						$(this).attr("data-verify",true);
					}
		   		});
				//给input绑定change事件
				$("input[data-type=item]").on("change",function(){
					ZF.formVerify(true, 4, $(this).val())?$(this).attr("data-verify","true"):$(this).attr("data-verify","false");
					var id=$(this).attr("id");
					if(!ZF.formVerify(true,"4",$(this).val())){
						$(this).addClass("zf-input-err")
						if($("#"+id+"Err").length<=0)
							$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>监控数据不得为空，且必须为正整数</label>")
						$(this).attr("data-verify","false");
					}else{
						if($("#"+id+"Err").length>0){
							$(this).removeClass("zf-input-err");
							$("#"+id+"Err").remove();
							$(this).attr("data-verify","true");
						}
					}
				});
			}
			
			//清楚check  table缓存
			window.localStorage.removeItem("whProduceForm");
		});
		
	});
	
	//过滤已有数据
	function checkExsit(produceArray){
		for(var i=0;i<produceArray.length;i++){
			$("#tBody").children('tr').each(function(){
				if(produceArray != null && produceArray!=undefined &&produceArray.length>0){
					if(produceArray[i][0]==$(this).attr("data-value")){
						produceArray.splice(i,1);
					}
				}
			})
		}
		return produceArray;
	}
	
	
	
	//当仓库发生改变时，清空所有tr
	function warehouseChange(){
		if($("#tBody").children('tr').length>0){
			confirm("更换仓库将清空已选择的产品","warning",function(){
				$("#tBody").children('tr').remove();
				return false;
			},function(){
				$("#warehouseId").val(warehouseId);
	   			$("#warehouseName").val(warehouseName);
				return false;
			})
		}
	}
	
	function formSubmit(){
		var verify=true;
		if($("#warehouseId").val() == null || $("#warehouseId").val() == ""){
			ZF.showTip("请先选择要监控的仓库！", "info");
			verify=false;
			return false;
		}
		if(!$("#tBody").children('tr').length>0){
			ZF.showTip("请先选择要监控的产品！", "info");
			verify=false;
			return false;
		}else{
			var inputs=$("input[data-verify=false]",$("#tBody"));
			for(var i=0;i<inputs.length;i++){
				$(inputs[i]).trigger('change');
				verify=false;
			}
			//校验监控数据，标准库存>警戒库存>安全库存
			$("#tBody").children('tr').each(function(){
				var inputVals=$(this).children('td').children('input');
				if(parseInt($(inputVals[2]).val())>parseInt($(inputVals[1]).val())){
					$(inputVals[2]).addClass("zf-input-err");
					$(inputVals[1]).addClass("zf-input-err");
					verify=false;
					ZF.showTip("安全库存不得大于标准库存","info");
					$(inputVals[1]).on("change",function(){
						$(this).removeClass("zf-input-err");
						$(inputVals[2]).removeClass("zf-input-err");
					});
					$(inputVals[2]).on("change",function(){
						$(this).removeClass("zf-input-err");
						$(inputVals[1]).removeClass("zf-input-err");
					});
					return false;
				}else if(parseInt($(inputVals[3]).val())>parseInt($(inputVals[2]).val())){
					$(inputVals[3]).addClass("zf-input-err");
					$(inputVals[2]).addClass("zf-input-err");
					verify=false;
					ZF.showTip("警戒库存不得大于安全库存","info");
					$(inputVals[3]).on("change",function(){
						$(this).removeClass("zf-input-err");
						$(inputVals[2]).removeClass("zf-input-err");
					});
					$(inputVals[2]).on("change",function(){
						$(this).removeClass("zf-input-err");
						$(inputVals[3]).removeClass("zf-input-err");
					});
					return false;
				}
				
			})
			
		}
		
		return verify;
	}
	
	function resetForm(){
		$("#tBody").children('tr').remove();
		$("#warehouseId").val("");
		$("#warehouseName").val("");
		return false;
	}
</script>	
</body>
</html>