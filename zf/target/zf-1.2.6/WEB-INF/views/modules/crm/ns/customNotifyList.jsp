<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>自定义消息管理</title>
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
      	//发布消息
		function publishNotify(url,id,message){
 			confirm(message,'info',function(){
				$("#notifyId").val(id);
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/ns/customNotify/">自定义消息列表</a></small>
            <shiro:hasPermission name="crm:ns:customNotify:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/crm/ns/customNotify/form">自定义消息添加</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border zf-query">
                <h5>查询条件</h5>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
            <form:form id="searchForm" modelAttribute="notify" action="${ctx}/crm/ns/customNotify/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input id="notifyId" name="id" type="hidden"/>
				<input id="publishFlag" type="hidden" name="flag" >
                <div class="box-body">
                    <div class="row">
                   	 	<div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">标题</label>
                                <div class="col-sm-7">  
                                    <form:input path="searchParameter.keyWord" class="form-control" placeholder="请输入标题查询"/>
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
                                <th>类型</th>
                                <th>标题</th>
                                <th>内容</th>
                                <th>状态</th>
                                <th>短信标记</th>
								<th style="display: none">创建者</th>
								<th style="display: none">创建时间</th>
								<th style="display: none">更新者</th>
								<th style="display: none">更新时间</th>
								<th style="display: none">备注信息</th>
                                <shiro:hasPermission name="crm:ns:notify:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="notify" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${fns:getDictLabel(notify.type,'crm_ns_notify_type','') }
									</td>
                                    <td title=" ${notify.title}">
										${fns:abbr(notify.title, 20) }
									</td>
                                    <td title="${notify.content }">
										${fns:abbr(notify.content, 50) }
									</td>
								   <td>
                                        <c:choose>
                                        	<c:when test="${notify.status eq '1' }">
                                        		<span class="label label-default">新建</span>
                                        	</c:when>
                                        	<c:when test="${notify.status eq '2' }">
                                        		<span class="label label-primary">未发布</span>
                                        	</c:when>
                                        	<c:when test="${notify.status eq '3' }">
                                        		<span class="label label-success">已发布</span>
                                        	</c:when>
                                        </c:choose>
									</td>
                                    <td>
                                        ${fns:getDictLabel(notify.smsFlag,'yes_no','') }
									</td>
									<td data-hide="true">
                                        ${fns:getUserById(notify.createBy.id).name }
									</td>
									<td data-hide="true">
                                        <fmt:formatDate value="${notify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
                                        ${fns:getUserById(notify.updateBy.id).name }
									</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${notify.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td data-hide="true">
                                        ${notify.remarks}
									</td>
                                    <shiro:hasPermission name="crm:ns:notify:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/crm/ns/notify/info?id=${notify.id}'">详情</button>
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
            "ordering" : false,
            //"order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:3},
                {"orderable":false,targets:6},
                {"orderable":false,targets:9},
                {"orderable":false,targets:7}
                
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