<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>微信支付记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/wp/wechatRefund/">微信退款列表</a></small>
            <!-- 
            <shiro:hasPermission name="bus:wp:wechatPayRecord:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/wp/wechatPayRecord/form">微信支付记录添加</a>
                </small>
            </shiro:hasPermission> -->
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <%-- <div class="box box-info">
            <div class="box-header with-border zf-query">
                <h5>查询条件</h5>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
            
            <form:form id="searchForm" modelAttribute="wechatPayRecord" action="${ctx}/bus/wp/wechatPayRecord/" method="post" class="form-horizontal">
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
        </div> --%>
    
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th class="zf-dataTables-multiline"></th>
                                <th>商户号</th>
                                <th>微信支付订单号</th>
                                <th>付款银行</th>
                                <th>现金支付金额</th>
                                <th>退款编号</th>
                                <th>自动退款状态</th>
                                <th>自动退款金额</th>
                                <th>自动退款时间</th>
                                <th>人工退款状态</th>
                                <th>人工退款金额</th>
                                <th>人工退款时间</th>
                                <th style="display:none">更新者</th>
                                <th style="display:none">更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="bus:wp:wechatPayRecord:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="wechatPayRecord" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${wechatPayRecord.mchId}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.transactionId}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.bankType}
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${wechatPayRecord.cashFee}</span>
                                    </td>
                                    <td>
                                        ${wechatPayRecord.refundNo}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(wechatPayRecord.refundAutoStatus, 'bus_wp_wechat_pay_record_refundAutoStatus', '')}</span>
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${wechatPayRecord.refundAutoMoney}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${wechatPayRecord.refundAutoTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(wechatPayRecord.refundArtificialStatus, 'bus_wp_wechat_pay_record_refundArtificialStatus', '')}</span>
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${wechatPayRecord.refundArtificialMoney}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${wechatPayRecord.refundArtificialTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${wechatPayRecord.updateBy.id}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${wechatPayRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td title="${wechatPayRecord.remarks }">
                                        ${fns:abbr(wechatPayRecord.remarks, 15)}
                                    </td>
                                   	<shiro:hasPermission name="bus:wp:wechatRefund:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/wp/wechatRefund/info?id=${wechatPayRecord.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <c:if test="${wechatPayRecord.refundArtificialStatus != '' and  wechatPayRecord.refundArtificialStatus == '1'}">
	                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
	                                                <li><a href="${ctx}/bus/wp/wechatRefund/refundForm?id=${wechatPayRecord.id}" target="">退款</a></li>
	                                            </ul>
                                            </c:if>
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
            "order": [[ 13, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15}
                
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