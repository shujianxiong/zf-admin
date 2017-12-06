<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>短信链接模块管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/sl/smsLink/">短信链接模块列表</a></small>
            <shiro:hasPermission name="crm:sl:smsLink:edit">
	            <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/crm/sl/smsLink/form">短信链接模块添加</a>
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
            
            <form:form id="searchForm" modelAttribute="smsLink" action="${ctx}/crm/sl/smsLink/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="type" class="col-sm-3 control-label">类型</label>
                                <div class="col-sm-7">
                                    <sys:selectverify name="type" tip="" verifyType="0" isMandatory="false" dictName="sms_link_type" id="type"></sys:selectverify>
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
                                <th>内容</th>
                                <th>链接</th>
                                <th>参数</th>
                                <th>点击率</th>
                                <th>类型</th>
                                <th>启用状态</th>
                                <th style="display:none;">更新者</th>
                                <th style="display:none;">更新时间</th>
                                <th style="display:none;">备注信息</th>
                                <shiro:hasPermission name="crm:sl:smsLink:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="smsLink" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${smsLink.context}
</td>
                                    <td>
                                        ${smsLink.link}
</td>
                                    <td>
                                        ${smsLink.parameter}
</td>
                                    <td>
                                        ${smsLink.clickRate}
</td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(smsLink.type, 'sms_link_type', '')}</span>
</td>
                                    <td>
                                        <c:if test="${smsLink.activeFlag=='1' }">
                                            <span class="label label-success">${fns:getDictLabel(smsLink.activeFlag, 'yes_no', '')}</span>
                                        </c:if>
                                        <c:if test="${smsLink.activeFlag=='0' }">
                                            <span class="label label-primary">${fns:getDictLabel(smsLink.activeFlag, 'yes_no', '')}</span>
                                        </c:if>
</td>
                                    <td data-hide="true">
                                        ${fns:getUserById(smsLink.updateBy.id).name}
</td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${smsLink.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
</td>
                                    <td data-hide="true">
                                        ${smsLink.remarks}
</td>
                                    <shiro:hasPermission name="crm:sl:smsLink:edit"><td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/crm/sl/smsLink/form?id=${smsLink.id}'">修改</button>
                                            <button type="button"
                                                class="btn btn-sm btn-info dropdown-toggle"
                                                data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <li><a href="${ctx}/crm/sl/smsLink/info?id=${smsLink.id}" target="">详情</a></li>
                                                <c:choose>
                                                    <c:when test="${ smsLink.activeFlag eq '0' }">
                                                        <li><a href="${ctx}/crm/sl/smsLink/delete?id=${smsLink.id}" style="color: #fff" onclick="return ZF.delRow('确定要删除该短信链接模块吗？',this.href)">删除</a>
                                                        </li>
                                                        <li><a href="${ctx}/crm/sl/smsLink/updateUsable?id=${smsLink.id}&activeFlag=1" onclick="return ZF.delRow('确认启用该模板么？',this.href)">启用</a></li>
                                                    </c:when>
                                                    <c:when test="${ smsLink.activeFlag eq '1' }">
                                                        <li><a href="${ctx}/crm/sl/smsLink/toSend?id=${smsLink.id}" target="">群发短信</a>
                                                        </li>
                                                        <li><a href="${ctx}/crm/sl/smsLink/updateUsable?id=${smsLink.id}&activeFlag=0" onclick="return ZF.delRow('确认停用该模板么？',this.href)">停用</a></li>
                                                    </c:when>
                                                </c:choose>
                                                <c:choose>
                                                    <c:when test="${empty smsLink.memberCodes}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li><a href="${ctx}/crm/sl/smsLink/sendMemberList?userCodes=${smsLink.memberCodes}" target="">已发送会员</a></li>
                                                        <li><a href="${ctx}/crm/sl/smsLink/msgList?userCodes=${smsLink.memberCodes}" target="">已发送短信列表</a></li>
                                                    </c:otherwise>
                                                </c:choose>
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
            "order": [[ 4, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
                {"orderable":false,targets:10}
                
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