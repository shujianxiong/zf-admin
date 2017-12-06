<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品货位调整</title>
	<meta name="decorator" content="adminLte"/>
	
	<script type="text/javascript">
	   
	 String.prototype.startWith=function(str){  
         if(str==null||str==""||this.length==0||str.length>this.length)  
           return false;  
         if(this.substr(0,str.length)==str)  
           return true;  
         else  
           return false;  
         return true;  
     }  
	
     var data = ${fns:getDictListJson('lgt_ps_product_wp_change_reasonType')};
     var uList = new Array();
     var sList = new Array();
     for(var i=0; i<data.length; i++) {
	     var type = data[i].value;
	     if(type.startWith('U')) {
		    uList.push(data[i]);
	     } else {
		    sList.push(data[i]);
	     }
     }
	   
	   $(function() {
		   //组装操作原因类型数据 
		   var chid = "${productWpChange.id}"; 
		   var reasonType = "${productWpChange.reasonType}";
		   var html = "";
		   if(chid == "" || chid == null || reasonType.startWith('U')) {
			   html += "<option value='-1'>请选择</option>";
			   for(var i=0;i<uList.length;i++) {
				   html += "<option value='"+uList[i].value+"'>"+uList[i].label+"</option>";
			   }
			   $("#reasonType").html(html);
			   $("#reasonType").select2("val", "-1");
		   } else if(reasonType.startWith('S')) {
			   html += "<option value='-1'>请选择</option>";
	           for(var i=0;i<sList.length;i++) {
	               html += "<option value='"+sList[i].value+"'>"+sList[i].label+"</option>";
	           }
	           html += "</select>";
	           $("#reasonType").html(html);
	           $("#reasonType").select2("val", "-1");
		   }
	   });
	   
	</script>
</head>

