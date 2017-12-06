<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>质检工单列表管理</title>
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
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/ser/as/qualityWorkorder/">质检工单列表列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="qualityWorkorder" action="${ctx}/ser/as/qualityWorkorder/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="workorderNo" class="col-sm-3 control-label">质检工单编号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="workorderNo" id="workorderNo" verifyType="0" tip="请输入质检工单编号" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="usercode" class="col-sm-3 control-label">会员账号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="usercode" id="usercode" verifyType="0" tip="请输入会员账号" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="orderNo" class="col-sm-3 control-label">订单编号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="orderNo" id="orderNo" verifyType="0" tip="请输入订单编号" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="workorderType" class="col-sm-3 control-label">工单类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="workorderType" tip="" isMandatory="false" verifyType="" dictName="ser_as_workorder_workorderType" id="workorderType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                       <div class="col-md-4">
                            <div  class="form-group">
                                <label for="status" class="col-sm-3 control-label">工单状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="status" tip="" isMandatory="false" verifyType="" dictName="ser_as_qualityWorkorder_status" id="status"></sys:selectverify>
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
                                <th>订单编号</th>
                                <th>工单类型</th>
                                <th>指派人</th>
                                <th>指派时间</th>
                                <th>工单状态</th>
                                <th>处理时间</th>
                                <th>被指派人</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">创建者</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">更新者</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="ser:as:qualityWorkorder:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="qualityWorkorder" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${qualityWorkorder.usercode}</td>
                                    <td>${qualityWorkorder.orderNo}</td>
                                    <td><span class="label label-info">${fns:getDictLabel(qualityWorkorder.workorderType, 'ser_as_workorder_workorderType', '')}</span></td>
                                    <td>${fns:getUserById(qualityWorkorder.appointedUser).name}</td>
                                    <td><fmt:formatDate value="${qualityWorkorder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                     <td>
                                    <c:choose>
                                        <c:when test="${qualityWorkorder.status eq '1' }"><!-- 未处理 -->
                                            <span class="label label-default">${fns:getDictLabel(qualityWorkorder.status, 'ser_as_qualityWorkorder_status', '')}</span>
                                        </c:when>
                                        <c:when test="${qualityWorkorder.status eq '2' }"><!-- 待审核 -->
                                            <span class="label label-primary">${fns:getDictLabel(qualityWorkorder.status, 'ser_as_qualityWorkorder_status', '')}</span>
                                        </c:when>
                                        <c:when test="${qualityWorkorder.status eq '3' }"><!-- 已完成 -->
                                            <span class="label label-success">${fns:getDictLabel(qualityWorkorder.status, 'ser_as_qualityWorkorder_status', '')}</span>
                                        </c:when>
                                    </c:choose></td>
                                    <td><fmt:formatDate value="${qualityWorkorder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td> ${fns:getUserById(qualityWorkorder.appointedUser).name}</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${qualityWorkorder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                            ${fns:getUserById(qualityWorkorder.createBy.id).name }
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${qualityWorkorder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                            ${fns:getUserById(qualityWorkorder.updateBy.id).name }
                                    </td>
                                    <td data-hide="true">
                                            ${workorder.remarks}
                                    </td>
                                    <shiro:hasPermission name="ser:as:qualityWorkorder:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/ser/as/qualityWorkorder/info?id=${qualityWorkorder.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <c:if test="${qualityWorkorder.status eq '1' }">
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/ser/as/qualityWorkorder/form?id=${qualityWorkorder.id}" target="">处理</a></li>
                                            </ul>
                                            </c:if>
                                                <shiro:hasPermission name="ser:as:qualityWorkorder:approve">
                                            <c:if test="${qualityWorkorder.status eq '2' }">
                                                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                    <li><a href="${ctx}/ser/as/qualityWorkorder/toApprove?id=${qualityWorkorder.id}" target="">审核</a></li>
                                                </ul>
                                            </c:if>
                                                </shiro:hasPermission>
                                        </div>
                                    </td></shiro:hasPermission>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            <div class="box-footer">
                <div class="dataTables_paginate paging_simple_numbers">${page}</div>
            </div>
            </div></div>
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