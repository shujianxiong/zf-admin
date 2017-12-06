<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调研活动模板列表管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ac/acActivityTemplate/list">活动模板列表</a></small>
				
				<shiro:hasPermission name="spm:ac:acActivityTemplate:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/spm/ac/acActivityTemplate/form">活动模板${not empty Template.id?'修改':'添加'}</a></small></shiro:hasPermission>
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
	
				<form:form id="searchForm" modelAttribute="acActivityTemplate" action="${ctx}/spm/ac/acActivityTemplate/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="id" name="id" type="hidden"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="keyWordId" class="col-sm-3 control-label">关键字</label>
									<div class="col-sm-7">
										<sys:inputverify name="name" tip="请输入活动模板名称进行检索" verifyType="0" isMandatory="false" isSpring="true" id="name"></sys:inputverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="activeFlagId" class="col-sm-3 control-label">启用状态</label>
									<div class="col-sm-7">
										<sys:selectverify name="activeFlag" tip="请选择启用状态" verifyType="0" isMandatory="false" dictName="yes_no" id="activeFlagId"></sys:selectverify>
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
									<th>模板名称</th>
									<th>模板描述</th>
									<th>模板样式效果图</th>
									<th>模板文件路径</th>
									<th>启用状态</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<th style="display:none;">备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="acActivityTemplate" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td title="${acActivityTemplate.name}">
												${fns:abbr(acActivityTemplate.name, 30)}
										</td>
										<td  title="${acActivityTemplate.description}">${fns:abbr(acActivityTemplate.description, 30) }</td>
										<td>
											<%-- <c:forEach items="${fn:split(acActivityTemplate.photo, '|') }" var="pic">
												<img src="${imgHost }${pic}" data-big data-src="${imgHost }${pic}" style="width:20px;height:20px;">
											</c:forEach> --%>
										
											<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(acActivityTemplate.photo, '|', '')}" data-big data-src="${imgHost }${fn:replace(acActivityTemplate.photo, '|', '')}" style="width:20px;height:20px;">
										</td>
										<td>
											${acActivityTemplate.dirPath }
										</td>
										<td>
											<c:choose>
												<c:when test="${acActivityTemplate.activeFlag eq '0'}">
													<span class="label label-primary">${fns:getDictLabel(acActivityTemplate.activeFlag, 'yes_no', '')}</span>
												</c:when>
												<c:when test="${acActivityTemplate.activeFlag eq '1'}">
													<span class="label label-success">${fns:getDictLabel(acActivityTemplate.activeFlag, 'yes_no', '')}</span>
												</c:when>
											</c:choose>
										</td>
										<td data-hide="true">
											${fns:getUserById(acActivityTemplate.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${acActivityTemplate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(acActivityTemplate.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${acActivityTemplate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td  data-hide="true">
											${acActivityTemplate.remarks }
										</td>
										<td>
											 <shiro:hasPermission name="spm:ac:acActivityTemplate:edit">
												<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/ac/acActivityTemplate/form?id=${acActivityTemplate.id}'">修改</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
									                </button>
								                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                  	<c:choose>
								                  		<c:when test="${acActivityTemplate.activeFlag eq '1' }">
										                  	<li><a href="#this" data-href="${ctx}/spm/ac/acActivityTemplate/updateStatus"  data-message="确定要停用吗？" data-json="{'id':'${acActivityTemplate.id }','activeFlag':'0'}" onclick="return ZF.xconfirm(this);">停用</a></li>
								                  		</c:when>
								                  		<c:when test="${acActivityTemplate.activeFlag eq '0' }">
								                  			<li><a href="#this" data-href="${ctx}/spm/ac/acActivityTemplate/updateStatus"  data-message="确定要启用吗？" data-json="{'id':'${acActivityTemplate.id }','activeFlag':'1'}" onclick="return ZF.xconfirm(this);">启用</a></li>
								                  		</c:when>
								                  	</c:choose>
								                  	<li><a href="#this" data-href="${ctx}/spm/ac/acActivityTemplate/delete"  data-message="确定要删除该活动模板吗？" data-json="{'id':'${acActivityTemplate.id }'}" onclick="return ZF.xconfirm(this);">删除</a></li>
								                  	<li><a href="${ctx}/spm/ac/acActivityTemplate/info?id=${acActivityTemplate.id}">详情</a></li>
												  	</ul>
												</div>
								            </shiro:hasPermission>
								            <shiro:lacksPermission name="spm:ac:acActivityTemplate:edit">
								            	<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/ac/acActivityTemplate/info?id=${acActivityTemplate.id}'">详情</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
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
		ZF.bigImg();
		
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
		//表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"ordering" : false,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){},//行取消选中回调
			"addRow":{
				"eventId":"#addRow",
				"getData":function(){
					return ["<td class=\"details-control text-center\"><i class=\"fa fa-plus-square-o text-success\"></i></td>",
					        "<td>2</td>",
					        "<td>3</td>",
					        "<td>4</td>",
					        "<td>5</td>",
					        "<td>6</td>",
					        "<td>7</td>",
					        "<td data-hide=\"true\">8</td>",
					        "<td data-hide=\"true\">9</td>",
					        "<td data-hide=\"true\">10</td>",
					        "<td data-hide=\"true\">11</td>",
					        "<td title=\"测试\">12</td>",
					        "<td>13</td>"
					       ];
				},
				"callBack":function(){
					console.log("行添加结束")
				}
				
			}
		});
	});
	
	
	function changeFlag(message,href){
		confirm(message,"info",function(){
			window.location.href=href;
		});
		return false;
	}
	</script>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</body>
</html>