<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>公司资产设备管理</title>
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
				href="${ctx}/cap/cc/capital/">公司资产设备列表</a></small>
			<shiro:hasPermission name="cap:cc:capital:edit">
				<small>|</small>
				<small><i class="fa-form-edit"></i><a
					href="${ctx}/cap/cc/capital/form">公司资产设备添加</a></small>
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
            
            <form:form id="searchForm" modelAttribute="capital" action="${ctx}/cap/cc/capital/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">资产名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" verifyType="0" tip="请输入资产名称" isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">资产类别</label>
                                <div class="col-sm-7">  
                                     <sys:selectverify name="category" tip="请选择" verifyType="0" isMandatory="false" dictName="cap_cc_capital_category" id="category"></sys:selectverify>                                    
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">归属类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="belongType" tip="请选择" verifyType="0" isMandatory="false" dictName="cap_cc_capital_belong_type" id="belongType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">资产状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="capitalStatus" tip="请选择" verifyType="0" isMandatory="false" dictName="cap_cc_capital_capital_status" id="capitalStatus"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">使用状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="useStatus" tip="请选择" verifyType="0" isMandatory="false" dictName="cap_cc_capital_use_status" id="useStatus"></sys:selectverify>
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
                                <th>资产名称</th>
                                <th>资产全称</th>
                                <th>规格型号</th>
                                <th>固定资产编号</th>
                                <th>资产类别</th>
                                <th>资产类型</th>
                                <th>数量</th>
                                <th>单位</th>
                                <th>供应商</th>
                                <th>资产价值</th>
                                <th>购入时间</th>
                                <th>资产图片</th>
                                <th>归属类型</th>
                                <th>资产状态</th>
                                <th>使用状态</th>
                                <th style="display: none;">归属人</th>
                                <th style="display: none;">使用部门</th>
                                <th style="display: none;">使用地点</th>
                                <th style="display: none;">使用员工</th>
                                <th style="display:none;">创建者</th>
                                <th style="display:none;">创建时间</th>
                                <th style="display:none;">更新者</th>
                                <th style="display:none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <shiro:hasPermission name="cap:cc:capital:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="capital" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
										<td>${capital.name}</td>
										<td>${capital.fullName}</td>
										<td>${capital.modelNumber}</td>
										<td>${capital.capitalNo}</td>
										<td>
										  <c:choose>
										      <c:when test="${capital.category eq '1' }"> <!-- 办公用品  -->
										          <span class="label label-primary">${fns:getDictLabel(capital.category, 'cap_cc_capital_category', '')}</span>
										      </c:when>
										      <c:when test="${capital.category eq '2' }"> <!-- 经营 -->
										          <span class="label label-success">${fns:getDictLabel(capital.category, 'cap_cc_capital_category', '')}</span>
										      </c:when>
										      <c:when test="${capital.category eq '3' }"> <!-- 消耗品 -->
                                                  <span class="label label-default">${fns:getDictLabel(capital.category, 'cap_cc_capital_category', '')}</span>
                                              </c:when>
										  </c:choose>
										</td>
										<td>
										  <c:choose>
                                              <c:when test="${capital.type eq '1' }"> <!-- 摄像头 -->
                                                  <span class="label label-default">${fns:getDictLabel(capital.type, 'cap_cc_capital_type', '')}</span>
                                              </c:when>
                                              <c:when test="${capital.type eq '2' }"> <!-- 评价器 -->
                                                  <span class="label label-primary">${fns:getDictLabel(capital.type, 'cap_cc_capital_type', '')}</span>
                                              </c:when>
                                          </c:choose>
										</td>
										<td>${capital.num}</td>
										<td>${capital.unit}</td>
										<td>${capital.supplier}</td>
										<td class="zf-table-money">
										    <span class="text-red">${capital.price}</span>
										</td>
										<td><fmt:formatDate value="${capital.buyDate}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>
										   <img onerror="imgOnerror(this);"  src="${imgHost }${capital.photosUrl}" data-big data-src="${imgHost }${capital.photosUrl}" width="20px" height="20px"/>
									    </td>
										<td>
										  <c:choose>
										      <c:when test="${capital.belongType eq '1' }"> <!-- 公司 -->
										          <span class="label label-success">${fns:getDictLabel(capital.belongType, 'cap_cc_capital_belong_type', '')}</span>
										      </c:when>
										      <c:when test="${capital.belongType eq '2' }"> <!-- 员工 -->
										          <span class="label label-primary">${fns:getDictLabel(capital.belongType, 'cap_cc_capital_belong_type', '')}</span>
										      </c:when>
										      <c:when test="${capital.belongType eq '3' }"> <!-- 不确定 -->
										          <span class="label label-default">${fns:getDictLabel(capital.belongType, 'cap_cc_capital_belong_type', '')}</span>
										      </c:when>
										  </c:choose>
										</td>
										<td>
										    <c:choose>
										        <c:when test="${capital.capitalStatus eq '1' }">  <!-- 正常 -->
										             <span class="label label-success">${fns:getDictLabel(capital.capitalStatus, 'cap_cc_capital_capital_status', '')}</span>
										        </c:when>
										        <c:when test="${capital.capitalStatus eq '2' }">  <!-- 破坏 -->
										          <span class="label label-primary">${fns:getDictLabel(capital.capitalStatus, 'cap_cc_capital_capital_status', '')}</span>
										        </c:when>
										        <c:when test="${capital.capitalStatus eq '3' }">  <!-- 损坏 -->
										          <span class="label label-default">${fns:getDictLabel(capital.capitalStatus, 'cap_cc_capital_capital_status', '')}</span>
										        </c:when>
										    </c:choose>
										</td>
										<td>
										  <c:choose>
										      <c:when test="${capital.useStatus eq '1' }"> <!-- 使用中 -->
										          <span class="label label-primary">${fns:getDictLabel(capital.useStatus, 'cap_cc_capital_use_status', '')}</span>
										      </c:when>
										      <c:when test="${capital.useStatus eq '2' }"> <!-- 闲置 -->
										          <span class="label label-default">${fns:getDictLabel(capital.useStatus, 'cap_cc_capital_use_status', '')}</span>
										      </c:when>
										  </c:choose>
										</td>
										<td data-hide="true">${capital.belongUser.name}</td>
										<td data-hide="true">${capital.useOffice.name}</td>
										<td data-hide="true">${capital.usePlace}</td>
										<td data-hide="true">${capital.useUser.name}</td>
										<td data-hide="true">
	                                        ${fns:getUserById(capital.createBy.id).name}
	                                    </td>
	                                    <td data-hide="true">
	                                        <fmt:formatDate value="${capital.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                    </td>
	                                    <td data-hide="true">
	                                        ${fns:getUserById(capital.updateBy.id).name}
	                                    </td>
	                                    <td data-hide="true">
	                                        <fmt:formatDate value="${capital.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                                    </td>
	                                    <td data-hide="true">
	                                        ${fns:abbr(capital.remarks, 15)}
	                                    </td>
										<shiro:hasPermission name="cap:cc:capital:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/cap/cc/capital/form?id=${capital.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/cap/cc/capital/delete?id=${capital.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该公司资产设备吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="#this" onclick="window.location.href='${ctx}/cap/cc/capitalChange/form?vid=${capital.id }'"">资产变动添加</a></li>
                                                <li><a href="${ctx}/cap/cc/capital/info?id=${capital.id}" target="">详情</a></li>
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
            "order": [[ 7, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6}, 
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15},
                {"orderable":false,targets:16},
                {"orderable":false,targets:17},
                {"orderable":false,targets:18},
                {"orderable":false,targets:19},
                {"orderable":false,targets:20},
                {"orderable":false,targets:21},
                {"orderable":false,targets:22},
                {"orderable":false,targets:23},
                {"orderable":false,targets:24},
                {"orderable":false,targets:25}
                
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