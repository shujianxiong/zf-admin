<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>免押金活动配置表管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/fd/freeDeposit/">免押金活动配置表列表</a></small>
            <shiro:hasPermission name="spm:fd:freeDeposit:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/spm/fd/freeDeposit/form">免押金活动配置表添加</a>
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
            
            <form:form id="searchForm" modelAttribute="freeDeposit" action="${ctx}/spm/fd/freeDeposit/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">配置名称</label>
                                <div class="col-sm-7">  
                                    <form:input path="name" class="form-control" placeholder="请输入名称查询" />
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
                                <th>简介</th>
                                <th>开始时间</th>
                                <th>结束时间</th>
                                <th>注册名额比例</th>
                                <th>总名额</th>
                                <th>初始名额</th>
                                <th>剩余名额</th>
                                <th>启用状态</th>
                                <th style="display:none">创建人</th>
                                <th style="display:none">创建时间</th>
                                <th style="display:none">更新人</th>
                                <th style="display:none">更新时间</th>
                                <th style="display:none">备注信息</th>
                                <shiro:hasPermission name="spm:fd:freeDeposit:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="freeDeposit" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td title="${freeDeposit.name }">
                                        ${fns:abbr(freeDeposit.name, 20)}
									</td>
									<td title="${freeDeposit.summary }">
                                        ${fns:abbr(freeDeposit.summary, 40)}
									</td>
									<td>
                                        <fmt:formatDate value="${freeDeposit.startTime}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
                                        <fmt:formatDate value="${freeDeposit.endTime}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
                                        ${freeDeposit.registerPlaces}
									</td>
									<td>
                                        ${freeDeposit.places}
									</td>
									<td>
                                        ${freeDeposit.initPlaces}
									</td>
									<td>
                                        ${freeDeposit.surplusPlaces}
									</td>
									<td>
                                        <c:choose>
									       <c:when test="${freeDeposit.activeFlag eq '0' }">
									           <span class="label label-primary">${fns:getDictLabel(freeDeposit.activeFlag, 'yes_no', '')}</span>
									       </c:when>
									       <c:when test="${freeDeposit.activeFlag eq '1' }">
									           <span class="label label-success">${fns:getDictLabel(freeDeposit.activeFlag, 'yes_no', '')}</span>
									       </c:when>
									    </c:choose>
									</td>
									<td data-hide="true">
                                        ${fns:getUserById(freeDeposit.createBy.id).name}
									</td>
									<td data-hide="true">
                                        <fmt:formatDate value="${freeDeposit.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
                                        ${fns:getUserById(freeDeposit.updateBy.id).name}
									</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${freeDeposit.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td data-hide="true">
                                        ${freeDeposit.remarks}
									</td>
                                    <shiro:hasPermission name="spm:fd:freeDeposit:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/spm/fd/freeDeposit/form?id=${freeDeposit.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                            	<li><a href="${ctx}/spm/fd/freeDeposit/updateFlag?id=${freeDeposit.id}" target="">${freeDeposit.activeFlag eq '1'?'停用':'启用' }</a></li>
								                    <c:if test="${freeDeposit.activeFlag eq '0' }"> <!-- 非启用状态允许删除 -->
                                                		<li><a href="${ctx}/spm/fd/freeDeposit/delete?id=${freeDeposit.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该免押金活动配置表吗？',this.href)">删除</a>
                                                		</li>
								                    </c:if>
                                                <li><a href="${ctx}/spm/fd/freeDeposit/info?id=${freeDeposit.id}" target="">详情</a></li>
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
            "order": [[ 3, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:0},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:15}
                
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