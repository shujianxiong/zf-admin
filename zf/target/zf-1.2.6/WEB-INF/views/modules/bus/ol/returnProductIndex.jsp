<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货货品管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/returnProduct/index">退货货品列表</a></small>
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

            <form:form id="searchForm" modelAttribute="returnProduct" action="${ctx}/bus/ol/returnProduct/index" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="code" class="col-sm-3 control-label">货品编码</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="product.code" id="code" verifyType="99" tip="请输入货品编码" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="beginQualityTime" class="col-sm-3 control-label">开始质检时间</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="beginQualityTime" inputName="beginQualityTime" tip="请选择开始创建时间" value="${returnProduct.beginQualityTime }" inputId="beginQualityTime"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="endQualityTime" class="col-sm-3 control-label">结束质检时间</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="endQualityTime" inputName="endQualityTime" tip="请选择结束创建时间" value="${returnProduct.endQualityTime }" inputId="endQualityTime"></sys:datetime>
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
                                <th>货品编码</th>
                                <th>货品图片</th>
                                <th>货品名称</th>
                                <th>货品状态</th>
                                <th>损坏类型</th>
                                <th>损坏图片</th>
                                <th>质检时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="returnProduct" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${returnProduct.product.code}
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);"  src="${imgHost }${returnProduct.product.goods.samplePhoto}" data-big data-src="${imgHost }${returnProduct.product.goods.samplePhoto}" width="21" height="21" />
                                    </td>
                                    <td>
                                            ${returnProduct.product.goods.name}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(returnProduct.inStatus, 'bus_ol_return_product_inStatus', '')}</span>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(returnProduct.damageType, 'bus_or_repair_order_breakdownType', '')}</span>
                                    </td>
                                    <td>
                                        <c:forEach items="${returnProduct.imgs}" var="img" varStatus="status">
                                            <img onerror="imgOnerror(this);" src="${imgHost }${img}" data-big data-src="${imgHost }${img}" width="20px" height="20px" />
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${returnProduct.qualityTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                            <div class="btn-group zf-tableButton">
                                                <button type="button" class="btn btn-sm btn-info"
                                                        onclick="window.location.href='${ctx}/bus/ol/returnProduct/info?id=${returnProduct.id}'">详情</button>
                                                <button type="button"
                                                        class="btn btn-sm btn-info dropdown-toggle"
                                                        data-toggle="dropdown">
                                                    <span class="caret"></span>
                                                </button>
                                                <shiro:hasPermission name="bus:ol:returnProduct:edit">
                                                        <ul class="dropdown-menu btn-info zf-dropdown-width" role=  "menu">
                                                            <li><a href="${ctx}/bus/ol/returnProduct/form?id=${returnProduct.id}">图片上传</a></li>
                                                        </ul>
                                                </shiro:hasPermission>
                                            </div>
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
            "ordering" : false,
            "order": [[ 1, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5}

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