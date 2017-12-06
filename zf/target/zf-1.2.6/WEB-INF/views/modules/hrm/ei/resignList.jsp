<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工离职管理</title>
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
			<small class="menu-active"><i class="fa fa-repeat"></i><a
				href="${ctx}/hrm/ei/resign/">员工离职列表</a></small>
			<shiro:hasPermission name="hrm:ei:resign:edit">
				<small>|</small>
				<small><i class="fa-form-edit"></i><a
					href="${ctx}/hrm/ei/resign/form">员工离职添加</a></small>
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
            
            <form:form id="searchForm" modelAttribute="resign" action="${ctx}/hrm/ei/resign/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">员工姓名</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="employee.user.name" id="euname" verifyType="0" tip="请输入员工姓名" isSpring="true" isMandatory="false"></sys:inputverify>
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
                                <th>员工姓名</th>
                                <th>离职申请日期</th>
                                <th>离职状态</th>
                                <th>离职原因</th>
                                <th>正式离职日期</th>
                                <th>工作交接状态</th>
                                <th>办公用品交接状态</th>
                                <th>薪资结算状态</th>
                                <th style="display: none;">主管领导审批意见</th>
                                <th style="display: none;">部门领导审批意见</th>
                                <th style="display: none;">总经理审批意见</th>
                                <th style="display: none;">董事长审批意见</th>
                                <th style="display: none;">创建人</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">更新人</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="hrm:ei:resign:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="resign" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
									<td>${resign.employee.user.name}</td>
									<td>
									   <fmt:formatDate value="${resign.applyDate}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
									<td>
									   <c:choose>
									       <c:when test="${resign.status eq '0' }"><!-- 已离职 -->
									           <span class="label label-default">${fns:getDictLabel(resign.status, 'hrm_ei_resign_status', '')}</span>
									       </c:when>
									       <c:when test="${resign.status eq '1' }"><!-- 在职 -->
									           <span class="label label-primary">${fns:getDictLabel(resign.status, 'hrm_ei_resign_status', '')}</span>
									       </c:when>
									   </c:choose>
									   
									</td>
									<td>${resign.reason}</td>
									<td>
									   <fmt:formatDate value="${resign.resignDate}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
                                    <td>
                                        <c:choose>
                                           <c:when test="${resign.workRelayStatus eq '1' }"><!-- 已交接 -->
                                               <span class="label label-default">${fns:getDictLabel(resign.workRelayStatus, 'hrm_ei_resign_workRelay_status', '')}</span>
                                           </c:when>
                                           <c:when test="${resign.workRelayStatus eq '0' }"><!-- 待交接 -->
                                               <span class="label label-primary">${fns:getDictLabel(resign.workRelayStatus, 'hrm_ei_resign_workRelay_status', '')}</span>
                                           </c:when>
                                       </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                           <c:when test="${resign.suppliesRelayStatus eq '1' }"><!-- 已归还 -->
                                               <span class="label label-default">${fns:getDictLabel(resign.suppliesRelayStatus, 'hrm_ei_resign_suppliesRelay_status', '')}</span>
                                           </c:when>
                                           <c:when test="${resign.suppliesRelayStatus eq '0' }"><!-- 待归还 -->
                                               <span class="label label-primary">${fns:getDictLabel(resign.suppliesRelayStatus, 'hrm_ei_resign_suppliesRelay_status', '')}</span>
                                           </c:when>
                                       </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                           <c:when test="${resign.salaryPayStatus eq '1' }"><!-- 已结算 -->
                                               <span class="label label-default">${fns:getDictLabel(resign.salaryPayStatus, 'hrm_ei_resign_salaryPay_status', '')}</span>
                                           </c:when>
                                           <c:when test="${resign.salaryPayStatus eq '0' }"><!-- 待结算 -->
                                               <span class="label label-primary">${fns:getDictLabel(resign.salaryPayStatus, 'hrm_ei_resign_salaryPay_status', '')}</span>
                                           </c:when>
                                       </c:choose>
                                    </td>
									
									<td data-hide="true">${resign.approvalMsgZg}</td>
									<td data-hide="true">${resign.approvalMsgBm}</td>
									<td data-hide="true">${resign.approvalMsgZjl}</td>
									<td data-hide="true">${resign.approvalMsgDsz}</td>
									
									<td data-hide="true">${fns:getUserById(resign.createBy.id).name}</td>
									<td data-hide="true"><fmt:formatDate value="${resign.createDate}"
                                            pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td data-hide="true">${fns:getUserById(resign.updateBy.id).name}</td>
									<td data-hide="true"><fmt:formatDate value="${resign.updateDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td data-hide="true">${fns:abbr(resign.remarks, 15)}</td>
									
									<shiro:hasPermission name="hrm:ei:resign:edit"><td>
                                       <div class="btn-group zf-tableButton">
                                           <button type="button" class="btn btn-sm btn-info"
                                               onclick="window.location.href='${ctx}/hrm/ei/resign/form?id=${resign.id}'">修改</button>
                                           <button type="button"
                                               class="btn btn-sm btn-info dropdown-toggle"
                                               data-toggle="dropdown">
                                               <span class="caret"></span>
                                           </button>
                                           <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                               <li><a href="${ctx}/hrm/ei/resign/delete?id=${resign.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该员工离职记录吗？',this.href)">删除</a>
                                               </li>
                                               <li><a href="${ctx}/hrm/ei/resign/info?id=${resign.id}" target="">详情</a></li>
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
            "order": [[ 2, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
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
                {"orderable":false,targets:16},
                {"orderable":false,targets:17},
                {"orderable":false,targets:18}
                
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