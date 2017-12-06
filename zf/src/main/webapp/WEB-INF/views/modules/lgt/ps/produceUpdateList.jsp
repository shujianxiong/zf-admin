<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品更新审批管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produceUpdate/">产品更新记录列表</a></small>
            <shiro:hasPermission name="lgt:ps:produceUpdate:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/produceUpdate/form">产品更新审批添加</a>
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
            
            <form:form id="searchForm" modelAttribute="produceUpdate" action="${ctx}/lgt/ps/produceUpdate/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">产品编码</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="produce.code" id="pcode" verifyType="0" tip="请输入产品编码" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">是否可购买</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="desIsBuy" tip="" verifyType="" isMandatory="false" dictName="yes_no" id="desIsBuy"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">是否可体验</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="desIsExperience" tip="" verifyType="" isMandatory="false" dictName="yes_no" id="desIsExperience"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">是否可预购</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="desIsForebuy" tip="" verifyType="" isMandatory="false" dictName="yes_no" id="desIsForebuy"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">是否可预约</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="desIsForeexperience" tip="" verifyType="" isMandatory="false" dictName="yes_no" id="desIsForeexperience"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">审批状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="checkStatus" tip="" verifyType="" isMandatory="false" dictName="lgt_ps_produce_update_checkStatus" id="checkStatus"></sys:selectverify>
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
                                <th>产品编码</th>
                                <th>产品名称</th>
                                <th>采购价<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="→左边为产品原来价格，右边为产品更改后的价格，后面以此类推">?</span></th>
                                <th>运算成本价</th>
                                <th>是否可购买</th>
                                <th>购买价格</th>
                                <th>购买打折比例</th>
                                <th>是否可体验</th>
                                <th>体验费收取比例</th>
                                <th>是否可预购</th>
                                <th>是否可预约</th>
                                <th>审批状态</th>
                                <th style="display: none;">审批人</th>
                                <th style="display: none;">审批时间</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <th style="display: none;">审批备注</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="produceUpdate" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>${produceUpdate.produce.code }</td>
                                    <td>${produceUpdate.produce.name }</td>
                                    <td class="zf-table-money"><span class="text-red">${produceUpdate.srcPricePurchase }</span>→<span class="text-red">${produceUpdate.desPricePurchase }</span></td>
                                    <td class="zf-table-money"><span class="text-red">${produceUpdate.srcPriceOperation }</span>→<span class="text-red">${produceUpdate.desPriceOperation }</span></td>
                                    <td><span class="label label-primary">${fns:getDictLabel(produceUpdate.srcIsBuy,'yes_no','' ) }</span>→<span class="label label-success">${fns:getDictLabel(produceUpdate.desIsBuy,'yes_no','' ) }</span></td>
                                    <td class="zf-table-money"><span class="text-red">${produceUpdate.srcPriceBuy }</span>→<span class="text-red">${produceUpdate.desPriceBuy }</span></td>
                                    
                                    <td>${produceUpdate.srcScaleDiscount }→${produceUpdate.desScaleDiscount }</td>
                                    
                                    <td><span class="label label-primary">${fns:getDictLabel(produceUpdate.srcIsExperience,'yes_no','' ) }</span>→<span class="label label-success">${fns:getDictLabel(produceUpdate.desIsExperience,'yes_no','' ) }</span></td>
                                    <td>${produceUpdate.srcScaleExperience }→${produceUpdate.desScaleExperience }</td>
                                   
                                    <td><span class="label label-primary">${fns:getDictLabel(produceUpdate.srcIsForebuy,'yes_no','' ) }</span>→<span class="label label-success">${fns:getDictLabel(produceUpdate.desIsForebuy,'yes_no','' ) }</span></td>
                                    <td><span class="label label-primary">${fns:getDictLabel(produceUpdate.srcIsForeexperience,'yes_no','' ) }</span>→<span class="label label-success">${fns:getDictLabel(produceUpdate.desIsForeexperience,'yes_no','' ) }</span></td>
                                    <td><span class="label label-primary">${fns:getDictLabel(produceUpdate.checkStatus,'lgt_ps_produce_update_checkStatus','' )}</span></td>
                                    <td data-hide="true">${fns:getUserById(produceUpdate.checkBy.id).name }</td>
                                    <td data-hide="true"><fmt:formatDate value="${produceUpdate.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${produceUpdate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(produceUpdate.remarks, 20)}
                                    </td>
                                    <td data-hide="true">
                                        ${fns:abbr(produceUpdate.checkRemarks, 20)}
                                    </td>
                                   <td>
	                                     <div class="btn-group zf-tableButton">
	                                         <button type="button" class="btn btn-sm btn-info"
	                                             onclick="window.location.href='${ctx}/lgt/ps/produceUpdate/info?id=${produceUpdate.id}'">详情</button>
	                                         <button type="button"
	                                             class="btn btn-sm btn-info dropdown-toggle"
	                                             data-toggle="dropdown">
	                                             <span class="caret"></span>
	                                         </button>
                                             <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '2' }">
	                                               <shiro:hasPermission name="lgt:ps:produceUpdate:approve">
		                                               <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
		                                                 <li><a href="${ctx}/lgt/ps/produceUpdate/form?id=${produceUpdate.id}" target="">审批</a></li>
		                                               </ul>
	                                               </shiro:hasPermission>
                                                </c:when>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }">
		                                            <shiro:hasPermission name="lgt:ps:produceUpdate:edit">
		                                               <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
		                                               <li><a href="${ctx}/lgt/ps/produceUpdate/form?id=${produceUpdate.id}" target="">修改</a></li>
		                                                   <%-- <li><a href="${ctx}/lgt/ps/produceUpdate/delete?id=${produceUpdate.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该产品更新审批吗？',this.href)">删除</a></li> --%>
		                                               </ul>
		                                            </shiro:hasPermission>
                                                </c:when>
                                             </c:choose>
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
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15},
                {"orderable":false,targets:16},
                {"orderable":false,targets:17},
                {"orderable":false,targets:18}
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