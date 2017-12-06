<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<html>
<head>
    <title>优惠券管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ci/coupon/">优惠券列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="coupon" action="${ctx}/spm/ci/coupon/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">优惠券名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" verifyType="0" tip="请输入优惠券名称" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="code" class="col-sm-3 control-label">优惠券编码</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="code" id="code" verifyType="0" tip="请输入优惠券编码" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="couponType" class="col-sm-3 control-label">优惠类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="type" tip="请选择优惠类型" isMandatory="false" verifyType="0" dictName="spm_ci_coupon_type" id="type"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">优惠券状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="status" isMandatory="false" tip="请选择优惠券状态" verifyType="0" dictName="spm_ci_coupon_status" id="status"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">领取方式</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="receiveType" isMandatory="false" tip="请选择领取方式" verifyType="0" dictName="spm_ci_coupon_receiveType" id="receiveType"></sys:selectverify>  
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
                                <th>优惠券名称</th>
                                <th>优惠券编码</th>
                                <th>优惠类型</th>
                                <th>可用起始时间</th>
                                <th>可用截止时间</th>
                                <th>优惠券状态</th>
                                <th>所属会员</th>
                                <th>领取方式</th>
                                <th>领取时间</th>
                                <th style="display: none;">使用订单号</th>
                                <th>使用扣减金额</th>
                                <th>使用时间</th>
                                <th style="display: none;">更新者</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="spm:ci:coupon:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="coupon" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td title="${coupon.name }">
                                        ${fns:abbr(coupon.name, 20)}
                                    </td>
                                    <td>
                                        ${coupon.code}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(coupon.type, 'spm_ci_coupon_type', '')}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${coupon.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${coupon.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate var="st" value="${coupon.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        <fmt:formatDate var="et"  value="${coupon.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        <fmt:parseDate value="${st }" var="startTime" pattern="yyyy-MM-dd"></fmt:parseDate>
                                        <fmt:parseDate value="${et }" var="endTime" pattern="yyyy-MM-dd"></fmt:parseDate>
                                        <c:choose>
                                            <c:when test="${now > endTime }">
                                                <span class="label label-default">已失效</span>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                       <c:when test="${coupon.status eq '1' }">
                                                           <span class="label label-info">${fns:getDictLabel(coupon.status, 'spm_ci_coupon_status', '')}</span>
                                                       </c:when>
                                                        <c:when test="${coupon.status eq '2' }">
                                                           <span class="label label-primary">${fns:getDictLabel(coupon.status, 'spm_ci_coupon_status', '')}</span>
                                                       </c:when>
                                                        <c:when test="${coupon.status eq '3' }">
                                                           <span class="label label-success">${fns:getDictLabel(coupon.status, 'spm_ci_coupon_status', '')}</span>
                                                       </c:when>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        ${fns:getMemberById(coupon.member.id).usercode}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(coupon.receiveType, 'spm_ci_coupon_receiveType', '')}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate  value="${coupon.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${coupon.useBuyOrder}
                                    </td>
                                    <td class="zf-table-money">
                                        <span class="text-red">${coupon.useDecMoney}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${coupon.useTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(coupon.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${coupon.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td  data-hide="true">
                                        ${fns:abbr(coupon.remarks, 15)}
                                    </td>
                                    <shiro:hasPermission name="spm:ci:coupon:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/spm/ci/coupon/info?id=${coupon.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/spm/ci/coupon/delete?id=${coupon.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该优惠券吗？',this.href)">删除</a>
                                                </li>
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
            "order": [[ 14, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:10},
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