<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>菜谱菜品评价</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/hrm/di/judgeCount/count">评价统计</a></small>
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
            
            <form:form id="searchForm" modelAttribute="diet" action="${ctx}/hrm/di/judgeCount/count" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="beginDate" class="col-sm-3 control-label">起始日期</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="beginDate" inputName="beginDate" value="${beginDate }" isMandatory="false" tip="请选择起始日期" inputId="beginDate" format="YYYY-MM-DD"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="endDate" class="col-sm-3 control-label">结束日期</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="endDate" inputName="endDate" value="${endDate }" isMandatory="false" tip="请选择结束日期" inputId="endDate" format="YYYY-MM-DD"></sys:datetime>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                        <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
                        <input type="hidden" id="beginDateStr" value="<fmt:formatDate value='${beginDate}' pattern='yyyy-MM-dd'/>"/>
                        <input type="hidden" id="endDateStr" value="<fmt:formatDate value='${endDate}' pattern='yyyy-MM-dd'/>"/>
				    	<button type="button" class="btn btn-default btn-sm" onclick="printWeb('${ctx}/hrm/di/judgeCount/count');"><i class="fa fa-print"></i>打印</button>
                    </div>
                </div>
            </form:form>
        </div>
        <div id="printArea" class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th colspan="2">菜谱菜品评价统计</th>
                            </tr>
                            <tr>
                                <th colspan="2">
	                                <fmt:formatDate value='${beginDate}' pattern='yyyy-MM-dd'/>&nbsp;至&nbsp;<fmt:formatDate value='${endDate}' pattern='yyyy-MM-dd'/><br/>
                                	单日平均得分：${dietScore }
                                </th>
                            </tr>
                        </thead>
                        <thead>
                            <tr>
                                <th>菜品名称</th>
                                <th>平均得分</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${dishes}" var="dish" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        ${dish.name}
									</td>
                                    <td>
                                        ${dish.score}
									</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
     </section>
    </div>

	<script>
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
			})
		});

		// 页面打印
		function printWeb(url) {
			var sourceHTML = document.body.innerHTML;
			document.body.innerHTML = document.getElementById("printArea").innerHTML;
			window.print();
			document.body.innerHTML = sourceHTML;
			window.location.href = url + "?beginDate=" + $("#beginDateStr").val() + "&endDate=" + $("#endDateStr").val();
		}
	</script>
</body>
</html>