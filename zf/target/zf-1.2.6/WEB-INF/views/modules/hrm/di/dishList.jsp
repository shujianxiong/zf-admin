<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>日常菜谱下菜品列表</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/hrm/di/diet/">菜谱列表</a></small>
            <small>|</small>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/hrm/di/dish/list?id=${diet.id}">菜品列表</a></small>
            
            <small>|</small>
            <small><i class="fa-form-edit"></i><a href="${ctx}/hrm/di/dish/form?dietId=${diet.id }">菜品添加</a></small>
            
            
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
                                <th>评价得分</th>
                                <th style="display:none">创建者</th>
                                <th style="display:none">创建时间</th>
                                <th style="display:none">更新者</th>
                                <th style="display:none">更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="hrm:di:dish:edit"><th>操作</th></shiro:hasPermission>
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
                                        ${dish.score}
									</td>
									<td data-hide="true">
										${fns:getUserById(diet.createBy.id).name}
									</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${dish.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(diet.updateBy.id).name}
									</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${dish.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td>
                                        ${dish.remarks}
									</td>
                                    <shiro:hasPermission name="hrm:di:dish:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/hrm/di/dish/form?dietId=${dish.diet.id}&id=${dish.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/hrm/di/dish/delete?id=${dish.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该日常菜品吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/hrm/di/dish/info?id=${dish.id}" target="">详情</a></li>
                                            </ul>
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