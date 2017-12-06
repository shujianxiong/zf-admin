<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>积分商品兑换记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/pm/pointExchange/">积分商品兑换记录列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="pointExchange" action="${ctx}/spm/pm/pointExchange/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                    	<div class="col-md-4">
                            <div  class="form-group">
                                <label for="serialNo" class="col-sm-3 control-label">兑换流水号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="serialNo" id="serialNo" verifyType="0" tip="请输入兑换流水号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">会员账号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="member.usercode" id="musercode" verifyType="0" tip="请输入会员账号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">兑换状态</label>
                                <div class="col-sm-7">  
                                     <sys:selectverify name="status" tip="请选择兑换状态" isMandatory="false" verifyType="0" dictName="spm_pm_point_exchange_status" id="status"></sys:selectverify>
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
                            	<th>兑换订单编号</th>
                                <th>会员账号</th>
                                <th>积分商品编号</th>
                                <th>兑换状态</th>
                                <th>消耗积分</th>
                                <th>更新时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="pointExchange" varStatus="status">
                                <tr data-index="${status.index }">
                                		<td>${pointExchange.serialNo}</td>
										<td>${pointExchange.member.usercode}</td>
										<td>${pointExchange.pointGoods.code}</td>
										<td>
										   <c:choose>
										       <c:when test="${pointExchange.status eq '1' }">
										          <span class="label label-primary">${fns:getDictLabel(pointExchange.status, 'spm_pm_point_exchange_status', '') }</span>
										       </c:when>
										       <c:otherwise>
										          <span class="label label-success">${fns:getDictLabel(pointExchange.status, 'spm_pm_point_exchange_status', '') }</span>
										       </c:otherwise>
										   </c:choose>
									    </td>
										<td>${pointExchange.point}</td>
										<td><fmt:formatDate value="${pointExchange.updateDate}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
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
                {"orderable":false,targets:2},
                {"orderable":false,targets:3}
                
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