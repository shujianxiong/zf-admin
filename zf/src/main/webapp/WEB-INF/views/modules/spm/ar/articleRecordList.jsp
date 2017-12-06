<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>宣传推广文章管理</title>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ar/articleRecord/list">文章阅读记录列表</a></small>
		      </h1>
		</section>
		<sys:tip content="${message }"/>
		<section class="content">
			<form:form id="searchForm" modelAttribute="articleRecord" action="${ctx}/spm/ar/articleRecord/list" method="post" class="form-horizontal">
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
			        					<form:input path="searchParameter.keyWord" class="form-control" placeholder="请输入会员账号或文章名称查询" />
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
		    		<div class="table-reponsive">
		    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>阅读人IP</th>
									<th>阅读人账号</th>
									<th>阅读人姓名</th>
									<th>阅读次数</th>
									<th>文章名称</th>
									<th>文章类别</th>
									<th>文章标题</th>
									<th>创建者</th>
									<th>创建时间</th>
									<th>更新者</th>
									<th>更新时间</th>
									<th>备注</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="articleRecord">
								<tr>
									<td>${articleRecord.ip }</td>
									<td>
										${articleRecord.member.usercode}
									</td>
									<td>
										${articleRecord.member.name }
									</td>
									<td>
										${articleRecord.readCount }
									</td>
									<td title="${ articleRecord.article.name}">
										${fns:abbr(articleRecord.article.name,16) }
									</td>
									<td>
										<c:choose>
											<c:when test="${articleRecord.article.category eq '1' }">
												<span class="label label-primary">${fns:getDictLabel(articleRecord.article.category,'spm_ar_article_category','')}</span>
											</c:when>
											<c:when test="${articleRecord.article.category eq '2' }">
												<span class="label label-success">${fns:getDictLabel(articleRecord.article.category,'spm_ar_article_category','')}</span>
											</c:when>
											<c:otherwise>
												<span class="label label-info">${fns:getDictLabel(articleRecord.article.category,'spm_ar_article_category','')}</span>
											</c:otherwise>
										</c:choose>
										
									</td>
									<td title="${ articleRecord.article.title}">
										${fns:abbr(articleRecord.article.title,32) }
									</td>
									<td>
										${fns:getUserById(articleRecord.createBy.id).name }
									</td>
									<td>
										<fmt:formatDate value="${articleRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										${fns:getUserById(articleRecord.updateBy.id).name }
									</td>
									<td>
										<fmt:formatDate value="${articleRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td title="${articleRecord.remarks }">
										${fns:abbr(articleRecord.remarks,48)}
									</td>
									<td>
						              	<div class="btn-group zf-tableButton">
					                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/spm/ar/articleRecord/info?id=${articleRecord.id}'">详情</button>
						                  	<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
						                    	<span class="caret"></span>
						                  	</button>
						                    <%-- <shiro:hasPermission name="spm:ar:articleRecord:edit">
							                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
														<li><a  href="${ctx}/spm/ar/articleRecord/delete?id=${articleRecord.id}" onclick="return ZF.delRow('确认要删除该文章阅读记录吗？', this.href)">删除</a></li>
							                  	</ul>
						                    </shiro:hasPermission> --%>
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
<script>
  $(function () {
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
	})
  	
  });
</script>
</body>
</html>