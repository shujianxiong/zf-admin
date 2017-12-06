<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
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
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/dac/mi/memberDac/statNewRegister">会员注册分析</a></small>
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
            
            <form:form id="searchForm" modelAttribute="member" action="${ctx}/dac/mi/memberDac/statNewRegister" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                           <div class="form-group">
                               <label for="beginRegisterTime" class="col-sm-3 control-label">注册开始时间</label>
                               <div class="col-sm-7">
                                   <sys:datetime id="beginRegisterTimeDiv" inputName="beginRegisterTime" tip="请选择注册开始时间"  value="${member.beginRegisterTime }" inputId="beginRegisterTime"></sys:datetime>
                               </div>
                           </div>
                       </div>
                       <div class="col-md-4">
                           <div class="form-group">
                               <label for="beginRegisterTime" class="col-sm-3 control-label">注册结束时间</label>
                               <div class="col-sm-7">
                                   <sys:datetime id="endRegisterTimeDiv" inputName="endRegisterTime" tip="请选择注册结束时间"  value="${member.endRegisterTime }" inputId="endRegisterTime"></sys:datetime>
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
                <div class="row">
                    <div class="col-sm-12 pull-right">
                        <button type="button" class="btn btn-sm btn-info" id="chartPreview"><i class="fa fa-line-chart">图表预览</i></button>
                        <button type="button" class="btn btn-sm btn-info" id="dataPreview" style="display: none;"><i class="fa fa-table">数据一览</i></button>
                        <c:if test="${not empty list }">
	                        <button type="button" class="btn btn-sm btn-success" id="exportBtn"><i class="fa fa-file-excel-o">Excel导出</i></button>
                        </c:if>
                    </div>
                </div>
                <div id="dataView" class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th>注册时间</th>
                                <th>新增人数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${list}" var="member">
                                <tr>
                                    <td>
                                        <fmt:formatDate value="${member.registerTime}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                        ${member.count}
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div id="chartView" style="display: none;">
                    <div id="lineChart" style="height:300px;width: 100%;"></div>
                </div>
            </div>
            <div class="box-footer">
                <div class="dataTables_paginate paging_simple_numbers">${page}</div>
            </div>
        </div>
	</section>
</div>


<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/morris/morris.css">
<script src="${ctxStatic }/adminLte/plugins/morris/morris.min.js"></script>
<script src="${ctxStatic }/adminLte/plugins/morris/raphael-min.js"></script>

<script type="text/javascript">
    $(function() {
    	
    	//表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : false,
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        });
        
        $("#chartPreview").on("click", function() {
            $("#dataView").hide();
            $("#chartView").show();
            
            $("#dataPreview").show();
            $("#exportBtn").hide();
            
            $("#chartPreview").hide();
            
            $("#lineChart").html("");
            var startTime = $("#beginRegisterTime").val();
            var endTime = $("#endRegisterTime").val();
            ZF.ajaxQuery(false, "${ctx}/dac/mi/memberDac/drawNewRegister",{"beginRegisterTime":startTime, "endRegisterTime":endTime} , function(data) {
            	   var line = new Morris.Line({
	                    element: 'lineChart',
	                    resize: true,
	                    data: data,
	                    xkey: 'x',
	                    ykeys: ['y'],
	                    labels: ['新增会员数'],
	                    lineColors: ['#3c8dbc'],
	                    hideHover: 'auto'
	              }); 
            });
            
     
        });
        
        $("#dataPreview").on("click", function() {
            $("#dataView").show();
            $("#chartView").hide();
            $("#dataPreview").hide();
            $("#chartPreview").show();
            $("#exportBtn").show();
        });

        $("#exportBtn").on("click", function() {
            $("#searchForm").attr("action", "${ctx}/dac/mi/memberDac/export");
            $("#searchForm").submit();
            $("#searchForm").attr("action", "${ctx}/dac/mi/memberDac/statNewRegister");
        });
    });
</script>


</body>
</html>