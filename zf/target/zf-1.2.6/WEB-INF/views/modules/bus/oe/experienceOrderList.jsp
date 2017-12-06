<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验单管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            var content = ${fns:toJson(message)}
            console.log(content);
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/oe/experienceOrder/">体验单列表</a></small>
            <%-- <shiro:hasPermission name="bus:oe:experienceOrder:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/oe/experienceOrder/form">体验单添加</a>
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
            
            <form:form id="searchForm" modelAttribute="experienceOrder" action="${ctx}/bus/oe/experienceOrder/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
				        	<div class="row">
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>
				        				<div class="col-sm-7">
				        					<form:input path="searchParameter.keyWord" class="form-control" placeholder="订单编号、会员账号模糊匹配查询" />
				        				</div>
				        			</div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="level" class="col-sm-3 control-label">订单类型</label>
					                  <div class="col-sm-7">
					                    <form:select path="type" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('bus_oe_experience_order_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="statusSystem" class="col-sm-3 control-label">订单状态</label>
					                  <div class="col-sm-7">
					                    <form:select path="statusSystem" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('bus_oe_experience_order_statusSystem')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        	</div>
				        	<div class="row">
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="statusPay" class="col-sm-3 control-label">支付状态</label>
					                  <div class="col-sm-7">
					                    <form:select path="statusPay" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('bus_order_statusPay')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="beginRegisterTime" class="col-sm-3 control-label">开始创建时间</label>
				        				<div class="col-sm-7">
				        					<sys:datetime id="beginCreateDate" inputName="beginCreateDate" tip="请选择开始创建时间" value="${experienceOrder.beginCreateDate }" inputId="beginCreateDate"></sys:datetime>
				        				</div>
				        			</div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="beginRegisterTime" class="col-sm-3 control-label">结束创建时间</label>
				        				<div class="col-sm-7">
				        					<sys:datetime id="endCreateDate" inputName="endCreateDate" tip="请选择结束创建时间" value="${experienceOrder.endCreateDate }" inputId="endCreateDate"></sys:datetime>
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
                                <th>订单编号</th>
                                <th>会员账号</th>
                                <th>订单类型</th>
                                <th>订单状态</th>
                                <th>支付状态</th>
                                <th>评价状态</th>
                                <th>总金额(元)</th>
                                <th>已支付金额(元)</th>
                                <th>用户备注</th>
                                <th style="display:none">创建者</th>
                                <th style="display:none">创建时间</th>
                                <th style="display:none">更新者</th>
                                <th style="display:none">更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="bus:oe:experienceOrder:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="experienceOrder" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${experienceOrder.orderNo}
                                    </td>
                                    <td>
                                        ${experienceOrder.member.usercode}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(experienceOrder.type, 'bus_oe_experience_order_type', '')}</span>
                                    </td>
                                    <td>
                                    	<span class="label label-primary">${fns:getDictLabel(experienceOrder.statusSystem, 'bus_oe_experience_order_statusSystem', '')}</span>
									</td>
									<td>
										<span class="label label-primary">${fns:getDictLabel(experienceOrder.statusPay, 'bus_order_statusPay', '')}</span>
									</td>
									<td>
										<span class="label label-primary">${fns:getDictLabel(experienceOrder.statusJudge, 'bus_order_statusJudge', '')}</span>
									</td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${experienceOrder.moneyTotal}</span>
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${experienceOrder.moneyPaid}</span>
                                    </td>
                                    <td title="${experienceOrder.memberRemarks }">
                                        ${fns:abbr(experienceOrder.memberRemarks, 15)}
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(experienceOrder.createBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${experienceOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(experienceOrder.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${experienceOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td title="${experienceOrder.remarks }">
                                        ${fns:abbr(experienceOrder.remarks, 15)}
                                    </td>
                                    <shiro:hasPermission name="bus:oe:experienceOrder:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/bus/oe/experienceOrder/info?id=${experienceOrder.id}'">详情</button>
                                            <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                             <c:if test="${experienceOrder.statusMember eq '2' }">
                                                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                    <li><a href="${ctx}/bus/oe/experienceOrder/form?id=${experienceOrder.id}" target="">修改</a></li>
                                                </ul>
                                             </c:if>
                                             <c:if test="${experienceOrder.statusSystem eq '1' && (experienceOrder.statusPay eq '1' || experienceOrder.statusPay eq '2') }">
                                                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                    <li><a href="#this" onclick="closeOrder('${ctx}/bus/oe/experienceOrder/closeExperienceOrder?id=${experienceOrder.id}','确定要关闭该体验单吗？关闭后的订单不可以再进行支付操作！')" target="">关闭订单</a></li>
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
	            "order": [[ 14, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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

		function closeOrder(url,message){
			confirm(message,"warning",function(){
				window.location.href = url;
			});
		}
      
   </script>
</body>
</html>