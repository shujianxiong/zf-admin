<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>红包分享模板管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/sr/redpacketShareTemp/">红包分享模板列表</a></small>
            
            <shiro:hasPermission name="spm:sr:redpacketShareTemp:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/spm/sr/redpacketShareTemp/form">红包分享模板添加</a></small></shiro:hasPermission>
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
            
            <form:form id="searchForm" modelAttribute="redpacketShareTemp" action="${ctx}/spm/sr/redpacketShareTemp/" method="post" class="form-horizontal">
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
                                <label for="name" class="col-sm-3 control-label">金额类型</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="amountType" tip="请选择红包金额类型" verifyType="0" isMandatory="false" dictName="spm_sr_redpacket_amountType" id="amountType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">使用状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="tempStatus" tip="请选择模板使用状态" verifyType="0" isMandatory="false" dictName="spm_sr_tempStatus" id="tempStatus"></sys:selectverify>
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
                                <th>模板名称</th>
                                <th>金额类型</th>
                                <th>红包金额</th>
                                <th>最大金额</th>
                                <th>最小金额</th>
                                <th>抢红包类型</th>
                                <th>有效时间（天）</th>
                                <th>数量类型</th>
                                <th>数量</th>
                                <th>最大数量</th>
                                <th>最小数量</th>
                                <th>使用状态</th>
                                <th>启用时间</th>
                                <th>红包类型</th>
                                <th style="display: none;">规则说明</th>
                                <th style="display: none;">活动说明</th>
                                <th style="display: none;">创建人</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">更新人</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注</th>
                                <shiro:hasPermission name="spm:sr:redpacketShareTemp:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="redpacketShareTemp" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
										<td>${redpacketShareTemp.name}</td>
										<td>
										  <span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.amountType, 'spm_sr_redpacket_amountType', '')}</span>
										</td>
										<td>${redpacketShareTemp.amount}</td>
										<td>${redpacketShareTemp.maxAmount}</td>
										<td>${redpacketShareTemp.minAmount}</td>
										<td>
										  <span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.shareType, 'spm_sr_redpacket_shareType', '')}</span>
									    </td>
										<td>${redpacketShareTemp.activeDays}</td>
										<td>
										   <span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.numType, 'spm_sr_redpacket_numType', '')}</span>
									    </td>
										<td>${redpacketShareTemp.num}</td>
										<td>${redpacketShareTemp.maxNum}</td>
										<td>${redpacketShareTemp.minNum}</td>
										<td>
										    <span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.tempStatus, 'spm_sr_tempStatus', '')}</span>
										</td>
										<td><fmt:formatDate
												value="${redpacketShareTemp.redpacketStartTime}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>
										   <span class="label label-primary">${fns:getDictLabel(redpacketShareTemp.redpacketType, 'spm_sr_redpacket_redpacketType', '')}</span>
										</td>
										<td data-hide="true">${redpacketShareTemp.ruleExplain}</td>
										<td data-hide="true">${redpacketShareTemp.activeExplain}</td>
										
										<td data-hide="true">${fns:getUserById(redpacketShareTemp.createBy.id).name}</td>
                                        <td data-hide="true"><fmt:formatDate
                                                value="${redpacketShareTemp.createDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                        <td data-hide="true">${fns:getUserById(redpacketShareTemp.updateBy.id).name}</td>
                                        <td data-hide="true"><fmt:formatDate
                                                value="${redpacketShareTemp.updateDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                        <td data-hide="true">${redpacketShareTemp.remarks}</td>
										
										<shiro:hasPermission name="spm:sr:redpacketShareTemp:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/spm/sr/redpacketShareTemp/form?id=${redpacketShareTemp.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/spm/sr/redpacketShareTemp/delete?id=${redpacketShareTemp.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该红包分享模板吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/spm/sr/redpacketShareTemp/info?id=${redpacketShareTemp.id}" target="">详情</a></li>
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
            "order": [[ 3, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:6},
                {"orderable":false,targets:8},
                {"orderable":false,targets:12},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15},
                {"orderable":false,targets:16},
                {"orderable":false,targets:17},
                {"orderable":false,targets:18},
                {"orderable":false,targets:19},
                {"orderable":false,targets:20},
                {"orderable":false,targets:21},
                {"orderable":false,targets:22}
                
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