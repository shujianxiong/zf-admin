<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>好坏货调动记录管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/goodBadChange/">好坏货调动记录列表</a></small>
            <shiro:hasPermission name="lgt:ps:goodBadChange:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/lgt/ps/goodBadChange/form">好坏货调动记录添加</a>
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
            
            <form:form id="searchForm" modelAttribute="goodBadChange" action="${ctx}/lgt/ps/goodBadChange/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label class="col-sm-3 control-label">查询条件</label>
                                <div class="col-sm-7">  
                                    <input type="text" class="form-control" name="searchParameter.keyWord" value="${goodBadChange.searchParameter.keyWord}" placeholder="请输入货品编码查询"/>
                                </div>
                            </div>
                        </div>
                         <div class="col-md-4">
                            <div  class="form-group">
                                <label for="reasonType" class="col-sm-3 control-label">调货原因类型</label>
                                <div class="col-sm-7">
                                   <sys:selectverify name="reasonType" tip="" verifyType="" dictName="lgt_ps_good_bad_change_reasonType" id="reasonType" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                         <div class="col-md-4">
                            <div  class="form-group">
                                <label for="status" class="col-sm-3 control-label">审核状态</label>
                                <div class="col-sm-7">
                                   <sys:selectverify name="status" tip="" verifyType="" dictName="check_status" id="status" isMandatory="false"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
					    <div class="col-md-4">
							<div class="form-group">
								<label for="beginCreateDate" class="col-sm-3 control-label">起始创建时间</label>
								<div class="col-sm-7">
									<sys:datetime id="beginCreateDate" inputId="beginCreateDate" inputName="beginCreateDate" value="${goodBadChange.beginCreateDate}" tip="请选择起始创建时间" isMandatory="false"></sys:datetime>
								</div>
							</div>
						</div>
					    <div class="col-md-4">
							<div class="form-group">
								<label for="endCreateDate" class="col-sm-3 control-label">截止创建时间</label>
								<div class="col-sm-7">
									<sys:datetime id="endCreateDate" inputId="endCreateDate" inputName="endCreateDate" value="${goodBadChange.endCreateDate}" tip="请选择截止创建时间" isMandatory="false"></sys:datetime>
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
                        <button type="button" class="btn btn-sm btn-primary" onclick="exportExcel();" ><i class="fa fa-file">导出Excel</i></button>
                         <shiro:hasPermission name="lgt:ps:goodBadChange:audit">
		                     <button type="button" class="btn btn-sm btn-dropbox" onclick="batchAudit('2');"><i class="fa fa-edit">批量审核通过</i></button>
                             <button type="button" class="btn btn-sm btn-dropbox" onclick="batchAudit('3');"><i class="fa fa-edit">批量审核不通过</i></button>
		                 </shiro:hasPermission>
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="selAll" name="selAll"/></th>
                               <!--  <input type="checkbox" id="selAll" name="selAll"/> -->
                                <th class="zf-dataTables-multiline"></th>
                                <th>货品编码</th>
                                <th>定损金额</th>
                                <th>图片</th>
                                <th>调前货位</th>
                                <th>调后货位</th>
                                <th>责任人</th>
                                <th>调货原因类型</th>
                                <th>备注信息</th>
                                <th>审核状态</th>
                                <th>审核备注</th>
                                <th style="display: none;">创建人</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">审批人 </th>
                                <th style="display: none;">审批时间 </th>
                                <shiro:hasPermission name="lgt:ps:goodBadChange:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="goodBadChange" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        <input type="checkbox" name="selItem" ${goodBadChange.status eq '1' ? '':'disabled=true' } value="${goodBadChange.id }"/>
                                    </td>
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${goodBadChange.product.code}
                                    </td>
                                    <td>
                                        ${goodBadChange.assessmentAmount}
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" data-big data-src="${imgHost }${goodBadChange.photo}" src="${imgHost }${goodBadChange.photo}" width="20px;" height="20px;"/>
                                    </td>
                                    <td>
                                        ${goodBadChange.preWareplace.warecounter.warearea.warehouse.code}-${goodBadChange.preWareplace.warecounter.warearea.code}-${goodBadChange.preWareplace.warecounter.code}-${goodBadChange.preWareplace.code}
                                    </td>
                                    <td>
                                        ${goodBadChange.postWareplace.warecounter.warearea.warehouse.code}-${goodBadChange.postWareplace.warecounter.warearea.code}-${goodBadChange.postWareplace.warecounter.code}-${goodBadChange.postWareplace.code}
                                    </td>
                                    <td>
                                        ${fns:getUserById(goodBadChange.personLiable.id).name}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(goodBadChange.reasonType, 'lgt_ps_good_bad_change_reasonType', '')}</span>
                                    </td>
                                    <td>
                                        ${goodBadChange.remarks}
                                    </td>
                                    <td>
                                     <c:choose>
                                            <c:when test="${goodBadChange.status eq '1'}">
                                                <span class="label label-primary">${fns:getDictLabel(goodBadChange.status, 'check_status', '')}</span>
                                            </c:when>
                                            <c:when test="${goodBadChange.status eq '2'}">
                                                <span class="label label-success">${fns:getDictLabel(goodBadChange.status, 'check_status', '')}</span>
                                            </c:when>
                                             <c:when test="${goodBadChange.status eq '3'}">
                                                <span class="label label-danger">${fns:getDictLabel(goodBadChange.status, 'check_status', '')}</span>
                                            </c:when>
                                        </c:choose>
                                        <span class="label label-primary"></span>
                                    </td>
                                    <td>
                                        ${goodBadChange.checkRemarks}
                                    </td>
                                     <td data-hide="true">
                                        ${fns:getUserById(goodBadChange.createBy.id).name}
                                    </td>
                                     <td data-hide="true">
                                        <fmt:formatDate value="${goodBadChange.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(goodBadChange.checkBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${goodBadChange.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <shiro:hasPermission name="lgt:ps:goodBadChange:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/lgt/ps/goodBadChange/info?id=${goodBadChange.id}'">详情</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <%--<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">--%>
                                                <%--<li><a href="${ctx}/lgt/ps/goodBadChange/delete?id=${goodBadChange.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该好坏货调动记录吗？',this.href)">删除</a>--%>
                                                <%--</li>--%>
                                                <%--<li><a href="${ctx}/lgt/ps/goodBadChange/info?id=${goodBadChange.id}" target="">详情</a></li>--%>
                                            <%--</ul>--%>
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
            <div style="display: none;">
		        <form id="hiddenForm" action="${ctx}/lgt/ps/goodBadChange/batchAudit" method="post">
		            <input id="ids" name="ids" type="hidden"/>
		            <input id="changeStatus" name="changeStatus" type="hidden"/>
		        </form>
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
            "columnDefs":[
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

      $("#selAll").on("ifChecked", function() {
          var c = 0;
          $("input[name='selItem']").each(function() {
              if(!$(this).prop('disabled')) {
                  $(this).iCheck('check');
                  c++;
              }
          });
      }).on("ifUnchecked", function() {
          $("input[name='selItem']").each(function() {
              if(!$(this).prop('disabled')) {
                  $(this).iCheck('uncheck');
              }
          });
      });
      
      function exportExcel() {
          $("#searchForm").attr("action", "${ctx}/lgt/ps/goodBadChange/export");
          $("#searchForm").submit();
          $("#searchForm").attr("action", "${ctx}/lgt/ps/goodBadChange/list");
      }
      
      function batchAudit(status) {
          var ids = new Array();
          var c = 0;
          $("input[name='selItem']").each(function() {
              if($(this).prop("checked")) {
                  ids.push($(this).val());
                  c++;
              }
          });
          if(c == 0) {
              ZF.showTip("请先勾选要批量审核的数据","info");
              return false;
          }
          $("#ids").val(ids.join());
          $("#changeStatus").val(status);
          $("#hiddenForm").submit();
      }
   </script>
</body>
</html>