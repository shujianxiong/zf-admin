<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>会员魅力豆流水管理</title>
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
        <form:form id="searchForm" modelAttribute="beansDetail" action="${ctx}/crm/mb/beansDetail/userInfolist" method="post" class="form-horizontal">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
            <input name="beans.id" type="hidden" value="${beansDetail.beans.id}"/>
            <input name="changeType" type="hidden" value="${beansDetail.changeType}"/>
        </form:form>

        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                        <tr>
                            <th class="zf-dataTables-multiline"></th>
                            <th>账户</th>
                            <th>姓名</th>
                            <th>变动类型</th>
                            <th>变动数量</th>
                            <th>变动后历史魅力豆</th>
                            <th>变动后当前魅力豆</th>
                            <th>变动时间</th>
                            <th style="display: none;">变动原因</th>
                            <th style="display: none;">来源业务编号</th>
                            <shiro:hasPermission name="crm:mb:beansDetail:edit"><th>操作</th></shiro:hasPermission>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${page.list}" var="beansDetail" varStatus="status">
                            <tr data-index="${status.index }">
                                <td class="details-control text-center">
                                    <i class="fa fa-plus-square-o text-success"></i>
                                </td>
                                <td>
                                        ${fns:getMemberById(beansDetail.beans.member.id).usercode}
                                </td>
                                <td>
                                        ${fns:getMemberById(beansDetail.beans.member.id).name}
                                </td>
                                <td>
                                    <span class="label label-primary">${fns:getDictLabel(beansDetail.changeType, 'add_decrease', '')}</span>
                                </td>
                                <td>
                                        ${beansDetail.num}
                                </td>
                                <td>
                                        ${beansDetail.historyBeans}
                                </td>
                                <td>
                                        ${beansDetail.currentBeans}
                                </td>
                                <td>
                                    <fmt:formatDate value="${beansDetail.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </td>
                                <td data-hide="true">
                                    <span class="label label-primary">${fns:getDictLabel(beansDetail.changeReasonType, 'crm_mb_beans_detail_changeReasonType', '')}</span>
                                </td>
                                <td data-hide="true">
                                        ${beansDetail.operateSourceNo}
                                </td>
                                <shiro:hasPermission name="crm:mb:beansDetail:edit"><td>
                                    <div class="btn-group zf-tableButton">
                                        <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/crm/mb/beansDetail/info?id=${beansDetail.id}'">详情</button>
                                        <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                            <span class="caret"></span>
                                        </button>
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
            "order": [[ 7, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10}

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