<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>购物车产品管理</title>
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
    
    <form:form id="inputForm" modelAttribute="shoppingcartProduce" action="${ctx}/bus/sp/shoppingcartProduce/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>购物车产品信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>ID</strong>
                            <p class="text-primary">
                                ${shoppingcartProduce.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>会员ID</strong>
                            <p class="text-primary">
                                ${shoppingcartProduce.member.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>来源搭配ID</strong>
                            <p class="text-primary">
                                ${shoppingcartProduce.collocation.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品ID</strong>
                            <p class="text-primary">
                                ${shoppingcartProduce.produce.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>产品数量</strong>
                            <p class="text-primary">
                                ${shoppingcartProduce.num}
                            </p>
                            <hr class="zf-hr">
                            <strong>创建者</strong>
                            <p class="text-primary">
                                ${shoppingcartProduce.createBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>创建时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${shoppingcartProduce.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新者</strong>
                            <p class="text-primary">
                                ${shoppingcartProduce.updateBy.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${shoppingcartProduce.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${shoppingcartProduce.remarks}
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