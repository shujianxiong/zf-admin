<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>运费模板管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
        	 $("#receiveAreaName").on("click", function() {
                 selectAreainit({
                     "selectCallBack" : function(list) {
                         $("#receiveAreaId").val(list[0].id);
                         $("#receiveAreaName").val(list[0].text);
                     }
                 })
             });
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/tf/transportFee/">运费模板列表</a></small>
            <shiro:hasPermission name="lgt:tf:transportFee:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/lgt/tf/transportFee/form">运费模板添加</a>
                </small>
            </shiro:hasPermission>
            <shiro:hasPermission name="sys:area:import">
                <small>|</small>
                <small>
                    <i class="glyphicon glyphicon-import"></i>
                    <a href="${ctx }/lgt/tf/transportFee/importForm">运费模板批量导入</a>
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
            
            <sys:userselect height="550" url="${ctx}/sys/area/treeData"
            width="550" isOffice="true" isMulti="false" title="区域选择"
            id="selectArea"></sys:userselect>
            
            <form:form id="searchForm" modelAttribute="transportFee" action="${ctx}/lgt/tf/transportFee/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <sys:inputtree id="warehouse" name="warehouse.id" verifyType="true" url="${ctx}/lgt/ps/warehouse/warehouseListData" 
                                    inputWidth="9" labelWidth="2" label="发货仓库" 
                                    labelValue="" labelName="warehouse.name" value="" 
                                    tip="请选择发货仓库" title="调入仓库"></sys:inputtree>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">收货地区</label>
                                <div class="col-sm-7">  
                                    <form:hidden id="receiveAreaId" path="receiveArea.id" />
                                    <form:input id="receiveAreaName" path="receiveArea.name"
                                            htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
                                            placeholder="选择收货地区" readonly="true"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">启用状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="usableFlag" tip="请选择启用状态" verifyType="0" isMandatory="false" dictName="yes_no" id="usableFlag"></sys:selectverify>
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
                                <th>发货仓库</th>
                                <th>收货地区</th>
                                <th>快递公司价格</th>
                                <th>运费</th>
                                <th>寄送耗时</th>
                                <th>启用状态</th>
                                <th>更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="lgt:tf:transportFee:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="transportFee" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        ${transportFee.warehouse.name}
                                    </td>
                                    <td>
                                        ${fns:getAreaFullNameById(transportFee.receiveArea.id)}
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${transportFee.costMoney}</span>
                                    </td>
                                    <td class="zf-table-monet">
                                        <span class="text-red">${transportFee.money}</span>
                                    </td>
                                    <td>
                                        ${transportFee.days}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${transportFee.usableFlag eq '0' }">
                                                <span class="label label-primary">${fns:getDictLabel(transportFee.usableFlag, 'yes_no', '') }</span>
                                            </c:when>
                                            <c:when test="${transportFee.usableFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(transportFee.usableFlag, 'yes_no', '') }</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${transportFee.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td title="${transportFee.remarks}">
                                        ${fns:abbr(transportFee.remarks, 20)}
                                    </td>
                                    <shiro:hasPermission name="lgt:tf:transportFee:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/lgt/tf/transportFee/form?id=${transportFee.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/lgt/tf/transportFee/delete?id=${transportFee.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该运费模板吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/lgt/tf/transportFee/info?id=${transportFee.id}" target="">详情</a></li>
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
            "order": [[ 6, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:1},
                {"orderable":false,targets:0},
                {"orderable":false,targets:5},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8}
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