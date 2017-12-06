<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>免押金活动配置表管理</title>
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
    
    <form:form id="inputForm" modelAttribute="freeDeposit" action="${ctx}/spm/fd/freeDeposit/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>免押金活动配置表信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>名称</strong>
                            <p class="text-primary">
                                ${freeDeposit.name}
                            </p>
                            <hr class="zf-hr">
                            <strong>简介</strong>
                            <p class="text-primary">
                                ${freeDeposit.summary}
                            </p>
                            <hr class="zf-hr">
                            <strong>开始时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${freeDeposit.startTime}" pattern="yyyy-MM-dd"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>结束时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${freeDeposit.endTime}" pattern="yyyy-MM-dd"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>注册名额比例</strong>
                            <p class="text-primary">
                                ${freeDeposit.registerPlaces}
                            </p>
                            <hr class="zf-hr">
                            <strong>总名额</strong>
                            <p class="text-primary">
                                ${freeDeposit.places}
                            </p>
                            <hr class="zf-hr">
                            <strong>初始名额</strong>
                            <p class="text-primary">
                                ${freeDeposit.initPlaces}
                            </p>
                            <hr class="zf-hr">
                            <strong>剩余名额</strong>
                            <p class="text-primary">
                                ${freeDeposit.surplusPlaces}
                            </p>
                            <hr class="zf-hr">
                            <strong>启用状态</strong>
                            <p class="text-primary">
                                <c:choose>
							       <c:when test="${freeDeposit.activeFlag eq '0' }">
							           <span class="label label-primary">${fns:getDictLabel(freeDeposit.activeFlag, 'yes_no', '')}</span>
							       </c:when>
							       <c:when test="${freeDeposit.activeFlag eq '1' }">
							           <span class="label label-success">${fns:getDictLabel(freeDeposit.activeFlag, 'yes_no', '')}</span>
							       </c:when>
							    </c:choose>
                            </p>
                            <hr class="zf-hr">
                            <strong>创建人</strong>
                            <p class="text-primary">
                                ${fns:getUserById(freeDeposit.createBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>创建时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${freeDeposit.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新人</strong>
                            <p class="text-primary">
                                ${fns:getUserById(freeDeposit.updateBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${freeDeposit.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${freeDeposit.remarks}
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