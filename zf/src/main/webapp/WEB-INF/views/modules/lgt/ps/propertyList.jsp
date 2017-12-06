<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>属性管理</title>
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
		
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/property/">属性配置列表</a></small>
	        
	        <shiro:hasPermission name="lgt:ps:lgtPsProperty:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/property/form">属性添加</a></small></shiro:hasPermission>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<form:form id="searchForm" modelAttribute="property" action="${ctx}/lgt/ps/property/" method="post" class="form-horizontal">
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
								<sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="分类查询" tip="请选择分类" id="category" labelName="category.categoryName" name="category.id" labelWidth="3" inputWidth="7"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParam" class="col-sm-3 control-label" >属性名称</label>
									<div class="col-sm-7">
										<form:input id="searchParam" path="propName" htmlEscape="false" maxlength="100" class="form-control" placeholder="属性名称查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
                                <div class="form-group">
                                    <label for="searchParam" class="col-sm-3 control-label" >是否必填</label>
                                    <div class="col-sm-7">
                                        <sys:selectverify name="necessaryFlag" tip="请选择是否必填" isMandatory="false" verifyType="" dictName="yes_no" id="necessaryFlag"></sys:selectverify>
                                    </div>
                                </div>
                            </div>
						</div>
						<div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="searchParam" class="col-sm-3 control-label" >属性类型</label>
                                    <div class="col-sm-7">
                                        <sys:selectverify name="propType" tip="请选择属性类型" verifyType="0" isMandatory="false" dictName="lgt_ps_property_propType" id="valueType"></sys:selectverify>
                                    </div>
                                </div>
                            </div>
						   <div class="col-md-4">
                                <div class="form-group">
                                    <label for="searchParam" class="col-sm-3 control-label" >适用范围</label>
                                    <div class="col-sm-7">
                                        <sys:selectverify name="suitType" tip="请选择适用范围" verifyType="0" isMandatory="false" dictName="lgt_ps_property_sultType" id="suitType"></sys:selectverify>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="searchParam" class="col-sm-3 control-label" >取值类型</label>
                                    <div class="col-sm-7">
                                        <sys:selectverify name="valueType" tip="请选择取值类型" verifyType="0" isMandatory="false" dictName="lgt_ps_property_valueType" id="valueType"></sys:selectverify>
                                    </div>
                                </div>
                            </div>
						</div>
						<div class="row">
						  <div class="col-md-4">
                                <div class="form-group">
                                    <label for="searchParam" class="col-sm-3 control-label" >是否筛选类型</label>
                                    <div class="col-sm-7">
                                        <sys:selectverify name="filterFlag" tip="请选择是否筛选类型" verifyType="0" isMandatory="false" dictName="yes_no" id="filterFlag"></sys:selectverify>
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
				<div class="box-herder with-border">
				
				</div>
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>属性名称</th>
									<th>是否必填</th>
									<th>属性类型</th>
									<th>适用范围</th>
									<th>取值类型</th>
									<th>是否筛选可用</th>
									<th>是否前台展示</th>
									<th>是否属于展示标题</th>
									<th>排序序号</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th style="display:none">更新者</th>
									<th style="display:none">更新时间</th>
									<th style="display:none">备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="property" varStatus="status">
								<tr data-index="${status.index }">
									<td class="details-control text-center">
										<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td>
										 ${property.propName}
									</td>
									<td>
										<c:if test="${property.necessaryFlag=='1' }">
											<span class="label label-success">${fns:getDictLabel(property.necessaryFlag, 'yes_no', '')}</span>
										</c:if>
										<c:if test="${property.necessaryFlag=='0' }">
											<span class="label label-primary">${fns:getDictLabel(property.necessaryFlag, 'yes_no', '')}</span>
										</c:if>
									</td>
									<td>
									    <c:choose>
									       <c:when test="${property.propType eq '1' }">
									           <span class="label label-default">${fns:getDictLabel(property.propType, 'lgt_ps_property_propType', '')}</span>
									       </c:when>
									       <c:when test="${property.propType eq '2' }">
                                               <span class="label label-danger">${fns:getDictLabel(property.propType, 'lgt_ps_property_propType', '')}</span>
                                           </c:when>
									    </c:choose>
									</td>
									<td>
										${fns:getDictLabel(property.suitType, 'lgt_ps_property_sultType', '')}
									</td>
									<td>
										${fns:getDictLabel(property.valueType, 'lgt_ps_property_valueType', '')}
									</td>
									<td>
									   <span class="label label-primary">${fns:getDictLabel(property.filterFlag, 'yes_no', '') }</span>
									</td>
									<td>
										<span class="label label-primary">${fns:getDictLabel(property.showFlag, 'yes_no', '') }</span>
									</td>
									<td>
										<span class="label label-primary">${fns:getDictLabel(property.titleFlag, 'yes_no', '') }</span>
									</td>
									<td>
										${property.orderNo}
									</td>
									<td data-hide="true">
										${fns:getUserById(property.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${property.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(property.updateBy.id).name}
									</td>
									<td data-hide="true"> 
										<fmt:formatDate value="${property.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:abbr(property.remarks,15)}
									</td>
									<td>
										<div class="btn-group zf-tableButton">
						                  <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/ps/property/info?id=${property.id}'">详情</button>
						                  <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
						                    <span class="caret"></span>
						                  </button>
										  <shiro:hasPermission name="lgt:ps:lgtPsProperty:edit">
							                  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                    <li><a href="${ctx}/lgt/ps/property/form?id=${property.id}" style="color:#fff">修改</a></li>
							                    <shiro:hasPermission name="lgt:ps:lgtPsProperty:edit">
							                    <li><a href="${ctx}/lgt/ps/property/delete?id=${property.id}" style="color:#fff" onclick="return ZF.delRow('确认要删除该属性吗？',this.href)">删除</a></li>
							                    </shiro:hasPermission>
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
	$(function () {
		 //表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			//"order": [[ 6, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
 				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
			    {"orderable":false,targets:5},
				{"orderable":false,targets:7},
			    {"orderable":false,targets:8},
			    {"orderable":false,targets:9},
			    {"orderable":false,targets:10},
				{"orderable":false,targets:11},
				{"orderable":false,targets:12},
				{"orderable":false,targets:13}
            ],
			"ordering" : false,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){}//行取消选中回调
		});
	});
	
	</script>
</body>
</html>