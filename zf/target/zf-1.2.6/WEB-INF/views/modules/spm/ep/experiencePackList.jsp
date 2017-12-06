<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验包管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ep/experiencePack/">体验包列表</a></small>
            <shiro:hasPermission name="spm:ep:experiencePack:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/spm/ep/experiencePack/form">体验包添加</a>
                </small>
            </shiro:hasPermission>
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
            
            <form:form id="searchForm" modelAttribute="experiencePack" action="${ctx}/spm/ep/experiencePack/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">名称</label>
                                <div class="col-sm-7">
                                    <form:input id="name" path="name" htmlEscape="false" maxlength="50" class="form-control" placeholder="请输入名称"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">回程运费是否可免</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="expressMoney" tip="请选择" verifyType="0" isMandatory="false" dictName="express_money_type" id="expressMoney"></sys:selectverify>
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
                                <th>名称</th>
                                <th>类型</th>
                                <th>标题</th>
                                <th>价格</th>
                                <th>邀请人数</th>
                                <th>体验次数</th>
                                <th>持续时间</th>
                                <th>购买折扣</th>
                                <th>押金折扣</th>
                                <th>购买上限</th>
                                <th>卡券ID</th>
                                <th>免回程运费</th>
                                <th>启用状态</th>
                                <th style="display:none;">更新时间</th>
                                <th style="display:none;">备注信息</th>
                                <shiro:hasPermission name="spm:ep:experiencePack:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="experiencePack" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td title="${experiencePack.name}">
                                            ${fns:abbr(experiencePack.name,20)}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(experiencePack.type, 'experience_pack_type', '')}</span>
                                    </td>
                                    <td title="${experiencePack.title}">
                                            ${fns:abbr(experiencePack.title,20)}
                                    </td>
                                    <td>
                                            ${experiencePack.price}
                                    </td>
                                    <td>
                                            ${experiencePack.persons}
                                    </td>
                                    <td>
                                            ${experiencePack.times}
                                    </td>
                                    <td>
                                            ${experiencePack.days}
                                    </td>
                                    <td>
                                            ${experiencePack.discountScale}
                                    </td>
                                    <td>
                                            ${experiencePack.depositScale}
                                    </td>
                                    <td>
                                            ${experiencePack.buyLimit}
                                    </td>
                                    <td>
                                            ${experiencePack.cardId}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(experiencePack.expressMoney, 'express_money_type', '')}</span>
                                    </td>
                                    <td>
                                        <c:if test="${experiencePack.activeFlag=='1' }">
                                            <span class="label label-success">${fns:getDictLabel(experiencePack.activeFlag, 'yes_no', '')}</span>
                                        </c:if>
                                        <c:if test="${experiencePack.activeFlag=='0' }">
                                            <span class="label label-primary">${fns:getDictLabel(experiencePack.activeFlag, 'yes_no', '')}</span>
                                        </c:if>
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${experiencePack.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
</td>
                                    <td data-hide="true">
                                        ${experiencePack.remarks}
</td>
                                    <shiro:hasPermission name="spm:ep:experiencePack:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/spm/ep/experiencePack/form?id=${experiencePack.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <c:choose><c:when test="${ experiencePack.activeFlag eq '0' }">
                                                    <li><a href="${ctx}/spm/ep/experiencePack/delete?id=${experiencePack.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该体验包吗？',this.href)">删除</a>
                                                    </li>
                                                </c:when></c:choose>
                                                <li><a href="${ctx}/spm/ep/experiencePack/info?id=${experiencePack.id}" target="">详情</a></li>
                                                <c:choose>
                                                    <c:when test="${ experiencePack.activeFlag eq '0' }">
                                                        <li><a href="${ctx}/spm/ep/experiencePack/updateUsable?id=${experiencePack.id}&activeFlag=1" onclick="return ZF.delRow('确认启用该体验包么？',this.href)">启用</a></li>
                                                    </c:when>
                                                    <c:when test="${ experiencePack.activeFlag eq '1' }">
                                                        <li><a href="${ctx}/spm/ep/experiencePack/updateUsable?id=${experiencePack.id}&activeFlag=0" onclick="return ZF.delRow('确认停用该体验包么？',this.href)">停用</a></li>
                                                    </c:when>
                                                </c:choose>
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
            "ordering" : true,
            "order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:14}
                
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