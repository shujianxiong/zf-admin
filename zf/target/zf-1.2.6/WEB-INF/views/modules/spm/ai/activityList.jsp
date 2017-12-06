<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>活动表管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ai/activity/">活动列表</a></small>
            <shiro:hasPermission name="spm:ai:activity:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/spm/ai/activity/form">活动添加</a>
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
            
            <form:form id="searchForm" modelAttribute="activity" action="${ctx}/spm/ai/activity/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>
                                <div class="col-sm-7">  
                                    <form:input path="searchParameter.keyWord" type="text" class="form-control" placeholder="请输入编码或名称或标题查询"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="searchParameter.keyWord" class="col-sm-3 control-label">启用状态</label>
                                <div class="col-sm-7">
                                    <form:select path="activeFlag">
                                        <form:option value="" label="请选择"/>
                                        <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                    </form:select>
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
                                <th>编码</th>
                                <th>名称</th>
                                <th>类型</th>
                                <th>标题</th>
                                <th>副标题</th>
                                <th>展示图</th>
                                <th>展示类型</th>
                                <th>人数上限</th>
                                <th>起始时间</th>
                                <th>结束时间</th>
                                <th>启用状态</th>
                                <th style="display: none">创建人</th>
                                <th style="display: none">创建时间</th>
                                <th style="display: none">更新人</th>
                                <th style="display: none">更新时间</th>
                                <th style="display: none">备注信息</th>
                                <shiro:hasPermission name="spm:ai:activity:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="activity" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${activity.code}
									</td>
                                    <td>
                                        ${activity.name}
									</td>
                                    <td>
                                        ${fns:getDictLabel(activity.type,'spm_ai_activity_type','')}
									</td>
                                    <td>
                                        ${activity.title}
									</td>
                                    <td>
                                        ${activity.subtitle}
									</td>
									<td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${activity.displayPhoto}" data-big data-src="${imgHost }${activity.displayPhoto}" width="20px" height="20px" />
									</td>
                                    <td>
                                         ${fns:getDictLabel(activity.displayType,'spm_ai_activity_displayType','')}
                                    </td>
                                    <td>
                                        ${activity.maxNum}
									</td>
                                    <td>
                                        <fmt:formatDate value="${activity.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td>
                                        <fmt:formatDate value="${activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${activity.activeFlag eq '0'}">
                                                <span class="label label-primary">否</span>
                                            </c:when>
                                            <c:when test="${activity.activeFlag eq '1'}">
                                                <span class="label label-success">是</span>
                                            </c:when>
                                        </c:choose>
									</td>
                                    <td data-hide="true">
                                        ${fns:getUserById(activity.createBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${activity.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(activity.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${activity.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td data-hide="true">
                                        ${activity.remarks}
									</td>
                                    <shiro:hasPermission name="spm:ai:activity:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/spm/ai/activity/info?id=${activity.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/spm/ai/activity/updateFlag?id=${activity.id}" style="color: #fff" >${activity.activeFlag eq '1'?'停用':'启用' }</a>
                                                </li>
                                                <c:if test="${activity.activeFlag eq '0'}">
                                                    <li><a href="${ctx}/spm/ai/activity/delete?id=${activity.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该活动吗？',this.href)">删除</a>
                                                    </li>
                                                    <li><a href="${ctx}/spm/ai/activity/form?id=${activity.id}" target="">修改</a></li>
                                                </c:if>
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
            "ordering" : false,
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