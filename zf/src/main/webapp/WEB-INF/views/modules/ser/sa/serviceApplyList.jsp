<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>服务申请管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/ser/sa/serviceApply/">服务申请列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="serviceApply" action="${ctx}/ser/sa/serviceApply/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="no" class="col-sm-3 control-label">服务单编号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="no" id="no" verifyType="0" tip="请输入服务单编号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="status" class="col-sm-3 control-label">处理状态</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="status" tip="请选择处理状态" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_status" id="status"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="applyTimeType" class="col-sm-3 control-label">申请时机类型</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="applyTimeType" tip="请选择时机类型" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_applyTimeType" id="applyTimeType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="orderNo" class="col-sm-3 control-label">订单编号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="orderNo" id="orderNo" verifyType="0" tip="请输入订单编号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
		        			<div class="form-group">
			                  <label for="applyDealType" class="col-sm-3 control-label">申请处理类型</label>
			                  <div class="col-sm-7">
			                  <sys:selectverify name="applyDealType" tip="请选择申请处理类型" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_applyDealType" id="applyDealType"></sys:selectverify>
			                  </div>
			                </div>
		        		</div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="applyReasonType" class="col-sm-3 control-label">申请原因类型</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="applyReasonType" tip="请申请原因类型" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_applyReasonType" id="applyReasonType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
		        		<div class="col-md-4">
                            <div  class="form-group">
                                <label for="membercode" class="col-sm-3 control-label">用户账号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="membercode" id="membercode" verifyType="0" tip="请输入用户账号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
		        		<div class="col-md-4">
		        			<div class="form-group">
			                  <label for="memberStatus" class="col-sm-3 control-label">会员状态</label>
			                  <div class="col-sm-7">
			                   <sys:selectverify name="memberStatus" tip="请选择处理状态" verifyType="99" isMandatory="false" dictName="crm_mi_member_memberStatus" id="memberStatus"></sys:selectverify>
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
                                <th>订单编号</th>
                                <th>用户账号</th>
                                <th>状态</th>
                                <th>申请时机类型</th>
                                <th>申请处理类型</th>
                                <th>申请原因类型</th>
                                <th>申请时间</th>
                                <th>处理人</th>
                                <th>处理结果状态</th>
                                <th>处理时间</th>
                                <th>处理结果</th>
                                <th style="display: none;">处理时间</th>
                                <th style="display: none;">处理备注</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="ser:sa:serviceApply:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="serviceApply" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td><%--  <td>${serviceApply.no}</td> --%>
                                     <td>
                                        ${serviceApply.orderNo}
                                    </td>
                                     <td>
                                        ${serviceApply.membercode}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(serviceApply.status, 'ser_sa_service_apply_status', '')}</span>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(serviceApply.applyTimeType, 'ser_sa_service_apply_applyTimeType', '')}</span>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(serviceApply.applyDealType, 'ser_sa_service_apply_applyDealType', '')}</span>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(serviceApply.applyReasonType, 'ser_sa_service_apply_applyReasonType', '')}</span>
                                    </td>
                                     <td >
                                        <fmt:formatDate value="${serviceApply.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                            ${fns:getUserById(serviceApply.dealBy.id).name}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(serviceApply.status, 'ser_sa_service_apply_status', '')}</span>
                                    </td>
                                    <td >
                                        <fmt:formatDate value="${serviceApply.dealTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(serviceApply.dealResultType, 'ser_sa_service_apply_dealResultType', '')}</span>
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${serviceApply.dealTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${serviceApply.dealRemarks}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${serviceApply.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${serviceApply.remarks}
                                    </td>
                                    <shiro:hasPermission name="ser:sa:serviceApply:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/ser/sa/serviceApply/info?id=${serviceApply.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <c:choose>
                                                <c:when test="${serviceApply.status eq '1' }">
                                                    <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                        <li><a href="${ctx}/ser/sa/serviceApply/form?id=${serviceApply.id}" target="">处理</a></li>
                                                    </ul>
                                                </c:when>
                                            </c:choose>
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
            "order": [[ 0, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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