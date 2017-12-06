<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工入职管理</title>
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
				href="${ctx}/hrm/ei/employee/">员工入职列表</a></small>
			<shiro:hasPermission name="hrm:ei:employee:edit">
				<small>|</small>
				<small><i class="fa-form-edit"></i><a
					href="${ctx}/hrm/ei/employee/form">员工入职添加</a></small>
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
            
            <form:form id="searchForm" modelAttribute="employee" action="${ctx}/hrm/ei/employee/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">姓名</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="user.name" id="uname" verifyType="0" tip="请输入姓名" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">姓名</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="user.name" id="uname" verifyType="0" tip="请输入姓名" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">手机号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="user.mobile" id="umobile" verifyType="1" tip="请输入正确的手机号码" isSpring="true" isMandatory="false"></sys:inputverify>
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
				                <th>账号</th>
				                <th>姓名</th>
				                <th>电话 </th>
				                <th>手机号</th>
				                <th>身份证号码</th>
				                <th>性别</th>
				                <th>现居住地详情</th>
				                <th>户口性质</th>
				                <th>户口所在地</th>
				                <th>毕业院校</th>
				                <th>专业</th>
				                <th>学历</th>
				                <th>合同到期时间</th>
				                <th>工龄</th>
				                <th style="display: none;">办公地</th>
				                <th style="display: none;">保险日期</th>
				                <th style="display: none;">公积金日期</th>
				                <th style="display: none;">创建人</th>
				                <th style="display: none;">创建时间</th>
				                <th style="display: none;">更新人</th>
				                <th style="display: none;">更新时间</th>
				                <th style="display: none;">备注信息</th>
				                <shiro:hasPermission name="hrm:ei:employee:edit"><th>操作</th></shiro:hasPermission>
				            </tr>
				        </thead>
				        <tbody>
				        <c:forEach items="${page.list}" var="employee" varStatus="status">
				            <tr data-index="${status.index }">
                                 <td class="details-control text-center">
                                      <i class="fa fa-plus-square-o text-success"></i>
                                 </td>
                                 <td>
				                    ${employee.user.loginName}
				                </td>
				                <td title="${employee.user.name }">
				                    ${fns:abbr(employee.user.name, 15)}
				                </td>
				                <td>
				                    ${employee.user.phone}
				                </td>
				                <td>
				                    ${employee.user.mobile}
				                </td>
				                <td title="${employee.idCard1 }">
				                    ${fns:abbr(employee.idCard1, 15)}
				                </td>
				                <td>
				                    ${fns:getDictLabel(employee.sex, 'sex', '')}
				                </td>
				                <td title="${fns:getAreaFullNameById(employee.liveArea.id)} ${employee.liveAreaDetail}">
				                    ${fns:abbr(fns:getAreaFullNameById(employee.liveArea.id), 15)} 
				                </td>
				                <td>
				                    ${fns:getDictLabel(employee.householdType, 'sys_user_info_householdType', '')}
				                </td>
				                <td title="${fns:getAreaFullNameById(employee.householdAddr.id)}">
				                    ${fns:abbr(fns:getAreaFullNameById(employee.householdAddr.id), 15)}
				                </td>
				                <td>
				                    ${employee.graduateCollege}
				                </td>
				                <td>
				                    ${employee.professional}
				                </td>
				                <td>
				                    ${fns:getDictLabel(employee.degree, 'hrm_ei_employee_degree', '')}
				                </td>
				                <td>
				                    <fmt:formatDate value="${employee.contractDueDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				                </td>
				                <td>
				                    ${employee.workAge}
				                </td>
				                <td data-hide="true">
				                    ${employee.officeAddr}
				                </td>
				                <td data-hide="true">
				                    <fmt:formatDate value="${employee.insuranceDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				                </td>
				                
				                <td data-hide="true">
				                    <fmt:formatDate value="${employee.cpfDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				                </td>
				            
				                <td data-hide="true">
                                    ${fns:getUserById(employee.createBy.id).name }
                                </td>
                                <td data-hide="true">
                                    <fmt:formatDate value="${employee.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </td>
                                <td data-hide="true">
                                    ${fns:getUserById(employee.updateBy.id).name }
                                </td>
				                <td data-hide="true">
				                    <fmt:formatDate value="${employee.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				                </td>
				                <td data-hide="true">
				                    ${fns:abbr(employee.remarks,15)}
				                </td>
				                <shiro:hasPermission name="hrm:ei:employee:edit"><td>
                                       <div class="btn-group zf-tableButton">
                                           <button type="button" class="btn btn-sm btn-info"
                                               onclick="window.location.href='${ctx}/hrm/ei/employee/form?id=${employee.id}'">修改</button>
                                           <button type="button"
                                               class="btn btn-sm btn-info dropdown-toggle"
                                               data-toggle="dropdown">
                                               <span class="caret"></span>
                                           </button>
                                           <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                               <li><a href="${ctx}/hrm/ei/employee/delete?id=${employee.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该员工入职记录吗？',this.href)">删除</a>
                                               </li>
                                               <li><a href="${ctx}/hrm/ei/employee/info?id=${employee.id}" target="">详情</a></li>
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
            "order": [[ 13, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:15},
                {"orderable":false,targets:16},
                {"orderable":false,targets:17},
                {"orderable":false,targets:18},
                {"orderable":false,targets:19},
                {"orderable":false,targets:20},
                {"orderable":false,targets:21},
                {"orderable":false,targets:22},
                {"orderable":false,targets:23}
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