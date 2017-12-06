<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品评价管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
            
        </section>
        <section class="invoice">
            <p class="lead">基本信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">会员账号</th>
                        <td>${produceJudge.member.usercode }</td>
                    </tr>
                    <tr>
                        <th width="10%">订单编号</th>
                        <td>${produceJudge.experienceOrder.orderNo }</td>
                    </tr>
                    <tr>
                        <th width="10%">商品名称</th>
                        <td>${produceJudge.goods.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">产品规格</th>
                        <td>${produceJudge.produce.name}</td>
                    </tr>
                    <tr>
                        <th width="10%">产品评价等级</th>
                        <td><span class="label label-primary">${fns:getDictLabel(produceJudge.produceLevel, 'bus_pj_produce_judge_level', '' )}</span></td>
                   </tr>
                   <tr>
                        <th width="10%">物流评价等级</th>
                        <td><span class="label label-primary">${fns:getDictLabel(produceJudge.expressLevel, 'bus_pj_produce_judge_level', '' )}</span></td>
                   </tr>
                   <tr>
                        <th width="10%">服务评价等级</th>
                        <td><span class="label label-primary">${fns:getDictLabel(produceJudge.serviceLevel, 'bus_pj_produce_judge_level', '' )}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">审核状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(produceJudge.checkStatus, 'check_status','') }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">审核人</th>
                        <td>${fns:getUserById(produceJudge.checkBy.id).name }</td>
                    </tr>
                    <tr>
                        <th width="10%">审核时间</th>
                        <td><fmt:formatDate value="${produceJudge.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                    </tr>
                    <tr>
                        <th width="10%">评价摘要</th>
                        <td colspan="5">
                            <c:forEach items="${produceJudge.summaryList}" var="summary">
                                <span class="label label-primary">${summary.name }</span>&nbsp;&nbsp;                 
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th width="10%">评价图片</th>
                        <td colspan="5">
                            <c:forEach items="${produceJudge.photoList}" var="photo">
                                <img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${photo.photoUrl }" alt="icon">                                
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${produceJudge.remarks}</p></td>
                    </tr>
                </table>
            </div>
            <div class="row no-print">
                <div class="col-xs-12">
                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                </div>
            </div>
        </section>
</div>
</body>
</html>