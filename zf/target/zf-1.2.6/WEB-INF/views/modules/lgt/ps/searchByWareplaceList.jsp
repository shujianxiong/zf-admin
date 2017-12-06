<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>商品关键字查询</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
    <script type="text/javascript">
    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
    
    function resetForm() {
    	$("#fullWareplace").val("");
    }
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
        <section class="content-header content-header-menu">
          <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produce/searchByWareplace">货位编码查询</a></small>
          </h1>
        </section>
        <sys:tip content="${message}"/>
        <section class="content">
            <form:form id="searchForm" modelAttribute="Produce" action="${ctx}/lgt/ps/produce/searchByWareplace" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box box-info">
                    <div class="box-header with-border zf-query">
                        <h5>查询条件</h5>
                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                            <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="fullWareplace" class="col-sm-3 control-label">关键字</label>
                                    <div class="col-sm-7">
                                        <input id="fullWareplace" name="fullWareplace" value="${produce.fullWareplace }" htmlEscape="false" maxlength="100" class="form-control" placeholder="请输入货位编码查询"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">   
                        <div class="pull-right box-tools">
                            <button type="button" class="btn btn-default btn-sm" onclick="resetForm()"><i class="fa fa-refresh"></i>重置</button>
                            <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
                        </div>
                    </div>
                </div>
            </form:form>
            <div class="box box-soild">
                <div class="box-body">
                    <div class="table-responsive">
                         <table  id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                             <thead>
                                 <tr>
                                     <th class="zf-dataTables-multiline"></th>
                                     <th>货位位置(货位编码)</th>
                                     <th>商品名称(编码)</th>
                                     <th>产品名称(编码)</th>
                                     <th>库存</th>
                                     <th style="display:none;">创建者</th>
                                     <th style="display:none;">创建时间</th>
                                     <th style="display:none;">更新者</th>
                                     <th style="display:none;">更新时间</th>
                                     <th style="display:none;">备注信息</th>
                                     <th>操作</th>
                                 </tr>
                             </thead>
                             <tbody>
                                 <c:forEach items="${page.list }" var="produce" varStatus="status">
	                                 <tr data-index="${status.index }">
                                        <td class="details-control text-center">
                                            <i class="fa fa-plus-square-o text-success"></i>
                                        </td>
	                                     <td>${produce.fullWareplace }</td>
	                                     <td>${produce.goods.name }(${produce.goods.code })</td>
	                                     <td>${produce.name }(${produce.code })</td>
	                                     <td>${produce.stockNormal }</td>
	                                     <td data-hide="true">
                                            ${fns:getUserById(produce.createBy.id).name}
                                         </td>
                                         <td data-hide="true">
                                            <fmt:formatDate value="${produce.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                         </td>
                                         <td data-hide="true">
                                            ${fns:getUserById(produce.updateBy.id).name}
                                         </td>
                                         <td data-hide="true">
                                            <fmt:formatDate value="${produce.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                         </td>
                                         <td data-hide="true">
                                            ${fns:abbr(produce.remarks,30)}
                                         </td>
	                                     <td>
	                                         <div class="btn-group zf-tableButton">
	                                             <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/goods/goodsSynInfo?id=${produce.goods.id}'">详情</button>
	                                             <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
	                                                <span class="caret"></span>
	                                             </button>
	                                         </div>
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
    <script type="text/javascript">
        $(function() {
        	
        	 //表格初始化
            var t=ZF.parseTable("#contentTable",{
                "paging" : false,
                "lengthChange" : false,
                "searching" : false,//关闭搜索
                "order": [[ 8, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
                "columnDefs":[
                    {"orderable":false,targets:0},  //第0列不排序
                    {"orderable":false,targets:1},  
                    {"orderable":false,targets:2},  
                    {"orderable":false,targets:3},
                    {"orderable":false,targets:4},
                    {"orderable":false,targets:5},
                    {"orderable":false,targets:6},
                    {"orderable":false,targets:7},
                    {"orderable":false,targets:8},
                    {"orderable":false,targets:9},
                    {"orderable":false,targets:10}
                ],
                "ordering" : false,//开启排序
                "info" : false,
                "autoWidth" : false,
                "multiline":true,//是否开启多行表格
                "isRowSelect":true,//是否开启行选中
                "rowSelect":function(tr){},//行选中回调
                "rowSelectCancel":function(tr){}//行取消选中回调
            });
        	
        });
    </script>
</body>
</html>