<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>会员签到管理</title>
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
    
    <form:form id="inputForm" modelAttribute="memberSign" action="${ctx}/crm/mi/memberSign/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>会员签到信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>会员ID</strong>
                            <p class="text-primary">
                                ${memberSign.member.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>最后签到日期</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${memberSign.lastSignDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>累计连续签到次数</strong>
                            <p class="text-primary">
                                ${memberSign.timesSeries}
                            </p>
                            <hr class="zf-hr">
                            <strong>累计签到次数</strong>
                            <p class="text-primary">
                                ${memberSign.timesTotal}
                            </p>
                            <hr class="zf-hr">
                            <strong>创建者</strong>
                            <p class="text-primary">
                                ${memberSign.createBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>创建时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${memberSign.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新者</strong>
                            <p class="text-primary">
                                ${memberSign.updateBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${memberSign.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${memberSign.remarks}
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