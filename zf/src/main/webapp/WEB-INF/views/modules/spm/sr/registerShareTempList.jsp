<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>邀请注册模板管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/sr/registerShareTemp/">邀请注册模板列表</a></small>
            
            <shiro:hasPermission name="spm:sr:registerShareTemp:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/spm/sr/registerShareTemp/form">邀请注册模板添加</a></small></shiro:hasPermission>
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
            
            <form:form id="searchForm" modelAttribute="registerShareTemp" action="${ctx}/spm/sr/registerShareTemp/" method="post" class="form-horizontal">
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
                                <label for="name" class="col-sm-3 control-label">使用状态</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="tempStatus" tip="请选择使用状态" isMandatory="false" verifyType="0" dictName="spm_sr_tempStatus" id="tempStatus"></sys:selectverify>
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
                                <th>使用状态</th>
                                <th>奖励金额</th>
                                <th>启用时间</th>
                                <th>有效时间（天）</th>
                                <th>邀请奖励类型</th>
                                <th>分享URL</th>
                                <th>分享标题</th>
                                <th>分享简介</th>
                                <th>分享ICON</th>
                                <th>分享广告图</th>
                                <th>分享背景色</th>
                                <th style="display: none;">规则说明</th>
                                <th style="display: none;">活动说明</th>
                                <th style="display: none;">创建人</th>
                                <th style="display: none;">创建时间</th>
                                <th style="display: none;">更新人</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注</th>
                                <shiro:hasPermission name="spm:sr:registerShareTemp:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="registerShareTemp" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
										<td>${registerShareTemp.name}</td>
										<td>
										  <span class="label label-primary">${fns:getDictLabel(registerShareTemp.tempStatus, 'spm_sr_tempStatus', '')}</span>
										</td>
										<td>${registerShareTemp.rewardAmount}</td>
										<td><fmt:formatDate
												value="${registerShareTemp.activeStartTime}"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>${registerShareTemp.activeDays}</td>
										<td>
										  <span class="label label-primary">${fns:getDictLabel(registerShareTemp.rewardType, 'spm_sr_register_rewardType', '')}</span>
										</td>
										<td>${registerShareTemp.shareUrl}</td>
										<td title="${registerShareTemp.shareTitle }">${fns:abbr(registerShareTemp.shareTitle, 15)}</td>
										<td title="${registerShareTemp.shareSummary }">${fns:abbr(registerShareTemp.shareSummary, 15)}</td>
										<td>
										  <img onerror="imgOnerror(this);"  src="${imgHost }${registerShareTemp.shareIcon}" data-big data-src="${imgHost }${registerShareTemp.shareIcon}" width="20px" height="20px"/>
										</td>
										<td>
										  <img onerror="imgOnerror(this);"  src="${imgHost }${registerShareTemp.sharePhoto}" data-big data-src="${imgHost }${registerShareTemp.sharePhoto}" width="20px" height="20px"/>
										</td>
										<td>${registerShareTemp.shareColor}</td>
										<td data-hide="true">${fns:abbr(registerShareTemp.ruleExplain, 15)}</td>
										<td data-hide="true">${fns:abbr(registerShareTemp.activeExplain, 15)}</td>
										
										<td data-hide="true">${fns:getUserById(registerShareTemp.createBy.id).name}</td>
                                        <td data-hide="true"><fmt:formatDate
                                                value="${registerShareTemp.createDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                        <td data-hide="true">${fns:getUserById(registerShareTemp.updateBy.id).name}</td>
                                        <td data-hide="true"><fmt:formatDate
                                                value="${registerShareTemp.updateDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                        <td data-hide="true">${registerShareTemp.remarks}</td>
										
										<shiro:hasPermission name="spm:sr:registerShareTemp:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/spm/sr/registerShareTemp/form?id=${registerShareTemp.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/spm/sr/registerShareTemp/delete?id=${registerShareTemp.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该邀请注册模板吗？',this.href)">删除</a>
                                                </li>
                                                <li><a href="${ctx}/spm/sr/registerShareTemp/info?id=${registerShareTemp.id}" target="">详情</a></li>
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
                {"orderable":false,targets:7},
                {"orderable":false,targets:8},
                {"orderable":false,targets:9},
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15},
                {"orderable":false,targets:16},
                {"orderable":false,targets:17},
                {"orderable":false,targets:18},
                {"orderable":false,targets:19},
                {"orderable":false,targets:20}
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