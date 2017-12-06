<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>考勤管理</title>
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
				href="${ctx}/hrm/at/attendance/">考勤列表</a></small>
			<shiro:hasPermission name="hrm:at:attendance:edit">
				<small>|</small>
				<small><i class="fa-form-edit"></i><a
					href="${ctx}/hrm/at/attendance/form">考勤添加</a></small>
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
            
            <form:form id="searchForm" modelAttribute="attendance" action="${ctx}/hrm/at/attendance/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">员工姓名</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="sysUser.name" id="userName" verifyType="0" tip="请输入员工姓名" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">考勤类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="attendanceType" tip="请选择考勤类型" isMandatory="false" verifyType="0" dictName="hrm_at_attendance_type" id="attendanceType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">考勤结果</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="result" tip="请选择考勤结果" isMandatory="false" verifyType="0" dictName="hrm_at_attendance_result_type" id="result"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">开始时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="beginAttendanceDate" inputName="beginAttendanceDate" value="${attendance.beginAttendanceDate }"  isMandatory="false" tip="请选择考勤开始时间" inputId="beginAttendanceDate"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">截止时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="endAttendanceDate" inputName="endAttendanceDate" value="${attendance.endAttendanceDate }" isMandatory="false" tip="请选择考勤截止时间" inputId="endAttendanceDate"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">考勤数据来源</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="sourceType" tip="请选择数据来源类型" verifyType="0" isMandatory="false" dictName="hrm_at_attendance_source_type" id="sourceType"></sys:selectverify>
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
                                <th>员工</th>
                                <th>考勤日期</th>
                                <th>考勤类型</th>
                                <th>考勤时间</th>
                                <th>考勤结果</th>
                                <th>数据来源类型</th>
                                <th>数据来源详情</th>
                                <th style="display: none;">创建人</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">更新人</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="hrm:at:attendance:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="attendance" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
										<td>${attendance.sysUser.name}</td>
										<td><fmt:formatDate value="${attendance.attendanceDate}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>
										   <c:choose>
										       <c:when test="${attendance.attendanceType eq '1' }"><!-- 打卡 -->
										           <span class="label label-primary">${fns:getDictLabel(attendance.attendanceType, 'hrm_at_attendance_type', '')}</span>
										       </c:when>
										       <c:when test="${attendance.attendanceType eq '2' }"><!-- 人工 -->
                                                   <span class="label label-success">${fns:getDictLabel(attendance.attendanceType, 'hrm_at_attendance_type', '')}</span>
                                               </c:when>
                                               <c:when test="${attendance.attendanceType eq '3' }"><!-- 其他 -->
                                                   <span class="label label-default">${fns:getDictLabel(attendance.attendanceType, 'hrm_at_attendance_type', '')}</span>
                                               </c:when>
										   </c:choose>
										</td>
										  
										<td>${attendance.attendanceTime}</td>
										<td>
										   <c:choose>
                                               <c:when test="${attendance.result eq '1' }"><!-- 通过 -->
                                                   <span class="label label-primary">${fns:getDictLabel(attendance.result, 'hrm_at_attendance_result_type', '')}</span>
                                               </c:when>
                                               <c:when test="${attendance.result eq '2' }"><!-- 迟到 -->
                                                   <span class="label label-success">${fns:getDictLabel(attendance.result, 'hrm_at_attendance_result_type', '')}</span>
                                               </c:when>
                                               <c:when test="${attendance.result eq '3' }"><!-- 早退 -->
                                                   <span class="label label-default">${fns:getDictLabel(attendance.result, 'hrm_at_attendance_result_type', '')}</span>
                                               </c:when>
                                           </c:choose>
										</td>
										<td>
										  <c:choose>
                                               <c:when test="${attendance.sourceType eq '1' }"><!-- 打卡机 -->
                                                   <span class="label label-primary">${fns:getDictLabel(attendance.sourceType, 'hrm_at_attendance_source_type', '')}</span>
                                               </c:when>
                                               <c:when test="${attendance.sourceType eq '2' }"><!-- 人工 -->
                                                   <span class="label label-success">${fns:getDictLabel(attendance.sourceType, 'hrm_at_attendance_source_type', '')}</span>
                                               </c:when>
                                               <c:when test="${attendance.sourceType eq '3' }"><!-- 其他 -->
                                                   <span class="label label-default">${fns:getDictLabel(attendance.sourceType, 'hrm_at_attendance_source_type', '')}</span>
                                               </c:when>
                                           </c:choose>
										</td>
										<td>${attendance.sourceDetail}</td>
										<td data-hide="true">
										   ${fns:getUserById(attendance.createBy.id).name }
										</td>
										<td data-hide="true">
										      <fmt:formatDate value="${attendance.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td data-hide="true">
                                           ${fns:getUserById(attendance.updateBy.id).name }
                                        </td>
                                        <td data-hide="true">
                                            <fmt:formatDate value="${attendance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                                        </td>
                                        <td data-hide="true">
                                            ${fns:abbr(attendance.remarks, 15)}
                                        </td>
										<shiro:hasPermission name="hrm:at:attendance:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/hrm/at/attendance/form?id=${attendance.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/hrm/at/attendance/delete?id=${attendance.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该考勤吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/hrm/at/attendance/info?id=${attendance.id}" target="">详情</a></li>
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
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13}
                
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