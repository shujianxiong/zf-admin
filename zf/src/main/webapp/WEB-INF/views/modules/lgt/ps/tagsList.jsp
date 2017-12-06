<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>标签管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/tags/">标签列表</a></small>
            
            <shiro:hasPermission name="lgt:ps:tags:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/tags/form">标签添加</a></small></shiro:hasPermission>
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
            
            <form:form id="searchForm" modelAttribute="tags" action="${ctx}/lgt/ps/tags/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">标签名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" verifyType="0" tip="请输入标签名称" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">是否热门</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="hotFlag" tip="请选择" verifyType="0" dictName="yes_no" id="hotFlag" isMandatory="false"></sys:selectverify>
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
                                <th>标签名称</th>
                                <th>是否热门</th>
                                <th>排列序号</th>
                                <th style="display:none">创建者</th>
                                <th style="display:none">创建时间</th>
                                <th style="display:none">更新者</th>
                                <th style="display:none">更新时间</th>
                                <th style="display:none">备注信息</th>
                                <shiro:hasPermission name="lgt:ps:tags:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="tags" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
									<td>${tags.name}</td>
									<td>
									   <c:choose>
                                           <c:when test="${tags.hotFlag eq '1'}">
                                               <span class="label label-success">${fns:getDictLabel(tags.hotFlag, 'yes_no', '')}</span>
                                           </c:when>
                                           <c:when test="${tags.hotFlag eq '0'}">
                                               <span class="label label-primary">${fns:getDictLabel(tags.hotFlag, 'yes_no', '')}</span>
                                           </c:when>
                                       </c:choose>
									</td>
									<td>${tags.orderNo}</td>
									<td data-hide="true">
                                        ${fns:getUserById(tags.createBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${tags.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(tags.updateBy.id).name}
                                    </td>
                                    <td data-hide="true"> 
                                        <fmt:formatDate value="${tags.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(tags.remarks,30)}
                                    </td>
									<shiro:hasPermission name="lgt:ps:tags:edit"><td>
                                       <div class="btn-group zf-tableButton">
                                           <button type="button" class="btn btn-sm btn-info"
                                               onclick="window.location.href='${ctx}/lgt/ps/tags/form?id=${tags.id}'">修改</button>
                                           <button type="button"
                                               class="btn btn-sm btn-info dropdown-toggle"
                                               data-toggle="dropdown">
                                               <span class="caret"></span>
                                           </button>
                                           <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                               <li><a href="${ctx}/lgt/ps/tags/delete?id=${tags.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该标签吗？',this.href)">删除</a>
                                               </li>
                                               <li><a href="${ctx}/lgt/ps/tags/info?id=${tags.id}" target="">详情</a></li>
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
            "order": [[ 3, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:9}
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