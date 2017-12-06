<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验包体验记录管理</title>
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
    
    <form:form id="inputForm" modelAttribute="experiencePackItem" action="${ctx}/spm/ep/experiencePackItem/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>体验包体验记录信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>支付类型（1、免费 2、收费）</strong>
                            <p class="text-primary">
                                ${experiencePackItem.payType}
                            </p>
                            <hr class="zf-hr">
                            <strong>支付时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${experiencePackItem.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>支付人openid</strong>
                            <p class="text-primary">
                                ${experiencePackItem.openid}
                            </p>
                            <hr class="zf-hr">
                            <strong>支付返回结果</strong>
                            <p class="text-primary">
                                ${experiencePackItem.returnResult}
                            </p>
                            <hr class="zf-hr">
                            <strong>启用日期</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${experiencePackItem.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>结束日期</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${experiencePackItem.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${experiencePackItem.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${experiencePackItem.remarks}
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