<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品出库管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#productCode").on("change", function(){
				productCodeChange();
			});
		});
		// 货品编码检测状态
		var pcodeCheckFlag = false;
		
		// 变更货品编码
		function productCodeChange(){
			pcodeCheckFlag = false;
		}
		
		//检测货品是否可进行出库操作
		function checkProductWpIoOut(){
			pcodeCheckFlag = false;
			
			var url="${ctx}/lgt/ps/product/checkProductWpIoOut";
			var data={"pcode":$("#productCode").val()};
			ZF.ajaxQuery(true,url,data,
				function(data){
					// 隐藏遮罩
					$("#loading").hide();
					var dataArr = data.split(":");
					if(dataArr[0] == "success"){
						pcodeCheckFlag = true;
						ZF.showTip(dataArr[1],"success");
					}else {
						ZF.showTip(dataArr[1],"danger");
					}
				},
				function(){
					$("#loading").attr("display","none")
					$.jBox.tip(data.msg, 'error',{
						timeout:1500
					});
				}
			);
		}
		
		// 提交表单
		function submitForm(){
			if($("#ioReasonType").val() == null || $("#ioReasonType").val() == ""){
				ZF.showTip("请选择操作原因类型！","warning");
				return false;
			}
			if(!pcodeCheckFlag){
				ZF.showTip("请检测货品编码以确认该货品是否可出库！","warning");
				return false;
			}
			$("#inputForm").submit();
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	    <section class="content-header content-header-menu">
	    	<h1>
		        <small>
		        	<i class="fa-list-style"></i><a href="${ctx}/lgt/ps/productWpIo/">货品出入库记录列表</a>
		        </small>
		        <small>|</small>
		        <small>
		        	<i class="fa-in-house"></i><a href="${ctx}/lgt/ps/productWpIo/inForm">货品入库</a>
		        </small>
		        <small>|</small>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/productWpIo/outForm">货品出库</a>
		        </small>
	      	</h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	    
	    <section class="content">
			<form:form id="inputForm" onsubmit="return ZF.formSubmit()" modelAttribute="productWpIo" action="${ctx}/lgt/ps/productWpIo/outSave" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="row">
		    	<div class="col-md-6">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>货品入库</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">操作原因类型</label>
								<div class="col-sm-9">
									<form:select path="ioReasonType" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:option value="" label="请选择"/>
										<form:options items="${outDictList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
    						</div>
    						
    						<div class="form-group">
    							<label class="col-sm-2 control-label">货品编码</label>
								<div class="col-sm-9">
									<div class="input-group">
										<sys:inputverify id="productCode" name="product.code" maxlength="50" tip="请输入货品编码，必填项" verifyType="0" isSpring="true" isMandatory="true"/>
										<span class="input-group-addon" onclick="checkProductWpIoOut();"><i class="fa fa-check-square-o"></i></span>
									</div>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">操作人</label>
								<div class="col-sm-9">
									<input type="hidden" id="ioUserId" name="ioUser.id"/>
									<sys:inputverify id="ioUserInput" name="" tip="请选择操作人" verifyType="0" isSpring="true" isMandatory="false" forbidInput="true"></sys:inputverify>
									<sys:userselect id="ioUser" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">操作时间</label>
								<div class="col-sm-9">
									<sys:datetime id="ioTime" inputId="ioTime" inputName="ioTime" tip="操作时间" isMandatory="false"></sys:datetime>
								</div>
    						</div>
			            	<div class="form-group">
    							<label class="col-sm-2 control-label">来源业务单号</label>
								<div class="col-sm-9">
									<sys:inputverify id="ioBusinessorderId" name="ioBusinessorderId" tip="请输入来源业务单号" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
    						</div>
    						<div class="form-group">
    							<label class="col-sm-2 control-label">备注信息</label>
								<div class="col-sm-9">
									<textarea name="remarks" rows="4" maxlength="255" class="form-control input-xxlarge"></textarea>
								</div>
    						</div>
						</div>
						<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
			               		<button type="button" onclick="submitForm()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
				        	</div>
	    				</div>
		            </div>
	            </div>
            </div>
            </form:form>
        </section>
	</div>
	
	<script type="text/javascript">
    	$(function(){
    		// 设置操作人(弹出公司人员选择树)
    		$("#ioUserInput").on('click',function(){
    			ioUserinit({
				   	"selectCallBack":function(list){
		   				if(list.length>0){
							$("#ioUserId").val(list[0].id);
 				   			$("#ioUserInput").val(list[0].text);
 				   		}
					}
				});
    		});
    	});
	</script>
	
</body>
</html>