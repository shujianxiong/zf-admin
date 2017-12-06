<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>评价摘要管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/pj/summary/">评价摘要列表</a></small>
            <shiro:hasPermission name="bus:pj:summary:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/pj/summary/form">评价摘要添加</a>
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
            
            <form:form id="searchForm" modelAttribute="summary" action="${ctx}/bus/pj/summary/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" verifyType="0" tip="请输入名称" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="type" tip="请选择类型" verifyType="0" dictName="bus_pj_summary_type" id="type" isMandatory="false" ></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">启用状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="activeFlag" tip="请选择启用状态" verifyType="0" dictName="yes_no" id="activeFlag" isMandatory="false"></sys:selectverify>
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
                                <th>名称</th>
                                <th>类型</th>
                                <th>所属等级</th>
                                <th>启用状态</th>
                                <th>排序</th>
                                <th style="display: none;">创建者</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">更新者</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="bus:pj:summary:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="summary" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${summary.name}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${summary.type eq 'goods' }">
		                                        <span class="label label-primary">${fns:getDictLabel(summary.type, 'bus_pj_summary_type', '')}</span>
                                            </c:when>
                                            <c:when test="${summary.type eq 'service' }">
                                                <span class="label label-default">${fns:getDictLabel(summary.type, 'bus_pj_summary_type', '')}</span>
                                            </c:when>
                                            <c:when test="${summary.type eq 'express' }">
                                                <span class="label label-info">${fns:getDictLabel(summary.type, 'bus_pj_summary_type', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(summary.level, 'bus_pj_produce_judge_level', '')}</span>
                                    </td>
                                    <td>
                                         <c:choose>
                                            <c:when test="${summary.activeFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(summary.activeFlag, 'yes_no', '')}</span>
                                            </c:when>
                                            <c:when test="${summary.type eq '0' }">
                                                <span class="label label-primary">${fns:getDictLabel(summary.type, 'bus_pj_summary_type', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        ${summary.orderNo}
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(summary.createBy.id).name }
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${summary.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(summary.updateBy.id).name }
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${summary.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${summary.remarks}
                                    </td>
                                    <shiro:hasPermission name="bus:pj:summary:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/pj/summary/form?id=${summary.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/bus/pj/summary/delete?id=${summary.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该评价摘要吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/bus/pj/summary/info?id=${summary.id}" target="">详情</a></li>
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
            "ordering" : true,
            "order": [[ 9, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11}
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