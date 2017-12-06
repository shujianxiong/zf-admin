<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>我的日常菜谱下菜品列表</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/hrm/di/myDiet/">菜谱列表</a></small>
            <small>|</small>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/hrm/di/myDish/list?dietId=${diet.id}">菜品列表</a></small>
        </h1>
    </section>
    
    <sys:tip content="${message}"/>
    
    <section class="content">
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th class="zf-dataTables-multiline"></th>
                                <th>菜谱日期</th>
                                <th>三餐类型</th>
                                <th>菜品名称</th>
                                <th>菜品得分</th>
                                <th style="display:none">创建者</th>
                                <th style="display:none">创建时间</th>
                                <th>评价状态</th>
                                <th>评价菜品</th>
                                <!-- 
                                <shiro:hasPermission name="hrm:di:dishJudge:edit"><th>操作</th></shiro:hasPermission> -->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="dish" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${dish.diet.date}" pattern="yyyy-MM-dd"/>
									</td>
                                    <td>
                                        ${fns:getDictLabel(dish.type,'hrm_di_mealType','') }
									</td>
                                    <td>
                                        ${dish.name}
									</td>
                                    <td>
                                        <div id="scoreDiv_${dish.id}">${dish.score}</div>
									</td>
									<td data-hide="true">
										${fns:getUserById(dish.createBy.id).name}
									</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${dish.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td>
                                       	<c:if test="${empty dish.dishJudge.id }">
                                       		<span id="statusSpan_${dish.id}" class="label label-primary">未评价</span>
                                       	</c:if>
                                       	<c:if test="${not empty dish.dishJudge.id }">
                                       		<span id="statusSpan_${ddishiet.id}" class="label label-success">已评价</span>
                                       	</c:if>
									</td>
									<td>
										<c:choose>
											<c:when test="${not empty dish.dishJudge.judgeLevel and dish.dishJudge.judgeLevel >= '1'}">
												<i id="judgeI_${dish.id}_1" class="fa fa-star" onclick="judge('${dish.id}','${dish.dishJudge.id}',1);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${dish.id}_1" class="fa fa-star-o" onclick="judge('${dish.id}','${dish.dishJudge.id}',1);"></i>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty dish.dishJudge.judgeLevel and dish.dishJudge.judgeLevel >= '2'}">
												<i id="judgeI_${dish.id}_2" class="fa fa-star" onclick="judge('${dish.id}','${dish.dishJudge.id}',2);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${dish.id}_2" class="fa fa-star-o" onclick="judge('${dish.id}','${dish.dishJudge.id}',2);"></i>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty dish.dishJudge.judgeLevel and dish.dishJudge.judgeLevel >= '3'}">
												<i id="judgeI_${dish.id}_3" class="fa fa-star" onclick="judge('${dish.id}','${dish.dishJudge.id}',3);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${dish.id}_3" class="fa fa-star-o" onclick="judge('${dish.id}','${dish.dishJudge.id}',3);"></i>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty dish.dishJudge.judgeLevel and dish.dishJudge.judgeLevel >= '4'}">
												<i id="judgeI_${dish.id}_4" class="fa fa-star" onclick="judge('${dish.id}','${dish.dishJudge.id}',4);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${dish.id}_4" class="fa fa-star-o" onclick="judge('${dish.id}','${dish.dishJudge.id}',4);"></i>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${not empty dish.dishJudge.judgeLevel and dish.dishJudge.judgeLevel >= '5'}">
												<i id="judgeI_${dish.id}_5" class="fa fa-star" onclick="judge('${dish.id}','${dish.dishJudge.id}',5);"></i>
											</c:when>
											<c:otherwise>
												<i id="judgeI_${dish.id}_5" class="fa fa-star-o" onclick="judge('${dish.id}','${dish.dishJudge.id}',5);"></i>
											</c:otherwise>
										</c:choose>
									</td>
									<!-- 
                                    <shiro:hasPermission name="hrm:di:dishJudge:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info" 
                                            	onclick="window.location.href='${ctx}/hrm/di/myDish/judgeForm?id=${dish.dishJudge.id}&dishId=${dish.id }'">评价</button>
                                            <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/hrm/di/myDish/info?id=${dish.dishJudge.id}&dishId=${dish.id }" target="">详情</a></li>
                                            </ul>
                                        </div>
                                    </td></shiro:hasPermission> -->
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
	            "info" : false,
	            "autoWidth" : false,
	            "multiline" : true,//是否开启多行表格
	            "isRowSelect" : false,//是否开启行选中
	            "rowSelect" : function(tr) {},
	            "rowSelectCancel" : function(tr) {}
        	})
      	});
      
      	function judge(dishId, judgeId, level){
			var data="{\"level\":\""+level+"\"}";
			console.log(data);
			ZF.ajaxQuery(true,"${ctx}/hrm/di/myDish/judge/"+dishId,$.parseJSON(data),function(data){
				if(data.status=="0"){
					ZF.showTip(data.message,"warning");
				}else{
					clearLevels(dishId);
					setLevels(dishId, level);
					$("#scoreDiv_"+dishId).text(data.score);
					$("#statusSpan_"+dishId).text("已评价");
					$("#statusSpan_"+dishId).removeClass("label label-primary").addClass("label label-success");
				}
			})
    	}
    
     	// 清空评价星级
      	function clearLevels(dishId){
    	  	for(var i=1; i<6; i++){
    		  	$("#judgeI_"+dishId+"_"+i).removeClass("fa fa-star").addClass("fa fa-star-o");
    	  	}
      	}
      	// 设置评价星级
      	function setLevels(dishId, idx){
    	  	for(var i=1; i<=idx; i++){
    		  	$("#judgeI_"+dishId+"_"+i).removeClass("fa fa-star-o").addClass("fa fa-star");
    	  	}
      	}
   </script>
</body>
</html>