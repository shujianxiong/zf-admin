<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>芝麻信用配置管理</title>
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
    
    <form:form id="inputForm" modelAttribute="zmxy" action="${ctx}/spm/zi/zmxy/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>芝麻信用配置信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <strong>名称</strong>
                            <p class="text-primary">
                                ${zmxy.name}
                            </p>
                            <strong>简介</strong>
                            <p class="text-primary">
                                ${zmxy.summary}
                            </p>
                            <hr class="zf-hr">
                            <strong>分数上限</strong>
                            <p class="text-primary">
                                ${zmxy.scoreMax}
                            </p>
                            <hr class="zf-hr">
                            <strong>分数下限</strong>
                            <p class="text-primary">
                                ${zmxy.scoreMin}
                            </p>
                            <hr class="zf-hr">
                            <strong>押金比例</strong>
                            <p class="text-primary">
                                ${zmxy.depositRate}
                            </p>
                            <hr class="zf-hr">
                            <strong>持续天数</strong>
                            <p class="text-primary">
                                ${zmxy.duration}
                            </p>
                            <hr class="zf-hr">
                            <strong>限定金额</strong>
                            <p class="text-primary">
                                ${zmxy.amount}
                            </p>
                            <hr class="zf-hr">
                            <strong>限制下单数量</strong>
                            <p class="text-primary">
                                ${zmxy.limitOrderNum}
                            </p>
                            <hr class="zf-hr">
                            <strong>启用状态</strong>
                            <p class="text-primary">
                                <c:choose>
							       <c:when test="${zmxy.activeFlag eq '0' }">
							           <span class="label label-primary">${fns:getDictLabel(zmxy.activeFlag, 'yes_no', '')}</span>
							       </c:when>
							       <c:when test="${zmxy.activeFlag eq '1' }">
							           <span class="label label-success">${fns:getDictLabel(zmxy.activeFlag, 'yes_no', '')}</span>
							       </c:when>
							    </c:choose>
                            </p>
                            <hr class="zf-hr">
                            <strong>创建人</strong>
                            <p class="text-primary">
                                ${fns:getUserById(zmxy.createBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>创建时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${zmxy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新人</strong>
                            <p class="text-primary">
                                ${fns:getUserById(zmxy.updateBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${zmxy.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${zmxy.remarks}
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