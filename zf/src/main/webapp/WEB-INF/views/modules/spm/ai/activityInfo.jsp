<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>活动表管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
    <script>
        $(function () {
            ZF.bigImg();
        });
    </script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <sys:tip content="${message}"/>
    
    <form:form id="inputForm" modelAttribute="activity" action="${ctx}/spm/ai/activity/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>活动表信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>编码</strong>
                            <p class="text-primary">
                                ${activity.code}
                            </p>
                            <hr class="zf-hr">
                            <strong>名称</strong>
                            <p class="text-primary">
                                ${activity.name}
                            </p>
                            <hr class="zf-hr">
                            <strong>类型</strong>
                            <p class="text-primary">
                                <span class="label label-primary">${fns:getDictLabel(activity.type, 'spm_ai_activity_type', '')}</span>
                            </p>
                            <hr class="zf-hr">
                            <strong>标题</strong>
                            <p class="text-primary">
                                ${activity.title}
                            </p>
                            <hr class="zf-hr">
                            <strong>副标题</strong>
                            <p class="text-primary">
                                ${activity.subtitle}
                            </p>
                            <hr class="zf-hr">
                            <strong>简介</strong>
                            <p class="text-primary">
                                ${activity.summary}
                            </p>
                            <hr class="zf-hr">
                            <strong>副标题</strong>
                            <p class="text-primary">
                                ${activity.subtitle}
                            </p>
                            <hr class="zf-hr">
                            <strong>展示图</strong>
                            <p class="text-primary">
                                <img onerror="imgOnerror(this);" src="${imgHost }${activity.displayPhoto}" data-big data-src="${imgHost }${activity.displayPhoto}" width="20px" height="20px" />
                            </p>
                            <hr class="zf-hr">
                            <strong>展示类型</strong>
                            <p class="text-primary">
                                <span class="label label-primary">${fns:getDictLabel(activity.displayType, 'spm_ai_activity_displayType', '')}</span>
                            </p>
                            <hr class="zf-hr">
                            <strong>介绍</strong>
                            <p class="text-primary">
                                ${activity.introduce}
                            </p>
                            <hr class="zf-hr">
                            <strong>规则详情</strong>
                            <p class="text-primary">
                                ${activity.ruleDetail}
                            </p>
                            <hr class="zf-hr">
                            <strong>人数上限</strong>
                            <p class="text-primary">
                                ${activity.maxNum}
                            </p>
                            <hr class="zf-hr">
                            <strong>起始时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${activity.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>结束时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>启用状态</strong>
                            <p class="text-primary">
                                <c:choose>
                                    <c:when test="${activity.activeFlag eq '0'}">
                                        <span class="label label-primary">否</span>
                                    </c:when>
                                    <c:when test="${activity.activeFlag eq '1'}">
                                        <span class="label label-success">是</span>
                                    </c:when>
                                </c:choose>
                            </p>
                            <hr class="zf-hr">
                            <strong>创建人</strong>
                            <p class="text-primary">
                                ${fns:getUserById(activity.createBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>创建时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${activity.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                ${fns:getUserById(activity.updateBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${activity.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${activity.remarks}
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