<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>优惠券模板管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ci/couponTemplate/select">优惠券模板列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="couponTemplate" action="${ctx}/spm/ci/couponTemplate/select" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">模板名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" verifyType="0" tip="请输入模板名称" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">开始时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="startTime" inputName="startTime" tip="请选择开始时间" inputId="startTimeId" value="${couponTemplate.startTime }" isMandatory="false"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">截止时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="endTime" inputName="endTime" tip="请选择截止时间" inputId="endTimeId" value="${couponTemplate.endTime }" isMandatory="false"></sys:datetime>
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
                                <th>模板名称</th>
                                <th>优惠券名称</th>
                                <th>可用起始时间</th>
                                <th>可用截止时间</th>
                                <th>优惠类型</th>
                                <th>已生成数量</th>
                                <th>已领取数量</th>
                                <th>更新时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="couponTemplate" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                       <input type="radio" name="selItem" value="${couponTemplate.id }=${couponTemplate.couponName}=${couponTemplate.introduction}"/>
                                    </td>
                                    <td title="${couponTemplate.name }">
                                        ${fns:abbr(couponTemplate.name, 20)}
                                    </td>
                                    <td title="${couponTemplate.couponName }">
                                        ${fns:abbr(couponTemplate.couponName, 20)}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${couponTemplate.startTime}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${couponTemplate.endTime}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                         <span class="label label-primary">${fns:getDictLabel(couponTemplate.couponType, 'spm_ci_coupon_type', '')}
                                    </td>
                                    <td>
                                        ${couponTemplate.numCreated}
                                    </td>
                                    <td>
                                        ${couponTemplate.numProvided}
                                    </td>
                                    <td><fmt:formatDate value="${couponTemplate.updateDate}" pattern="yyyy-MM-dd mm:hh:ss"/></td>
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
            "order": [[ 8, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
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