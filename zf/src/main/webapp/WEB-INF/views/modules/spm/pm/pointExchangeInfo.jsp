<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>积分商品兑换记录管理</title>
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
    
    <form:form id="inputForm" modelAttribute="pointExchange" action="${ctx}/spm/pm/pointExchange/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>积分商品兑换记录信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>兑换流水号</strong>
                            <p class="text-primary">
                                ${pointExchange.serialNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>会员ID</strong>
                            <p class="text-primary">
                                ${pointExchange.member.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>积分商品ID</strong>
                            <p class="text-primary">
                                ${pointExchange.pointGoods.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>兑换状态</strong>
                            <p class="text-primary">
                                ${pointExchange.status}
                            </p>
                            <hr class="zf-hr">
                            <strong>消耗积分</strong>
                            <p class="text-primary">
                                ${pointExchange.point}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新者</strong>
                            <p class="text-primary">
                                ${pointExchange.updateBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${pointExchange.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${pointExchange.remarks}
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