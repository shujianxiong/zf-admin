<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品评价管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/pj/produceJudge/">产品评价列表</a></small>
            <%-- <shiro:hasPermission name="bus:pj:produceJudge:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/bus/pj/produceJudge/form">产品评价添加</a>
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
            
            <form:form id="searchForm" modelAttribute="produceJudge" action="${ctx}/bus/pj/produceJudge/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="eorderNo" class="col-sm-3 control-label">订单编号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="experienceOrder.orderNo" id="eorderNo" verifyType="99" tip="请输入订单编号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="musercode" class="col-sm-3 control-label">会员账号</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="member.usercode" id="musercode" verifyType="99" tip="请输入会员账号" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="checkStatus" class="col-sm-3 control-label">审核状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="checkStatus" tip="请选择" verifyType="0" dictName="check_status" isMandatory="false" id="checkStatus"></sys:selectverify>
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
                                <th>体验订单编号</th>
                                <th>会员账号</th>
                                <th>产品样图</th>
                                <th>产品编码</th>
                                <th>产品全称</th>
                                <th>产品评价等级</th>
                                <th>服务评价等级</th>
                                <th>物流评价等级</th>
                                <th>评价图片</th>
                                <th>审核状态</th>
                                <th>审核人</th>
                                <th>审核时间</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="bus:pj:produceJudge:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="produceJudge" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>${produceJudge.experienceOrder.orderNo }</td>
                                    <td>${produceJudge.member.usercode }</td>
                                    <td><img onerror="imgOnerror(this);"  src="${imgHost }${produceJudge.goods.samplePhoto}" data-big data-src="${imgHost }${produceJudge.goods.samplePhoto}" width="21" height="21" /></td>
                                    <td>${produceJudge.produce.code }</td>
                                    <c:set var="fullName" value="${produceJudge.goods.name } ${produceJudge.produce.name}"></c:set>
                                    <td title="${fullName }">${fns:abbr(fullName, 15)}</td>
                                    <td><span class="label label-primary">${fns:getDictLabel(produceJudge.produceLevel, 'bus_pj_produce_judge_level', '' )}</span></td>
                                    <td><span class="label label-primary">${fns:getDictLabel(produceJudge.serviceLevel, 'bus_pj_produce_judge_level', '' )}</span></td>
                                    <td><span class="label label-primary">${fns:getDictLabel(produceJudge.expressLevel, 'bus_pj_produce_judge_level', '' )}</span></td>
                                    <td>
                                        <c:forEach items="${produceJudge.photoList }" var="photo">
                                            <img src="${imgHost }${photo.photoUrl}" data-big data-src="${imgHost }${photo.photoUrl}" width="20px;" height="20px;"/>
                                        </c:forEach>
                                    </td>
                                    <td><span class="label label-primary">${fns:getDictLabel(produceJudge.checkStatus, 'check_status', '' )}</span></td>
                                    <td>${fns:getUserById(produceJudge.checkBy.id).name }</td>
                                    <td><fmt:formatDate value="${produceJudge.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${produceJudge.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${produceJudge.remarks}
                                    </td>
                                    <shiro:hasPermission name="bus:pj:produceJudge:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/pj/produceJudge/info?id=${produceJudge.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/bus/pj/produceJudge/delete?id=${produceJudge.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该产品评价吗？',this.href)">删除</a>
                                                </li>
                                                <c:if test="${produceJudge.checkStatus eq '1' }">
                                                    <li><a href="${ctx}/bus/pj/produceJudge/checkProduceJudge?id=${produceJudge.id}&checkStatus=2" style="color: #00c0ef" onclick="return ZF.delRow('该产品评价确定审核通过？',this.href)">审核通过</a></li>
                                                    <li><a href="${ctx}/bus/pj/produceJudge/checkProduceJudge?id=${produceJudge.id}&checkStatus=3" style="color: #00c0ef" onclick="return ZF.delRow('该产品评价确定审核拒绝？',this.href)">审核拒绝</a></li>
                                                </c:if>
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
            "order": [[ 12, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
      
   </script>
</body>
</html>