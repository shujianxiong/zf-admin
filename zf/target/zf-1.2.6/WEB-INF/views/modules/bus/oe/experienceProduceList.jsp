<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验产品管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/oe/experienceProduce/">体验产品列表</a></small>
            <shiro:hasPermission name="bus:oe:experienceProduce:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/oe/experienceProduce/form">体验产品添加</a>
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
            
            <form:form id="searchForm" modelAttribute="experienceProduce" action="${ctx}/bus/oe/experienceProduce/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">查询条件</label>
                                <div class="col-sm-7">  
                                    <input />
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
                                <th>体验单</th>
                                <th>产品编码</th>
                                <th>数量</th>
                                <th>商品标题</th>
                                <th>产品名称</th>
                                <th>购买价格</th>
                                <th>体验状态</th>
                                <th>消费决策</th>
                                <th>消费购买单ID</th>
                                <th>结算扣减金额</th>
                                <th>结算优惠金额</th>
                                <th>更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="bus:oe:experienceProduce:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="experienceProduce" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${experienceProduce.experienceOrder.orderNo}
									</td>
                                    <td>
                                        ${experienceProduce.produce.code}
									</td>
                                    <td>
                                        ${experienceProduce.num}
									</td>
                                    <td>
                                        ${experienceProduce.goodsTitle}
									</td>
                                    <td>
                                        ${experienceProduce.produceName}
									</td>
                                    <td>
                                        ${experienceProduce.priceBuy}
									</td>
                                    <td>
                                        ${fns:getDictLabel(experienceProduce.status, 'bus_oe_experience_produce_status', '')}
									</td>
                                    <td>
                                        ${fns:getDictLabel(experienceProduce.decisionType, 'bus_oe_experience_produce_decisionType', '')}
									</td>
                                    <td>
                                        ${experienceProduce.decisionBuyOrder.id}
									</td>
                                    <td>
                                        ${experienceProduce.moneySettlementDec}
									</td>
                                    <td>
                                        ${experienceProduce.moneySettlementPre}
									</td>
                                    <td>
                                        <fmt:formatDate value="${experienceProduce.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
                                    <td>
                                        ${experienceProduce.remarks}
									</td>
                                    <shiro:hasPermission name="bus:oe:experienceProduce:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/oe/experienceProduce/form?id=${experienceProduce.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/bus/oe/experienceProduce/delete?id=${experienceProduce.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该体验产品吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/bus/oe/experienceProduce/info?id=${experienceProduce.id}" target="">详情</a></li>
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
            "order": [[ 0, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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