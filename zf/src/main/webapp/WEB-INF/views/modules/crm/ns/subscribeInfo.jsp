<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>订阅管理</title>
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
    
    <form:form id="inputForm" modelAttribute="subscribe" action="${ctx}/crm/ns/subscribe/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>订阅信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>目标ID</strong>
                            <p class="text-primary">
                                ${subscribe.targetId}
                            </p>
                            <hr class="zf-hr">
                            <strong>目标类型</strong>
                            <p class="text-primary">
                                ${subscribe.targetType}
                            </p>
                            <hr class="zf-hr">
                            <strong>目标动作类型</strong>
                            <p class="text-primary">
                                ${subscribe.targetActionType}
                            </p>
                            <hr class="zf-hr">
                            <strong>会员ID</strong>
                            <p class="text-primary">
                                ${subscribe.member.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>消息ID</strong>
                            <p class="text-primary">
                                ${subscribe.notify.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>状态</strong>
                            <p class="text-primary">
                                ${subscribe.status}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${subscribe.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${subscribe.remarks}
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