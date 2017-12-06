<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>会员消息管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/ns/memberNotify/">会员消息列表</a></small>
            <shiro:hasPermission name="crm:ns:memberNotify:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/crm/ns/memberNotify/form">会员消息添加</a>
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
            
            <form:form id="searchForm" modelAttribute="memberNotify" action="${ctx}/crm/ns/memberNotify/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">会员账号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="member.usercode" id="musercode" verifyType="99" tip="请输入会员账号" isMandatory="false" isSpring="true"></sys:inputverify>
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
                                <th>会员账号</th>
                                <th>标题</th>
                                <th>查看标记</th>
                                <th>查看时间</th>
                                <th>创建时间</th>
                                <th style="display: none;">备注信息</th>
                               <%--  <shiro:hasPermission name="crm:ns:memberNotify:edit"><th>操作</th></shiro:hasPermission> --%>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="memberNotify" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${memberNotify.member.usercode}
									</td>
                                    <td>
                                        ${memberNotify.title}
									</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${memberNotify.readFlag eq '0' }">
                                                <span class="label label-primary">${fns:getDictLabel(memberNotify.readFlag, 'yes_no', '') }</span>
                                            </c:when>
                                            <c:when test="${memberNotify.readFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(memberNotify.readFlag, 'yes_no', '') }</span>
                                            </c:when>
                                        </c:choose>
									</td>
                                    <td>
                                        <fmt:formatDate value="${memberNotify.readTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td>
                                        <fmt:formatDate value="${memberNotify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td data-hide="true">
                                        ${fns:abbr(memberNotify.remarks, 20)}
									</td>
                                    <%-- <shiro:hasPermission name="crm:ns:memberNotify:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/crm/ns/memberNotify/form?id=${memberNotify.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/crm/ns/memberNotify/delete?id=${memberNotify.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该会员消息吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/crm/ns/memberNotify/info?id=${memberNotify.id}" target="">详情</a></li>
                                            </ul>
                                        </div>
                                    </td></shiro:hasPermission> --%>
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
            "order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3}, 
                {"orderable":false,targets:4},
                {"orderable":false,targets:6}
                
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