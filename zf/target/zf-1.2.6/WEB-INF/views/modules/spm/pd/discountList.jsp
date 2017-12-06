<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品促销记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/pd/discount/">产品促销记录列表</a></small>
            <shiro:hasPermission name="spm:pd:discount:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/spm/pd/discount/form">产品促销设置</a>
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
            
            <form:form id="searchForm" modelAttribute="discount" action="${ctx}/spm/pd/discount/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                    	<div class="col-md-4">
                            <div  class="form-group">
                                <label for="startTimeId" class="col-sm-3 control-label">标题</label>
                                <div class="col-sm-7">  
                                    <form:input id="title" path="title" htmlEscape="false" maxlength="64" class="form-control"  placeholder="请输入标题"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="startTimeId" class="col-sm-3 control-label">生效时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="discountFilterStart" inputName="discountFilterStart" tip="请选择生效时间" value="${discount.discountFilterStart }" isMandatory="false" inputId="startTimeId"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="endTimeId" class="col-sm-3 control-label">失效时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="discountFilterEnd" inputName="discountFilterEnd" tip="请选择失效时间" value="${discount.discountFilterEnd }" isMandatory="false" inputId="endTimeId"></sys:datetime>
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
                                <th>标题</th>
                                <th>促销折扣</th>
                                <th>体验押金比例</th>
                                <th>积分可抵金额</th>
                                <th>促销生效时间</th>
                                <th>促销失效时间</th>
                                <th>执行产品数量</th>
                                <th>创建人</th>
                                <th>创建时间</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">更新人</th>
                                <th style="display: none;">备注信息</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="discount" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td title="${discount.title }">
                                        ${fns:abbr(discount.title, 20)}
                                    </td>
                                    <td>
                                        <span class="text-red">${discount.discountFilterScale}</span>
                                    </td>
                                    <td>
                                        <span class="text-red">${discount.scaleExperienceDeposit}</span>
                                    </td>
                                    <td>
                                        <span class="text-red">${discount.priceDecPoint}</span>
                                    </td>
                                    <td>
                                        <span class="text-red"><fmt:formatDate value="${discount.discountFilterStart}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                    </td>
                                    <td>
                                        <span class="text-red"><fmt:formatDate value="${discount.discountFilterEnd}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                    </td>
                                    <td>
                                        ${discount.produceNum}
                                    </td>
                                    <td>
                                        ${fns:getUserById(discount.createBy.id).name }
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${discount.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${discount.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(discount.updateBy.id).name }
                                    </td>
                                    <td data-hide="true">
                                        ${discount.remarks}
                                    </td>
                                    <td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/spm/pd/discount/info?id=${discount.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
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
            "order": [[ 1, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
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