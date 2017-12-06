<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片素材库</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
	
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
    	return false;
    }
	
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
	
	function delAll(id){
		confirm("确认删除该图片吗？","warning", function(){
			if(id!=null&&id.length>0){
				$("#searchForm").append("<input type=\"hidden\" name=\"fileLibrarys\" value="+id+">");
				searchForm.action="${ctx}/bas/fileLibrary/delete";
				searchForm.submit();
				return;
			}
			$("[name=fileLibrarys]").remove();
			var arrays=$("input[type=checkBox]:checked");
			if(arrays.length<=0){
				ZF.showTip("请选择您要删除的图片","info")
				return;
			}
			for(var i=0;i<arrays.length;i++){
				var hidden="<input type=\"hidden\" name=\"fileLibrarys\" value="+$(arrays[i]).val()+">"
				$("#searchForm").append(hidden);
			}
			searchForm.action="${ctx}/bas/fileLibrary/delete";
			searchForm.submit();
		});
		
	}
	
	function edit(id){
		if(id!=null&&id.length>0){
			$("#fileLibraryId").val(id)
			searchForm.action="${ctx}/bas/fileLibrary/editForm";
			searchForm.submit();
			return;
		}
		var arrays=$("input[type=checkBox]:checked");
		if(arrays.length<=0){
			ZF.showTip("请选择您要修改的图片","info")
			return;
		}
		if(arrays.length!=1){
			ZF.showTip("不支持批量修改功能","info")
			return;
		}
		$("#fileLibraryId").val($(arrays[0]).val())
		searchForm.action="${ctx}/bas/fileLibrary/editForm";
		searchForm.submit();
	}
	
	function checkAll(obj){
		if($(obj).attr("data-check")=="0"){
			$(obj).attr("data-check","1");
			$("input[type=checkBox]").iCheck('check');
		}else{
			$(obj).attr("data-check","0");
			$("input[type=checkBox]").iCheck('uncheck')
		}
	}
	
	function search(){
		searchModal
	}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bas/fileLibrary">图片列表</a></small>
	        <shiro:hasPermission name="bas:fileLibrary:view">
		       <small>|</small>
	           <small><i class="fa-upload-img"></i><a href="${ctx}/bas/fileLibrary/form?opType=0">上传图片</a></small>
	           <small>|</small>
	           <small><i class="fa-fast-upload"></i><a href="${ctx}/bas/fileLibrary/form?opType=1">快速上传图片</a></small>
	        </shiro:hasPermission>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<form:form id="searchForm" modelAttribute="fileLibrary" action="${ctx}/bas/fileLibrary" method="post" class="form-horizontal">
	    	<form:hidden id="fileLibraryId" path="id"/>
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
				<div class="box-body">
					<div class="row">
					    
					    <div class="col-md-4">
					        <sys:inputtree url="${ctx}/bas/fileDir/treeData" label="文件目录" tip="请选择文件目录" id="fileDir" labelName="fileDir.name" name="fileDir.id" labelWidth="3" inputWidth="7"></sys:inputtree>
                        </div>
					    
					    <div class="col-md-4">
                            <sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="商品分类" tip="请选择分类" id="category" labelName="category.categoryName" name="category.id" labelWidth="3" inputWidth="7"></sys:inputtree>
                        </div>
					    
						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-3 control-label" >开始时间</label>
								<div class="col-sm-7">
									<sys:datetime id="beginTimeDiv" inputName="searchParameter.starTime" tip="请选择上传开始时间" value="${fileLibrary.searchParameter.starTime }" inputId="starTime"></sys:datetime>
								</div>
							</div>
						</div>
						
					</div>
					<div class="row">
					       
					    <div class="col-md-4">
                            <div class="form-group">
                                <label for="searchParam" class="col-sm-3 control-label" >截止时间</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="endTimeDiv" inputName="searchParameter.endTime" tip="请选择上传结束时间" value="${fileLibrary.searchParameter.endTime }" inputId="endTime"></sys:datetime>
                                </div>
                            </div>
                        </div>
					   
						<div class="col-md-4">
							<sys:inputtree name="supplier.id" url="${ctx}/lgt/si/supplier/treeData"
										id="supplier" label="供应商" labelValue="" labelWidth="3" 
										inputWidth="7" labelName="supplier.name" value="" tip="请选择供应商"></sys:inputtree>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-3 control-label" >品牌</label>
								<div class="col-sm-7">
									<div class="input-group">
										<form:hidden id="brandId" path="brand.id"/>
										<form:input id="brandInput" path="brand.name" htmlEscape="false" maxlength="50" placeholder="请选择" readOnly="true" class="form-control zf-input-readonly"/>
										<span class="input-group-addon" style="cursor:pointer;" onclick="selectBrand()"><i class="fa fa-search"></i></span>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					<div class="row">
					   <div class="col-md-4">
                            <div class="form-group">
                                <label for="searchParam" class="col-sm-3 control-label" >设计师</label>
                                <div class="col-sm-7">
                                    <div class="input-group">
                                        <form:hidden id="designerId" path="designer.id"/>
                                        <form:input id="designerInput" path="designer.name" htmlEscape="false" maxlength="50" placeholder="请选择" readOnly="true" class="form-control zf-input-readonly" onclick="selectDesigner()"/>
                                        <span class="input-group-addon" style="cursor:pointer;" onclick="selectDesigner()"><i class="fa fa-search"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
					</div>
				</div>
				
				<div class="box-footer">
					<div class="pull-left box-tools">
        		 		<button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#searchModal"><i class="fa fa-search-plus"></i>高级筛选</button>
		        	</div>   
		        	<div class="pull-right box-tools">
        		 		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm();resetSearch();"><i class="fa fa-refresh"></i>重置</button>
	               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
		        	</div>
	            </div>
			</div>
			</form:form>
			
			<div class="box box-soild">
				<div class="box-herder with-border">
					
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 pull-right">
				          	<shiro:hasPermission name="lgt:ps:product:edit">
				          		<button type="button" class="btn btn-sm btn-default" data-check="0" onclick="checkAll(this)" ><i class="fa fa-check-square">全选</i></button>
					            <button type="button" class="btn btn-sm btn-default" onclick="delAll()" ><i class="fa fa-remove">批量删除</i></button>
					            <button type="button" class="btn btn-sm btn-default" onclick="edit()" ><i class="fa fa-edit">修改</i></button>
				            </shiro:hasPermission>
						</div>
					</div>
				 	<ul class="nav nav-tabs">
				 		<c:forEach items="${page.list}" var="fileLibrary" varStatus="status">
				 			<li class="zf-img-list" onmousemove="$(this).children()[0].style.display='block'" onmouseout="$(this).children()[0].style.display='none'">
				 				<div style="position: absolute;bottom:0;width:100%;height:40px;background:rgba(0,0,0,0.3);color:#fff;font-size:12px;display:none">
				 					<div style="cursor:pointer;float:left;line-height:40px;text-align:center;width:50%;box-sizing:border-box;border-right:1px solid #D2D1D1" onclick="edit('${fileLibrary.id}')">修改</div>
				 					<div style="cursor:pointer;float:left;line-height:40px;text-align:center;width:50%;" onclick="delAll('${fileLibrary.id}')">删除</div>
				 				</div>
				 				<div style="position: absolute;">
				 					<input type="checkbox" value="${fileLibrary.id }"/>
				 				</div>
					 			<img src="${imgHost }${fileLibrary.fileUrl }" style="cursor:pointer;" width="200" data-id="${fileLibrary.id }" data-supplierId="${fileLibrary.supplier.id }" data-brandId="${fileLibrary.brand.id }" data-designerId="${fileLibrary.designer.id }" data-categoryId="${fileLibrary.category.id }" height="200" onclick="showImg(this)"/>
					 		</li>
				 		</c:forEach>
				 	</ul>
				</div>
				<div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
		        </div>
			</div>
	    </section>
	    
	</div>
	<sys:selectmutil height="600" url="" width="1200" isDisableCommitBtn="true" title="选择" id="select" ></sys:selectmutil>
	
	<div id="searchModal" class="modal fade">
       <div class="modal-dialog">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span></button>
             <h4 class="modal-title">高级筛选</h4>
           </div>
           <div id="paramDiv" class="modal-body divScroll">
          	 <table id="contentTable" class="table table-bordered table-hover table-striped">
				<thead>
					<tr>
						<th class="text-center">属性名</th>
						<th class="text-center">属性值</th>
					</tr>
				</thead>
				<tbody id="propvalueListTbody">
					
				</tbody>
			 </table>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
             <button type="button" id="searchCommitBtn" class="btn btn-primary" onclick="searchCommit()">提交</button>
           </div>
         </div>
       </div>
     </div>
     
     <div id="imgModal" class="modal fade" data-id="" data-supplierId="" data-brandId="" data-designerId="" data-categoryId="">
       <div class="modal-dialog" style="width:80%;height:80%;">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span></button>
             <h4 class="modal-title">大图浏览</h4>
           </div>
           <div class="modal-body divScroll">
           	 <div class="nav-tabs-custom">
           	 	<ul class="nav nav-tabs">
	              <li class="active"><a href="#tab_1" data-toggle="tab">图片</a></li>
	              <li><a href="#tab_2" data-toggle="tab" onclick="setIframeSrc(this,'${ctx}/lgt/si/supplier/info?id=$supplierId')">供应商</a></li>
	              <li><a href="#tab_3" data-toggle="tab" onclick="setIframeSrc(this,'${ctx}/lgt/bs/brand/info?id=$brandId')">品牌</a></li>
	              <li><a href="#tab_4" data-toggle="tab" onclick="setIframeSrc(this,'${ctx}/lgt/bs/designer/info?id=$designerId')">设计师</a></li>
	              <li><a href="#tab_5" data-toggle="tab" onclick="setIframeSrc(this,'${ctx}/lgt/ps/category/view?id=$categoryId')">分类</a></li>
	              <li><a href="#tab_6" data-toggle="tab" onclick="setIframeSrc(this,'${ctx}/bas/fileLibrary/propInfo?id=$id')">属性</a></li>
	            </ul>
           	 </div>
           	 <div class="tab-content">
              	<div class="tab-pane active" id="tab_1">
              		<img id="bigImg" src="" width="100%" style="float:left"/>
              	</div>
              	<div class="tab-pane" id="tab_2">
              		<iframe src="" frameborder='0' width='100%' height='400px' scrolling='auto'></iframe>
              	</div>
              	<div class="tab-pane" id="tab_3">
              		<iframe src="" frameborder='0' width='100%' height='400px' scrolling='auto'></iframe>
              	</div>
              	<div class="tab-pane" id="tab_4">
              		<iframe src="" frameborder='0' width='100%' height='400px' scrolling='auto'></iframe>
              	</div>
              	<div class="tab-pane" id="tab_5">
              		<iframe src="" frameborder='0' width='100%' height='400px' scrolling='auto'></iframe>
              	</div>
              	<div class="tab-pane" id="tab_6">
              		<iframe src="" frameborder='0' width='100%' height='400px' scrolling='auto'></iframe>
              	</div>
             </div>
           </div>
           <div class="modal-footer" style="clear:both;">
             <button type="button" class="btn btn-default pull-right" data-dismiss="modal">关闭</button>
           </div>
         </div>
       </div>
     </div>
	
	<sys:userselect height="550" url="${ctx}/bas/fileDir/treeData"
                    width="550" isOffice="true" isMulti="false" title="文件目录选择" isTopSelectable="true"
                    id="selectDir"></sys:userselect>
	
	<script type="text/javascript">
	
	function setIframeSrc(obj,src){
		var id=$("#imgModal").attr("data-id");
		var supplierId=$("#imgModal").attr("data-supplierId");
		var brandId=$("#imgModal").attr("data-brandId");
		var designerId=$("#imgModal").attr("data-designerId");
		var categoryId=$("#imgModal").attr("data-categoryId");
		var divId=$(obj).attr("href");
		src=src.replace("$id",id).replace("$supplierId",supplierId).replace("$brandId",brandId).replace("$designerId",designerId).replace("$categoryId",categoryId);
		console.log(src)
		console.log(divId)
		$("iframe",$(divId)).each(function(){
			if($(this).attr("src")=="")
				$(this).attr("src",src)
		});
	}
	
	function showImg(obj){
		$("#bigImg").attr("src",$(obj).attr("src"));
		$("#imgModal").attr("data-id",$(obj).attr("data-id"))
		$("#imgModal").attr("data-supplierId",$(obj).attr("data-supplierId"))
		$("#imgModal").attr("data-brandId",$(obj).attr("data-brandId"))
		$("#imgModal").attr("data-designerId",$(obj).attr("data-designerId"))
		$("#imgModal").attr("data-categoryId",$(obj).attr("data-categoryId"))
		$("#imgModal").modal('show');
	}
	
	function resetSearch(){
		$("#propvalueListTbody").html("")
		$("input[data-name=propHidden]").remove();//清空所有的预表单项
	}
	
	function searchCommit(){
		$("input[data-name=propHidden]").remove();//清空所有的预表单项
		var vals=$("[name=valSelect]");
		var valInput=$("[name=valInput]");
		var form=$("#searchForm");
		var temp="<input data-name=\"propHidden\" type=\"hidden\" name=\"$postname\" value=\"$val\" />"
		var idx=0;
		for(var i=0;i<vals.length;i++){
			var val=$(vals[i]).val();
			if(val==null||val.length<=0)
				continue;
			if(val instanceof Array){
				for(var j=0;j<val.length;j++){
					form.append(temp.replace("$postname","fileProps["+idx+"].propvalue.id").replace("$val",val[j]))
					form.append(temp.replace("$postname","fileProps["+idx+"].property.valueType").replace("$val","2"))
					idx++;
				}
			}else{
				form.append(temp.replace("$postname","fileProps["+idx+"].propvalue.id").replace("$val",val))
				form.append(temp.replace("$postname","fileProps["+idx+"].property.valueType").replace("$val","1"))
				idx++;
			}
		}
		for(var i=0;i<valInput.length;i++){
			var val=$(valInput[i]).val();
			if(val==null||val.length<=0)
				continue;
			form.append(temp.replace("$postname","fileProps["+idx+"].pvalue").replace("$val",val));
			form.append(temp.replace("$postname","fileProps["+idx+"].property.valueType").replace("$val","0"))
			idx++;
		}
		$("#searchModal").modal('hide');
	}
	
	function createRow(data){
		var temp="<tr><td><p class=\"text-center\">$propertyName</p></td>"+
		"<td>$select</td></tr>";
		for(var i=0;i<data.length;i++){
			var tempHtml="";
			tempHtml=temp.replace("$propertyName",data[i].propName).replace("$select",getSelect(data[i].valueType,data[i].propvalueList))
			$("#propvalueListTbody").append(tempHtml);
		}
		$("select[name=valSelect]").select2();
	}
	
	function getSelect(type,valData){
		if(type=="0"){
			return "<input data-type="+type+" name=\"valInput\" type=\"text\" class=\"form-control\" />";
		}
		var tempHtml="";
		//单选
		/*if(type=="1"){
			tempHtml="<select data-type="+type+" name=\"valSelect\" class=\"select2\">$select</select>";
		}
		//多选
		if(type=="2"){
			tempHtml="<select data-type="+type+" name=\"valSelect\" multiple class=\"multiSelect\">$select</select>";
		}*/
		tempHtml="<select data-type="+type+" name=\"valSelect\" class=\"select2\">$select</select>";
		var options="<option></option>";
		for(var i=0;i<valData.length;i++){
			options+="<option value="+valData[i].id+" >"+valData[i].pvalueName+"</option>"
		}
		return tempHtml.replace("$select",options);
	}
	
	function selectFileDir() {
		selectDirinit({
            "selectCallBack" : function(list) {
                $("#fileDirId").val(list[0].id);
                $("#fileDirName").val(list[0].text);
            }
        })
	}
	
	$(function(){
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
		$("#searchModal").on("shown.bs.modal",function () {
			if($("#propvalueListTbody").html().trim()==""){
				$("#propvalueListTbody").html("<div class=\"overlay\"><i class=\"fa fa-refresh fa-spin\"></i></div>");
				ZF.ajaxQuery(true,"${ctx}/lgt/ps/property/findPropertyData","",function(data){
					$("#propvalueListTbody").html("");
					createRow(data);
					ZF.createScroll(".divScroll",500)
				})
			}
		})
		
		$("#imgModal").on("hide.bs.modal",function () {
			$("iframe","#imgModal").each(function(){
				$(this).attr("src","");
			})
		})
		
	})
	</script>
</body>
</html>