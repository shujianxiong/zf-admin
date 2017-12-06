<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搜索热词管理</title>
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
    
    <form:form id="inputForm" modelAttribute="seHotWord" action="${ctx}/idx/se/seHotWord/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>搜索热词信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>热词名称</strong>
                            <p class="text-primary">
                                ${seHotWord.name}
                            </p>
                            <hr class="zf-hr">
                            <strong>热词类型（商品场景范）</strong>
                            <p class="text-primary">
                                <span class="label label-primary">${fns:getDictLabel(seHotWord.type, 'idx_se_hot_word_type', '')}</span>
                            </p>
                            <hr class="zf-hr">
                            <strong>关联关键词</strong>
                            <p class="text-primary">
                                ${seHotWord.relateKeywords}
                            </p>
                            <hr class="zf-hr">
                            <strong>排列序号</strong>
                            <p class="text-primary">
                                ${seHotWord.orderNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>点击量</strong>
                            <p class="text-primary">
                                ${seHotWord.clickNum}
                            </p>
                            <hr class="zf-hr">
                            <strong>是否启用</strong>
                            <p class="text-primary">
                                <span class="label label-primary">${fns:getDictLabel(seHotWord.usableFlag, 'yes_no', '')}</span>
                            </p>
                            <hr class="zf-hr">
                            <strong>创建者</strong>
                            <p class="text-primary">
                                ${fns:getMemberById(seHotWord.createBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>创建时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${seHotWord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>更新者</strong>
                            <p class="text-primary">
                                ${fns:getMemberById(seHotWord.updateBy.id).name}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${seHotWord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${seHotWord.remarks}
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