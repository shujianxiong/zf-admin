<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>我的日常菜谱</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/hrm/di/myDiet/">菜谱列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="diet" action="${ctx}/hrm/di/myDiet/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">菜谱日期</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="date" inputName="date" value="${diet.date }" isMandatory="false" tip="请选择所属日期" inputId="date" format="YYYY-MM-DD"></sys:datetime>
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
                                <th>菜谱日期</th>
                                <th>菜谱得分</th>
                                <th style="display:none">创建者</th>
                                <th style="display:none">创建时间</th>
                                <th>评价状态</th>
                                <th>评价菜谱</th>
                                <shiro:hasPermission name="hrm:di:dietJudge:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="diet" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${diet.date}" pattern="yyyy-MM-dd"/>
									</td>
                                    <td>
                                        <div id="scoreDiv_${diet.id}">${diet.score}</div>
									</td>
									<td data-hide="true">
                                        ${fns:getUserById(diet.createBy.id).name}
									</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${diet.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td>
                                       	<c:if test="${empty diet.dietJudge.id }">
                                       		<span id="statusSpan_${diet.id}" class="label label-primary">未评价</span>
                                       	</c:if>
                                       	<c:if test="${not empty diet.dietJudge.id }">
                                       		<span id="statusSpan_${diet.id}" class="label label-success">已评价</span>
                                       	</c:if>
									</td>
									<td>
										<c:choose>
											<c:when test="${not empty diet.dietJudge.judgeLevel and diet.dietJudge.judgeLevel >= '1'}">
												<i id="judgeI_${diet.id}_1" class="fa fa-star" onclick="judge('${diet.id}','${diet.dietJudge.id}',1);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${diet.id}_1" class="fa fa-star-o" onclick="judge('${diet.id}','${diet.dietJudge.id}',1);"></i>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty diet.dietJudge.judgeLevel and diet.dietJudge.judgeLevel >= '2'}">
												<i id="judgeI_${diet.id}_2" class="fa fa-star" onclick="judge('${diet.id}','${diet.dietJudge.id}',2);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${diet.id}_2" class="fa fa-star-o" onclick="judge('${diet.id}','${diet.dietJudge.id}',2);"></i>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty diet.dietJudge.judgeLevel and diet.dietJudge.judgeLevel >= '3'}">
												<i id="judgeI_${diet.id}_3" class="fa fa-star" onclick="judge('${diet.id}','${diet.dietJudge.id}',3);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${diet.id}_3" class="fa fa-star-o" onclick="judge('${diet.id}','${diet.dietJudge.id}',3);"></i>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty diet.dietJudge.judgeLevel and diet.dietJudge.judgeLevel >= '4'}">
												<i id="judgeI_${diet.id}_4" class="fa fa-star" onclick="judge('${diet.id}','${diet.dietJudge.id}',4);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${diet.id}_4" class="fa fa-star-o" onclick="judge('${diet.id}','${diet.dietJudge.id}',4);"></i>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty diet.dietJudge.judgeLevel and diet.dietJudge.judgeLevel >= '5'}">
												<i id="judgeI_${diet.id}_5" class="fa fa-star" onclick="judge('${diet.id}','${diet.dietJudge.id}',5);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${diet.id}_5" class="fa fa-star-o" onclick="judge('${diet.id}','${diet.dietJudge.id}',5);"></i>
											</c:otherwise>
										</c:choose>
									</td>
                                    <shiro:hasPermission name="hrm:di:dietJudge:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/hrm/di/myDish/list?dietId=${diet.id}'">查看菜品</button>
                                        </div>
                                    </td></shiro:hasPermission>
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
        	//表格初始化
        	ZF.parseTable("#contentTable", {
            	"paging" : false,
            	"lengthChange" : false,
            	"searching" : false,
            	"ordering" : false,
	            "info" : false,
	            "autoWidth" : false,
	            "multiline" : true,//是否开启多行表格
	            "isRowSelect" : false,//是否开启行选中
	            "rowSelect" : function(tr) {
	            },
            	"rowSelectCancel" : function(tr) {
            	}
	        })
	    });
      
		function judge(dietId, judgeId, level){
			var data="{\"level\":\""+level+"\"}";
			console.log(data);
			ZF.ajaxQuery(true,"${ctx}/hrm/di/myDiet/judge/"+dietId,$.parseJSON(data),function(data){
				if(data.status=="0"){
					ZF.showTip(data.message,"warning");
				}else{
					clearLevels(dietId);
					setLevels(dietId, level);
					$("#scoreDiv_"+dietId).text(data.score);
					$("#statusSpan_"+dietId).text("已评价");
					$("#statusSpan_"+dietId).removeClass("label label-primary").addClass("label label-success");
				}
			})
      	}
      
      	// 清空评价星级
      	function clearLevels(dietId){
    	  	for(var i=1; i<6; i++){
    		  	$("#judgeI_"+dietId+"_"+i).removeClass("fa fa-star").addClass("fa fa-star-o");
    	  	}
      	}
      	// 设置评价星级
      	function setLevels(dietId, idx){
    	  	for(var i=1; i<=idx; i++){
    		  	$("#judgeI_"+dietId+"_"+i).removeClass("fa fa-star-o").addClass("fa fa-star");
    	  	}
      	}
	</script>
</body>
</html>