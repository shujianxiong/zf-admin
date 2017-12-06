<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>货品编码变动记录管理</title>
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
                <div class="col-md-4">
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>货品名称</b> 
                                    <a class="pull-right">${productCodeChange.product.produce.goods.name}&nbsp;&nbsp;${productCodeChange.product.produce.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>调前货品编号</b> 
                                    <a class="pull-right">${productCodeChange.preProductCode}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>调后货品编号</b> 
                                    <a class="pull-right">${productCodeChange.postProductCode}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>变更原因</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(productCodeChange.reasonType, 'lgt_ps_product_code_change_reasonType', '无')}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>创建人</b> 
                                    <a class="pull-right">${fns:getUserById(productCodeChange.createBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>创建时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${productCodeChange.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>更新人</b> 
                                    <a class="pull-right">${fns:getUserById(productCodeChange.updateBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${productCodeChange.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${productCodeChange.remarks}</a>
                                </li>
                            </ul>
                        </div>
                        
                        <div class="box-footer">
                                <button type="button" class="btn btn-default btn-sm"
                                    onclick="javascript:history.go(-1)">
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