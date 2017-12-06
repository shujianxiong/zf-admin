<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>帮助中心问题管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>帮助中心问题信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            
                            <strong>类型</strong>
                            <p class="text-primary">
                                <span class="label label-primary">${fns:getDictLabel(question.type, 'ser_hc_question_type', '')}</span>
                            </p>
                            <hr class="zf-hr">
                            <strong>名称</strong>
                            <p class="text-primary">
                                ${question.name}
                            </p>
                            <hr class="zf-hr">
                            <strong>问题</strong>
                            <p class="text-primary">
                                ${question.question}
                            </p>
                            <hr class="zf-hr">
                            <strong>答案</strong>
                            <p class="text-primary">
                                ${question.answer}
                            </p>
                            <hr class="zf-hr">
                            <strong>排列序号</strong>
                            <p class="text-primary">
                                ${question.orderNo}
                            </p>
                            <hr class="zf-hr">
                            <strong>更新时间</strong>
                            <p class="text-primary">
                                <fmt:formatDate value="${question.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                            <hr class="zf-hr">
                            <strong>备注信息</strong>
                            <p class="text-primary">
                                ${question.remarks}
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
</div>
</body>
</html>