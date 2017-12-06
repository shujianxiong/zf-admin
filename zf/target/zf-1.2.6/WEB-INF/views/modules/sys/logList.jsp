<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>日志管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/log/log/">日志列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="log" action="${ctx}/sys/log/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="title" class="col-sm-3 control-label">操作菜单</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="title" id="title" verifyType="0" tip="请输入操作菜单" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="uno" class="col-sm-3 control-label">操作用户</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="createBy.loginName" id="uno" verifyType="0" tip="请输入操作用户" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="beginDate" class="col-sm-3 control-label">开始时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="beginDate" inputName="beginDate" tip="请选择操作开始时间" inputId="beginDate" isMandatory="false" value="${log.beginDate }"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="endDate" class="col-sm-3 control-label">截止时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="endDate" inputName="endDate" tip="请选择操作结束时间" inputId="endDate" isMandatory="false"  value="${log.endDate }"></sys:datetime>
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
                                <th>操作时间</th>
								<th>操作菜单</th>
								<th>操作用户</th>
								<th>所在公司</th>
								<th>所在部门</th>
								<th>URI</th>
								<th>提交方式</th>
								<th>操作者IP</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="log" varStatus="status">
                                <tr>
                                    <td><fmt:formatDate value="${log.createDate}" type="both"/></td>
                                    <td>${log.title}</td>
                                    <td>${log.createBy.loginName}</td>
                                    <td>${log.createBy.company.name}</td>
                                    <td>${log.createBy.office.name}</td>
                                    <td><strong>${log.requestUri}</strong></td>
                                    <td>${log.method}</td>
                                    <td>${log.remoteAddr}</td>
                                </tr>
                                
                                <c:if test="${not empty log.exception}"><tr>
					                <td colspan="8" style="word-wrap:break-word;word-break:break-all;">
					<%--                    用户代理: ${log.userAgent}<br/> --%>
					<%--                    提交参数: ${fns:escapeHtml(log.params)} <br/> --%>
					                                        异常信息: <br/>
					                    ${fn:replace(fn:replace(fns:escapeHtml(log.exception), strEnter, '<br/>'), strTab, '&nbsp; &nbsp; ')}</td>
                                    </tr>
                                </c:if>
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
            "order": [[ 0, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
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