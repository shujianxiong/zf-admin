<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发货单管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/sendOrder/">发货单列表</a></small>
<%--             <shiro:hasPermission name="bus:ol:sendOrder:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/ol/sendOrder/createTestData">生成发货单测试数据</a>
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

            <form:form id="searchForm" modelAttribute="sendOrder" action="${ctx}/bus/ol/sendOrder/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="sendOrderNo" class="col-sm-3 control-label">发货单编号</label>
                                <div class="col-sm-7">
                                   <sys:inputverify name="sendOrderNo" id="sendOrderNo" verifyType="0" tip="请输入发货单编号 " isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="orderNo" class="col-sm-3 control-label">订单编号</label>
                                <div class="col-sm-7">
                                   <sys:inputverify name="orderNo" id="orderNo" verifyType="0" tip="请输入订单编号" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="status" class="col-sm-3 control-label">发货状态</label>
                                <div class="col-sm-7">
                                   <sys:selectverify name="status" tip="" verifyType="" dictName="bus_ol_send_order_status" id="status" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
					    <div class="col-md-4">
							<div class="form-group">
								<label for="beginExpressTime" class="col-sm-3 control-label">起始发货时间</label>
								<div class="col-sm-7">
									<sys:datetime id="beginExpressTime" inputId="beginExpressTime" inputName="beginExpressTime" value="${sendOrder.beginExpressTime}" tip="请选择起始发货时间" isMandatory="false"></sys:datetime>
								</div>
							</div>
						</div>
					    <div class="col-md-4">
							<div class="form-group">
								<label for="endExpressTime" class="col-sm-3 control-label">截止发货时间</label>
								<div class="col-sm-7">
									<sys:datetime id="endExpressTime" inputId="endExpressTime" inputName="endExpressTime" value="${sendOrder.endExpressTime}" tip="请选择截止发货时间" isMandatory="false"></sys:datetime>
								</div>
							</div>
						</div>
						<div class="col-md-4">
                            <div  class="form-group">
                                <label for="expressNo" class="col-sm-3 control-label">快递单号</label>
                                <div class="col-sm-7">
                                   <sys:inputverify name="expressNo" id="expressNo" verifyType="0" tip="请输入快递单号" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
				    </div>
				    <div class="row">
					    <div class="col-md-4">
							<div class="form-group">
								<label for="beginSendDate" class="col-sm-3 control-label">起始可发货时间</label>
								<div class="col-sm-7">
									<sys:datetime id="beginSendDate" inputId="beginSendDate" inputName="beginSendDate" value="${sendOrder.beginSendDate}" tip="请选择起始可发货时间" isMandatory="false"></sys:datetime>
								</div>
							</div>
						</div>
					    <div class="col-md-4">
							<div class="form-group">
								<label for="endSendDate" class="col-sm-3 control-label">截止可发货时间</label>
								<div class="col-sm-7">
									<sys:datetime id="endSendDate" inputId="endSendDate" inputName="endSendDate" value="${sendOrder.endSendDate}" tip="请选择截止可发货时间" isMandatory="false"></sys:datetime>
								</div>
							</div>
						</div>
						<div class="col-md-4">
                            <div  class="form-group">
                                <label for="productNo" class="col-sm-3 control-label">货品编码</label>
                                <div class="col-sm-7">
                                    <sys:inputverify name="productNo" id="productNo" verifyType="0" tip="请输入货品编码" isMandatory="false" isSpring="true"></sys:inputverify>
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
                <div class="row">
                    <div class="col-sm-12 pull-right">
                        <shiro:hasPermission name="bus:ol:sendOrder:edit">
                            <button type="button" class="btn btn-sm btn-dropbox" onclick="batchConfirmSend();"><i class="fa fa-edit">确认发货</i></button>
                            <button type="button" class="btn btn-sm btn-success" id="exportBtn"><i class="fa fa-file-excel-o">Excel导出(快递出库详细)</i></button>
                        </shiro:hasPermission>
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="selAll" name="selAll"/></th>
                                <th class="zf-dataTables-multiline"></th>
                                <th>发货单编号</th>
                                <th>发货单类型</th>
                                <th>订单类型</th>
                                <th>订单编号</th>
                                <th>发货状态</th>
                                <th>激活标记</th>
                                <th>可发货日期</th>
                                <th>拣货单编号</th>
                                <th>托盘编号</th>
                                <th>拣货单序号</th>
                                <th>快递公司</th>
                                <th>快递单号</th>
                                <th>发货时间</th>
                                <th>用户备注</th>
                                <th style="display: none;">收货人</th>
                                <th style="display: none;">收货电话</th>
                                <th style="display: none;">收货地址省市区</th>
                                <th style="display: none;">收货地址详情</th>
                                <th style="display: none;">创建者</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">更新者</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="sendOrder" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        <input type="checkbox" name="selItem" ${sendOrder.status eq '7' ? '':'disabled=true' } value="${sendOrder.id }"/>
                                    </td>
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${sendOrder.sendOrderNo}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(sendOrder.type,'send_order_type','')}</span>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(sendOrder.orderType,'bus_order_type','')}</span>
                                    </td>
                                    <td>
                                        ${sendOrder.orderNo}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${sendOrder.status eq '99' }">
                                                <span class="label label-danger">${fns:getDictLabel(sendOrder.status,'bus_ol_send_order_status','')}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="label label-primary">${fns:getDictLabel(sendOrder.status,'bus_ol_send_order_status','')}</span>
                                            </c:otherwise>
                                        </c:choose>

                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(sendOrder.activeFlag,'yes_no','')}</span>
                                    </td>
                                    <td>
                                    	<c:choose>
                                    		<c:when test="${sendOrder.sendDate.getTime() > currentDate.getTime()}">
                                    			<font style="color:#aaa;"><fmt:formatDate value="${sendOrder.sendDate}" pattern="yyyy-MM-dd"/></font>
                                    		</c:when>
                                    		<c:otherwise>
                                    			<fmt:formatDate value="${sendOrder.sendDate}" pattern="yyyy-MM-dd"/>
                                    		</c:otherwise>
                                    	</c:choose>
                                    </td>
                                    <td>
                                        ${sendOrder.pickOrder.pickOrderNo}
                                    </td>
                                    <td>
                                        ${sendOrder.pickOrder.plateNo}
                                    </td>
                                    <td>
                                        ${sendOrder.pickNo}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(sendOrder.expressCompany,'express_company','')}</span>
                                    </td>
                                    <td>
                                        ${sendOrder.expressNo}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${sendOrder.expressTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td nowrap="nowrap" title="${sendOrder.memberRemarks }">
                                        ${fns:abbr(sendOrder.memberRemarks, 15)}
                                    </td>
                                    <td data-hide="true">
                                        ${sendOrder.receiveName}
                                    </td>
                                    <td data-hide="true">
                                        ${sendOrder.receiveTel}
                                    </td>
                                    <td data-hide="true">
                                        ${sendOrder.receiveAreaStr}
                                    </td>
                                    <td data-hide="true" title="${sendOrder.receiveAreaDetail }">
                                        ${fns:abbr(sendOrder.receiveAreaDetail, 20)}
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(sendOrder.createBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${sendOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                     <td data-hide="true">
                                        ${fns:getUserById(sendOrder.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${sendOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true" title="${sendOrder.remarks }">
                                        ${fns:abbr(sendOrder.remarks, 15)}
                                    </td>
                                    <td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/ol/sendOrder/info?id=${sendOrder.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <c:if test="${sendOrder.status eq '4' }"><!-- 待发货 -->
	                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
	                                                <li><a href="${ctx}/bus/ol/sendOrder/printInfo?id=${sendOrder.id}">打印详情</a></li>
	                                            </ul>
                                            </c:if>
                                            <c:if test="${sendOrder.status eq '7' }"><!-- 确认发货 -->
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/bus/ol/sendOrder/confirmSend?id=${sendOrder.id}">发货</a></li>
                                                <li><a href="${ctx}/bus/ol/pickOrder/myPackageForm?pickOrderId=${sendOrder.pickOrder.id}&sendOrderId=${sendOrder.id}&type=read">打印面单</a></li>
                                            </ul>
                                            </c:if>
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
    <div style="display: none;">
        <form id="hiddenForm" action="${ctx}/bus/ol/sendOrder/batchConfirmSend" method="post">
            <input id="ids" name="ids" type="hidden"/>
        </form>
    </div>
    </div>

    <script>
        $(function () {

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
            "order": [[ 14, "DESC" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
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
                {"orderable":false,targets:15},
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

          $("#selAll").on("ifChecked", function() {
              var c = 0;
              $("input[name='selItem']").each(function() {
                  if(!$(this).prop('disabled')) {
                      $(this).iCheck('check');
                      c++;
                  }
              });
          }).on("ifUnchecked", function() {
              $("input[name='selItem']").each(function() {
                  if(!$(this).prop('disabled')) {
                      $(this).iCheck('uncheck');
                  }
              });
          });

        $("#exportBtn").on("click", function() {
            $("#searchForm").attr("action", "${ctx}/bus/ol/sendOrderExport/exportOutboundDetails");
            $("#searchForm").submit();
            $("#searchForm").attr("action", "${ctx}/bus/ol/sendOrder/list");
        });

      });
      function batchConfirmSend() {
          var ids = new Array();
          var c = 0;
          $("input[name='selItem']").each(function() {
              if($(this).prop("checked")) {
                  ids.push($(this).val());
                  c++;
              }
          });
          if(c == 0) {
              ZF.showTip("请先勾选要发货的订单","info");
              return false;
          }
          $("#ids").val(ids.join());
          $("#hiddenForm").submit();
      }
      
   </script>
</body>
</html>