<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>消息管理</title>
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
    
    <form:form id="inputForm" modelAttribute="notify" action="${ctx}/crm/ns/notify/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>消息信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>类型</strong>
                            <p class="text-primary">
                                <span class="label label-info">${fns:getDictLabel(notify.type,'crm_ns_notify_type','') }</span>
                            </p>
                            <hr class="zf-hr">
                            <strong>目标类型</strong>
                            <p class="text-primary">
                                ${ not empty notify.remindTargetType ? fns:getDictLabel(notify.remindTargetType,'crm_ns_notify_remindTargetType','') : '无'}
                            </p>
                            <hr class="zf-hr">
                            <strong>目标动作类型</strong>
                            <p class="text-primary">
                                ${ not empty notify.remindTargetAction? fns:getDictLabel(notify.remindTargetAction,'crm_ns_notify_remindTargetAction',''):'无' }
                            </p>
                            <hr class="zf-hr">
                            <strong>编码</strong>
                            <p class="text-primary">
                                ${ not empty notify.messageCode ?notify.messageCode:'无'}
                            </p>
                            <hr class="zf-hr">
                            <strong>标题</strong>
                            <p class="text-primary">
                                ${notify.title}
                            </p>
                            <hr class="zf-hr">
                            <strong>内容</strong>
                            <p class="text-primary">
                                ${notify.content}
                            </p>
                            <hr class="zf-hr">
                            <strong>状态</strong>
                            <p class="text-primary">
                                <c:choose>
                                	<c:when test="${notify.status eq '1' }">
                                		<span class="label label-default">新建</span>
                                	</c:when>
                                	<c:when test="${notify.status eq '2' }">
                                		<span class="label label-primary">未发布</span>
                                	</c:when>
                                	<c:when test="${notify.status eq '3' }">
                                		<span class="label label-success">已发布</span>
                                	</c:when>
                                </c:choose>
                            </p>
                            <hr class="zf-hr">
                            <strong>短信标记</strong>
                            <p class="text-primary">
                                ${fns:getDictLabel(notify.smsFlag,'yes_no','') }
                            </p>
                            <hr class="zf-hr">
                            <strong>创建人</strong>
                            <p class="text-primary">
                                ${fns:getUserById(notify.createBy.id).name }
                            </p>
                            <hr class="zf-hr">
                            <strong>创建时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${notify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新人</strong>
                            <p class="text-primary">
                               ${fns:getUserById(notify.updateBy.id).name }
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${notify.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${notify.remarks}
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