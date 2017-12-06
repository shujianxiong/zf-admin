<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>供应商信誉分流水管理</title>
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
    
    <form:form id="inputForm" modelAttribute="creditPointDetail" action="${ctx}/lgt/si/creditPointDetail/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>供应商信誉分流水信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>供应商ID</strong>
                            <p class="text-primary">
                                ${creditPointDetail.supplier.id}
                            </p>
                            <hr class="zf-hr">
                            <strong>变动类型（增/减）</strong>
                            <p class="text-primary">
                                ${creditPointDetail.changeType}
                            </p>
                            <hr class="zf-hr">
                            <strong>变动信誉分数量</strong>
                            <p class="text-primary">
                                ${creditPointDetail.changeCreditPoint}
                            </p>
                            <hr class="zf-hr">
                            <strong>变动后信誉分</strong>
                            <p class="text-primary">
                                ${creditPointDetail.lastCreditPoint}
                            </p>
                            <hr class="zf-hr">
                            <strong>变动原因</strong>
                            <p class="text-primary">
                                ${creditPointDetail.changeReasonType}
                            </p>
                            <hr class="zf-hr">
                            <strong>变动时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${creditPointDetail.changeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>操作人类型（员工/系统）</strong>
                            <p class="text-primary">
                                ${creditPointDetail.operaterType}
                            </p>
                            <hr class="zf-hr">
                            <strong>来源业务编号</strong>
                            <p class="text-primary">
                                ${creditPointDetail.operateSourceNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${creditPointDetail.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${creditPointDetail.remarks}
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