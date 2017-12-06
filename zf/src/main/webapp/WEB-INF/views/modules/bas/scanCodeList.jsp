<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>扫描电子码管理</title>
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
			<small class="menu-active"><i class="fa fa-repeat"></i><a
				href="${ctx}/bas/scanCode/">扫描电子码列表</a></small>
			<shiro:hasPermission name="bas:scanCode:edit">
				<small>|</small>
				<small><i class="fa fa-plus"></i><a
					href="${ctx}/bas/scanCode/form">扫描电子码添加</a></small>
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
            
            <form:form id="searchForm" modelAttribute="scanCode" action="${ctx}/bas/scanCode/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">电子码</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="code" id="code" verifyType="0" tip="请输入电子码" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">业务类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="type" tip="请选择业务类型" verifyType="0" dictName="bas_scan_code_type" id="type" isMandatory="false"></sys:selectverify>
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
                                <th>电子码</th>
                                <th>业务类型</th>
                                <th style="display: none;">创建者</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">更新者</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="bas:scanCode:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="scanCode" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
									<td>${scanCode.code}</td>
									<td>${fns:getDictLabel(scanCode.type,'bas_scan_code_type', '')}</td>
									<td data-hide="true">${fns:getUserById(scanCode.createBy.id).name}</td>
									<td data-hide="true"><fmt:formatDate value="${scanCode.createDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td data-hide="true">${fns:getUserById(scanCode.updateBy.id).name}</td>
									<td data-hide="true"><fmt:formatDate value="${scanCode.updateDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td data-hide="true">${fns:abbr(scanCode.remarks, 30)}</td>
									<shiro:hasPermission name="bas:scanCode:edit"><td>
                                       <div class="btn-group zf-tableButton">
                                           <button type="button" class="btn btn-sm btn-info"
                                               onclick="window.location.href='${ctx}/bas/scanCode/form?id=${scanCode.id}'">修改</button>
                                           <button type="button"
                                               class="btn btn-sm btn-info dropdown-toggle"
                                               data-toggle="dropdown">
                                               <span class="caret"></span>
                                           </button>
                                           <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                               <li><a href="${ctx}/bas/scanCode/delete?id=${scanCode.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该扫描电子码吗？',this.href)">删除</a>
                                               </li>
                                               <li><a href="${ctx}/bas/scanCode/info?id=${scanCode.id}" target="">详情</a></li>
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
            "ordering" : false,
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