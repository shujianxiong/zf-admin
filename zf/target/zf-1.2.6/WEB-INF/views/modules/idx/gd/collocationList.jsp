<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搭配管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/gd/collocation/">搭配列表</a></small>
            <shiro:hasPermission name="idx:gd:collocation:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/idx/gd/collocation/form">搭配添加</a>
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
            
            <form:form id="searchForm" modelAttribute="collocation" action="${ctx}/idx/gd/collocation/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" verifyType="0" tip="可输入搭配或场景名称查询，不包含特殊字符" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">是否启用</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="usableFlag" tip="请选择" verifyType="0" dictName="yes_no" id="usableFlag" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">默认推荐</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="recommendFlag" tip="请选择" verifyType="0" dictName="yes_no" id="recommendFlag" isMandatory="false"></sys:selectverify>
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
                                <th>搭配名称</th>
                                <th>英文名称</th>
                                <th>色系</th>
                                <th>所属场景</th>
                                <th>搭配详情图</th>
                                <th>搭配描述</th>
                                <th>搜索关键词</th>
                                <th>是否启用</th>
                                <th>默认推荐</th>
                                <th>分享标题</th>
                                <th>分享描述</th>
                                <th>分享图片</th>
                                <th>排列序号</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="collocation" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td title="${ collocation.name}">
                                        ${fns:abbr(collocation.name, 20)}
                                    </td>
                                    <td title="${ collocation.englishName}">
                                        ${fns:abbr(collocation.englishName, 20)}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(collocation.colourSystem, 'idx_gd_collocation_colourSystem', '')}</span>
                                    </td>
                                    <td>
                                        ${collocation.scene.name}
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${collocation.photo}" data-big data-src="${imgHost }${collocation.photo}" width="20px" height="20px" />
                                    </td>
                                    <td title="${collocation.description}">
                                        ${fns:abbr(collocation.description,20)}
                                    </td>
                                    <td title="${collocation.searchKey}">
                                            ${fns:abbr(collocation.searchKey,20)}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${collocation.usableFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(collocation.usableFlag, 'yes_no', '')}</span>
                                            </c:when>
                                            <c:when test="${collocation.usableFlag eq '0' }">
                                                 <span class="label label-primary">${fns:getDictLabel(collocation.usableFlag, 'yes_no', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${collocation.recommendFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(collocation.recommendFlag, 'yes_no', '')}</span>
                                            </c:when>
                                            <c:when test="${collocation.recommendFlag eq '0' }">
                                                 <span class="label label-primary">${fns:getDictLabel(collocation.recommendFlag, 'yes_no', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td title="${ collocation.shareTitle}">
                                        ${fns:abbr(collocation.shareTitle, 20)}
                                    </td>
                                    <td title="${ collocation.shareDescribe}">
                                        ${fns:abbr(collocation.shareDescribe,30)}
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${collocation.sharePhoto}" data-big data-src="${imgHost }${collocation.sharePhoto}" width="20px" height="20px" />
                                    </td>
                                    <td>
                                        ${collocation.orderNo}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${collocation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(collocation.remarks, 20)}
                                    </td>
                                    <shiro:hasPermission name="idx:gd:collocation:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/idx/gd/collocation/form?id=${collocation.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/idx/gd/collocation/updateFlag?id=${collocation.id}" target="">${collocation.usableFlag eq '1'?'停用':'启用' }</a></li>
                                                <li><a href="${ctx}/idx/gd/collocation/updateRecommandFlag?id=${collocation.id}" target="">${collocation.recommendFlag eq '1'?'取消推荐':'默认推荐' }</a></li>
                                                <li><a href="${ctx}/idx/gd/collocationGroup/list?collocation.id=${collocation.id}" target="">分组管理</a></li>
                                                <c:if test="${collocation.usableFlag eq '0'}">  <!-- 非启用状态可以删除 -->
	                                                <li><a href="${ctx}/idx/gd/collocation/delete?id=${collocation.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该搭配吗？选择确定，会将关联的搭配分组及分组商品一并删掉',this.href)">删除</a>
                                                </c:if>
                                                </li>
                                                <li><a href="${ctx}/idx/gd/collocation/info?id=${collocation.id}" target="">详情</a></li>
                                            </ul>
                                        </div>
                                    </td></shiro:hasPermission>
                                    <shiro:lacksPermission name="idx:gd:collocation:edit">
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/idx/gd/collocation/info?id=${collocation.id}'">详情</button>
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
            "ordering" : false,
            //"order": [[ 9, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:5},
                {"orderable":false,targets:7},
                {"orderable":false,targets:6},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
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