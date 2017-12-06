<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>页面访问记录管理</title>
    <meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bas/pv/pvRecord/statPageViewByPageType">页面访问记录列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="pvRecord" action="${ctx}/bas/pv/pvRecord/statPageViewByPageType" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <%-- <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">页面类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="pageType" tip="请选择" verifyType="0" isMandatory="false" dictName="bas_pv_record_pageType" id="pageType"></sys:selectverify>
                                </div>
                            </div>
                        </div> --%>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">开始时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="startTime" inputName="searchParameter.starTime" tip="请选择开始时间" value="${pvRecord.searchParameter.starTime }" inputId="startTimeId"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">结束时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="endTime" inputName="searchParameter.endTime" tip="请选择结束时间" value="${pvRecord.searchParameter.endTime }" inputId="endTimeId"></sys:datetime>
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
	                    <button type="button" class="btn btn-sm btn-info" id="chartPreview"><i class="fa fa-area-chart">图表预览</i></button>
	                    <button type="button" class="btn btn-sm btn-info" id="dataPreview" style="display: none;"><i class="fa fa-area-chart">数据一览</i></button>
	                    <c:if test="${not empty list }">
	                       <button type="button" class="btn btn-sm btn-success" id="exportBtn"><i class="fa fa-file-excel-o">Excel导出</i></button>
	                    </c:if>
	                </div>
	            </div>
                <div id="dataView" class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th>页面类型</th>
                                <th>浏览量</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${list}" var="pvRecord">
                                <tr>
                                    <td>
                                        ${pvRecord.pageType}
                                    </td>
                                    <td>
                                        ${pvRecord.count}
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div id="chartView" style="display: none;">
                    <div id="pieChart" style="height:300px;width: 100%;"></div>
                </div>
            </div>
            <div class="box-footer">
                <div class="dataTables_paginate paging_simple_numbers">${page}</div>
            </div>
        </div>
     </section>
    </div>
    <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.min.js"></script>
    <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.resize.min.js"></script>
    <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.pie.min.js"></script>
    <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.categories.min.js"></script>
    
    <script>
      $(function () {
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
        	
        	
        	var pageType = $("#pageType").val();
        	var startTime = $("#startTimeId").val();
        	var endTime = $("#endTimeId").val();
        	ZF.ajaxQuery(false, "${ctx}/bas/pv/pvRecord/drawPageViewByPageType",{"pageType":pageType, "searchParameter.starTime":startTime, "searchParameter.endTime":endTime} , function(data) {
        		$.plot("#pieChart", data, 
                        {
                              series: {
                                    pie: {
                                      show: true,
                                      radius: 1,
                                     // innerRadius: 0.5,
                                      label: {
                                            show: true,
                                            radius: 2 / 3,
                                            formatter: function(label, series){
                                                return '<div style="font-size:8pt;text-align:center;padding:2px;color:white;">'+label+'<br/>'+Math.round(series.percent)+'%</div>';
                                            }
                                     },
                                     threshold: 0.1
                                  }
                              },
                              legend: {
                                    show: false
                              }
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
        	$("#searchForm").attr("action", "${ctx}/bas/pv/pvRecord/export");
        	$("#searchForm").submit();
        	$("#searchForm").attr("action", "${ctx}/bas/pv/pvRecord/statPageViewByPageType");
        });
        
	        
        
      });
      
      function page(n,s){
          $("#pageNo").val(n);
          $("#pageSize").val(s);
          $("#searchForm").submit();
          return false;
      }
   </script>
</body>
</html>