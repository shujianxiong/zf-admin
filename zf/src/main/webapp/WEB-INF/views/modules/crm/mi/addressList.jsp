<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>物流地址管理管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#hint').tooltip();
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
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/mi/address/">会员收货地址列表</a></small>
	      </h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="address" action="${ctx}/crm/mi/address/" method="post" class="form-horizontal">
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
									<label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>	
									<div class="col-sm-7">
										<form:input path="searchParameter.keyWord" class="form-control" placeholder="请输入会员账号"/>
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
										<th>会员账号</th>
										<th>收货区域</th>
										<th>收货地址详情</th>
										<th>邮政编码</th>
										<th>收货人</th>
										<th>收货人联系电话</th>
										<th>是否默认</th>
										<th>备注信息</th>
										<shiro:hasPermission name="crm:mi:address:edit"><th>操作</th></shiro:hasPermission>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${page.list}" var="address">
									<tr>
										<td>
											${fns:getMemberById(address.member.id).usercode}
										</td>
										<td>
											${fns:getAreaFullNameById(address.sysArea.id)}
										</td>
										<td title="${address.addressDetail }">
											${fns:abbr(address.addressDetail, 30)}
										</td>
										<td>
											${address.zipCode}
										</td>
										<td>
											${address.receiveName}
										</td>
										<td>
											${address.receiveTel}
										</td>
										<td>
											<c:choose>
												<c:when test="${address.defaultFlag eq '0' }">
													<span class="label label-primary">${fns:getDictLabel(address.defaultFlag, 'yes_no', '')}</span>
												</c:when>
												<c:when test="${address.defaultFlag eq '1' }">
													<span class="label label-success">${fns:getDictLabel(address.defaultFlag, 'yes_no', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<td title="${address.remarks}">
											${fns:abbr(address.remarks,15)}
										</td>
										<shiro:hasPermission name="crm:mi:address:edit">
											<td>
							    				<div class="btn-group zf-tableButton">
							                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/crm/mi/address/info?id=${address.id}'">详情</button>
							                  		<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
	                                                    <span class="caret"></span>
	                                                </button>
								                </div>
											</td>
									    </shiro:hasPermission>
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
		$(function(){
			 //表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : false,
				"info" : false,
				"autoWidth" : false,
				"multiline" : true,//是否开启多行表格
				"isRowSelect" : false//是否开启行选中
			});
		})
	</script>
</body>
</html>