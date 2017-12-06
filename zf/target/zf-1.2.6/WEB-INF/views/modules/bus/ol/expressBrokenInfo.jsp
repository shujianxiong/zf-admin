<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>快递包裹损坏记录管理</title>
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
    
    <form:form id="inputForm" modelAttribute="expressBroken" action="${ctx}/bus/ol/expressBroken/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>快递包裹损坏记录信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>退货单ID</strong>
                            <p class="text-primary">
                                ${expressBroken.returnOrder.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>包裹损坏类型</strong>
                            <p class="text-primary">
                                ${expressBroken.outsideBrokenType}
                            </p>
                            <hr class="zf-hr">
                            <strong>包裹损坏照片</strong>
                            <p class="text-primary">
                                ${expressBroken.outsideBrokenPhotos}
                            </p>
                            <hr class="zf-hr">
                            <strong>内包装损坏类型</strong>
                            <p class="text-primary">
                                ${expressBroken.insideBrokenType}
                            </p>
                            <hr class="zf-hr">
                            <strong>内包装损坏照片</strong>
                            <p class="text-primary">
                                ${expressBroken.insideBrokenPhotos}
                            </p>
                            <hr class="zf-hr">
                            <strong>内包装损坏金额</strong>
                            <p class="text-primary">
                                ${expressBroken.insideBrokenPrice}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${expressBroken.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${expressBroken.remarks}
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