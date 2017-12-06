<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>供应商信誉分流水管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/creditPointDetail/">供应商信誉分流水列表</a></small>
            <%-- <shiro:hasPermission name="lgt:si:creditPointDetail:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/lgt/si/creditPointDetail/form">供应商信誉分流水添加</a>
                </small>
            </shiro:hasPermission> --%>
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
            
            <form:form id="searchForm" modelAttribute="creditPointDetail" action="${ctx}/lgt/si/creditPointDetail/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">供应商名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="supplier.name" id="sname" verifyType="99" tip="请输入待查询的供应商名称" isMandatory="false"></sys:inputverify>
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
                                <th>供应商</th>
                                <th>变动类型</th>
                                <th>变动信誉分数量</th>
                                <th>变动后信誉分</th>
                                <th>变动原因</th>
                                <th>变动时间</th>
                                <th>操作人类型</th>
                                <th>来源业务编号</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <!-- <th>操作</th> -->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="creditPointDetail" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${creditPointDetail.supplier.name}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(creditPointDetail.changeType, 'add_decrease', '')}</span>
                                    </td>
                                    <td>
                                        ${creditPointDetail.changeCreditPoint}
                                    </td>
                                    <td>
                                        ${creditPointDetail.lastCreditPoint}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(creditPointDetail.changeReasonType, 'lgt_si_credit_point_detail_changeReasonType', '')}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${creditPointDetail.changeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(creditPointDetail.operaterType, 'operater_type_admin', '')}</span>
                                    </td>
                                    <td>
                                        ${creditPointDetail.operateSourceNo}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${creditPointDetail.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(creditPointDetail.remarks, 30)}
                                    </td>
                                    <%-- <td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/lgt/si/creditPointDetail/info?id=${creditPointDetail.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/lgt/si/creditPointDetail/form?id=${creditPointDetail.id}" target="">修改</a></li>
                                                <li><a href="${ctx}/lgt/si/creditPointDetail/delete?id=${creditPointDetail.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该供应商信誉分流水吗？',this.href)">删除</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </td> --%>
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
            "order": [[ 6, "DESC" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:10},
                
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