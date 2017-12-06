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
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <sys:tip content="${message}"/>
    
    <form:form id="inputForm" modelAttribute="smsLink" action="${ctx}/crm/sl/smsLink/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>短信链接模块信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>内容</strong>
                            <p class="text-primary">
                                ${smsLink.context}
                            </p>
                            <hr class="zf-hr">
                            <strong>链接</strong>
                            <p class="text-primary">
                                ${smsLink.link}
                            </p>
                            <hr class="zf-hr">
                            <strong>参数</strong>
                            <p class="text-primary">
                                ${smsLink.parameter}
                            </p>
                            <hr class="zf-hr">
                            <strong>点击率</strong>
                            <p class="text-primary">
                                ${smsLink.clickRate}
                            </p>
                            <hr class="zf-hr">
                            <strong>类型</strong>
                            <p class="text-primary">
                                ${fns:getDictLabel(smsLink.type, 'sms_link_type', '')}
                            </p>
                            <hr class="zf-hr">
                            <strong>启用状态</strong>
                            <p class="text-primary">
                                <c:if test="${smsLink.activeFlag=='1' }">
                                    <span class="label label-success">${fns:getDictLabel(smsLink.activeFlag, 'yes_no', '')}</span>
                                </c:if>
                                <c:if test="${smsLink.activeFlag=='0' }">
                                    <span class="label label-primary">${fns:getDictLabel(smsLink.activeFlag, 'yes_no', '')}</span>
                                </c:if>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新者</strong>
                            <p class="text-primary">
                                    ${fns:getUserById(smsLink.updateBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${smsLink.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${smsLink.remarks}
                            </p>
                            <hr class="zf-hr">
                        </div>
                        
                        <div class="box-footer">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                                <i class="fa fa-mail-reply"></i>返回
                            </button>
                        </div>
                    </div>
               </div>
            </div>
         </section>
    </form:form>
</div>
</body>
</html>