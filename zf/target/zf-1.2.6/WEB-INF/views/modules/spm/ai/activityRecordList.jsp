<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>活动参与记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ai/activityRecord/">活动参与记录列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="activityRecord" action="${ctx}/spm/ai/activityRecord/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="searchParameter.keyWord" class="col-sm-3 control-label">查询条件</label>
                                <div class="col-sm-7">
                                    <form:input path="searchParameter.keyWord" type="text" class="form-control" placeholder="请输入活动编码或名称或会员或会员账号查询"/>
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
                                <th>活动编码</th>
                                <th>活动名称</th>
                                <th>会员账号</th>
                                <th>参与时间</th>
                                <th>备注信息</th>
                                <%--<shiro:hasPermission name="spm:ai:activityRecord:edit"><th>操作</th></shiro:hasPermission>--%>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="activityRecord" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        ${activityRecord.activity.code}
                                    </td>
                                    <td>
                                        ${activityRecord.activity.name}
                                    </td>
                                    <td>
                                        ${activityRecord.member.usercode}
                                    </td>

                                    <td>
                                        <fmt:formatDate value="${activityRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        ${activityRecord.remarks}
                                    </td>
                                    <%--<shiro:hasPermission name="spm:ai:activityRecord:edit"><td>--%>
                                        <%--<div class="btn-group zf-tableButton">--%>
                                            <%--<button type="button" class="btn btn-sm btn-info"--%>
                                                <%--onclick="window.location.href='${ctx}/spm/ai/activityRecord/info?id=${activityRecord.id}'">详情</button>--%>
                                            <%--<button type="button"--%>
                                                <%--class="btn btn-sm btn-info dropdown-toggle"--%>
                                                <%--data-toggle="dropdown">--%>
                                                <%--<span class="caret"></span>--%>
                                            <%--</button>--%>
                                        <%--</div>--%>
                                    <%--</td></shiro:hasPermission>--%>
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
            "columnDefs":[
                {"orderable":false,targets:1},
                {"orderable":false,targets:2}
                
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