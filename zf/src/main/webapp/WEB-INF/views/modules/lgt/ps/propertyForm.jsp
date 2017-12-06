<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建属性</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
	
	var id = ${fns:toJson(property.id)};
	function init() {
		if(id.length > 0) {
			$("#propertyValueTypeSelect").prop("disabled", true);
		}
	}
	
	$(function() {
		init();
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
		var categoryData = ${fns:toJson(property.categoryList)};
		var str="";
		var ids="";
		for (var i=0; i<categoryData.length; i++){
			console.log(categoryData[i].categoryName+" : "+categoryData[i].id)
			var addStr=i>0?","+categoryData[i].categoryName:categoryData[i].categoryName;
			var addId=i>0?","+categoryData[i].id:categoryData[i].id;
			str=str+addStr;
			ids=ids+addId;
		}
		$("#categoryName").val(str);
			$("#categoryId").val(ids);
		
		var data = ${fns:toJson(property.propvalueList)};
		for (var i=0; i<data.length; i++){
			addRow('#propvalueListTbody', rowIdx, tpl, data[i]);
			rowIdx = rowIdx + 1;
		}
		
		$(".select2").on("click",function(){
			valueType = $("#propertyValueTypeSelect").val();
		});
		
		$("#propertyValueTypeSelect").on("change",function(){
			if($("#propvalueListTbody").children('tr').length>0){
				confirm("取值类型变更将清空属性值，请确定","warning",function(){
					$("#propvalueListTbody").children('tr').remove();//确定清空表格数据
					return false;
				},function(){
					$("#propertyValueTypeSelect").select2("val",valueType);//取消还原select值
					return false;
				})
			}
		});
	});
	
	function addRow(list, idx, tpl, row){
		if($("#propertyValueTypeSelect").val()==""||$("#propertyValueTypeSelect").val().length<=0){
			ZF.showTip("请选择取值类型","info")
			return;
		}
		if($("#propertyValueTypeSelect").val()=="0"){
			ZF.showTip("输入类型不需要添加属性值","info")
			return;
		}
		$(list).append(Mustache.render(tpl, {
			idx: idx, delBtn: true, row: row
		}));
		$(list+idx).find("select").each(function(){
			$(this).val($(this).attr("data-value"));
		});
		$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
			var ss = $(this).attr("data-value").split(',');
			for (var i=0; i<ss.length; i++){
				if($(this).val() == ss[i]){
					$(this).attr("checked","checked");
				}
			}
		});
	}
	function delRow(obj, prefix){
		var id = $(prefix+"_id");
		var delFlag = $(prefix+"_delFlag");
		if (id.val() == ""){
			$(obj).parent().parent().remove();
		}else if(delFlag.val() == "0"){
			delFlag.val("1");
			$(obj).html("&divide;").attr("title", "撤销删除");
			$(obj).parent().parent().addClass("error");
		}else if(delFlag.val() == "1"){
			delFlag.val("0");
			$(obj).html("&times;").attr("title", "删除");
			$(obj).parent().parent().removeClass("error");
		}
	}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/property/">属性配置列表</a></small>
	        <shiro:hasPermission name="lgt:ps:lgtPsProperty:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/property/form?id=${property.id}">属性${empty property.id ? '添加':'修改' }</a></small></shiro:hasPermission>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	    
	    <section class="content">
	    	<div class="row">
	    		<div class="col-md-6">
	    			<form:form id="inputForm" modelAttribute="property" action="${ctx}/lgt/ps/property/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
	    				<form:hidden path="id"/>
	    				<div class="box box-success">
		    				<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				              <div class="box-tools">
				                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
				                </button>    
				              </div>
		    				</div>
		    				<div class="box-body">
		    					<div class="form-group">
	    							<label class="col-sm-2 control-label">属性名称</label>
									<div class="col-sm-9">
										<sys:inputverify id="propNameInput" name="propName" tip="请输入属性名称，必填项" verifyType="0" isSpring="true" ></sys:inputverify>
									</div>
	    						</div>
	    						
	    						<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >属性类型</label>
									<div class="col-sm-9">
										<sys:selectverify name="propType" tip="必须选择属性类型" verifyType="0" id="propTypeSelect" dictName="lgt_ps_property_propType"></sys:selectverify>
									</div>
								</div>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >适用范围</label>
									<div class="col-sm-9">
										<sys:selectverify name="suitType" tip="必须选择适用范围" verifyType="0" id="suitTypeSelect" dictName="lgt_ps_property_sultType"></sys:selectverify>
									</div>
								</div>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >取值类型</label>
									<div class="col-sm-9">
									    <%-- <c:choose>
									        <c:when test="${empty property.id }"> --%>
									            <sys:selectverify name="valueType" tip="必须选择取值类型" verifyType="0" id="propertyValueTypeSelect" dictName="lgt_ps_property_valueType"></sys:selectverify>
									       <%-- </c:when>
									         <c:otherwise>
									           <form:select id="propertyValueTypeSelect" path="valueType" items="${fns:getDictList('lgt_ps_property_valueType')}" itemLabel="label" itemValue="value" htmlEscape="false" disabled="disabled"></form:select>
									        </c:otherwise>
									    </c:choose> --%>
									</div>
								</div>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >排序序号</label>
									<div class="col-sm-9">
										<sys:inputverify id="orderNoInput" name="orderNo" tip="请输入正确的序号,整数，必填项" maxlength="8" verifyType="4" isSpring="true" ></sys:inputverify>
									</div>
								</div>
								
								<sys:inputtree name="selectCategoryIds" url="${ctx}/lgt/ps/category/categoryData" id="category" isChildrenSelect="true" label="分类选择" labelValue="" labelWidth="2" inputWidth="9" labelName="category.categoryName" verifyType="1" value="" isMultiselect="true" tip="请选择属性关联的分类"></sys:inputtree>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >属性值</label>
									<div class="col-sm-9">
										<table id="contentTable" class="table table-bordered table-hover table-striped">
											<thead>
												<tr>
													<th class="hide"></th>
													<th>属性值</th>
													<th title="前端展示名称">属性值别名</th>
													<th>排列序号</th>
													<shiro:hasPermission name="lgt:ps:lgtPsProperty:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
												</tr>
											</thead>
											<tbody id="propvalueListTbody">
												
											</tbody>
											<tfoot>
												<tr>
													<td colspan="4">
														<button type="button" class="btn btn-sm btn-success" onclick="addRow('#propvalueListTbody', rowIdx, tpl);rowIdx = rowIdx + 1;"><i class="fa fa-plus">增加属性值</i></button>
													</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
								
								<%-- <div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >是否影响价格</label>
									<div class="col-sm-9 zf-check-wrapper-padding">
										<form:radiobuttons path="produceFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" />
									</div>
								</div> --%>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >商品必备属性</label>
									<div class="col-sm-9 zf-check-wrapper-padding">
										<form:radiobuttons path="necessaryFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" />
									</div>
								</div>
								
								<div class="form-group">
                                    <label for="searchParam" class="col-sm-2 control-label" >是否筛选可用</label>
                                    <div class="col-sm-9 zf-check-wrapper-padding">
                                        <form:radiobuttons path="filterFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" />
                                    </div>
                                </div>

								<div class="form-group">
                                    <label for="searchParam" class="col-sm-2 control-label" >是否前台展示</label>
                                    <div class="col-sm-9 zf-check-wrapper-padding">
                                        <form:radiobuttons path="showFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" />
                                    </div>
                                </div>

								<div class="form-group">
                                    <label for="searchParam" class="col-sm-2 control-label" >是否属于展示标题</label>
                                    <div class="col-sm-9 zf-check-wrapper-padding">
                                        <form:radiobuttons path="titleFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" />
                                    </div>
                                </div>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >备注</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
									</div>
								</div>
		    				</div>
	    					<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
		    					     <c:if test="${empty property.id }">
						        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					     </c:if>
				               		<shiro:hasPermission name="lgt:ps:lgtPsProperty:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        	</div>
		    				</div>
	    				</div>
	    			</form:form>
	    		</div>
	    	</div>
	    </section>
	</div>
	<script type="text/template" id="templateScript">//<!--
		<tr id="templateScript{{idx}}">
			<td class="hide">
				<input id="propvalueList{{idx}}_id" name="propvalueList[{{idx}}].id" type="hidden" value="{{row.id}}" />
				<input id="propvalueList{{idx}}_delFlag" name="propvalueList[{{idx}}].delFlag" type="hidden" value="0"/>
			</td>
			<td>
				<input id="propvalueList{{idx}}_pvalueName" name="propvalueList[{{idx}}].pvalueName" type="text" value="{{row.pvalueName}}" class="form-control"/>
			</td>
			<td>
				<input id="propvalueList{{idx}}_pvalueNickname" name="propvalueList[{{idx}}].pvalueNickname" type="text" value="{{row.pvalueNickname}}" class="form-control"/>
			</td>
			<td>
				<input id="propvalueList{{idx}}_orderNo" name="propvalueList[{{idx}}].orderNo" type="text" value="{{row.orderNo}}" class="form-control"/>
			</td>
				<shiro:hasPermission name="lgt:ps:lgtPsProperty:edit"><td class="text-center" width="10">
				{{#delBtn}}<span class="close" onclick="delRow(this, '#propvalueList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
			</td></shiro:hasPermission>
		</tr>//-->
	</script>
	<script type="text/javascript">
		var rowIdx = 0,tpl = $("#templateScript").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
		var valueType;
// 		$(function(){
// 			$('input').iCheck({
// 				checkboxClass : 'icheckbox_minimal-blue',
// 				radioClass : 'iradio_minimal-blue'
// 			});
			
// 			var categoryData = ${fns:toJson(property.categoryList)};
// 			var str="";
// 			var ids="";
// 			for (var i=0; i<categoryData.length; i++){
// 				console.log(categoryData[i].categoryName+" : "+categoryData[i].id)
// 				var addStr=i>0?","+categoryData[i].categoryName:categoryData[i].categoryName;
// 				var addId=i>0?","+categoryData[i].id:categoryData[i].id;
// 				str=str+addStr;
// 				ids=ids+addId;
// 			}
// 			$("#categoryName").val(str);
//   			$("#categoryId").val(ids);
			
// 			var data = ${fns:toJson(property.propvalueList)};
// 			for (var i=0; i<data.length; i++){
// 				addRow('#propvalueListTbody', rowIdx, tpl, data[i]);
// 				rowIdx = rowIdx + 1;
// 			}
			
// 			$(".select2").on("click",function(){
// 				valueType = $("#propertyValueTypeSelect").val();
// 			});
			
// 			$("#propertyValueTypeSelect").on("change",function(){
// 				if($("#propvalueListTbody").children('tr').length>0){
// 					confirm("取值类型变更将清空属性值，请确定","warning",function(){
// 						$("#propvalueListTbody").children('tr').remove();//确定清空表格数据
// 						return false;
// 					},function(){
// 						$("#propertyValueTypeSelect").select2("val",valueType);//取消还原select值
// 						return false;
// 					})
// 				}
// 			});
// 		})
	</script>
</body>
</html>