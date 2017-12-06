<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>会员信誉流水管理</title>
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
	            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/mi/creditDetail/">会员信誉流水列表</a></small>
	            <shiro:hasPermission name="crm:mi:creditDetail:edit">
		            <small>|</small>
	                <small>
	                    <i class="fa-form-edit"></i><a href="${ctx}/crm/mi/creditDetail/form">会员信誉流水添加</a>
	                </small>
	            </shiro:hasPermission>
	        </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<form:form id="searchForm" modelAttribute="creditDetail" action="${ctx}/crm/mi/creditDetail/list" method="post" class="form-horizontal">
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
										<form:input path="searchParameter.keyWord" htmlEscape="false" maxlength="64" class="form-control" placeholder="请输入会员账号或姓名或联系电话进行查询"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">	
								<div class="form-group">
									<label for="changeType" class="col-sm-3 control-label">变动类型</label>
									<div class="col-sm-7">
										<form:select path="changeType" class="form-control select2">
											<form:option value=""  label="所有"/>
											<form:options items="${fns:getDictList('add_decrease')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">		
								<div class="form-group">
									<label for="changeReasonType" class="col-sm-3 control-label">变动原因</label>
									<div class="col-sm-7">
										<form:select path="changeReasonType" class="form-control select2">
											<form:option value=""  label="所有"/>
											<form:options items="${fns:getDictList('crm_mi_credit_detail_changeReasonType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
	        <div class="box box-soild">
	            <div class="box-body">
	                <div class="table-responsive">
	                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
	                        <thead>
	                            <tr>
	                                <th class="zf-dataTables-multiline"></th>
	                                <th>会员账号</th>
	                                <th>变动类型</th>
	                                <th>变动信誉数量</th>
	                                <th>变动后信誉</th>
	                                <th>变动原因</th>
	                                <th>变动时间</th>
	                                <th>操作人类型</th>
	                                <th>来源业务编号</th>
	                                <th style="display: none">创建时间</th>
	                                <th style="display: none">更新时间</th>
	                                <th>备注信息</th>
	                                <shiro:hasPermission name="crm:mi:creditDetail:edit"><th>操作</th></shiro:hasPermission>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <c:forEach items="${page.list}" var="creditDetail" varStatus="status">
	                                <tr data-index="${status.index }">
	                                    <td class="details-control text-center">
	                                        <i class="fa fa-plus-square-o text-success"></i>
	                                    </td>
	                                    <td>
	                                        ${fns:getMemberById(creditDetail.member.id).usercode }
	                                    </td>
	                                    <td>
											<c:choose>
												<c:when test="${creditDetail.changeType eq 'A' }">
													<span class="label label-success">${fns:getDictLabel(creditDetail.changeType, 'add_decrease', '') }</span>
												</c:when>
												<c:when test="${creditDetail.changeType eq 'D' }">
													<span class="label label-info">${fns:getDictLabel(creditDetail.changeType, 'add_decrease', '') }</span>
												</c:when>
											</c:choose>
										</td>
	                                    <td>
	                                        ${creditDetail.changeCredit}
	                                    </td>
	                                    <td>
	                                        ${creditDetail.lastCredit}
	                                    </td>
	                                    <td>
											<span class="label label-primary">${fns:getDictLabel(creditDetail.changeReasonType, 'crm_mi_credit_detail_changeReasonType', '') }</span>
										</td>
	                                    <td>
	                                        <fmt:formatDate value="${creditDetail.changeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                    </td>
	                                    <td>
											<span class="label label-primary">${fns:getDictLabel(creditDetail.operaterType, 'operater_type', '') }</span>
										</td>
	                                    <td>
	                                        ${creditDetail.operateSourceNo}
	                                    </td>
	                                    <td data-hide="true">
											<fmt:formatDate value="${creditDetail.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
	                                    <td data-hide="true">
	                                        <fmt:formatDate value="${creditDetail.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                    </td>
	                                    <td>
	                                        ${creditDetail.remarks}
	                                    </td>
	                                    <shiro:hasPermission name="crm:mi:creditDetail:edit"><td>
	                                        <div class="btn-group zf-tableButton">
	                                            <button type="button" class="btn btn-sm btn-info"
	                                                onclick="window.location.href='${ctx}/crm/mi/creditDetail/info?id=${creditDetail.id}'">详情</button>
	                                            <button type="button"
	                                                class="btn btn-sm btn-info dropdown-toggle"
	                                                data-toggle="dropdown">
	                                                <span class="caret"></span>
	                                            </button>
	                                        </div>
	                                    </td></shiro:hasPermission>
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
        
        ZF.bigImg();
         
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
          
        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : true,
            "order": [[ 10, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
				{"orderable":false,targets:0}, 
				{"orderable":false,targets:1}, 
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:5},
				{"orderable":false,targets:7},
				{"orderable":false,targets:8},
				{"orderable":false,targets:9},
				{"orderable":false,targets:11},
				{"orderable":false,targets:12}
                
            ],
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        })
      });
      
   </script>
</body>
</html>