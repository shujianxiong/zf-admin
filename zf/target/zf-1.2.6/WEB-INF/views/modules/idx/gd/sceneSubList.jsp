<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>场景管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/gd/scene/findParentList">场景列表</a></small>
            <small>|</small>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/gd/scene/findSubList?scene.id=${scene.scene.id}">子场景列表</a></small>
            <shiro:hasPermission name="idx:gd:scene:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/idx/gd/scene/form?scene.id=${scene.scene.id}">子场景添加</a>
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
            
            <form:form id="searchForm" modelAttribute="scene" action="${ctx}/idx/gd/scene/findSubList?scene.id=${scene.scene.id }" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">场景名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" isMandatory="false" verifyType="0" isSpring="true" tip="请输入正确的查询条件，不包含特殊字符"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="usableFlag" class="col-sm-3 control-label">是否启用</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="usableFlag" tip="" verifyType="0" isMandatory="false" dictName="yes_no" id="usableFlag"></sys:selectverify>
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
                                <th>场景名称</th>
                                <th>父场景名称</th>
                                <th>场景英文名称</th>
                                <th>展示图</th>
                                <th>头部图</th>
                                <th>搜索图</th>
                                <th>是否启用</th>
                                <th>排列序号</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${list}" var="scene" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${scene.name}
                                    </td>
                                    <td>
                                        ${scene.scene.name}
                                    </td>
                                    <td>
                                        ${scene.englishName}
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${scene.dpPhoto}" data-big data-src="${imgHost }${scene.dpPhoto}" width="20px" height="20px" />
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${scene.topPhoto}" data-big data-src="${imgHost }${scene.topPhoto}" width="20px" height="20px" />
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${scene.searchIcon}" data-big data-src="${imgHost }${scene.searchIcon}" width="20px" height="20px" />
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${scene.usableFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(scene.usableFlag, 'yes_no', '')}</span>
                                            </c:when>
                                            <c:when test="${scene.usableFlag eq '0' }">
                                                 <span class="label label-primary">${fns:getDictLabel(scene.usableFlag, 'yes_no', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        ${scene.orderNo}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${scene.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(scene.remarks, 20)}
                                    </td>
                                    <shiro:hasPermission name="idx:gd:scene:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/idx/gd/scene/form?id=${scene.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/idx/gd/scene/updateFlag?id=${scene.id}&type=U&subType=1" target="">${scene.usableFlag eq '1'?'停用':'启用' }</a></li>
                                                <c:if test="${scene.usableFlag eq '0' }">  <!-- 非启用状态可以删除 -->
	                                                <li><a href="${ctx}/idx/gd/scene/delete?id=${scene.id}&subType=1" style="color: #fff" onclick="return ZF.delRow('确定要删除该子场景吗？',this.href)">删除</a>
	                                                </li>
	                                            </c:if>
                                                <li><a href="${ctx}/idx/gd/scene/info?id=${scene.id}" target="">详情</a></li>
                                            </ul>
                                        </div>
                                    </td></shiro:hasPermission>
                                    <shiro:lacksPermission name="idx:gd:scene:edit">
                                        <td>
                                             <div class="btn-group zf-tableButton">
	                                            <button type="button" class="btn btn-sm btn-info"
	                                                onclick="window.location.href='${ctx}/idx/gd/scene/info?id=${scene.id}'">详情</button>
	                                            <button type="button"
	                                                class="btn btn-sm btn-info dropdown-toggle"
	                                                data-toggle="dropdown">
	                                                <span class="caret"></span>
	                                            </button>
	                                         </div>
                                        </td>
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
            "order": [[ 8, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11}
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