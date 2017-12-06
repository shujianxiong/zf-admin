<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<html>
<head>
    <title>优惠券模板管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/ci/couponTemplate/">优惠券模板列表</a></small>
            <shiro:hasPermission name="spm:ci:couponTemplate:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/spm/ci/couponTemplate/form">优惠券模板添加</a>
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
            
            <form:form id="searchForm" modelAttribute="couponTemplate" action="${ctx}/spm/ci/couponTemplate/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">模板名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" verifyType="0" tip="请输入模板名称" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">优惠类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="couponType" tip="请选择优惠类型" isMandatory="false" verifyType="0" dictName="spm_ci_coupon_type" id="couponType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">开始时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="startTime" inputName="startTime" tip="请选择开始时间" inputId="startTimeId" value="${couponTemplate.startTime }" isMandatory="false"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">截止时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="endTime" inputName="endTime" tip="请选择截止时间" inputId="endTimeId" value="${couponTemplate.endTime }" isMandatory="false"></sys:datetime>
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
                                <th>模板名称</th>
                                <th>优惠券名称</th>
                                <th>可用起始时间</th>
                                <th>可用截止时间</th>
                                <th>优惠类型</th>
                                <th>已生成数量</th>
                                <th>已领取数量</th>
                                <th>更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="spm:ci:couponTemplate:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="couponTemplate" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td title="${couponTemplate.name }">
                                        ${fns:abbr(couponTemplate.name, 15)}
                                    </td>
                                    <td title="${couponTemplate.couponName }">
                                        ${fns:abbr(couponTemplate.couponName, 15)}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${couponTemplate.startTime}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${couponTemplate.endTime}" pattern="yyyy-MM-dd"/>
                                        
                                        <fmt:formatDate var="st" value="${couponTemplate.startTime}" pattern="yyyy-MM-dd"/>
                                        <fmt:formatDate var="et"  value="${couponTemplate.endTime}" pattern="yyyy-MM-dd"/>
                                        <fmt:formatDate var="cur"  value="${couponTemplate.endTime}" pattern="yyyy-MM-dd"/>
                                        <fmt:parseDate value="${st }" var="startTime" pattern="yyyy-MM-dd"></fmt:parseDate>
                                        <fmt:parseDate value="${et }" var="endTime" pattern="yyyy-MM-dd"></fmt:parseDate>
                                        <fmt:parseDate value="${cur }" var="curT" pattern="yyyy-MM-dd"></fmt:parseDate>
                                        <c:if test="${curT > endTime }">
                                            <span class="label label-default text-red">已失效</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(couponTemplate.couponType, 'spm_ci_coupon_type', '')}</span>
                                    </td>
                                    <td>
                                        ${couponTemplate.numCreated}
                                    </td>
                                    <td>
                                        ${couponTemplate.numProvided}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${couponTemplate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td title="${couponTemplate.remarks }">
                                        ${fns:abbr(couponTemplate.remarks,15)}
                                    </td>
                                    <shiro:hasPermission name="spm:ci:couponTemplate:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/spm/ci/couponTemplate/form?id=${couponTemplate.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/spm/ci/couponTemplate/delete?id=${couponTemplate.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该优惠券模板吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/spm/ci/couponTemplate/info?id=${couponTemplate.id}" target="">详情</a></li>
                                                <li><a href="#" onclick="generate('${couponTemplate.id}');" target="">生成优惠券</a></li>
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
        <div style="display: none;">
            <form id="geneForm" action="${ctx}/spm/ci/couponTemplate/generateCoupon" method="post">
                <input id="couponTId" name="couponTemplateId" type="hidden"/>
                <input id="num" name="num" type="hidden"/>
            </form>
        </div>
     </section>
     
    <div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="确认优惠券数量" aria-hidden="true">
       <div class="modal-dialog" style="width:20%;height:32%;" >
          <div class="modal-content" style="width:100%;height:100%;">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认优惠券生成数量</h4>
             </div>
             <div class="modal-body">
                <input type="text" class="form-control" name="geneNum" maxlength="4" id="geneNum" max="1000" placeholder="请输入要生成的优惠券数量,单次最大生成数为1000"/>
             </div>
             <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="${input }commitBtn">提交生成</button>
             </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
     
     
    </div>
    
    <script>
      $(function () {
        
        ZF.bigImg();
         
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
          
        
        $("#geneNum").on("change", function() {
        	var val = $(this).val();
            if(!ZF.formVerify(true, 4, val) || val > 1000) {
                $(this).addClass("zf-input-err")
                if($("#geneNumErr").length<=0)
                    $(this).after("<label id=\"geneNumErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请核查填写的优惠券数量值,单次最大值1000</label>")
                $(this).attr("data-verify","false");
            }else{
                if($("#geneNumErr").length>0){
                    $(this).removeClass("zf-input-err");
                    $("#geneNumErr").remove();
                }
                $(this).attr("data-verify","true");
            }
        });
       
        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : true,
            "order": [[ 7, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:4},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9}
            ],
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        });
        
        $("#geneteModal #commitBtn").on("click",function () {
               
            var val = $("#geneNum").val();
            if(!ZF.formVerify(true, 4, val) || val > 1000) {
            	$("#geneNum").addClass("zf-input-err")
                if($("#geneNumErr").length<=0)
                    $("#geneNum").after("<label id=\"geneNumErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请核查填写的优惠券数量值,单次最大值1000</label>")
                $("#geneNum").attr("data-verify","false");
            }else{
                if($("#geneNumErr").length>0){
                    $("#geneNum").removeClass("zf-input-err");
                    $("#geneNumErr").remove();
                }
                $(this).attr("data-verify","true");
	            $("#num").val(val);
	            $("#geneteModal").modal("hide");    
	            $("#geneForm").submit();
            }
        });
        
        
      });
      
      function generate(couponId) {
    	  $("#couponTId").val(couponId);
    	  $("#geneteModal #geneNum").val("").removeClass("zf-input-err");
          $("#geneteModal #geneNumErr").remove();
    	  $("#geneteModal").modal('toggle');
      }
   </script>
</body>
</html>