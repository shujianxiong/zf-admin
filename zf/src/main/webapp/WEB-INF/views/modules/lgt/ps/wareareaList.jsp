<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货架管理</title>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(function() {
			$("#contentTable").treeTable({expandLevel  : 2}).show();
			$("#tBody tr").each(function(){
				if($("#warehouseId").val()!=null &&$("#warehouseId").val()!=undefined&&$("#warehouseId").val()!=""){
					if($(this).prop("id")!=$("#warehouseId").val()&&$(this).attr("pid")!=$("#warehouseId").val()){
						$(this).remove();
					}
				}
			});
			
			$("#commitBtn").on("click",function(){
				console.log(1111);
				var flag = ZF.formSubmit();
				$("button[type=submit]").attr('disabled',false);
	    		if(flag) {
					var param = {
						"wareareaId":$("#wareareaId").val(),
						"horizontalNum":$("#horizontalNum").val(),
						"verticalNum":$("#verticalNum").val(),
						"wareplaceNum":$("#wareplaceNum").val()
					}
					console.log(param)
					ZF.ajaxQuery(true,"${ctx}/lgt/ps/warearea/batchSet",param,
							function(data){
								if(data.status == 1){
									ZF.showTip(data.message,"success");
								}else{
									ZF.showTip(data.message,"error");
								}
					},function(data){
						ZF.showTip('系统出错，请稍后再试！',"error");
					});
		    		$("#wareModal").modal("hide"); 
	    		}
			});
		});
		
		function openModal(wareareaId){
			console.log(wareareaId);
			$("#wareareaId").val(wareareaId);
			$("#horizontalNum").val(4);
    		$("#verticalNum").val(15);
    		$("#wareplaceNum").val(2);
			$("#horizontalNum").trigger('change');
			$("#verticalNum").trigger('change');
			$("#wareplaceNum").trigger('change');
			$("#wareModal").modal("show"); 
		}
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/warearea/">货架列表</a>
		        </small>
		        <shiro:hasPermission name="lgt:ps:warehouse:edit">
			        <small>|</small>
		        	<small>
		        		<i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/warearea/form">货架<shiro:hasPermission name="lgt:ps:warearea:edit">${not empty warehouse.id?'修改':'添加'}</shiro:hasPermission></a>
		        	</small>
		        </shiro:hasPermission>
		    </h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="warearea" action="${ctx}/lgt/ps/warearea/" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
				          	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
				        </div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label">货架编码</label>
									<div class="col-sm-7">
										<form:input id="code" path="code" htmlEscape="false" maxlength="20" class="form-control"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label">货架类型</label>
									<div class="col-sm-7">
										<sys:selectverify id="type" name="type" dictName="lgt_ps_warearea_type" tip="" verifyType="0" isMandatory="false"></sys:selectverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label">启用状态</label>
									<div class="col-sm-7">
										<sys:selectverify id="usableFlag" name="usableFlag" dictName="yes_no" tip="" verifyType="0" isMandatory="false"></sys:selectverify>
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
				</div>
			</form:form>
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>仓库/货架</th>
									<th>货架类型</th>
									<th>存放分类</th>
									<th>启用状态</th>
									<th>创建者</th>
									<th>创建时间</th>
									<th>更新者</th>
									<th>更新时间</th>
									<th>备注信息</th>
									<shiro:hasPermission name="lgt:ps:warearea:edit"><th>操作</th></shiro:hasPermission>
								</tr>
							</thead>
							<tbody id="tBody">
							<c:forEach items="${warehouses}" var="ws">
								<tr id="${ws.id}">
									<td colspan="9">${ws.code}（${ws.name}）</td>
								</tr>
								<c:forEach items="${page.list}" var="warearea">
									<c:if test="${ws.id == warearea.warehouse.id}">
										<tr id="${warearea.id}" pid="${warearea.warehouse.id}">
											<td>
												${warearea.code}
											</td>
											<td>
												<c:choose>
                                                	<c:when test="${warearea.type == 1 }">
                                                    	<span class="label label-primary">${fns:getDictLabel(warearea.type, 'lgt_ps_warearea_type', '') }</span>
                                                    </c:when>
                                                    <c:when test="${warearea.type == 2 }">
                                                    	<span class="label label-default">${fns:getDictLabel(warearea.type, 'lgt_ps_warearea_type', '') }</span>
                                                    </c:when>
                                                </c:choose>
											</td>
											<td>
												${warearea.categories.categoryName}
											</td>
											<td>
												<c:choose>
                                                	<c:when test="${warearea.usableFlag == 1 }">
                                                    	<span class="label label-success">${fns:getDictLabel(warearea.usableFlag, 'yes_no', '') }</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                    	<span class="label label-primary">${fns:getDictLabel(warearea.usableFlag, 'yes_no', '') }</span>
                                                    </c:otherwise>
                                                </c:choose>
											</td>
											<td>
												${fns:getUserById(warearea.createBy.id).name}
											</td>
											<td>
												<fmt:formatDate value="${warearea.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
											</td>
											<td>
												${fns:getUserById(warearea.updateBy.id).name}
											</td>
											<td>
												<fmt:formatDate value="${warearea.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
											</td>
											<td title="${warearea.remarks}">
												${fns:abbr(warearea.remarks, 15)}
											</td>
											<shiro:hasPermission name="lgt:ps:warearea:edit"><td>
												<div class="btn-group zf-tableButton">
					                  				<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/warearea/form?id=${warearea.id}'">修改</button>
					                  				<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
									                   <span class="caret"></span>
									                </button>
									                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
									                	<li><a href="${ctx}/lgt/ps/warearea/delete?id=${warearea.id}" onclick="return ZF.delRow('确认要删除该记录吗？', this.href)">删除</a></li>
									                	<c:if test="${warearea.type eq 1 }">
									                		<shiro:hasPermission name="lgt:ps:warearea:batchSet">
									                			<li><a onclick="openModal('${warearea.id}')">批量生成货屉货位</a></li>
									                		</shiro:hasPermission>
									                	</c:if>
									                </ul>
								                </div>
											</td></shiro:hasPermission>
										</tr>
									</c:if>	
								</c:forEach>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="box-footer">
	        		<div class="dataTables_paginate paging_simple_numbers">${page}</div>
				</div>
			</div>
			
			<div id="wareModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="录入产品促销折扣信息" aria-hidden="true">
           		<div class="modal-dialog" style="width:60%;height:55%;" >
                  <div class="modal-content" style="width:100%;height:100%;">
                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">录入货屉货位信息</h4>
                     </div>
                     <div class="modal-body">
                        <form id="wareForm"  method="post" class="form-horizontal" >
                        	<input id="wareareaId" type="hidden" name="wareareaId" value="${ warearea.id}">
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">横排货屉数</label>
                                  <div class="col-sm-7">
                                      <sys:inputverify id="horizontalNum" name="horizontalNum" tip="请输入横列货屉数,必填项且只能输入一位正整数" verifyType="4" maxlength="1" isMandatory="true" ></sys:inputverify>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">纵列货屉数</label>
                                  <div class="col-sm-7">
                                      <sys:inputverify id="verticalNum" name="verticalNum" tip="请输入纵列货屉数,必填项且最大只能输入两位正整数" verifyType="9" maxlength="2" isMandatory="true" ></sys:inputverify>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">屉内货位数</label>
                                  <div class="col-sm-7">
                                      <sys:inputverify id="wareplaceNum" name="wareplaceNum" tip="请输入屉内货位数,必填项且只能输入一位正整数" verifyType="9" maxlength="1" isMandatory="true" ></sys:inputverify>
                                  </div>
                              </div>
	                     </form>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="commitBtn">提交生成</button>
                     </div>
                  </div><!-- /.modal-content -->
            	</div><!-- /.modal -->
        	</div>
		</section>
	</div>
</body>
</html>