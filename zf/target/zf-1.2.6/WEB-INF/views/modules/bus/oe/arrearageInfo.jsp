<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>欠费信息</title>
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
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="box box-info">
            <form:form id="searchForm" modelAttribute="experienceOrder" action="${ctx}/bus/oe/experienceOrder/arrearageInfo" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <input name="id" type="hidden" value="${experienceOrder.id}"/>
            </form:form>
        </div>
    
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th>订单</th>
                                <th>欠费金额</th>
                                <th>是否偿还</th>
                                <th>偿还时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="experienceOrder" varStatus="status">
                                <tr >
                                    <td>${experienceOrder.orderNo}</td>
                                    <td>${experienceOrder.arrearageAmount}</td>
                                    <td>
                                    <c:choose>
					 					<c:when test="${experienceOrder.statusPay eq '98' }">
					 						<span class="text-red">是</span>
					 					</c:when>
					 					<c:otherwise>
					 						<span class="text-red">否</span>
					 					</c:otherwise>
					 				</c:choose>
                                    <td>
                                    <c:choose>
					 					<c:when test="${experienceOrder.statusPay eq '98' }">
					 						<span class="text-red"><fmt:formatDate value="${experienceOrder.appointPickDate}" pattern="yyyy-MM-dd"/></span>
					 					</c:when>
					 					<c:otherwise>
					 						<span class="text-red"></span>
					 					</c:otherwise>
					 				</c:choose>
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
            "ordering" : true,
            "order": [[ 3, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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