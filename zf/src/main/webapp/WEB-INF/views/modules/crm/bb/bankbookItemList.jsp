<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>资金账户流水管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/bb/bankbookItem/">资金账户流水列表</a></small>
            <%-- <small>|</small>
            <shiro:hasPermission name="crm:bb:bankbookItem:edit"><small><i class="fa-form-edit"></i><a href="${ctx}/crm/bb/bankbookItem/form">资金账户流水添加</a></small></shiro:hasPermission> --%>
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
            
            <form:form id="searchForm" modelAttribute="bankbookItem" action="${ctx}/crm/bb/bankbookItem/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">会员账号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="bankbookBalance.member.usercode" id="musercode" verifyType="0" tip="请输入会员账号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">变动类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="changeType" tip="请选择" verifyType="0" isMandatory="false" dictName="crm_bb_bankbook_changeType" id="changeType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">资金类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="moneyType" tip="请选择" verifyType="0" isMandatory="false" dictName="crm_bb_bankbook_moneyType" id="moneyType"></sys:selectverify>
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
							    <th>会员账号</th>
							    <th>姓名</th>
							    <th>变动类型</th>
							    <th>资金类型</th>
							    <th>变动金额(元)</th>
							    <th>变后可用(元)</th>
							    <th>变后冻结(元)</th>
                                <th>变动时间</th>
							    <th style="display: none;">上一次可用(元)</th>
							    <th style="display: none;">上一次冻结(元)</th>
							    <th style="display: none;">来源业务编号</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="bankbookItem" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${fns:getMemberById(bankbookItem.bankbookBalance.member.id).usercode}
                                    </td>
                                    
                                    <td>
                                        ${fns:getMemberById(bankbookItem.bankbookBalance.member.id).name}
                                    </td>
									<td>
									    <span class="label label-primary">${fns:getDictLabel(bankbookItem.changeType, 'crm_bb_bankbook_changeType', '')}</span>
									</td>
									
									<td>
									    <span class="label label-primary">${fns:getDictLabel(bankbookItem.moneyType, 'crm_bb_bankbook_moneyType', '')}</span>
									</td>
									
									<td class="zf-table-money">
									   <span class="text-red">${bankbookItem.money}</span>
									</td>
									
									<td class="zf-table-money">
									   <span class="text-red">${bankbookItem.usableBalance}</span>
									</td>
									
									<td class="zf-table-money">
									   <span class="text-red">${bankbookItem.frozenBalance}</span>
									</td>
                                    <td>
                                        <fmt:formatDate value="${bankbookItem.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
								    <td data-hide="true">${bankbookItem.lastUsableBalance}</td>
								    <td data-hide="true">${bankbookItem.lastFrozenBalance}</td>
								    <td data-hide="true">${bankbookItem.uniqueNo}</td>
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
            //"order": [[ 1, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11}
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