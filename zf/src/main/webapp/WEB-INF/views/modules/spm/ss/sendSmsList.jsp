<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发送短信记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ss/sendSms/">发送短信记录列表</a></small>
            <shiro:hasPermission name="spm:ss:sendSms:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/spm/ss/sendSms/form">发送短信记录添加</a>
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
            
            <form:form id="searchForm" modelAttribute="sendSms" action="${ctx}/spm/ss/sendSms/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="phone" class="col-sm-3 control-label">名称</label>
                            <div class="col-sm-7">
                                <form:input path="phone" class="form-control" placeholder="请输入手机号码" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                          <label for="context" class="col-sm-3 control-label">内容</label>
                          <div class="col-sm-7">
                            <form:input path="context" class="form-control" placeholder="请输入发送内容" />
                          </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                         <div  class="form-group">
                             <label for="status" class="col-sm-3 control-label">是否发送成功</label>
                             <div class="col-sm-7">
                                 <select id="status" name="status" class="required input-medium">
                                      <option value="" >所有</option>
									  <option value="0">是</option>
									  <option value="1">否</option>
								</select>
                             </div>
                         </div>
                     </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div  class="form-group">
                            <label for="name" class="col-sm-3 control-label">发送开始时间</label>
                            <div class="col-sm-7">  
                                <sys:datetime id="beginTime" inputName="beginTime" tip="请选择发送开始时间" inputId="beginTime" value="${sendSms.beginTime }" isMandatory="false"></sys:datetime>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div  class="form-group">
                            <label for="name" class="col-sm-3 control-label">发送截止时间</label>
                            <div class="col-sm-7">  
                                <sys:datetime id="endTime" inputName="endTime" tip="请选择发送结束时间" inputId="endTime" value="${sendSms.endTime }" isMandatory="false"></sys:datetime>
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
                                <th>名称</th>
                                <th>内容</th>
                                <th>发送时间</th>
                                <th>备注</th>
                                <th>发送是否成功</th>
                                <th style="display:none">创建者</th>
								<th style="display:none">创建时间</th>
								<th style="display:none">更新者</th>
								<th style="display:none">更新时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="sendSms" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>${sendSms.phone}</td>
                                    <c:set var="fullName" value="${sendSms.context }"></c:set>
                                    <td title="${fullName }">${fns:abbr(fullName, 15)}</td>
                                    <td><fmt:formatDate value="${sendSms.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>${sendSms.remarks}</td>
                                    <td><span>
	                                     <c:choose>
						 					<c:when test="${sendSms.status eq '0' }">
						 						<span >是</span>
						 					</c:when>
						 					<c:otherwise>
						 						<span >否</span>
						 					</c:otherwise>
						 				</c:choose>
                                     </span></td>
                                     <td data-hide="true">
										${fns:getUserById(sendSms.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${sendSms.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(sendSms.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${sendSms.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
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
            "order": [[ 3, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5}
                
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