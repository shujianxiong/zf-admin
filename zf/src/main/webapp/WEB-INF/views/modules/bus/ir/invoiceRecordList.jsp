<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发票开票记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ir/invoiceRecord/">发票开票记录列表</a></small>
            <shiro:hasPermission name="bus:ir:invoiceRecord:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/ir/invoiceRecord/form">发票开票记录添加</a>
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
            
            <form:form id="searchForm" modelAttribute="invoiceRecord" action="${ctx}/bus/ir/invoiceRecord/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                	<div class="row">
	                	<div class="col-md-4">
	                       <div class="form-group">
	                           <label for="orderNo" class="col-sm-3 control-label">购买订单编号</label>
	                           <div class="col-sm-7">
	                               <form:input path="buyOrder.orderNo" class="form-control" placeholder="购买订单编号" />
	                           </div>
	                       </div>
	                   </div>
	                   <div class="col-md-4">
	                       <div class="form-group">
	                         <label for="status" class="col-sm-3 control-label">开票状态</label>
	                         <div class="col-sm-7">
	                           <form:select path="status" class="form-control select2">
	                               <form:option value="" label="所有"/>
	                               <form:options items="${fns:getDictList('bus_ir_invoice_record_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
	                           </form:select>
	                         </div>
	                       </div>
	                   </div>
	                   <div class="col-md-4">
	                       <div class="form-group">
	                         <label for="type" class="col-sm-3 control-label">发票类型</label>
	                         <div class="col-sm-7">
	                           <form:select path="type" class="form-control select2">
	                               <form:option value="" label="所有"/>
	                               <form:options items="${fns:getDictList('bus_ir_invoice_record_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
	                           </form:select>
	                         </div>
	                       </div>
	                   	</div>
                	</div>
                	<div class="row">
                		<div class="col-md-4">
	                       <div class="form-group">
	                         <label for="titleType" class="col-sm-3 control-label">抬头类型</label>
	                         <div class="col-sm-7">
	                           <form:select path="titleType" class="form-control select2">
	                               <form:option value="" label="所有"/>
	                               <form:options items="${fns:getDictList('bus_ir_invoice_record_titleType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
	                           </form:select>
	                         </div>
	                       </div>
	                   	</div>
	                   	<div class="col-md-4">
	                       <div class="form-group">
	                         <label for="contentType" class="col-sm-3 control-label">发票内容</label>
	                         <div class="col-sm-7">
	                           <form:select path="contentType" class="form-control select2">
	                               <form:option value="" label="所有"/>
	                               <form:options items="${fns:getDictList('bus_ir_invoice_record_contentType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
	                           </form:select>
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
                                <th>购买订单编号</th>
                                <th>开票金额</th>
                                <th>状态</th>
                                <th>发票类型</th>
                                <th>发票抬头类型</th>
                                <th>发票抬头</th>
                                <th>发票税号</th>
                                <th>发票内容</th>
                                <th>收货人</th>
                                <th>收货电话</th>
                                <th>收货地址省市区</th>
                                <th>收货地址详情</th>
                                <shiro:hasPermission name="bus:ir:invoiceRecord:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="invoiceRecord" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${invoiceRecord.buyOrder.orderNo}
									</td>
                                    <td>
                                        ${invoiceRecord.money}
									</td>
                                    <td>
                                         <span class="label label-primary">${fns:getDictLabel(invoiceRecord.status, 'bus_ir_invoice_record_status', '')}</span>
									</td>
                                    <td>
                                         <span class="label label-primary">${fns:getDictLabel(invoiceRecord.type, 'bus_ir_invoice_record_type', '')}</span>
									</td>
									<td>
                                         <span class="label label-primary">${fns:getDictLabel(invoiceRecord.titleType, 'bus_ir_invoice_record_titleType', '')}</span>
									</td>
									<td>
                                        ${invoiceRecord.title}
									</td>
                                    <td>
                                        ${invoiceRecord.taxNo}
									</td>
									<td>
                                         <span class="label label-primary">${fns:getDictLabel(invoiceRecord.contentType, 'bus_ir_invoice_record_contentType', '')}</span>
									</td>
                                    <td>
                                        ${invoiceRecord.receiveName}
									</td>
                                    <td>
                                        ${invoiceRecord.receiveTel}
									</td>
                                    <td>
                                        ${invoiceRecord.receiveAreaStr}
									</td>
                                    <td>
                                        ${invoiceRecord.receiveAreaDetail}
									</td>
                                    <shiro:hasPermission name="bus:ir:invoiceRecord:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/ir/invoiceRecord/form?id=${invoiceRecord.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/bus/ir/invoiceRecord/delete?id=${invoiceRecord.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该发票开票记录吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/bus/ir/invoiceRecord/info?id=${invoiceRecord.id}" target="">详情</a></li>
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