<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>周范秀场管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/sa/showArea/">周范秀场列表</a></small>
            <shiro:hasPermission name="idx:sa:showArea:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/idx/sa/showArea/form">周范秀场添加</a>
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
            
            <form:form id="searchForm" modelAttribute="showArea" action="${ctx}/idx/sa/showArea/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="musercode" class="col-sm-3 control-label">会员账号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="member.usercode" id="musercode" verifyType="99" tip="请输入会员账号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="usableFlag" class="col-sm-3 control-label" >是否启用</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="usableFlag" tip="请选择是否启用" verifyType="99" isMandatory="false" dictName="yes_no" id="usableFlag"></sys:selectverify>
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
                                <th>视频</th>
                                <th>标题</th>
                                <th>展示时间</th>
                                <th>播放次数</th>
                                <th>是否启用</th>
                                <th style="display:none;">创建者</th>
                                <th style="display:none;">创建时间</th>
                                <th style="display:none;">更新者</th>
                                <th style="display:none;">更新时间</th>
                                <th style="display:none;">备注信息</th>
                                <shiro:hasPermission name="idx:sa:showArea:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="showArea" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                            ${fns:getMemberById(showArea.member.id).usercode}
</td>
                                    <td>
                                        http://img.chinazhoufan.com/${showArea.video}
</td>
                                    <td>
                                            ${fns:abbr(showArea.title,35)}
</td>
                                    <td>
                                        <fmt:formatDate value="${showArea.displayTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
</td>
                                    <td>
                                        ${showArea.playNum}
</td>
                                    <td>
                                        <c:if test="${showArea.usableFlag=='1' }">
                                            <span class="label label-success">${fns:getDictLabel(showArea.usableFlag, 'yes_no', '')}</span>
                                        </c:if>
                                        <c:if test="${showArea.usableFlag=='0' }">
                                            <span class="label label-primary">${fns:getDictLabel(showArea.usableFlag, 'yes_no', '')}</span>
                                        </c:if>
</td>
                                    <td data-hide="true">
                                            ${fns:getUserById(showArea.createBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${showArea.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                            ${fns:getUserById(showArea.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${showArea.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                            ${fns:abbr(showArea.remarks,15)}
                                    </td>
                                    <shiro:hasPermission name="idx:sa:showArea:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/idx/sa/showArea/form?id=${showArea.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <c:choose><c:when test="${ showArea.usableFlag eq '0' }">
                                                    <li><a href="${ctx}/idx/sa/showArea/delete?id=${showArea.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该周范秀场吗？',this.href)">删除</a>
                                                    </li>
                                                </c:when></c:choose>
                                                <li><a href="${ctx}/idx/sa/showArea/info?id=${showArea.id}" target="">详情</a></li>
                                                <c:choose>
                                                    <c:when test="${ showArea.usableFlag eq '0' }">
                                                        <li><a href="${ctx}/idx/sa/showArea/updateUsable?id=${showArea.id}&usableFlag=1" onclick="return ZF.delRow('确认启用该周范秀场么？',this.href)">启用</a></li>
                                                    </c:when>
                                                    <c:when test="${ showArea.usableFlag eq '1' }">
                                                        <li><a href="${ctx}/idx/sa/showArea/updateUsable?id=${showArea.id}&usableFlag=0" onclick="return ZF.delRow('确认停用该周范秀场么？',this.href)">停用</a></li>
                                                    </c:when>
                                                </c:choose>
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
            "order": [[ 4, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12}
                
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