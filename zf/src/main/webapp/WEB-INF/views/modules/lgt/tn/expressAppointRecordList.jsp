<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>快递预约记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/tn/expressAppointRecord/">快递预约记录列表</a></small>
            <%-- <shiro:hasPermission name="lgt:tn:expressAppointRecord:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/lgt/tn/expressAppointRecord/form">快递预约记录添加</a>
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
            
            <form:form id="searchForm" modelAttribute="expressAppointRecord" action="${ctx}/lgt/tn/expressAppointRecord/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">订单类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="orderType" tip="请选择" verifyType="99" dictName="bus_order_type" id="orderType" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">预约状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="status" tip="请选择" verifyType="99" dictName="lgt_tn_express_appoint_record_status" id="status" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="membercode" class="col-sm-3 control-label">会员账号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="member.usercode" id="membercode" verifyType="0" tip="请输入用户账号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">预约开始时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="appointStartTime" inputName="appointStartTime" tip="请选择预约开始时间" isMandatory="false" inputId="appointStartTimeID"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">预约截止时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="appointEndTime" inputName="appointEndTime" tip="请选择预约开始时间" isMandatory="false" inputId="appointEndTimeID"></sys:datetime>
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
                                <th>订单类型</th>
                                <th>预约状态</th>
                                <th>预约开始时间</th>
                                <th>预约截止时间</th>
                                <th>取件区域</th>
                                <th>取件地址</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="lgt:tn:expressAppointRecord:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="expressAppointRecord" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>${fns:getMemberById(expressAppointRecord.member.id).usercode }</td>
	                                <td>
	                                   <span class="label label-primary">${fns:getDictLabel(expressAppointRecord.orderType, 'bus_order_type','') }</span>
	                                </td>
	                                <td>
	                                   <c:choose>
	                                       <c:when test="${expressAppointRecord.status eq '2' }">
                                               <span class="label label-primary">${fns:getDictLabel(expressAppointRecord.status, 'lgt_tn_express_appoint_record_status','') }</span>
                                           </c:when>
	                                       <c:otherwise>
	                                           <span class="label label-success">${fns:getDictLabel(expressAppointRecord.status, 'lgt_tn_express_appoint_record_status','') }</span>
	                                       </c:otherwise>
	                                   </c:choose>
	                                </td>
	                                <td><fmt:formatDate value="${expressAppointRecord.appointStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                                <td><fmt:formatDate value="${expressAppointRecord.appointEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                                <td>${expressAppointRecord.area.name }</td>
	                                <td>${expressAppointRecord.areaDetail }</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${expressAppointRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${expressAppointRecord.remarks}
                                    </td>
                                    <shiro:hasPermission name="lgt:tn:expressAppointRecord:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/lgt/tn/expressAppointRecord/info?id=${expressAppointRecord.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <c:if test="${expressAppointRecord.status eq '2' }">
	                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
	                                                <li><a href="${ctx}/lgt/tn/expressAppointRecord/updateStatus?id=${expressAppointRecord.id}" target="">预约成功</a></li>
	                                            </ul>
                                            </c:if>
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
            "order": [[ 8, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10}
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