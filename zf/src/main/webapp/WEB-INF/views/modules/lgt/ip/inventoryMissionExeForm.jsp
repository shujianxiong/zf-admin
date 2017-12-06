<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>盘点任务管理</title>
	<meta name="decorator" content="adminLte"/>
</head>

<body>
	<div class="content-wrapper sub-content-wrapper">
	    <!-- Content Header (Page header) -->
	    <section class="content-header content-header-menu">
	    	<h1>
		        <small>
		        	<i class="fa-list-style"></i><a href="${ctx}/lgt/ip/inventoryMissionExe">我的盘点任务</a>
		        </small>
		        <shiro:hasPermission name="lgt:ip:inventoryMission:edit">
			        <small>|</small>
			        <small class="menu-active">
			        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ip/inventoryMissionExe/form?id=${inventoryMission.id}">盘点任务执行</a>
			        </small>
			     </shiro:hasPermission>
	      	</h1>
	    </section>
	    
	    <sys:tip content="${message}"/>

	    <section class="content">
		    <form:form id="inputForm" onsubmit="return ZF.formSubmit()" modelAttribute="inventoryMission" action="${ctx}/lgt/ip/inventoryMissionExe/save" method="post" class="form-horizontal">
		    <form:hidden path="id"/>
		    <input type="hidden" name="token" value="${token }" />
		    <div class="row">
		    	<div class="col-md-12">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>盘点任务</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <!-- /.box-header -->
						<div class="box-body">
							<div class="col-md-4">
								<div class="form-group">
									<label for="style" class="col-sm-3 control-label">盘点方式</label>
									<div class="col-sm-8">
										<input value="${fns:getDictLabel(inventoryMission.style, 'lgt_ip_inventory_mission_style', '')}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">盘点类型</label>
									<div class="col-sm-8">
										<input value="${fns:getDictLabel(inventoryMission.type, 'lgt_ip_inventory_mission_type', '')}" class="form-control" readonly="readonly"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">盘点仓库</label>
									<div class="col-sm-8">
	  									<input value="${inventoryMission.warehouse.name }" class="form-control" readonly="readonly"/>
									</div>
  								</div>
							</div>
						</div>
		            </div>
	            </div>
            </div>
            
            <div class="box box-soild">
            	<div class="box-header with-border zf-query">
	            	<h5>盘点明细</h5>
	              	<div class="box-tools">
	              		<div class="pull-left">
		                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              		</div>
		            </div>
	            </div>
				<div class="box-body">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th>盘点货位</th>
								<th>系统库存</th>
								<th>盘点库存</th>
								<th>盘点结果</th>
								<th>盘点备注</th>
							</tr>
						</thead>
						<tbody id="builderTbody">
							<c:forEach items="${inventoryMission.inventoryRecordList }" var="record" varStatus="sta">
							<tr id="${record.wareplace.id }">
			   					<td>
					   				${record.wareplace.warecounter.warearea.warehouse.code}-${record.wareplace.warecounter.warearea.code}-${record.wareplace.warecounter.code}-${record.wareplace.code}
					   			</td>
			   					<td>
			   						<c:choose>
			   							<c:when test="${record.status==3 }">${record.systemNum }</c:when>
			   							<c:otherwise>***</c:otherwise>
			   						</c:choose>
								</td>
								<td>
									<c:choose>
			   							<c:when test="${record.status==3 }">${record.inventoryNum }</c:when>
			   							<c:otherwise>
			   								<sys:inputverify id="${record.wareplace.id }_inventoryNum" name="inventoryRecordList[${sta.index }].inventoryNum"  value="${record.inventoryNum }" verifyType="4" tip="请输入正整数或零" maxlength="9" isMandatory="false"/>
										</c:otherwise>
			   						</c:choose>
								</td>
								<td>
									${fns:getDictLabel(record.resultType,'lgt_ip_inventory_record_resultType','') }
								</td>
					   			<td>
					   				<c:choose>
			   							<c:when test="${record.status==3 }">
			   								<span title="${record.inventoryRemarks }">${fns:abbr(record.inventoryRemarks,15)}</span>
			   							</c:when>
			   							<c:otherwise>
			   								<textarea name="inventoryRecordList[${sta.index }].inventoryRemarks" rows="1" maxlength="255" class="form-control">${record.inventoryRemarks }</textarea>
										</c:otherwise>
			   						</c:choose>
					   				<input type="hidden" name="inventoryRecordList[${sta.index }].id" value="${record.id }"/>
					   			</td>
					   		</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
            </div>
            <div class="box zf-box-mul-border">
           		<div class="box-footer">
           			<div class="pull-left box-tools">
		        		<button type="button" class="btn btn-default btn-sm" onclick="window.location.href='${ctx}/lgt/ip/inventoryMissionExe'"><i class="fa fa-mail-reply"></i>返回</button>
		        	</div>
		        	
					<div class="pull-right">
						<c:if test="${inventoryMission.status == 2}">
		               		<button type="submit" class="btn btn-info btn-sm" ><i class="fa fa-mail-forward">提交</i></button>
						</c:if>
	            	</div>
	            </div>
            </div>
		    </form:form>
	    </section>
	</div>
	
   	<script type="text/javascript">
    	
    	// 提交表单
   		function submitForm(){
    		// 验证数据
    		
   			// 验证盘点明细数量
//    			var iRecordTrArr = $("#builderTbody").children();
//    			var showLength = 0;
//    			for(var i=0; i<iRecordTrArr.length; i++){
//    				if($("#"+$(iRecordTrArr[i]).prop("id")+"_delFlag").val()=="0"){
//    					showLength++;
//    				}
//    			}
//    			if(showLength<=0){
//    				alert("请选择要盘点的产品！", "info", null);
//    				return false;
//    			}
   			
   			confirm("确认提交盘点数量？确认后已录入盘点库存数量的明细记录将进入盘点完成状态，对应的盘点货位将解锁！", "info", function(){inputForm.submit();}, null);    				
   		};
   		

   	</script>
</body>
</html>