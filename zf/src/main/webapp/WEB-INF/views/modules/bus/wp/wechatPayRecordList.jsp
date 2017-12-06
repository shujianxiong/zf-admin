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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/wp/wechatPayRecord/">微信支付记录列表</a></small>
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
        <div class="box box-info" style="display: none;">
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
        </div>
    
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th class="zf-dataTables-multiline"></th>
                                <th>公众账号ID</th>
                                <th>商户号</th>
                                <th>设备号</th>
                                <th>签名类型</th>
                                <th>业务结果</th>
                                <th>错误代码</th>
                                <th>用户标识</th>
                                <th>是否关注公众账号</th>
                                <th>交易类型</th>
                                <th>付款银行</th>
                                <th>订单金额(分)</th>
                                <th>应结订单金额(分)</th>
                                <th>货币种类</th>
                                <th style="display:none">更新者</th>
                                <th style="display:none">更新时间</th>
                                <th>备注信息</th>
                                <%-- <shiro:hasPermission name="bus:wp:wechatPayRecord:edit"><th>操作</th></shiro:hasPermission> --%>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="wechatPayRecord" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${wechatPayRecord.appid}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.mchId}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.deviceInfo}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.signType}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.resultCode}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.errCode}
                                    </td>
                                    <td title="${wechatPayRecord.openid }">
                                        ${fns:abbr(wechatPayRecord.openid, 15)}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.isSubscribe}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.tradeType}
                                    </td>
                                    <td>
                                        ${wechatPayRecord.bankType}
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${wechatPayRecord.totalFee}</span>
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${wechatPayRecord.settlementTotalFee}</span>
                                    </td>
                                    <td>
                                        ${wechatPayRecord.feeType}
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
                                   <%--  <shiro:hasPermission name="bus:wp:wechatPayRecord:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/wp/wechatPayRecord/info?id=${wechatPayRecord.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <!-- 
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/bus/wp/wechatPayRecord/form?id=${wechatPayRecord.id}" target="">修改</a></li>
                                                <li><a href="${ctx}/bus/wp/wechatPayRecord/delete?id=${wechatPayRecord.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该微信支付记录吗？',this.href)">删除</a>
                                                </li> 
                                            </ul>-->
                                        </div>
                                    </td></shiro:hasPermission> --%>
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
            "order": [[ 15, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
                {"orderable":false,targets:13},
                {"orderable":false,targets:14},
                {"orderable":false,targets:16}
                
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