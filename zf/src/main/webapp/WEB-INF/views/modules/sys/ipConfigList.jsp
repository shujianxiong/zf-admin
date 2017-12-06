<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>IP白名单管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		//启用或停用
		function updateActiveFlag(url,id,flag,message){
 			confirm(message,'info',function(){
				$("#ifConfigId").val(id);
				$("#flag").val(flag),
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
				return false;
			})
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/ipConfig/list">IP白名单列表</a></small>
	        <small>|</small>
			<small><i class="fa-form-edit"></i><a href="${ctx}/sys/ipConfig/form">IP白名单新增</a></small>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
		    <form:form id="searchForm" modelAttribute="ipConfig" action="${ctx}/sys/ipConfig/" method="post" class="form-horizontal">
		    	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input id="ifConfigId" name="id" type="hidden"/>
				<input id="flag" name="flag" type="hidden"/>
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
				                  <label for="ip" class="col-sm-3 control-label">白名单IP</label>
				                  <div class="col-sm-7">
				                    <input name="ip" type="text" class="form-control" placeholder="输入IP地址模糊匹配查询" />
				                  </div>
				                </div>
			        		</div>
			        		<div class="col-md-4">
			        			<div class="form-group">
			        				<label for="activeFlag" class="col-sm-3 control-label">启用状态</label>
			        				<div class="col-sm-7">
			        					<form:select path="activeFlag" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('yes_no') }" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
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
	    	<div class="box box-solid">
	    		<div class="box-body">
	    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th>创建时间</th>
								<th>IP地址</th>
								<th>是否启用</th>
								<th>创建人</th>
								<th>更新人</th>
								<th>更新时间</th>
								<th>备注</th>
								<shiro:hasPermission name="sys:dict:edit"><th>操作</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="ipConfig">
							<tr>
							    <td>
                                    <fmt:formatDate value="${ipConfig.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </td>
								<td>
									${ipConfig.ip}
								</td>
								<td>
									<c:choose>
										<c:when test="${ ipConfig.activeFlag=='1'}">
											<span class="label label-success">${fns:getDictLabel(ipConfig.activeFlag, 'yes_no', '')}</span>
										</c:when>
										<c:when test="${ ipConfig.activeFlag=='0'}">
											<span class="label label-primary">${fns:getDictLabel(ipConfig.activeFlag, 'yes_no', '')}</span>
										</c:when>
									</c:choose>
								</td>
								<td>
                                    ${fns:getUserById(ipConfig.createBy.id).name }
                                </td>
								<td>
									${fns:getUserById(ipConfig.updateBy.id).name }
								</td>
								<td>
									<fmt:formatDate value="${ipConfig.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td title="${ipConfig.remarks }">
									${fns:abbr(ipConfig.remarks,48)}
								</td>
								<shiro:hasPermission name="sys:ipConfig:edit">
								<td>
					              	<div class="btn-group zf-tableButton">
				                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/ipConfig/info?id=${ipConfig.id}'">详情</button>
					                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
					                    	<span class="caret"></span>
					                  	</button>
					                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
						                    <shiro:hasPermission name="sys:ipConfig:edit">
						                    	<c:choose>
						                    		<c:when test="${ ipConfig.activeFlag=='1'}">
														<li><a href="#this" onclick="updateActiveFlag('${ctx}/sys/ipConfig/updateActiveFlag','${ipConfig.id}','0','确定要停用该IP地址吗？')">停用</a></li>
						                    		</c:when>
						                    		<c:when test="${ ipConfig.activeFlag=='0'}">
						                    			<li><a href="#this" onclick="updateActiveFlag('${ctx}/sys/ipConfig/updateActiveFlag','${ipConfig.id}','1','确定要启用该IP地址吗？')">启用</a></li>
						                    		</c:when>
						                    	</c:choose>
												<li><a href="#this" onclick="window.location.href='${ctx}/sys/ipConfig/form?id=${ipConfig.id}'">修改</a></li>
												<li><a  href="${ctx}/sys/ipConfig/delete?id=${ipConfig.id}" onclick="return ZF.delRow('确认要删除该IP白名单吗？', this.href)">删除</a></li>
						                    </shiro:hasPermission>
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
	    </section>
	</div>
<script>
	  $(function () {
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"order": [[ 0, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
                {"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:6},
				{"orderable":false,targets:7}
            ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		})
	  	
	  });
</script>
</body>
</html>