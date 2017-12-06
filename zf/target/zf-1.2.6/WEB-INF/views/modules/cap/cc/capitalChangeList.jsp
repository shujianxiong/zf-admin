<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>公司资产变更记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/cap/cc/capitalChange/">公司资产变更记录列表</a></small>
            <%-- <small>|</small>
            <shiro:hasPermission name="cap:cc:capitalChange:edit"><small><i class="fa-form-edit"></i><a href="${ctx}/cap/cc/capitalChange/form">公司资产变更记录添加</a></small></shiro:hasPermission> --%>
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
            
            <form:form id="searchForm" modelAttribute="capitalChange" action="${ctx}/cap/cc/capitalChange/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">资产全名</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="capital.fullName" id="cfullName" verifyType="0" tip="请输入资产全名" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">变动原因</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="changeType" tip="请选择" isMandatory="false" verifyType="0" dictName="cap_cc_capital_change_type" id="changeType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">变动类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="changeReasonType" isMandatory="false" tip="请选择" verifyType="0" dictName="cap_cc_capital_change_reason_type" id="changeReasonType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">新资产状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="newCapitalStatus" tip="请选择" verifyType="0" isMandatory="false" dictName="cap_cc_capital_capital_status" id="capitalStatus"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">新使用状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="newUseStatus" tip="请选择" verifyType="0" isMandatory="false" dictName="cap_cc_capital_use_status" id="useStatus"></sys:selectverify>
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
                                <th>资产全名</th>
                                <th>变动类型</th>
                                <th>变动原因类型</th>
                                <th>新固定资产编号</th>
                                <th>新数量</th>
                                <th>新使用部门</th>
                                <th>新使用地点</th>
                                <th>新使用员工</th>
                                <th>新资产状态</th>
                                <th>新使用状态</th>
                                <th style="display: none;">创建人</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">更新人</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="cap:cc:capitalChange:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="capitalChange" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>${capitalChange.capital.fullName }</td>
									<td>
									   <c:choose>
									       <c:when test="${capitalChange.changeType eq '1' }"> <!-- 领取 -->
									           <span class="label label-success">${fns:getDictLabel(capitalChange.changeType, 'cap_cc_capital_change_type', '')}</span>
									       </c:when>
									       <c:when test="${capitalChange.changeType eq '2' }"> <!-- 收回 -->
									           <span class="label label-primary">${fns:getDictLabel(capitalChange.changeType, 'cap_cc_capital_change_type', '')}</span>
									       </c:when>
									   </c:choose>
									</td>
									
									<td>
								        <c:choose>
								            <c:when test="${capitalChange.changeReasonType eq '1' }"><!-- 入职 -->
								               <span class="label label-primary">${fns:getDictLabel(capitalChange.changeReasonType, 'cap_cc_capital_change_reason_type', '')}</span>
								            </c:when>
								            <c:when test="${capitalChange.changeReasonType eq '2' }"><!-- 损坏 -->
                                               <span class="label label-default">${fns:getDictLabel(capitalChange.changeReasonType, 'cap_cc_capital_change_reason_type', '')}</span>
                                            </c:when>
                                            <c:when test="${capitalChange.changeReasonType eq '3' }"><!-- 业务 -->
                                               <span class="label label-success">${fns:getDictLabel(capitalChange.changeReasonType, 'cap_cc_capital_change_reason_type', '')}</span>
                                            </c:when>
								        </c:choose>
									</td>
									
									<td>${capitalChange.newCapitalNo}</td>
									<td>${capitalChange.newNum}</td>
									<td>${capitalChange.newUseOffice.name}</td>
									<td>${capitalChange.newUsePlace}</td>
									<td>${capitalChange.newUseUser.name}</td>
									<td>
                                        <c:choose>
                                            <c:when test="${capitalChange.newCapitalStatus eq '1' }">  <!-- 正常 -->
                                                 <span class="label label-success">${fns:getDictLabel(capitalChange.newCapitalStatus, 'cap_cc_capital_capital_status', '')}</span>
                                            </c:when>
                                            <c:when test="${capitalChange.newCapitalStatus eq '2' }">  <!-- 破坏 -->
                                              <span class="label label-primary">${fns:getDictLabel(capitalChange.newCapitalStatus, 'cap_cc_capital_capital_status', '')}</span>
                                            </c:when>
                                            <c:when test="${capitalChange.newCapitalStatus eq '3' }">  <!-- 损坏 -->
                                              <span class="label label-default">${fns:getDictLabel(capitalChange.newCapitalStatus, 'cap_cc_capital_capital_status', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                      <c:choose>
                                          <c:when test="${capitalChange.newUseStatus eq '1' }"> <!-- 使用中 -->
                                              <span class="label label-primary">${fns:getDictLabel(capitalChange.newUseStatus, 'cap_cc_capital_use_status', '')}</span>
                                          </c:when>
                                          <c:when test="${capitalChange.newUseStatus eq '2' }"> <!-- 闲置 -->
                                              <span class="label label-default">${fns:getDictLabel(capitalChange.newUseStatus, 'cap_cc_capital_use_status', '')}</span>
                                          </c:when>
                                      </c:choose>
                                    </td>
                                    
                                    <td data-hide="true">
                                        ${fns:getUserById(capitalChange.createBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${capitalChange.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(capitalChange.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${capitalChange.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
									<td data-hide="true">${fns:abbr(capitalChange.remarks, 15)}</td>
									
									<shiro:hasPermission name="cap:cc:capitalChange:edit"><td>
                                       <div class="btn-group zf-tableButton">
                                           <button type="button" class="btn btn-sm btn-info"
                                               onclick="window.location.href='${ctx}/cap/cc/capitalChange/form?id=${capitalChange.id}'">修改</button>
                                           <button type="button"
                                               class="btn btn-sm btn-info dropdown-toggle"
                                               data-toggle="dropdown">
                                               <span class="caret"></span>
                                           </button>
                                           <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                               <li><a href="${ctx}/cap/cc/capitalChange/delete?id=${capitalChange.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该公司资产变更记录吗？',this.href)">删除</a>
                                               </li>
                                               <li><a href="${ctx}/cap/cc/capitalChange/info?id=${capitalChange.id}" target="">详情</a></li>
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
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15},
                {"orderable":false,targets:16}
                
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