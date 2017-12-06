<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>顺丰快递管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/tn/expressInfoRecord/">顺丰快递列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="expressInfoRecord" action="${ctx}/lgt/tn/expressInfoRecord/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                       <%--  <div class="col-md-4">
                       <%--  <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">体验订单号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="orderNo" id="orderNo" verifyType="99" tip="请输入查询的体验订单号" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div> 
                        </div>--%>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="expressOrderId" class="col-sm-3 control-label">发货单号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="expressOrderId" id="expressOrderId" verifyType="99" tip="请输入查询的发货单号" isMandatory="false" isSpring="true"></sys:inputverify> 
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="searchParameter.keyWord" class="col-sm-3 control-label">会员账号</label>
                                <div class="col-sm-7">
                                     <form:input path="searchParameter.keyWord" class="form-control" placeholder="体验订单号、会员账号模糊匹配查询" />
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
                                <th>快递订单号</th>
                                <th>来源订单类型</th>
                                <th>送货单类型</th>
                                <th>快递状态</th>
                                <th>状态描述</th>
                                <th style="display: none;">更新时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="expressInfoRecord" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>${fns:getMemberById(expressInfoRecord.member.id).usercode}</td>
	                                <td>
	                                   ${expressInfoRecord.expressOrderId}
	                                </td>
	                                <td><span class="label label-primary">${fns:getDictLabel(expressInfoRecord.orderType, 'bus_order_type','') }</span></td>
	                                <td><span class="label label-primary">${fns:getDictLabel(expressInfoRecord.sendOrderType, 'send_order_type','') }</span></td>
	                                <td>${expressInfoRecord.status }</td>
	                                <td>${expressInfoRecord.statusDescription }</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${expressInfoRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
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
            "order": [[ 7, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
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