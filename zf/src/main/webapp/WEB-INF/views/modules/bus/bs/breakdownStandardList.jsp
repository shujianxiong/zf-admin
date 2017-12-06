<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>货品定损标准管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/bs/breakdownStandard/">货品定损标准列表</a></small>
            <shiro:hasPermission name="bus:bs:breakdownStandard:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/bs/breakdownStandard/form">货品定损标准添加</a>
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
            
            <form:form id="searchForm" modelAttribute="breakdownStandard" action="${ctx}/bus/bs/breakdownStandard/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">问题类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="breakdownType" tip="请选择" isMandatory="false" verifyType="0" dictName="bus_or_repair_order_breakdownType" id="breakdownType"></sys:selectverify>
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
                                <th>问题类型</th>
                                <th>魅力可抵标记</th>
                                <th>定损百分比</th>
                                <th>创建者</th>
                                <th>创建时间</th>
                                <th>更新者</th>
                                <th>更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="bus:bs:breakdownStandard:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="breakdownStandard" varStatus="status">
                                <tr data-index="${status.index }">
									<td>${fns:getDictLabel(breakdownStandard.breakdownType, 'bus_or_repair_order_breakdownType', '')}
									</td>
                                    <td>
                                        <c:if test="${breakdownStandard.beansDecFlag=='1' }">
                                            <span class="label label-success">${fns:getDictLabel(breakdownStandard.beansDecFlag, 'yes_no', '')}</span>
                                        </c:if>
                                        <c:if test="${breakdownStandard.beansDecFlag=='0' }">
                                            <span class="label label-primary">${fns:getDictLabel(breakdownStandard.beansDecFlag, 'yes_no', '')}</span>
                                        </c:if>
                                    </td>
									<td>${breakdownStandard.moneyLossPercent}</td>
									<td>${fns:getUserById(breakdownStandard.createBy.id).name}</td>
									<td><fmt:formatDate
											value="${breakdownStandard.createDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td>${fns:getUserById(breakdownStandard.updateBy.id).name}</td>
									<td><fmt:formatDate
											value="${breakdownStandard.updateDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td>${breakdownStandard.remarks}</td>
									<shiro:hasPermission name="bus:bs:breakdownStandard:edit"><td>
                                       <div class="btn-group zf-tableButton">
                                           <button type="button" class="btn btn-sm btn-info"
                                               onclick="window.location.href='${ctx}/bus/bs/breakdownStandard/form?id=${breakdownStandard.id}'">修改</button>
                                           <button type="button"
                                               class="btn btn-sm btn-info dropdown-toggle"
                                               data-toggle="dropdown">
                                               <span class="caret"></span>
                                           </button>
                                           <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                               <li><a href="${ctx}/bus/bs/breakdownStandard/delete?id=${breakdownStandard.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该货品定损标准吗？',this.href)">删除</a>
                                               </li>
                                               <li><a href="${ctx}/bus/bs/breakdownStandard/info?id=${breakdownStandard.id}" target="">详情</a></li>
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
            "order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
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