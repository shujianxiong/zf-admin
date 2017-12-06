<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>评价摘要管理</title>
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
                                    <b>名称</b> 
                                    <a class="pull-right">${summary.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(summary.type, 'bus_pj_summary_type', '')}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>所属等级</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(summary.level, 'bus_pj_produce_judge_level', '') }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>启用状态</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(summary.activeFlag, 'yes_no', '')}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>创建人</b> 
                                    <a class="pull-right">${fns:getUserById(summary.createBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>创建时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${summary.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>更新人</b> 
                                    <a class="pull-right">${fns:getUserById(summary.updateBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${summary.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${summary.remarks}</a>
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