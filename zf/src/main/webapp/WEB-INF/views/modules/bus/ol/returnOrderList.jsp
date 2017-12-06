<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货单管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/returnOrder/">回货质检</a></small>
            <%-- <shiro:hasPermission name="bus:ol:returnOrder:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/ol/returnOrder/form">退货单添加</a>
                </small>
            </shiro:hasPermission> --%>
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
            
            <form:form id="searchForm" modelAttribute="returnOrder" action="${ctx}/bus/ol/returnOrder/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">物流单号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="expressNo" id="expressNo" verifyType="0" tip="请输入物流单号" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">退货状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="status" tip="" verifyType="" isMandatory="false" dictName="bus_ol_return_order_status" id="status"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">退货原因类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="reasonType" tip="" isMandatory="false" verifyType="" dictName="bus_ol_return_order_reasonType" id="reasonType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="productNo" class="col-sm-3 control-label">货品编码</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="productNo" id="productNo" verifyType="0" tip="请输入货品编码" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="beginReceiveTime" class="col-sm-3 control-label">开始收货时间</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="beginReceiveTime" inputName="beginReceiveTime" tip="请选择开始收货时间" value="${returnOrder.beginReceiveTime }" inputId="beginReceiveTime"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="endReceiveTime" class="col-sm-3 control-label">结束收货时间</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="endReceiveTime" inputName="endReceiveTime" tip="请选择结束收货时间" value="${returnOrder.endReceiveTime }" inputId="endReceiveTime"></sys:datetime>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="orderNo" class="col-sm-3 control-label">订单编号</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="orderNo" id="orderNo" verifyType="0" tip="请输入订单编号" isMandatory="false" isSpring="true"></sys:inputverify>
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
        <div class="box box-info">
            <div class="box-header with-border zf-query">
                <h5>质检扫描</h5>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="expressNoTemp" class="col-sm-3 control-label">物流单号</label>
                                <div class="col-sm-7">
                                    <input type="text" name="expressNoTemp" id="expressNoTemp" placeholder="请扫描录入物流单号" class="form-control zf-input-readonly" t>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-sm btn-dropbox" onclick="scan()"><i class="fa fa-edit"></i>添加</button>
                    </div>
                </div>
        </div>
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th>物流单号</th>
                                <th>物流快递公司</th>
                                <th>退货单编号</th>
                                <th>订单编号</th>
                                <th>退货状态</th>
                                <th>退货原因类型</th>
                                <th>退货原因详情</th>
                                <th>收货时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="returnOrder" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        ${returnOrder.expressNo}
                                    </td>
                                    <td>
                                        ${fns:getDictLabel(returnOrder.expressCompany, 'express_company', '')}
                                    </td>
                                    <td>
                                        ${returnOrder.returnOrderNo}
                                    </td>
                                    <td>
                                        ${returnOrder.orderNo}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${returnOrder.status eq '1' }"><!-- 待退货 -->
                                                <span class="label label-default">${fns:getDictLabel(returnOrder.status, 'bus_ol_return_order_status', '')}</span>
                                            </c:when>
                                            <c:when test="${returnOrder.status eq '2' }"><!-- 退货中 -->
                                                <span class="label label-info">${fns:getDictLabel(returnOrder.status, 'bus_ol_return_order_status', '')}</span>
                                            </c:when>
                                            <c:when test="${returnOrder.status eq '3' }"><!-- 待质检 -->
                                                <span class="label label-primary">${fns:getDictLabel(returnOrder.status, 'bus_ol_return_order_status', '')}</span>
                                            </c:when>
                                            <c:when test="${returnOrder.status eq '4' }"><!-- 待结算 -->
                                                <span class="label label-warning">${fns:getDictLabel(returnOrder.status, 'bus_ol_return_order_status', '')}</span>
                                            </c:when>
                                            <c:when test="${returnOrder.status eq '5' }"><!-- 退货完成 -->
                                                <span class="label label-success">${fns:getDictLabel(returnOrder.status, 'bus_ol_return_order_status', '')}</span>
                                            </c:when>
                                            <c:when test="${returnOrder.status eq '99' }"><!-- 退货完成 -->
                                                <span class="label label-info">${fns:getDictLabel(returnOrder.status, 'bus_ol_return_order_status', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(returnOrder.reasonType, 'bus_ol_return_order_reasonType', '')}</span>
                                    </td>
                                    <td title="${returnOrder.reasonDetail }">
                                        ${fns:abbr(returnOrder.reasonDetail, 15)}
                                    </td>
                                    <td title="${returnOrder.receiveTime }">
                                        <fmt:formatDate value="${returnOrder.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/ol/returnOrder/info?id=${returnOrder.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <shiro:hasPermission name="bus:ol:returnOrder:edit">
                                                <c:if test="${returnOrder.status eq '3'  or returnOrder.status eq '5' }">
		                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role=  "menu">
		                                               <c:if test="${returnOrder.status eq '3' }">
                                                           <shiro:hasPermission name="bus:ol:productCheck:view">
                                                               <li><a href="${ctx}/bus/ol/returnOrder/toQuality?id=${returnOrder.id}&returnOrderNo=${returnOrder.returnOrderNo}">回货质检</a></li>
                                                           </shiro:hasPermission>
		                                               </c:if>
                                                        <c:if test="${returnOrder.status eq '5' }">
                                                            <li><a href="${ctx}/bus/ol/returnOrder/qualityInfo?id=${returnOrder.id}&returnOrderNo=${returnOrder.returnOrderNo}">确认清单查看</a></li>
                                                        </c:if>
	                                                </ul>
                                                </c:if>
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
          $("#expressNoTemp").focus();//给定默认光标
          $("#expressNoTemp").on("change", function() {
              var expressNo = $.trim($(this).val());
              if(expressNo == null || expressNo == "" || expressNo == undefined) {
                  alert("请先扫描物流单号");
                  return false;
              }else{
                  window.location.href="${ctx}/bus/ol/returnOrder/scan?expressNo="+expressNo;
              }
          });

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
            "order": [[ 0, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6}
                
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
      function scan() {
          var expressNoTemp=  $("#expressNoTemp").val();
          if(expressNoTemp ==null || expressNoTemp == ""){
              ZF.showTip("请输入物流单号","danger");
              return false;
          }
          window.location.href="${ctx}/bus/ol/returnOrder/scan?expressNo="+expressNoTemp;
      }
   </script>
</body>
</html>