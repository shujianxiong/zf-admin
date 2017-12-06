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
		        	<i class="fa-list-style"></i><a href="${ctx}/lgt/ip/inventoryMission">盘点任务列表</a>
		        </small>
		        <shiro:hasPermission name="lgt:ip:inventoryMission:edit">
			        <small>|</small>
			        <small class="menu-active">
			        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ip/inventoryMission/form?style=2">新增盘点任务</a>
			        </small>
			    </shiro:hasPermission>
	      	</h1>
	    </section>
	    
	    <sys:tip content="${message}"/>

	    <section class="content">
		    <form:form id="inputForm" modelAttribute="inventoryMission" action="${ctx}/lgt/ip/inventoryMission/save" method="post" class="form-horizontal">
		    <form:hidden path="id"/>
		    <input type="hidden" id="submitType" name="submitType" value="save" />
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
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label for="style" class="col-sm-3 control-label">盘点方式</label>
										<div class="col-sm-7">
											<form:select id="style" path="style" htmlEscape="false" maxlength="50" class="form-control select2" disabled="true">
												<form:option value="2" label="按位置盘" />
											</form:select>
											<input type="hidden" name="style" value="2"/>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="type" class="col-sm-3 control-label">盘点类型</label>
										<div class="col-sm-7">
											<form:select id="type" path="type" htmlEscape="false" maxlength="50" class="form-control select2">
												<form:option value="" label="请选择"/>
												<form:options items="${fns:getDictList('lgt_ip_inventory_mission_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
											</form:select>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<sys:inputtree id="warehouse" name="warehouse.id" onchange="warehouseOnchange" url="${ctx}/lgt/ps/warehouse/warehouseListData" inputWidth="7" labelWidth="3" label="盘点仓库" labelValue="" labelName="warehouse.name" value="" tip="请选择仓库" title="盘点仓库"></sys:inputtree>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="col-sm-3 control-label">备注信息</label>
										<div class="col-sm-7"> 
											<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
										</div>
									</div>
								</div>
							</div>
						</div>
		            </div>
	            </div>
            </div>
            
            <div class="box box-soild">
            	<div class="box-header with-border zf-query">
	            	<h5>位置盘点明细</h5>
	              	<div class="box-tools">
	              		<div class="pull-left">
		                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	              		</div>
		            </div>
	            </div>
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 pull-right">
							<div class="col-md-4">
								<sys:inputtree id="warearea" name="" url="${ctx}/lgt/ps/warearea/wareareaListData" postParam="{postName:[\"warehouse.id\"],inputId:[\"warehouseId\"]}" isQuery="true" inputWidth="7" labelWidth="3" label="盘点仓库区域" labelValue="" labelName="" value="" tip="请选择仓库区域" title="盘点仓库区域"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<sys:inputtree id="warecounter" name="" url="${ctx}/lgt/ps/warecounter/warecounterListData" postParam="{postName:[\"warearea.id\"],inputId:[\"wareareaId\"]}" isQuery="true" inputWidth="7" labelWidth="3" label="盘点货柜" labelValue="" labelName="" value="" tip="请选择货柜" title="盘点货柜"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="type" class="col-sm-3 control-label">盘点人</label>
									<div class="col-sm-7">
										<input id="inventoryUserBtn" type="text" data-value="" value="" placeholder="请选择盘点人" class="form-control zf-input-readonly" readonly="readonly"/>
									</div>
									<div class="col-sm-2" style="padding-left: 0px;">
										<button type="button" class="btn btn-success btn-sm" onclick="addRecord()"><i class="fa fa-plus">追加</i></button>
									</div>
								</div>
							</div>
						</div>
					</div>
            		<div class="table-reponsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>盘点货位</th>
									<!-- 
									<th>存放产品编码</th> -->
									<th>货位库存</th>
									<th>盘点人</th>
									<th width="10">&nbsp;</th>
								</tr>
							</thead>
							<tbody id="builderTbody">
								<c:forEach items="${inventoryMission.inventoryRecordList }" var="record" varStatus="sta">
								<tr id="${record.wareplace.id }">
				   					<td>
						   				${record.wareplace.warecounter.warearea.warehouse.name}
						   				-${record.wareplace.warecounter.warearea.name}
						   				-${record.wareplace.warecounter.code}
						   				-${record.wareplace.code}
						   				<input id="${record.wareplace.id }_wid" type="hidden" name="inventoryRecordList[${sta.index }].wareplace.id" value="${record.wareplace.id }"/>
						   			</td>
				   					<td>${record.systemNum}</td>
						   			<td>
						   				<span id="${record.wareplace.id }_userNameSpan">${fns:getUserById(record.inventoryUser.id).name}</span>
						   				<input type="hidden" id="${record.wareplace.id }_uid" name="inventoryRecordList[${sta.index }].inventoryUser.id" data-type="uidHidden" data-set="1" value="${record.inventoryUser.id }"/>
						   			</td>
						   			<td>
						   				<span data-type="hideBtn" class="close" title="删除" style="display:block;float: left;" onclick="recordTrHide('${record.wareplace.id }');">&times;</span>
						   				<input type="hidden" name="inventoryRecordList[${sta.index }].id" value="${record.id }"/>
						   				<input type="hidden" name="inventoryRecordList[${sta.index }].inventoryMission.id" value="${record.inventoryMission.id }"/>
						   				<input type="hidden" id="${record.wareplace.id }_delFlag" name="inventoryRecordList[${sta.index }].delFlag" value="${record.delFlag }"/>
						   			</td>
						   		</tr>
								</c:forEach>
							</tbody>
						</table>
            		</div>
				</div>
            </div>
            
            <div class="box zf-box-mul-border">
           		<div class="box-footer">
           			<div class="pull-left box-tools">
		        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
		        	</div>
   					<div class="pull-right box-tools">
		            	<button type="button" class="btn btn-info btn-sm" onclick="submitForm('save')"><i class="fa fa-save">保存</i></button>
		        	</div>
	            </div>
            </div>
            
		    </form:form>
	    </section>
	    <sys:userselect id="inventoryUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>

	</div>
	
   	<script type="text/javascript">
    	$(function(){
    		
       		// 设置盘点人(弹出公司人员选择树)
    		$("#inventoryUserBtn").on('click',function(){
    			// 选择数据后的回调方法
			   	inventoryUserinit({
			   		"selectCallBack":function(list){
		   				if(list.length>0){
	 				   		$("#inventoryUserBtn").attr("data-value",list[0].id);
	 			   			$("#inventoryUserBtn").val(list[0].text);
 				   		}
					}
				});
    		});
    	});
    	
    	// 提交表单
   		function submitForm(stype){
    		// 验证数据
   			if($("#warehouseId").val() == null || $("#warehouseId").val() == ""){
   				alert("请选择要盘点的仓库！", "info", null);
   				return false;
   			}
   			if($("#type").select2("val") == null || $("#type").select2("val") == ""){
   				alert("请选择盘点类型！", "info", null);
   				return false;
   			}
   			// 验证盘点明细数量
   			var iRecordTrArr = $("#builderTbody").children();
   			var showLength = 0;
   			for(var i=0; i<iRecordTrArr.length; i++){
   				if($("#"+$(iRecordTrArr[i]).prop("id")+"_delFlag").val()=="0"){
   					showLength++;
   				}
   			}
   			if(showLength<=0){
   				alert("请选择要盘点的货位！", "info", null);
   				return false;
   			}
   			
   			$("#submitType").val(stype);
   			inputForm.submit();
   		};
   		
   		
   		// 追加
   		function addRecord(){
   			var inventoryUserId = $("#inventoryUserBtn").attr("data-value");	// 盘点人ID
   			var inventoryUserName = $("#inventoryUserBtn").val();				// 盘点人姓名
   			if(inventoryUserId == null || inventoryUserId==""){
   				ZF.showTip("请先设置盘点人！","info");
   				return false;
   			}
   			var warehouseId = $("#warehouseId").val();
   			var wareareaId = $("#wareareaId").val();
   			var warecounterId = $("#warecounterId").val();
   			var url="${ctx}/lgt/ps/wareplace/findWareplaceByProduceAndPosition";
   			var data={"warecounter.warearea.warehouse.id":warehouseId, "warecounter.warearea.id":wareareaId, "warecounter.id":warecounterId};
   			// 根据货柜ID/仓库区域ID/仓库ID，查询货位信息
   			ZF.ajaxQuery(true,url,data,function(data){
   				var inventoryUserId = $("#inventoryUserBtn").attr("data-value");	// 盘点人ID
   	   			var inventoryUserName = $("#inventoryUserBtn").val();				// 盘点人姓名
   				var wareplaceArr = JSON.parse(data);
				var iRecordTrArr = $("#builderTbody").children();
				var trCount = iRecordTrArr.length;
				var appendHtml = ""; 
				for(var i=0; i<wareplaceArr.length; i++){
					// 当前要添加的盘点产品货位数据是否已存在
					var existFlag = false;
					for(var j=0; j<trCount; j++){
						if($(iRecordTrArr[j]).prop("id")==wareplaceArr[i].id){
							existFlag = true;
							// 显示隐藏的行（并更新该行盘点人）
 							if($("#"+$(iRecordTrArr[j]).prop("id")+"_delFlag").val() == "1"){
								// 设置当前已存在的行
 								$("#"+$(iRecordTrArr[j]).prop("id")+"_userNameSpan").html(inventoryUserName);
 								$("#"+$(iRecordTrArr[j]).prop("id")+"_uid").val(inventoryUserId);
								$(iRecordTrArr[j]).show();
							   	$("#"+$(iRecordTrArr[j]).prop("id")+"_delFlag").val("0");
 							}
						}
					}
					if(!existFlag){
					   	appendHtml	+=
					   		"<tr id=\""+wareplaceArr[i].id+"\">"+
					   			"<td>"+
					   				wareplaceArr[i].warecounter.warearea.warehouse.code+
					   				"-"+wareplaceArr[i].warecounter.warearea.code+
					   				"-"+wareplaceArr[i].warecounter.code+
					   				"-"+wareplaceArr[i].code+
					   				"<input id=\""+wareplaceArr[i].id+"_wid\" type=\"hidden\" name=\"inventoryRecordList["+trCount+"].wareplace.id\" value=\""+wareplaceArr[i].id+"\"/>"+
					   			"</td>"+
					   			//"<td>"+wareplaceArr[i].produce.code+"</td>"+
					   			"<td>"+wareplaceArr[i].stock+"</td>"+
					   			"<td>"+
					   				"<span id=\""+wareplaceArr[i].id+"_userNameSpan\">"+inventoryUserName+"</span>"+
					   				"<input id=\""+wareplaceArr[i].id+"_uid\" type=\"hidden\" name=\"inventoryRecordList["+trCount+"].inventoryUser.id\" data-type=\"uidHidden\" data-set=\"0\" value=\""+inventoryUserId+"\"/>"+
					   			"</td>"+
					   			"<td>"+
					   				"<span data-type=\"delBtn\" onclick=\"recordTrDel('"+wareplaceArr[i].id+"');\" class=\"close\" title=\"删除\" style=\"display:block;float: left;\">&times;</span>"+
					   				"<input type=\"hidden\" id=\""+wareplaceArr[i].id+"_delFlag\" name=\"inventoryRecordList["+trCount+"].delFlag\" value=\"0\"/>"
					   			"</td>"+
					   		"</tr>";
					   	trCount++;
					}
				}
				$("#builderTbody").append(appendHtml);
   			},function(){
   				alert(data.msg, "info", null);
   			});
   		}
   		
   		// 隐藏盘点明细，并设置产品盘点明细为删除状态（delFlag=1）
   		function recordTrHide(wid){
		   	$("#"+wid).hide();
		   	$("#"+wid+"_delFlag").val("1");
		   	resetTrNameIndex();
   		}
   		// 删除盘点明细（删除明细对应的tr）
   		function recordTrDel(wid){
		   	$("#"+wid).remove();
		   	resetTrNameIndex();
   		}
   		
   		// 重置页面某行盘点记录的各隐藏域的name的序号(删除某条盘点记录时调用)
   		function resetTrNameIndex(){
   			var iRecordTrArr = $("#builderTbody").children();
			for(var i=0; i<iRecordTrArr.length; i++){
				$("#"+$(iRecordTrArr[i])[0].id+"_wid").prop("name","inventoryRecordList["+i+"].wareplace.id");
				$("#"+$(iRecordTrArr[i])[0].id+"_uid").prop("name","inventoryRecordList["+i+"].inventoryUser.id");
				$("#"+$(iRecordTrArr[i])[0].id+"_delFlag").prop("name","inventoryRecordList["+i+"].delFlag");
			}
   		}
   		
   		// 盘点仓库变动时的方法调用
   		function warehouseOnchange(){
   			// 清空仓库区域、货柜赛选条件
   			$("#wareareaId").val("");
			$("#wareareaName").val("");
			$("#warecounterId").val("");
			$("#warecounterName").val("");
			// 清空盘点记录
			$("span[data-type=hideBtn]").click();
			$("span[data-type=delBtn]").click();
   		}
   	</script>
</body>
</html>