<body>
	<div class="content-wrapper sub-content-wrapper">
	    <section class="content-header content-header-menu">
			<h1>
				<small><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/productWpChange/form?id=${productWpChange.id}">货品货位调整</a></small>
			</h1>
		</section>
	    
	    <sys:tip content="${message}"/>
		<section class="content">
			<form:form id="inputForm"  modelAttribute="productWpChange" action="${ctx}/lgt/ps/productWpChange/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="row">
		    	<div class="col-md-6">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>货品货位调整</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">操作原因类型</label>
								<div class="col-sm-9">
								    <select id="reasonType" name="reasonType" class="form-control select2">
								    
								    </select>
								</div>
    						</div>
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">货品编码</label>
								<div class="col-sm-9">
									<div class="input-group">
										<input type="hidden" id="productId" name="product.id"/>
										<input type="text" readonly="readonly" value="${productWpChange.product.code}" maxlength="50" class="form-control" r/>
									</div>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">货品当前货位</label>
								<div class="col-sm-9">
									<input id="preWareplace"  type="text"   readonly="readonly" class="form-control"/>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">货品当前持有人</label>
								<div class="col-sm-9">
									<input id="preHoldUser"  type="text"   readonly="readonly" class="form-control"/>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">调后存放类型</label>
								<div class="col-sm-9">
									<c:forEach items="${fns:getDictList('lgt_ps_product_wp_change_postType')}" var="type" varStatus="status">
				                  		<input type="radio" name="postType" value="${type.value }"
				                  			<c:if test="${status.index==0}"> checked=checked</c:if>
				                  		/>${type.label }
				                  	</c:forEach>
								</div>
    						</div>
							<sys:inputtree id="postWarehouse" 	name="" 				url="${ctx}/lgt/ps/warehouse/warehouseListData" 	postParam="" onchange="warehouseOnchange" 									isQuery="false"	inputWidth="9" labelWidth="2" label="调整后仓库" labelValue="" labelName="" value="" tip="请选择仓库，必填项" title="调整后仓库"></sys:inputtree>
    						<sys:inputtree id="postWarearea" 	name="" 				url="${ctx}/lgt/ps/warearea/wareareaListData" 		postParam="{postName:[\"warehouse.id\"],inputId:[\"postWarehouseId\"]}" 	isQuery="true" 	inputWidth="9" labelWidth="2" label="调整后区域" labelValue="" labelName="" value="" tip="请选择区域，必填项" title="调整后区域"></sys:inputtree>
    						<sys:inputtree id="postWarecounter"	name="" 				url="${ctx}/lgt/ps/warecounter/warecounterListData"	postParam="{postName:[\"warearea.id\"],inputId:[\"postWareareaId\"]}" 		isQuery="true" 	inputWidth="9" labelWidth="2" label="调整后货柜" labelValue="" labelName="" value="" tip="请选择货柜，必填项" title="调整后货柜"></sys:inputtree>
    						<sys:inputtree id="postWareplace" 	name="postWareplace.id"	url="${ctx}/lgt/ps/wareplace/wareplaceListData" 	postParam="{postName:[\"warecounter.id\"],inputId:[\"postWarecounterId\"]}" isQuery="true" 	inputWidth="9" labelWidth="2" label="调整后货位" labelValue="" labelName="" value="" tip="请选择货位，必填项" title="调整后货位"></sys:inputtree>
    						
    						<div class="form-group" id="postHoldUserDiv" style="display: none;">
    							<label class="col-sm-2 control-label">调整后持有人</label>
								<div class="col-sm-9">
									<input type="hidden" id="postHoldUserId" name="postHoldUser.id"/>
									<sys:inputverify id="postHoldUserInput" name="" tip="请选择操作人" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
									<sys:userselect id="postHoldUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<textarea name="remarks" rows="4" maxlength="255" class="form-control input-xxlarge"></textarea>
								</div>
    						</div>
						</div>
		            </div>
	            </div>
            </div>
            </form:form>
        </section>
	</div>
   	<script type="text/javascript">
   		var pcodeCheckFlag = false;
   		var radioVal = "wareplace";
    	$(function(){
    		// radio样式
    		$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
    		
    		// 货品编码change事件绑定
    		$("#productCode").on("change", function(){
				productCodeChange();
			});
    		
    		// 调后存放类型
    		$("input[type='radio'][name='postType']").on("ifChecked",function(event){
    			var checkCompent = $(this);
    			var checkedVal = checkCompent.val();
    			radioVal = checkedVal;
	    		if(checkedVal == "wareplace"){
	    			$("#postWarehousetreeInput").show();
	    			$("#postWareareatreeInput").show();
	    			$("#postWarecountertreeInput").show();
	    			$("#postWareplacetreeInput").show();
    				$("#postHoldUserDiv").hide();
    				$("#postHoldUser").val("");
    			}else if(checkedVal == "holduser"){
    				$("#postWarehousetreeInput").hide();
	    			$("#postWareareatreeInput").hide();
	    			$("#postWarecountertreeInput").hide();
	    			$("#postWareplacetreeInput").hide();
    				$("#postHoldUserDiv").show();
    				$("#postWareplaceId").val("");
    				
    			}
    		});
    		
    		// 设置调后持有人(弹出公司人员选择树)
    		$("#postHoldUserInput").on('click',function(){
    			postHoldUserinit({
				   	"selectCallBack":function(list){
		   				if(list.length>0){
							$("#postHoldUserId").val(list[0].id);
 				   			$("#postHoldUserInput").val(list[0].text);
 				   		}
					}
				});
    		});
    		
    		
    	});
    	
    	// 货品编码change
    	function productCodeChange(){
    		pcodeCheckFlag = false;
    	}
    	
    	// 货品编码检测
    	function checkProduct(){

    	}
    	
   		// 仓库变动时的方法调用
   		function warehouseOnchange(){
   			// 清空仓库区域、货柜、货位
   			$("#postWareareaId").val("");
			$("#postWareareaName").val("");
			$("#postWarecounterId").val("");
			$("#postWarecounterName").val("");
			$("#postWareplaceId").val("");
			$("#postWareplaceName").val("");
   		}

    	
   		// 提交表单
   		function submitForm(){
   			// 操作原因类型
   			if($("#reasonType").val() == null || $("#reasonType").val() == "" || $("#reasonType").val() == "-1"){
				ZF.showTip("请选择操作原因类型！","danger");	
				return;
			}
   			
   			// 货品编号
   			if(!pcodeCheckFlag){
   				ZF.showTip("请录入货品编号并检测对应的货品可进行货位调整操作！","danger");	
					return;
   			}
   			
   			// 调后存放类型 && 调整后存放位置
   			if(radioVal == "wareplace"){
   				if($("#postWarehouseId").val() == null || $("#postWarehouseId").val() == ""){
   					ZF.showTip("请选择调整后仓库！","danger");	
   					return;
   				}else if($("#postWareareaId").val() == null || $("#postWareareaId").val() == ""){
   					ZF.showTip("请选择调整后区域！","danger");	
   					return;
   				}else if($("#postWarecounterId").val() == null || $("#postWarecounterId").val() == ""){
   					ZF.showTip("请选择调整后货柜！","danger");	
   					return;
   				}else if($("#postWareplaceId").val() == null || $("#postWareplaceId").val() == ""){
   					ZF.showTip("请选择调整后货位！","danger");	
   					return;
   				}
			}else if(radioVal == "holduser" && $("#postHoldUserId").val() == null || $("#postHoldUserId").val() == ""){
				ZF.showTip("请选择调整后持有人！","danger");	
				return;
			}

			confirm("确认后货品货位或持有人数据将变更，是否确认调整货品货位？","warning",function(){
				$("#inputForm").submit();
			});
   		}
   		
   		
   		
   		function resetForm() {
   			ZF.resetForm();
   			$("#reasonType").select2("val", "-1");
   		}
	</script>
</body>
</html>