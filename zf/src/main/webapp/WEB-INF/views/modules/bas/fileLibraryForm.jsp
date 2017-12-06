<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片素材上传</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
	
	function selectBrand(){
		var url="${ctx}/lgt/bs/brand/select";
		$(".modal-title").text("选择商品品牌")
		$("#selectModalUrl").val(url);
		$("#commitBtn").unbind("click");
		$("#commitBtn").on("click",function () {
			var content = $("#selectModalIframe").contents().find("body");
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
    				var id="#brandName"+$(this).val();
    				$("#brandId").val($(this).val())
    				$("#brandInput").val($(id,content).val())
    				$("#selectModal").modal('hide');
				}
			});
		});
		$("#selectModal").modal('toggle');
	}
	
	function selectDesigner(){   
		var url="${ctx}/lgt/bs/designer/select";
		$(".modal-title").text("选择设计师")
		$("#selectModalUrl").val(url);
		$("#commitBtn").unbind("click");
		$("#commitBtn").on("click",function () {
			var content = $("#selectModalIframe").contents().find("body");
			$("input[type=radio]", content).each(function(){
				if($(this).prop("checked")){
    				var id="#designerName"+$(this).val();
    				$("#designerId").val($(this).val())
    				$("#designerInput").val($(id,content).val())
    				$("#selectModal").modal('hide');
				}
			});
		});
		$("#selectModal").modal('toggle');
	}
	
	var propertyData=null;
	
	function createRow(data){
		var temp="<tr><td><select name=\"propertySelect\" class=\"select2\" onchange=\"propertyChange(this)\">$propertyList</select></td>"+
		"<td>请先选择属性名</td>"+
		"<td><span class=\"close\" onclick=\"delRow(this)\" title=\"删除\">&times;</span></td></tr>";
		 
		var options="<option></option>";
		for(var i=0;i<data.length;i++){
			options+="<option data-index="+i+" value="+data[i].id+" data-type="+data[i].valueType+" >"+data[i].propName+"</option>"
		}
		var tempHtml=temp.replace("$propertyList",options);
		return tempHtml;
	}
	
	function addRow(){
		if(propertyData==null){
			ZF.ajaxQuery(true,"${ctx}/lgt/ps/property/findPropertyData","",function(data){
				propertyData=data;
				var tr=createRow(data);
				var trObj=$(tr);
				$("#propvalueListTbody").append(trObj);
				$(".select2",trObj).select2();
			})
		}else{
			var tr=createRow(propertyData);
			var trObj=$(tr);
			$("#propvalueListTbody").append(trObj);
			$(".select2",trObj).select2();
		}
	}
	
	function propertyChange(obj){
		var td=$(obj).parent().next();
		td.html("");
		var option=$(obj).find("option:selected");
		var type=option.attr("data-type");
		var index=option.attr("data-index");
		//输入
		if(type=="0"){
			td.append("<input name=\"valSelect\" type=\"text\" class=\"form-control\" />")
			return;  
		}
		var select=null;
		//单选
		if(type=="1"){
			var tempHtml="<select name=\"valSelect\" class=\"select2\"></select>";
			select=$(tempHtml);
		}
		//多选
		if(type=="2"){
			var tempHtml="<select name=\"valSelect\" multiple class=\"multiSelect\"></select>";
			select=$(tempHtml);
		}
		var valData=propertyData[index].propvalueList;
		var options="";
		for(var i=0;i<valData.length;i++){
			options+="<option value="+valData[i].id+" >"+valData[i].pvalueName+"</option>"
		}
		select.append(options)
		td.append(select)
		select.select2();
	}
	
	function delRow(obj){
		$(obj).parent().parent().remove();
	}
	
	function formSubmit(obj){
		$("input[data-name=propHidden]").remove();//清空所有的预表单项
		var props=$("[name=propertySelect]");
		var vals=$("[name=valSelect]");
		var valInput=$("[name=valInput]");
		var form=$("#inputForm");
		var temp="<input data-name=\"propHidden\" type=\"hidden\" name=\"$postname\" value=\"$val\" />"
		var idx=0;
		for(var i=0;i<props.length;i++){
			var type=$(props[i]).find("option:selected").attr("data-type");
			var propId=$(props[i]).val();
			var propVal=$(vals[i]).val();
			if(propId!=null&&propId.length>0&&propVal!=null&&propVal.length>0){
				if(propVal instanceof Array){
					for(var j=0;j<propVal.length;j++){
						form.append(temp.replace("$postname","fileProps["+idx+"].property.id").replace("$val",propId));
						form.append(temp.replace("$postname","fileProps["+idx+"].propvalue.id").replace("$val",propVal[j]));
						idx++;
					}
				}else{
					form.append(temp.replace("$postname","fileProps["+idx+"].property.id").replace("$val",propId));
					if(type=="0"){
						form.append(temp.replace("$postname","fileProps["+idx+"].pvalue").replace("$val",propVal));
					}else{
						form.append(temp.replace("$postname","fileProps["+idx+"].propvalue.id").replace("$val",propVal));
					}
					idx++;
				}
			}
		}
		return true;
	}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <shiro:hasPermission name="bas:fileLibrary:view"><small><i class="fa-list-style"></i><a href="${ctx}/bas/fileLibrary">图片列表</a></small></shiro:hasPermission>
			<c:choose>
				<c:when test="${empty fileLibrary.opType }">
					<small>|</small>
					<small class="menu-active"><i class="fa fa-repeat"></i><a
						href="${ctx}/bas/fileLibrary/form??id=${fileLibrary.id}&opType=${fileLibrary.opType}">编辑图片</a></small>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${fileLibrary.opType eq '0' }"> 
							<small>|</small>
							<small class="menu-active"><i class="fa fa-repeat"></i><a
								href="${ctx}/bas/fileLibrary/form?opType=0">上传图片</a></small>
							<small>|</small>
							<small><i class="fa-fast-upload"></i><a
								href="${ctx}/bas/fileLibrary/form?opType=1">快速上传图片</a></small>
						</c:when>
						<c:when test="${fileLibrary.opType eq '1' }">
							<small>|</small>
							<small><i class="fa-upload-img"></i><a
								href="${ctx}/bas/fileLibrary/form?opType=0">上传图片</a></small>
							<small>|</small>
							<small class="menu-active"><i class="fa fa-repeat"></i><a
								href="${ctx}/bas/fileLibrary/form?opType=1">快速上传图片</a></small>
						</c:when>
					</c:choose>
				</c:otherwise>
			</c:choose>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	    
	    <section class="content">
	    	<div class="row">
	    		<div class="col-md-6">
	    			<form:form id="inputForm" modelAttribute="fileLibrary" action="${ctx}/bas/fileLibrary/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
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
	    				    <sys:inputtree url="${ctx}/bas/fileDir/treeData" label="文件目录" tip="请选择文件目录" id="fileDir" labelName="fileDir.name" value="${fileDir.id }" labelValue="${fileDir.name }" name="fileDir.id" labelWidth="2" inputWidth="9"></sys:inputtree>
	    					<div class="form-group">
								<label for="" class="col-sm-2 control-label" >文件类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="type" tip="必须选择图片类型" verifyType="0" id="fileLibraryType" dictName="bas_file_library_type" ></sys:selectverify>
								</div>
							</div>
                            
                            <c:if test="${empty fileLibrary.opType or fileLibrary.opType eq '0'}">
								
								<sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="商品分类" tip="请选择分类"  id="category" labelName="category.categoryName" name="category.id" labelWidth="2" inputWidth="9"></sys:inputtree>
								
								<sys:inputtree name="supplier.id" url="${ctx}/lgt/si/supplier/treeData" verifyType="-1"
											id="supplier" label="供应商" labelValue="" labelWidth="2"
											inputWidth="9" labelName="supplier.name" value="" tip="请选择供应商"></sys:inputtree>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >品牌</label>
									<div class="col-sm-9">
										<div class="input-group">
											<form:hidden id="brandId" path="brand.id"/>
											<form:input id="brandInput" path="brand.name" htmlEscape="false" maxlength="50" placeholder="请选择" readOnly="true" class="form-control zf-input-readonly"/>
											<span class="input-group-addon" onclick="selectBrand()"><i class="fa fa-search"></i></span>
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >设计师</label>
									<div class="col-sm-9">
										<div class="input-group">
											<form:hidden id="designerId" path="designer.id"/>
											<form:input id="designerInput" path="designer.name" htmlEscape="false" maxlength="50" placeholder="请选择" readOnly="true" class="form-control zf-input-readonly" onclick="selectDesigner()"/>
											<span class="input-group-addon" onclick="selectDesigner()"><i class="fa fa-search"></i></span>
										</div>
									</div>
								</div>
								
		    					<div class="form-group">
									<label for="searchParam" class="col-sm-2 control-label" >关联属性</label>
									<div class="col-sm-9">
										<table id="contentTable" class="table table-bordered table-hover table-striped">
											<thead>
												<tr>
													<th>属性名</th>
													<th>属性值</th>
													<shiro:hasPermission name="lgt:ps:lgtPsProperty:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
												</tr>
											</thead>
											<tbody id="propvalueListTbody">
												
											</tbody>
											<tfoot>
												<tr>
													<td colspan="4">
														<button type="button" class="btn btn-sm btn-success" onclick="addRow()"><i class="fa fa-plus">增加属性值</i></button>
													</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
                            </c:if>
	    				    <div class="form-group">
	    				    	<label for="" class="col-sm-2 control-label" >图片名称</label>
								<div class="col-sm-9">
									<sys:inputverify isSpring="true" name="name" id="name" verifyType="99" tip="请输入图片名称，必填项" maxlength="50"></sys:inputverify>
								</div>
	    				    </div>
							<div class="form-group">
								<label for="" class="col-sm-2 control-label" >关联图片</label>
								<div class="col-sm-9">
									<%-- <form:hidden id="fileUrl" path="fileUrl" htmlEscape="false" maxlength="255" />
									<sys:ckfinder input="fileUrl" type="images" uploadPath="/fileLibrary" selectMultiple="true" maxWidth="200" maxHeight="200"/> --%>
									
									
									<form:hidden id="fileUrl" path="fileUrl" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="fileUrl" model="true" selectMultiple="true"></sys:fileUpload>
									
								</div>
							</div>
	    				</div>
	    				<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
	    					    <c:if test="${empty fileLibrary.id  }">
					        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
	    					    </c:if>
			               		<shiro:hasPermission name="lgt:ps:lgtPsProperty:edit"><button type="submit" class="btn btn-info btn-sm" onclick="return formSubmit(this)"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
				        	</div>
	    				</div>
	    			</div>
	    			
	    			</form:form>
	    		</div>
	    	</div>
	    </section>
    </div>
    
    <sys:userselect height="550" url="${ctx}/bas/fileDir/treeData"
            width="550" isOffice="true" isMulti="false" title="文件目录选择" isTopSelectable="true"
            id="selectDir"></sys:userselect>
    
    <sys:selectmutil height="600" url="" width="1200" isDisableCommitBtn="true" title="选择" id="select" ></sys:selectmutil>
    <script type="text/javascript">
    	$(function(){
    		var fileProps=${fns:toJson(fileLibrary.fileProps)};
    		
    		function init(){
    			if(fileProps==null||fileProps.length<=0)
    				return;
    			ZF.ajaxQuery(true,"${ctx}/lgt/ps/property/findPropertyData","",function(data){
    				propertyData=data;
    				
    				var arrays=getProperty(fileProps,propertyData);//检索出的已选择属性，已排除多选
    				var temp="<tr><td><select name=\"propertySelect\" class=\"select2\" onchange=\"propertyChange(this)\">$propertyList</select></td>"+
					"<td>$valList</td>"+
					"<td><span class=\"close\" onclick=\"delRow(this)\" title=\"删除\">&times;</span></td></tr>";
					
					console.log(arrays);
					
					for(var i=0;i<arrays.length;i++){
						var options="<option></option>";
						for(var j=0;j<propertyData.length;j++){
							if(propertyData[j].id==arrays[i].id){
								options+="<option data-index="+j+" value="+propertyData[j].id+" data-type="+propertyData[j].valueType+" selected>"+propertyData[j].propName+"</option>"
							}else{
								options+="<option data-index="+j+" value="+propertyData[j].id+" data-type="+propertyData[j].valueType+" >"+propertyData[j].propName+"</option>"
							}
						}
						var tempHtml=temp.replace("$propertyList",options);
						var selectHtml="";
						if(arrays[i].valueType=="0"){
							tempHtml=tempHtml.replace("$valList","<input name=\"valSelect\" type=\"text\" class=\"form-control\" />");
						}else if(arrays[i].valueType=="1"){
							selectHtml="<select name=\"valSelect\" class=\"select2\">$options</select>";
						}else if(arrays[i].valueType=="2"){
							selectHtml="<select name=\"valSelect\" multiple class=\"multiSelect\">$options</select>";
						}
						tempHtml=tempHtml.replace("$valList",selectHtml);
						var valData=arrays[i].propvalueList;
						var options2="";
						for(var x=0;x<valData.length;x++){
							var selected=validatePropval(valData[x],fileProps)?"selected":"";
							options2+="<option value="+valData[x].id+" "+selected+">"+valData[x].pvalueName+"</option>"
						}
						tempHtml=tempHtml.replace("$options",options2);
						$("#propvalueListTbody").append(tempHtml);
					}
					$(".select2").select2();
					$(".multiSelect").select2();
    			})
    		}
    		
    		function getProperty(props,propertyData){
    			var arrays = [], result=[], hash = {};
    		    for (var i = 0, elem; (elem = props[i]) != null; i++) {
    		        if (!hash[elem.property.id]) {
    		        	result.push(elem);
    		            hash[elem.property.id] = true;
    		        }
    		    }
    		    for(var i=0;i<propertyData.length;i++){
					if(hash[propertyData[i].id]){
						arrays.push(propertyData[i]);
					}
				}
    			return arrays;
    		}
    		
    		function validatePropval(valData,fileProps){
    			for(var i=0;i<fileProps.length;i++){
    				if(valData.id==fileProps[i].propvalue.id||valData.pvalue==fileProps[i].pvalue)
						return true;
				}
    			return false
    		}
    		
    		
    		init();
    		
    	})
    	
    	
    	function selectFileDir() {
	        selectDirinit({
	            "selectCallBack" : function(list) {
	                $("#fileDirId").val(list[0].id);
	                $("#fileDirName").val(list[0].text);
	            }
        })
    }
    </script>
</body>
</html>