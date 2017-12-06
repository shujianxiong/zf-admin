<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>设计师管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section  class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/bs/designer/list">设计师列表</a></small>
				<shiro:hasPermission name="lgt:bs:designer:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/bs/designer/form">设计师${not empty designer.id?'修改':'添加'}</a></small></shiro:hasPermission>
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
				<form:form id="searchForm" modelAttribute="designer" action="${ctx}/lgt/bs/designer/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="name" class="col-sm-3 control-label">名称</label>
									<div class="col-sm-7">
										<sys:inputverify name="name" id="name" verifyType="0" tip="请输入设计师名称" isMandatory="false" isSpring="true"></sys:inputverify>
									</div>
								</div>
							</div>
							<div class="col-md-4">
                                <div  class="form-group">
                                    <label for="name" class="col-sm-3 control-label">是否启用</label>
                                    <div class="col-sm-7">
                                        <sys:selectverify name="usableFlag" tip="请选择" verifyType="0" isMandatory="false" dictName="yes_no" id="usableFlag"></sys:selectverify>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div  class="form-group">
                                    <label for="name" class="col-sm-3 control-label">是否推荐</label>
                                    <div class="col-sm-7">
                                        <sys:selectverify name="recommendFlag" tip="请选择" verifyType="0" isMandatory="false" dictName="yes_no" id="recommendFlag"></sys:selectverify>
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
									<th>姓名</th>
									<th>性别</th>
									<th>年龄</th>
									<th>国籍</th>
									<th>设计风格</th>
									<th>标签</th>
									<th>头像</th>
									<th>列表图</th>
									<th>形象图</th>
									<th>简介</th>
									<th>是否启用</th>
									<th>是否推荐</th>
									<th style="display:none">创建者</th>
                                    <th style="display:none">创建时间</th>
                                    <th style="display:none">更新者</th>
                                    <th style="display:none">更新时间</th>
                                    <th style="display:none">备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="designer" varStatus="status">
								<tr data-id="${designer.id}"  data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
									<td title="${designer.name}">
										${designer.name}
									</td>
									<td>
										${fns:getDictLabel(designer.sex, 'sex', '')}
									</td>
									<td>
										${designer.age}
									</td>
									<td>
										${fns:getDictLabel(designer.country, 'country', '')}
									</td>
									<td>
										${fns:getDictLabel(designer.designStyle, 'lgt_bs_designer_designStyle', '')}
									</td>
									<td>
										${designer.tags}
									</td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(designer.gravatar, '|', '')}" data-big data-src="${imgHost }${designer.gravatar}" width="20px" height="20px" />
									</td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(designer.listPhoto, '|', '')}" data-big data-src="${imgHost }${designer.listPhoto}" width="20px" height="20px" />
									</td>
									<td>
										<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(designer.headPhoto, '|', '')}" data-big data-src="${imgHost }${designer.headPhoto}" width="20px" height="20px" />
									</td>
									<td title="${designer.summary }">
										${fns:abbr(designer.summary,40)}
									</td>
									<td>
										<c:choose>
											<c:when test="${designer.usableFlag eq '1'}">
												<span class="label label-success">${fns:getDictLabel(designer.usableFlag, 'yes_no', '')}</span>
											</c:when>
											<c:when test="${designer.usableFlag eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(designer.usableFlag, 'yes_no', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${designer.recommendFlag eq '1'}">
												<span class="label label-success">${fns:getDictLabel(designer.recommendFlag, 'yes_no', '')}</span>
											</c:when>
											<c:when test="${designer.recommendFlag eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(designer.recommendFlag, 'yes_no', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td data-hide="true">
                                        ${fns:getUserById(designer.createBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${designer.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(designer.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${designer.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(designer.remarks, 15)}
                                    </td>
									<td>
									  	<shiro:hasPermission name="lgt:bs:designer:edit">
											<div class="btn-group zf-tableButton">
							                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/bs/designer/form?id=${designer.id}'">修改</button>
							                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
							                   		<span class="caret"></span>
							                  	</button>
							                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                  		<li><a onclick="return changeFlag('确定要执行该操作吗？', '${ctx}/lgt/bs/designer/updateStatus?id=${designer.id}')" href="#this">${designer.usableFlag eq '0'?"启用":"停用"}</a></li>
								                    <li><a href="${ctx}/lgt/bs/designer/delete?id=${designer.id}" style="color:#fff" onclick="return ZF.delRow('确定要删除该设计师吗？',this.href)">删除</a></li>
							                  		<li><a href="${ctx}/lgt/bs/designer/info?id=${designer.id}">详情</a></li>
											  	</ul>
											</div>
					               		</shiro:hasPermission>
					               		<shiro:lacksPermission name="lgt:bs:designer:edit">
					               			<div class="btn-group zf-tableButton">
							                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/bs/designer/info?id=${designer.id}'">详情</button>
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
			
			//表格初始化
		 	var t=ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,//关闭搜索
				"order": [[ 3, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
                    {"orderable":false,targets:0},
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:4},
					{"orderable":false,targets:5},
					{"orderable":false,targets:6},
					{"orderable":false,targets:7},
					{"orderable":false,targets:8},
					{"orderable":false,targets:9},
					{"orderable":false,targets:10},
					{"orderable":false,targets:11},
					{"orderable":false,targets:12},
					{"orderable":false,targets:13},
					{"orderable":false,targets:14},
					{"orderable":false,targets:15},
					{"orderable":false,targets:16},
					{"orderable":false,targets:17},
					{"orderable":false,targets:18}
	            ],
	            "ordering" : true,//开启排序
	            "info" : false,
	            "autoWidth" : false,
	            "multiline":true,//是否开启多行表格
	            "isRowSelect":true,//是否开启行选中
	            "rowSelect":function(tr){},//行选中回调
	            "rowSelectCancel":function(tr){}//行取消选中回调
			});
			
		});
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
		
		function changeFlag(message,href){
			confirm(message,"info",function(){
				window.location.href=href;
			});
			return false;
		}
		
	</script>
</body>
</html>