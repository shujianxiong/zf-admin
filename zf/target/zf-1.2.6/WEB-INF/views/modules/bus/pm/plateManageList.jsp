<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>托盘管理管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/pm/plateManage/">托盘管理列表</a></small>
            <shiro:hasPermission name="bus:pm:plateManage:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/pm/plateManage/form">托盘管理添加</a>
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
            
            <form:form id="searchForm" modelAttribute="plateManage" action="${ctx}/bus/pm/plateManage/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="plateNo" class="col-sm-3 control-label">托盘编号</label>
                                <div class="col-sm-7">  
                                    <input type="text" name="plateNo" class="form-control" value="${plateManage.plateNo}" placeholder="请输入托盘编号"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="plateStatus" class="col-sm-3 control-label">托盘状态</label>
                                <div class="col-sm-7">
                                    <form:select path="plateStatus">
                                        <form:option value="" label="请选择"/>
                                        <form:option value="1" label="启用"/>
                                        <form:option value="0" label="停用"/>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="plateUsed" class="col-sm-3 control-label">托盘使用状态</label>
                                <div class="col-sm-7">
                                    <form:select path="plateUsed">
                                        <form:option value="" label="请选择"/>
                                        <form:option value="1" label="使用中"/>
                                        <form:option value="0" label="空闲"/>
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
                                <th>托盘编号</th>
                                <th>托盘状态</th>
                                <th>托盘使用情况</th>
                                <th>创建人</th>
                                <th>创建时间</th>
                                <th>更新人</th>
                                <th>更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="bus:pm:plateManage:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="plateManage" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        ${plateManage.plateNo}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${plateManage.plateStatus eq '1'}">
                                                <span class="label label-success">启用</span>
                                            </c:when>
                                            <c:when test="${plateManage.plateStatus eq '0'}">
                                                <span class="label label-primary">停用</span>
                                            </c:when>
                                        </c:choose>

                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${plateManage.plateUsed eq '1'}">
                                                <span class="label label-success">使用中</span>
                                            </c:when>
                                            <c:when test="${plateManage.plateUsed eq '0'}">
                                                <span class="label label-primary">空闲</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        ${fns:getUserById(plateManage.createBy.id).name}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${plateManage.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        ${fns:getUserById(plateManage.updateBy.id).name}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${plateManage.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        ${plateManage.remarks}
                                    </td>
                                    <shiro:hasPermission name="bus:pm:plateManage:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/pm/plateManage/info?id=${plateManage.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <c:if test="${plateManage.plateStatus eq '0' && plateManage.plateUsed eq '0'}">
                                                    <li><a href="${ctx}/bus/pm/plateManage/delete?id=${plateManage.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该托盘吗？',this.href)">删除</a>
                                                    </li>
                                                </c:if>

                                                <c:if test="${plateManage.plateUsed eq '0'}">
                                                    <li><a href="${ctx}/bus/pm/plateManage/updateFlag?id=${plateManage.id}" style="color: #fff" >${plateManage.plateStatus eq '1'?'停用':'启用' }</a>
                                                    </li>
                                                </c:if>
                                                <c:if test="${plateManage.plateUsed eq '1'}">
                                                    <li><a href="${ctx}/bus/pm/plateManage/pickOrderinfo?plateNo=${plateManage.plateNo}" style="color: #fff" >拣货单详情</a>
                                                    </li>
                                                    <li><a href="${ctx}/bus/pm/plateManage/clearPlate?id=${plateManage.id}" style="color: #fff" >清空托盘</a>
                                                    </li>
                                                </c:if>
                                                <li><a href="${ctx}/bus/pm/plateManage/form?id=${plateManage.id}" target="">修改</a></li>
                                            </ul>
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
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:8},
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