<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>仓库列表管理</title>
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
		//清空查询条件
		function clearQueryParam(){
			$("#name").val("");
			$("#areaName").val("");
			$("#responsibleUserIdName").val("");
			$("#type").select2("val","");
		}
		//启用或停用仓库
		function updateUsableFlag(url,id,usableFlag,message){
			confirm(message,"warning",function(){
				$("#warehourseId").val(id);
				$("#usableFlag").val(usableFlag),
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			})
		}
		
		//删除记录
		function del(){
			
			if(warehouseId==''||warehouseId == null || warehouseId==undefined){
				alert("请先选中需要操作的记录！")
				return false;
			}else{
				if(confirm("确定要删除吗？")){
					$.ajax({
						type:'POST',
						data:'{id:'+warehouseId+'}',
						url:'${ctx}/lgt/ps/warehouse/delete',
						success:function(data){
							warehouseId = null;
							return false;
						},
						error:function(data){
							alert("操作失败！")
							return false;
						}
					})
				}
			}
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
	        	<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/warehouse/">仓库列表</a>
	        </small>
	        <shiro:hasPermission name="lgt:ps:warehouse:edit">
		        <small>|</small>
	        	<small>
	        		<shiro:hasPermission name="lgt:ps:warehouse:edit"><i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/warehouse/form">仓库添加</a></shiro:hasPermission>
	        	</small>
	        </shiro:hasPermission>
	    </h1>
	</section>
	
	<sys:tip content="${message}"/>

	<section class="content">
		<form:form id="searchForm" modelAttribute="warehouse" action="${ctx}/lgt/ps/warehouse/" method="post" class="form-horizontal">
			<input id="warehourseId" name="id" type="hidden"/>
			<input id="lockFlag" name="lockFlag" type="hidden"/>
			<input id="usableFlag" name="usableFlag" type="hidden"/>
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
								<label for="searchParam" class="col-sm-2 control-label" >编码</label>
								<div class="col-sm-7">
									<form:input id="code" path="code" htmlEscape="false" maxlength="64" class="form-control"  placeholder="仓库编码"/>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-2 control-label" >名称</label>
								<div class="col-sm-7">
									<form:input id="name" path="name" htmlEscape="false" maxlength="64" class="form-control"  placeholder="仓库名称"/>
								</div>
							</div>
						</div>
<!-- 							<div class="col-md-4"> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label for="searchParam" class="col-sm-3 control-label">所属区域</label> -->
<!-- 									<div class="col-sm-5"> -->
<%-- 										<sys:treeselect id="area" name="area.id" value="${warehouse.area.id}" labelName="area.name" labelValue="${warehouse.area.name}"  --%>
<%-- 											title="区域" url="/sys/area/treeData" cssClass="form-control" allowClear="true" notAllowSelectParent="true"/> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div class="col-md-4"> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label for="searchParam" class="col-sm-2 control-label">负责人</label> -->
<!-- 									<div class="col-sm-5"> -->
<%-- 										<sys:treeselect id="responsibleUserId" name="responsibleUser.id" value="${warehouse.responsibleUser.id}" labelName="responsibleUser.name" labelValue="${warehouse.responsibleUser.name}" --%>
<%-- 											title="负责人" url="/sys/office/treeData?type=3" cssClass="form-control" allowClear="true" notAllowSelectParent="true"/> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->

						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-3 control-label">仓库类型</label>
								<div class="col-sm-7">
									<form:select path="type" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:option label="所有" value="" />
										<form:options items="${fns:getDictList('lgt_ps_warehouse_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
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
			</div>
		</form:form>
		
		<div class="box box-soild">
	        <div class="box-body">
				<div class="table-responsive">
					<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th>仓库名称</th>
								<th>仓库编码</th>
								<th>仓库类型</th>
								<th>所处区域</th>
								<th>地址详情</th>
								<th>仓库布局图</th>
								<th>负责人</th>
								<th>负责人电话</th>
								<th>排列序号</th>
								<th>启用状态</th>
								<th>备注信息</th>
								<shiro:hasPermission name="lgt:ps:warehouse:edit"><th>操作</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="warehouse">
								<tr data-value="${warehouse.id}">
									<td>
										${warehouse.name }
									</td>
									<td>
										${warehouse.code }
									</td>
									<td>
										<c:choose>
											<c:when test="${warehouse.type == 1 }">
												<span class="label label-primary"> ${fns:getDictLabel(warehouse.type,'lgt_ps_warehouse_type','') }</span>
											</c:when>
											<c:otherwise>
												<span class="label label-info"> ${fns:getDictLabel(warehouse.type,'lgt_ps_warehouse_type','') }</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td title="${warehouse.area.name}">
										<c:set value="${fns:getAreaFullNameById(warehouse.area.id) }" var="areaName"/>
										${fns:abbr(areaName,32)}
									</td>
									<td title="${warehouse.areaDetail}">
										${fns:abbr(warehouse.areaDetail,32)}
									</td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(warehouse.layoutPhoto, '|', '')}" data-big data-src="${imgHost }${warehouse.layoutPhoto}" width="30px" height="30px" />
									</td>
									<td>
										${warehouse.responsibleUser.name}
									</td>
									<td>
										${warehouse.responsibleMobile}
									</td>
									<td>
										${warehouse.orderNo}
									</td>
									<td>
										<c:choose>
											<c:when test="${warehouse.usableFlag == 1 }">
												<span class="label label-success">${fns:getDictLabel(warehouse.usableFlag, 'yes_no', '') }</span>
											</c:when>
											<c:otherwise>
												<span class="label label-primary">${fns:getDictLabel(warehouse.usableFlag, 'yes_no', '') }</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td title="${warehouse.remarks}">
										${fns:abbr(warehouse.remarks,15)}
									</td>
								  	<shiro:hasPermission name="lgt:ps:warehouse:edit">
										<td>
							              	<div class="btn-group zf-tableButton">
							                  	<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/warehouse/form?id=${warehouse.id}'">修改</button>
							                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                    	<span class="caret"></span>
							                  	</button>
							                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
						                    		<c:choose>
								                  		<c:when test="${warehouse.usableFlag == 1}">
	    													<li><a href="#this" onclick="updateUsableFlag('${ctx}/lgt/ps/warehouse/updateUsableFlag','${warehouse.id}','0','确定要停用吗？')">停用</a></li>
								                  		</c:when>
								                  		<c:otherwise>
	    													<li><a href="#this" onclick="updateUsableFlag('${ctx}/lgt/ps/warehouse/updateUsableFlag','${warehouse.id}','1','确定要启用吗？')">启用</a></li>
								                  		</c:otherwise>
								                  	</c:choose>
							                    	<li><a href="${ctx}/lgt/ps/warehouse/delete?id=${warehouse.id}" onclick="return ZF.delRow('确认要删除该仓库记录？', this.href)">删除</a></li>
							                  	</ul>
							                </div>
										</td>
				                    </shiro:hasPermission>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	            </div>
            </div>
        </div>
	</section>

</div>	
<script>
  var warehouseId = null;
  $(function () {
	
	ZF.bigImg();
	  
	 //表格初始化
    var t=$('#contentTable').DataTable({
      "paging": false,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "order": [[ 7, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
      "columnDefs":[
          {"orderable":false,targets:0},
          {"orderable":false,targets:1},
          {"orderable":false,targets:2},
          {"orderable":false,targets:3},
          {"orderable":false,targets:4},
          {"orderable":false,targets:5},
          {"orderable":false,targets:6},
          {"orderable":false,targets:7},
          {"orderable":false,targets:9},
          {"orderable":false,targets:10},
          {"orderable":false,targets:11}
      ],
      "info": false,
      "autoWidth": false
    });
    
  	//表格单选功能
    $('#contentTable tbody').on( 'click', 'tr', function (){
        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
        	warehouseId = null;
        }else{
        	$('#contentTable tr.selected').removeClass('selected');
            $(this).addClass('selected');
        	warehouseId = $(this).attr("data-value");
        }
    });
  	
  	
  });
</script>	
</body>
</html>