<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>待拣货出库单管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        }
        .label-primary {
            display: inline-block;
            margin: 8px 5px;
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/sendOrder/listToPick">待拣货发货单列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="sendOrder" action="${ctx}/bus/ol/sendOrder/listToPick" method="post" class="form-horizontal">
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
                                <label for="beginCreateTime" class="col-sm-3 control-label">起始时间</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="beginCreateTime" inputName="beginCreateTime" tip="请选择生成时间" value="${beginCreateTime }" inputId="beginCreateTime" isMandatory="false"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="endCreateTime" class="col-sm-3 control-label">结束时间</label>
                                <div class="col-sm-7">
                                    <sys:datetime id="endCreateTime" inputName="endCreateTime" tip="请选择生成时间" value="${endCreateTime }" inputId="endCreateTime"  isMandatory="false"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="courtType" class="col-sm-3 control-label">商品种类</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="courtType" tip="请选择商品种类" isMandatory="false" verifyType="0" dictName="send_produce_type" id="courtType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="orderNo" class="col-sm-3 control-label">订单编号</label>
                                <div class="col-sm-7">
                                   <sys:inputverify name="orderNo" id="orderNo" verifyType="0" tip="请输入订单编号 " isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="orderNo" class="col-sm-3 control-label">订单取消标记</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="orderCancelFlag" tip="请选择" isMandatory="false" verifyType="0" dictName="yes_no" id="orderCancelFlag"></sys:selectverify>
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
                            <button type="button" class="btn btn-sm btn-dropbox" onclick="receive();"><i class="fa fa-edit">接单</i></button>
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
                                <th>来源订单类型</th>
                                <th>订单编号</th>
                                <th>生成时间</th>
                                <th>出库状态</th>
                                <th>取消订单申请</th>
                                <th>收货人</th>
                                <th>收货电话</th>
                                <th>收货地址省市区</th>
                                <th>收货地址详情</th>
                                <th style="display: none;">用户备注</th>
                                <th style="display: none;">所属拣货序号</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="sendOrder" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        <input type="checkbox" name="selItem" ${not empty sendOrder.pickNo ? 'disabled=true':'' } value="${sendOrder.id }" data-order="${sendOrder.orderId }"/>
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
                                        <fmt:formatDate value="${sendOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(sendOrder.status,'bus_ol_send_order_status','')}</span>
                                    </td>
                                    <td>
										<c:choose>
											<c:when test="${sendOrder.orderCancelFlag eq '1' }">
												<span class="label label-warning">${fns:getDictLabel(sendOrder.orderCancelFlag,'yes_no','')}</span>
											</c:when>
											<c:when test="${sendOrder.orderCancelFlag eq '0' }">
												<span class="label label-primary">${fns:getDictLabel(sendOrder.orderCancelFlag,'yes_no','')}</span>
											</c:when>
										</c:choose>                                    
                                    </td>
                                    <td>
                                        ${sendOrder.receiveName}
                                    </td>
                                    <td>
                                        ${sendOrder.receiveTel}
                                    </td>
                                    <td>
                                        ${sendOrder.receiveAreaStr}
                                    </td>
                                    <td title="${sendOrder.receiveAreaDetail}">
                                        ${fns:abbr(sendOrder.receiveAreaDetail, 20)}
                                    </td>
                                    <td data-hide="true">
                                        ${sendOrder.memberRemarks}
                                    </td>
                                    <td data-hide="true">
                                        ${sendOrder.pickNo}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${sendOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${sendOrder.remarks}
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
        <div style="display: none;">
            <form id="hiddenForm" action="${ctx}/bus/ol/sendOrder/receiveSendOrder" method="post">
                <input id="ids" name="ids" type="hidden"/>
                <input id="no" name="plateNo" type="hidden"/>
                <input id="orderIds" name="orderIds" type="hidden"/>
            </form> 
        </div>
        
       <div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="录入拣货盘编号" aria-hidden="true">
	       <div class="modal-dialog" style="width:40%;height:50%;" >
		          <div class="modal-content" style="width:100%;height:100%;">
		             <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                      <span aria-hidden="true">&times;</span></button>
		                <h4 class="modal-title">录入拣货盘编号</h4>
		             </div>
		             <div class="modal-body">
		                <div>
		                  <label for="geneNum">拣货盘编号</label>
		                  <input type="text" class="form-control zf-readonly" maxlength="10" readonly name="plateNo" id="plateNo"  placeholder="请点击下面托盘编号"/>
		                </div>
                         <div class="col-md-6" style="margin-top: 20px;">
                             <label>可用托盘编号：</label>
                         </div>
                         <div class="col-md-12" id="plateDiv">

                         </div>
		             </div>
		             <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                <button type="button" class="btn btn-primary" id="commitBtn">提交接单</button>
		             </div>
		          </div><!-- /.modal-content -->
	        </div><!-- /.modal -->
        </div>
        
        
     </section>
    </div>
    
    <script>
   	  var maxReceiveSendOrderNum = "${config.configValue}";  
     
   	  $(function () {
         
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
        
        $("#selAll").on("ifChecked", function() {
        	var c = 0;
            $("input[name='selItem']").each(function() {
                if(!$(this).prop('disabled')) {
                    $(this).iCheck('check');
                    c++;
                }
            });
            if(c > maxReceiveSendOrderNum) {
            	ZF.showTip("单人单次接单不能超过最大值【"+maxReceiveSendOrderNum+"】","info");
            	return false;
            }
        }).on("ifUnchecked", function() {
            $("input[name='selItem']").each(function() {
                if(!$(this).prop('disabled')) {
                    $(this).iCheck('uncheck');
                }
            });
        });
        
       
        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : false,
            "order": [[ 4, "ASC" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
        
        $("#geneteModal #commitBtn").on("click",function () {
            
            var no = $("#plateNo").val();
            if(no == null || no == "" || $.trim(no).length == 0) {
            	ZF.showTip("请输入托盘编号!","info");
                return false;
            }
            $("#no").val(no);
            
            $("#geneteModal").modal("hide");    
            $("#hiddenForm").submit();
        });
        
      });
      
      function receive() {
    	  var ids = new Array();
    	  var orderIds = new Array();
    	  var c = 0;
          $("input[name='selItem']").each(function() {
              if($(this).prop("checked")) {
                 ids.push($(this).val());
                 orderIds.push($(this).attr('data-order'))
                 c++;
              }
          });
          if(c == 0) {
        	  ZF.showTip("请先勾选要拣货的出库单, 注意：单次接单的总数不能超过【"+maxReceiveSendOrderNum+"】个!","info");
              return false;
          }
          if(c > maxReceiveSendOrderNum) {
              ZF.showTip("单人单次接单不能超过最大值【"+maxReceiveSendOrderNum+"】","info");
              return false;
          }
          
          $("#ids").val(ids.join());
          $("#orderIds").val(orderIds.join());


          ZF.ajaxQuery(true, '${ctx}/bus/pm/plateManage/findUsableList',{},
          function (data) {
            let html="";
            for (let i=0; i<data.length; i++){
                html+="<span class='label label-primary' data-item title='点击选择该托盘' >"+data[i].plateNo+"</span>";
            }
            $("#plateDiv").html(html);
            $('[data-item]').on('click',function () {
                $("#plateNo").val($(this).text());
            });
            $("#geneteModal").modal('toggle');
            return false;
          },function () {
             ZF.showTip('获取托盘信息失败，请稍后再试！','warning');
             return false;
          });

          
      }
      
   </script>
</body>
</html>