<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搭配分组管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/gd/collocation/">搭配列表</a></small>
            <small>|</small>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/gd/collocationGroup/list?collocation.id=${collocationGroup.collocation.id}">搭配分组列表</a></small>
            <shiro:hasPermission name="idx:gd:collocationGroup:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/idx/gd/collocationGroup/form?collocation.id=${collocationGroup.collocation.id}">搭配分组添加</a>
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
            
            <form:form id="searchForm" modelAttribute="collocationGroup" action="${ctx}/idx/gd/collocationGroup/list?collocation.id=${collocationGroup.collocation.id}" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">展示标题</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="title" id="title" verifyType="0" tip="请输入正确的查询条件，不包含特殊字符" isMandatory="false" isSpring="true"></sys:inputverify>
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
                                <th>展示标题</th>
                                <th>展示图</th>
                                <th>展示视频</th>
                                <th>所属搭配</th>
                                <th>所属分类</th>
                                <th>是否启用</th>
                                <th>排列序号</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="collocationGroup" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${collocationGroup.title}
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${collocationGroup.photo}" data-big data-src="${imgHost }${collocationGroup.photo}" width="20px" height="20px" />
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${collocationGroup.video eq null }">
                                            </c:when>
                                            <c:otherwise>
                                                ${fns:getQiNiuWebSite()}${collocationGroup.video}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        ${collocationGroup.collocation.name}
                                    </td>
                                    <td>
                                        ${collocationGroup.category.categoryName}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${collocationGroup.usableFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(collocationGroup.usableFlag, 'yes_no', '')}</span>
                                            </c:when>
                                            <c:when test="${collocationGroup.usableFlag eq '0' }">
                                                 <span class="label label-primary">${fns:getDictLabel(collocationGroup.usableFlag, 'yes_no', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>${collocationGroup.orderNo }</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${collocationGroup.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(collocationGroup.remarks, 20)}
                                    </td>
                                    <shiro:hasPermission name="idx:gd:collocationGroup:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/idx/gd/collocationGroup/form?id=${collocationGroup.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/idx/gd/collocationGroup/updateFlag?id=${collocationGroup.id}" target="">${collocationGroup.usableFlag eq '1'?'停用':'启用' }</a></li>
                                                <c:choose><c:when test="${ collocationGroup.usableFlag eq '0' }">
                                                    <li><a href="${ctx}/idx/gd/collocationGroup/delete?id=${collocationGroup.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该搭配分组吗？选择确定，会将关联的分组商品一并删除',this.href)">删除</a>
                                                    </li>
                                                </c:when></c:choose>
                                                <li><a href="${ctx}/idx/gd/collocationGroup/info?id=${collocationGroup.id}" target="">详情</a></li>
                                            </ul>
                                        </div>
                                    </td></shiro:hasPermission>
                                    <shiro:lacksPermission name="idx:gd:collocationGroup:edit">
                                         <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/idx/gd/collocationGroup/info?id=${collocationGroup.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                         </div>
                                    </shiro:lacksPermission>
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
            "order": [[ 7, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10}
                
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