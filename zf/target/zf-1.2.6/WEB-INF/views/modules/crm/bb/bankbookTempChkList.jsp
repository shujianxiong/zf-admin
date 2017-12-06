<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>资金账户条目管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/bb/bankbookTempChk/">资金账户条目列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="bankbookTemp" action="${ctx}/crm/bb/bankbookTempChk/" method="post" class="form-horizontal">
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
                                <label for="name" class="col-sm-3 control-label">开始时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="beginTime" inputName="beginTime" tip="请选择变动开始时间" inputId="beginTime" value="${bankbookTemp.beginTime }" isMandatory="false"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">截止时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="endTime" inputName="endTime" tip="请选择变动截止时间" inputId="endTime" value="${bankbookTemp.endTime }" isMandatory="false"></sys:datetime>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">创建类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="createType" tip="请选择" verifyType="0" dictName="crm_bb_bankbook_createType" id="createType" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">变动类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="changeType" tip="请选择" verifyType="0" dictName="crm_bb_bankbook_changeType" id="changeType" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">资金类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="moneyType" tip="请选择" verifyType="0" dictName="crm_bb_bankbook_moneyType" id="moneyType" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">条目状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="status" tip="请选择" verifyType="0" dictName="crm_bb_bankbook_temp_status" id="status" isMandatory="false"></sys:selectverify>
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
                                <th>创建时间</th>
                                <th>会员账号</th>
                                <th>创建类型</th>
                                <th>变动类型</th>
                                <th>资金类型</th>
                                <th>变动金额(元)</th>
                                <th>条目状态</th>
                                <th>审核时间</th>
                                <th style="display: none;">创建者</th>
                                <th style="display: none;">更新者</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="crm:bb:bankbookTemp:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="bankbookTemp" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${bankbookTemp.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        ${fns:getMemberById(bankbookTemp.bankbookBalance.member.id).usercode}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(bankbookTemp.createType, 'crm_bb_bankbook_createType', '')}</span>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(bankbookTemp.changeType, 'crm_bb_bankbook_changeType', '')}</span>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(bankbookTemp.moneyType, 'crm_bb_bankbook_moneyType', '')}</span>
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${bankbookTemp.money}</span>
                                    </td>
                                    <td>
                                         <c:choose>
                                            <c:when test="${bankbookTemp.status eq '1' }">
                                                <span class="label label-default">${fns:getDictLabel(bankbookTemp.status, 'crm_bb_bankbook_temp_status', '')}</span>
                                            </c:when>
                                            <c:when test="${bankbookTemp.status eq '2' }">
                                                <span class="label label-success">${fns:getDictLabel(bankbookTemp.status, 'crm_bb_bankbook_temp_status', '')}</span>
                                            </c:when>
                                            <c:when test="${bankbookTemp.status eq '3' }">
                                                <span class="label label-primary">${fns:getDictLabel(bankbookTemp.status, 'crm_bb_bankbook_temp_status', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${bankbookTemp.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(bankbookTemp.createBy.id).name }
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(bankbookTemp.updateBy.id).name }
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${bankbookTemp.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(bankbookTemp.remarks,15)}
                                    </td>
                                    <shiro:hasPermission name="crm:bb:bankbookTemp:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/crm/bb/bankbookTemp/info?id=${bankbookTemp.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <c:if test="${bankbookTemp.status eq '1' }">
	                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
	                                                <%-- <li><a href="${ctx}/crm/bb/bankbookTemp/delete?id=${bankbookTemp.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该资金账户条目吗？',this.href)">删除</a>
	                                                </li> --%>
	                                                <li><a href="${ctx}/crm/bb/bankbookTempChk/check?id=${bankbookTemp.id}&checkType=pass" target="">审核通过</a></li>
	                                                <li><a href="${ctx}/crm/bb/bankbookTempChk/check?id=${bankbookTemp.id}&checkType=refuse" target="">审核拒绝</a></li>
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
            "order": [[ 1, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:7},
                {"orderable":false,targets:9},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13}
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