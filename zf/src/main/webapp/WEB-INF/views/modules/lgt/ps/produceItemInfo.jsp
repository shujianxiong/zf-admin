<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品变更记录管理</title>
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
    
    <form:form id="inputForm" modelAttribute="produceItem" action="${ctx}/lgt/ps/produceItem/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>产品变更记录信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>新旧标记</strong>
                            <p class="text-primary">
                                ${produceItem.newOldFlag}
                            </p>
                            <hr class="zf-hr">
                            <strong>旧记录ID</strong>
                            <p class="text-primary">
                                ${produceItem.oldItem.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品编码</strong>
                            <p class="text-primary">
                                ${produceItem.code}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品原厂编码</strong>
                            <p class="text-primary">
                                ${produceItem.factoryCode}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品名称</strong>
                            <p class="text-primary">
                                ${produceItem.name}
                            </p>
                            <hr class="zf-hr">
                            <strong>风格类型</strong>
                            <p class="text-primary">
                                ${produceItem.styleType}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品状态</strong>
                            <p class="text-primary">
                                ${produceItem.status}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${produceItem.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${produceItem.remarks}
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