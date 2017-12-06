<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/idx/pd/channel/">频道列表</a></small>
				<shiro:hasPermission name="idx:pd:channel:edit">
					<small>|</small>
					<small><i class="fa-form-edit"></i><a
						href="${ctx}/idx/pd/channel/form">频道${not empty designer.id?'修改':'添加'}</a></small>
				</shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		
		<section  class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
				<form:form id="searchForm" modelAttribute="channel" action="${ctx}/idx/pd/channel/" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="name" class="col-sm-3 control-label">频道名称</label>
									<div class="col-sm-7">
										<sys:inputverify name="name" id="name" verifyType="0" tip="请输入频道名称" isMandatory="false" isSpring="true"></sys:inputverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="companyName" class="col-sm-3 control-label">频道类型</label>
									<div class="col-sm-7">
										<form:select path="type" class="input-medium">
											<form:option value="" label=""/>
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('idx_pd_channel_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="companyName" class="col-sm-3 control-label">展示区域</label>
									<div class="col-sm-7">
										<form:select path="displayArea" class="input-medium">
											<form:option value="" label=""/>
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('idx_pd_channel_displayArea')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
	            </form:form>
				</div>
				<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>频道名称</th>
									<th>频道类型</th>
									<th>展示区域</th>
									<th>图标</th>
									<th>背景图</th>
									<th>链接地址</th>
									<th>排列序号</th>
									<th>是否启用</th>
									<th>备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="channel">
								<tr>
									<td>
										${channel.name}
									</td>
									<td>
										${fns:getDictLabel(channel.type, 'idx_pd_channel_type', '')}
									</td>
									<td>
										${fns:getDictLabel(channel.displayArea, 'idx_pd_channel_displayArea', '')}
									</td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(channel.icon, '|', '')}" data-big data-src="${imgHost }${channel.icon}" width="20px" height="20px" />
									</td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(channel.bgPhoto, '|', '')}" data-big data-src="${imgHost }${channel.bgPhoto}" width="20px" height="20px" />
									</td>
									<td title="${channel.url}">
										${fns:abbr(channel.url,30)}
									</td>
									<td>
										${channel.orderNo}
									</td>
									<td>
									    <c:choose>
									       <c:when test="${channel.usableFlag eq '0' }">
									           <span class="label label-primary">${fns:getDictLabel(channel.usableFlag, 'yes_no', '')}</span>
									       </c:when>
									       <c:when test="${channel.usableFlag eq '1' }">
									           <span class="label label-success">${fns:getDictLabel(channel.usableFlag, 'yes_no', '')}</span>
									       </c:when>
									    </c:choose>
										
									</td>
									<td title="${channel.remarks}">
										${fns:abbr(channel.remarks,15)}
									</td>
									<td>
										<div class="btn-group zf-tableButton">
						                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/idx/pd/channel/info?id=${channel.id}'">详情</button>
						                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
						                    	<span class="caret"></span>
						                  	</button>
						                    <shiro:hasPermission name="idx:pd:channel:edit">
							                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                    <li><a href="${ctx}/idx/pd/channel/form?id=${channel.id}">修改</a></li>
								                    <li><a href="${ctx}/idx/pd/channel/updateFlag?id=${channel.id}" target="">${channel.usableFlag eq '1'?'停用':'启用' }</a></li>
								                    <c:if test="${channel.usableFlag eq '0' }"> <!-- 非启用状态允许删除 -->
								                        <li><a href="#this" onclick="confirmxFormSubmit('确认要删除该频道吗？','${ctx}/idx/pd/channel/delete?id=${channel.id}')">删除</a></li>
								                    </c:if>
							                  	</ul>
					                    	</shiro:hasPermission>
						                </div>
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
			ZF.bigImg();
			//表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,//关闭搜索
				"ordering" : false,
				//"order": [[ 6, "desc" ]],			// 指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},	//第 0、3、4、5、7、8、9列不排序
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
				"info" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"isRowSelect" : true,//是否开启行选中
				"rowSelect" : function(tr) {
					purchaseId = tr.attr("data-value");
				},
				"rowSelectCancel" : function(tr) {
					purchaseId = null;
				}
			})
		});
		
		function confirmxFormSubmit(message, href) {
			confirm(message, "warning", function() {
				window.location.href = href;
			});
		}
	</script>
</body>
</html>