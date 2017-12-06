<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
	</script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section class="content-header content-header-menu">
		<h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/supplier/">供应商列表</a></small>
			
			<shiro:hasPermission name="lgt:si:supplier:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/si/supplier/form">供应商${not empty supplier.id?'修改':'添加'}</a></small></shiro:hasPermission>
            <small>|</small>
			<small><i class="fa-list-style"></i><a href="#" onclick="showSupplierProduce('');">供应商产品列表</a></small>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="box box-info">
			<div class="box-header with-border zf-query">
				<h5>查询条件</h5>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
					<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
				</div>
			</div>
			
			<form:form id="searchForm" modelAttribute="supplier" action="${ctx}/lgt/si/supplier/" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box-body">
					<div class="row">
						<div class="col-md-4">
							<div  class="form-group">
								<label for="type" class="col-sm-3 control-label">供应商名称</label>
								<div class="col-sm-7">	
									<sys:inputverify id="name" name="name" tip="请输入供应商名称" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
								</div>
							</div>
						</div>
						<div class="col-md-4">
								<sys:inputtree name="supplierCategory.id" url="${ctx}/lgt/ps/category/categoryData"
									id="category" label="供应商分类" labelValue="" labelWidth="3"
									inputWidth="7" labelName="supplierCategory.categoryName" value="" tip="请选择分类"></sys:inputtree>
						</div>
						<div class="col-md-4">
							<div  class="form-group">
								<label for="type" class="col-sm-3 control-label">供应商类型</label>
								<div class="col-sm-7">
									<form:select path="type" id="type" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('lgt_si_supplier_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<div  class="form-group">
								<label for="level" class="col-sm-3 control-label">信誉等级</label>
								<div class="col-sm-7">
									<form:select path="level" id="level" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('lgt_si_supplier_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div  class="form-group">
								<label for="activeFlag" class="col-sm-3 control-label">是否启用</label>
								<div class="col-sm-7">
								    <sys:selectverify name="activeFlag" tip="请选择启用状态" verifyType="0" dictName="yes_no" id="activeFlag" isMandatory="false"></sys:selectverify>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-right box-tools">
		        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
	               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
		        	</div>
				</div>
            </form:form>
		</div>
	
		<div class="box box-soild">
    		<div class="box-body">
    			<div class="table-responsive">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th class="zf-dataTables-multiline"></th>
								<th>供应商名称</th>
								<th>LOGO</th>
								<th>供应商类型</th>
								<th>信誉等级</th>
								<th>是否启用</th>
								<th>供应商分类</th>
								<th>国家/地区</th>
								<th>品牌分级</th>
								<th>联系电话</th>
								<th>公司网址</th>
								<th>传真</th>
								<th>邮箱</th>
								<th>产品主材质</th>
								<th style="display: none;">默认账期(天)</th>
								<th style="display: none;">默认账期利率</th>
								<th style="display: none;">回货周期(天)</th>
								<th style="display: none;">信誉积分</th>
								<th style="display:none;">创建者</th>
								<th style="display:none;">创建时间</th>
								<th style="display:none;">更新者</th>
								<th style="display:none;">更新时间</th>
								<th style="display:none;">备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="supplier" varStatus="status">
								<tr data-id="${supplier.id}" data-index="${status.index }">
								<!--  -->
									<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td title="${ supplier.name}">
										${fns:abbr(supplier.name,16)}
									</td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${supplier.logo}" data-big data-src="${imgHost }${supplier.logo}" style="width:20px;height:20px;">
									</td>
									<td>
										${fns:getDictLabel(supplier.type, 'lgt_si_supplier_type', '')}
									</td>
									<td>
										${fns:getDictLabel(supplier.level, 'lgt_si_supplier_level', '')}
									</td>
									<td>
										<c:choose>
											<c:when test="${supplier.activeFlag eq '1'}">
												<span class="label label-success">${fns:getDictLabel(supplier.activeFlag, 'yes_no', '')}</span>
											</c:when>
											<c:when test="${supplier.activeFlag eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(supplier.activeFlag, 'yes_no', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										${supplier.supplierCategory.categoryName}
									</td>
									
									<td>${fns:getDictLabel(supplier.country, 'country', '')} </td>
									<td>${fns:getDictLabel(supplier.brandLevel, 'lgt_si_supplier_brandLevel', '')} </td>
									<td>${supplier.tel }</td>
									<td title="${supplier.website }">${fns:abbr(supplier.website,20 )}</td>
									<td>${supplier.fax }</td>
									<td>${supplier.email }</td>
									<td title="${supplier.produceMaterial }">${fns:abbr(supplier.produceMaterial, 10 )}</td>
									<td data-hide="true">${supplier.defaultAccount }</td>
									<td data-hide="true">${supplier.defaultAccountRate }</td>
									<td data-hide="true">${supplier.returnPeriod }</td>
									<td data-hide="true">${supplier.creditPoint }</td>
									<td data-hide="true">
										${fns:getUserById(supplier.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${supplier.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(supplier.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${supplier.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:abbr(supplier.remarks, 15)}
									</td>
									
									<td>
										<shiro:hasPermission name="lgt:si:supplier:edit">
											<div class="btn-group zf-tableButton">
													<button type="button" class="btn btn-sm btn-info"
														onclick="window.location.href='${ctx}/lgt/si/supplier/info?id=${supplier.id}'">详情</button>
													<button type="button"
														class="btn btn-sm btn-info dropdown-toggle"
														data-toggle="dropdown">
														<span class="caret"></span>
													</button>
													<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
													    <li><a href="${ctx}/lgt/si/supplier/form?id=${supplier.id}">修改</a></li>
														<li><a href="#this" onclick="addBrand('${supplier.id}','${supplier.name}')">设置品牌</a></li>
														<li><a href="#this" onclick="showSupplierProduce('${supplier.id}');">关联产品</a></li>
														<li><a
															href="${ctx}/lgt/si/supplier/delete?id=${supplier.id}"
															style="color: #fff"
															onclick="return ZF.delRow('确认要删除该供应商吗？',this.href)">删除</a>
														</li>
														<li>
															<c:choose>
									                    		<c:when test="${supplier.activeFlag == 1 }">
									                    			<a href="${ctx}/lgt/si/supplier/changeActiveFlag?id=${supplier.id}&activeFlag=0" style="color:#fff" onclick="return changeFlag('确认要停用该供应商吗？',this.href);">
									                    				停用
									                        		</a>
									                    		</c:when>
									                    		<c:when test="${supplier.activeFlag == 0  || supplier.activeFlag == null}">
									                    			<a href="${ctx}/lgt/si/supplier/changeActiveFlag?id=${supplier.id}&activeFlag=1" style="color:#fff" onclick="return changeFlag('确认要启用该供应商吗？',this.href);">
									                    				启用
									                        		</a>
									                    		</c:when>
									                    	</c:choose>
														</li>
													</ul>
											</div>
										</shiro:hasPermission>
										<shiro:lacksPermission name="lgt:si:supplier:edit">
											<div class="btn-group zf-tableButton">
												<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/si/supplier/info?id=${supplier.id}'">详情</button>
												<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
													<span class="caret"></span>
												</button>
										</shiro:lacksPermission>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
    		</div>
    		<div class="box-footer">
        		<div class="dataTables_paginate paging_simple_numbers">${page}</div>
        	</div>
    	</div>
    	<sys:selectmutil id="brandSelect" title="设置所属品牌" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
	 </section>
	</div>
	
	<script>
	  $(function () {
		
			ZF.bigImg();
			 
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
			  
		    //表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : false,
				"info" : false,
				"autoWidth" : false,
				"multiline" : true,//是否开启多行表格
				"isRowSelect" : true,//是否开启行选中
				"rowSelect" : function(tr) {
					
				},
				"rowSelectCancel" : function(tr) {
					
				}
			});
		    
		    
			// Modal<iframe>回调事件,获取弹出框选择的货品信息
			$("#brandSelectModal #commitBtn").on("click",function () {
				$("#brandSelectModal").modal("hide");		
				var content = $("#brandSelectModalIframe").contents().find("body");
				var arr = [];
				var supplierId = $("#supplier_id", content).val();
				
				$("input[type=checkBox]", content).each(function(){
					if($(this).prop("checked")){
						//重新选择产品清空原来数据
						$("tr",$("#tableList")).each(function(){
							$(this).remove();
						})
						arr.push($(this).val());
					}
				});
				
				var param = supplierId+"="+arr.join();
				ZF.ajaxQuery(false, "${ctx}/lgt/si/supplierBrand/saveSupplierBrandBatch",{"param":param} , function() {
					window.location.href = window.location.href;
				});
				
				//清楚check  table缓存
				window.localStorage.removeItem("supplierList");
				
			});
	  });
	  
	  
	  function changeFlag(message,href){
		 confirm(message,"info",function(){
			window.location.href=href;
		 });
		 return false;
	  };
	  
	  
	  function addBrand(supplierId,name){
			//带参数请求URL设置方式
			$("#brandSelectModalUrl").val("${ctx}/lgt/si/supplierBrand/select?supplier.id="+supplierId+"&pageKey=supplierList");
      		$("#brandSelectModal").modal('toggle');//显示模态框
	  };
	  
	  function showSupplierProduce(supplierId) {
		  if(supplierId == null || supplierId == "" || supplierId == undefined) {
				var trs=$("tr");
		        for(var i=0;i<trs.length;i++){
		            if($(trs[i]).hasClass('selected')){
		                var supplierId = $(trs[i]).attr("data-id");
		                window.location.href = "${ctx}/lgt/si/supplierProduce/list?supplier.id="+supplierId;
		                return "";
		            }
		        }
		        alert("请选择你要操作的供应商记录","info",function(){
		            //处理确定
		            return "";
		        }, function() {
		        	//处理取消
			        return ""; 
		        });
		        return "";
		  } else {
			  window.location.href = "${ctx}/lgt/si/supplierProduce/list?supplier.id="+supplierId;
		  }
	  }
	  
   </script>
</body>
</html>