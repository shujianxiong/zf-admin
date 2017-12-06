<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
	
		var area = ${fns:toJson(area)}	
	
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			if(area.parentId!=0){
				$("#parentId").val(area.parentId)
			}
			$("#searchForm").submit();
        	return false;
        }
		
		function query(){
			$("#pageNo").val(1);
			$("#searchForm").submit();
        	return false;
		}

        function removeArea(url,id){
            confirm("要删除该区域及所有子区域项吗？","warning",function(){
                window.location.href=url+"?id="+id;
            });
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
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/area/listByType?isDistrict=1">区域列表</a></small>
            
            <shiro:hasPermission name="sys:area:edit">
               <small>|</small>
               <small>
                   <i class="glyphicon glyphicon-edit"></i>
                   <a href="${ctx}/sys/area/form?id=${area.id}">区域${not empty area.id?'修改':'添加'}</a>
               </small>
            </shiro:hasPermission>
            <shiro:hasPermission name="sys:area:import">
               <small>|</small>
               <small>
                   <i class="glyphicon glyphicon-import"></i>
                   <a href="${ctx }/sys/area/importForm">区域批量导入</a>
               </small>
            </shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<form:form id="searchForm" modelAttribute="area" action="${ctx}/sys/area/listByType?isDistrict=0" method="post" class="form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="parentId" name="parent.id" type="hidden"/>
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
							<label for="name" class="col-sm-3 control-label">区域名称</label>
							<div class="col-sm-7">
								<form:input path="name" placeholder="请输入区域名称查询" class="form-control"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box-footer">
				<div class="pull-right box-tools">
	        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
               		<button type="submit" class="btn btn-info btn-sm" onclick="query()"><i class="fa fa-search"></i>查询</button>
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
								<th class="zf-dataTables-multiline"></th>
								<th>区域名称</th>
                                <th>区域编码</th>
                                <th>区域类型</th>
								<th style="display:none">创建者</th>
								<th style="display:none">创建时间</th>
								<th style="display:none">更新者</th>
								<th style="display:none">更新时间</th>
								<th>备注</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list }" var="area" varStatus="status">
								<tr data-index="${status.index }">
									<td class="details-control text-center">
										<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td>
                                        ${ area.name}
                                    </td>
                                    <td>
                                        ${area.code}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(area.type, 'sys_area_type', '无')}</span>
                                    </td>
									<td data-hide="true">
										${fns:getUserById(area.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${area.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(area.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${area.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${area.remarks }">
										${fns:abbr(area.remarks, 15)}
									</td>
									<td>
										<shiro:hasPermission name="sys:area:edit">
                                            <div class="btn-group zf-tableButton">
                                              <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/area/form?id=${area.id}'">修改</button>
                                              <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
                                                <span class="caret"></span>
                                              </button>
                                              <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="#this" onclick="removeArea('${ctx}/sys/area/delete','${area.id}')" style="color:#fff">删除</a></li>
                                                <li><a href="${ctx}/sys/area/form?parent.id=${area.id}">添加下级区域</a></li>
                                                <li><a href="${ctx}/sys/area/info?id=${area.id}">详情</a></li>
                                              </ul>
                                            </div>
                                        </shiro:hasPermission>
                                        <shiro:lacksPermission name="sys:area:edit">
                                            <div class="btn-group zf-tableButton">
                                              <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/area/info?id=${area.id}'">详情</button>
                                              <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
                                                <span class="caret"></span>
                                              </button>
                                            </div>
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
		
	</section>
</div>

<script type="text/javascript">

	$(function() {
		 //表格初始化
	 	ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"order": [[ 4, "asc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},  
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
			    {"orderable":false,targets:4},
				{"orderable":false,targets:5},
				{"orderable":false,targets:6},
				{"orderable":false,targets:7},
				{"orderable":false,targets:8},
				{"orderable":false,targets:9}
            ],
			"ordering" : true,
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){productId = tr.attr("data-value");},
			"rowSelectCancel":function(tr){productId = null;}
		})
	});
</script>	
</body>
</html>