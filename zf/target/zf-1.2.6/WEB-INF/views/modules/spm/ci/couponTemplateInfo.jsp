<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>优惠券模板管理</title>
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
                                    <b>模板名称</b> 
                                    <c:choose>
                                        <c:when test="${couponTemplate.name.length() > 30 }">
                                            <br/>
                                            <a>${couponTemplate.name}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="pull-right">${couponTemplate.name}</a>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </li>
                                <li class="list-group-item">
                                    <b>优惠券名称</b> 
                                     <c:choose>
                                        <c:when test="${couponTemplate.couponName.length() > 30 }">
                                            <br/>
                                            <a>${couponTemplate.couponName}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="pull-right">${couponTemplate.couponName}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>可用起始时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${couponTemplate.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>可用截止时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${couponTemplate.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>优惠类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(couponTemplate.couponType, 'spm_ci_coupon_type', '')}</span></a>
                                </li>
                                
                                 <c:choose>
                                    <c:when test="${couponTemplate.couponType eq '1' }">
                                        <li class="list-group-item">
                                            <b>达标金额</b> 
                                            <a class="pull-right">${couponTemplate.reachMoney }</a>
                                        </li>
                                        <li class="list-group-item">
                                            <b>扣减金额</b> 
                                            <a class="pull-right">${couponTemplate.decreaseMoney }</a>
                                        </li>
                                    </c:when>
                                    <c:when test="${couponTemplate.couponType eq '2' }">
                                        <li class="list-group-item">
                                            <b>扣减金额</b> 
                                            <a class="pull-right">${couponTemplate.decreaseMoney }</a>
                                        </li>
                                    </c:when>
                                    <c:when test="${couponTemplate.couponType eq '3' }">
                                        <li class="list-group-item">
                                            <b>打折比例</b> 
                                            <a class="pull-right">${couponTemplate.discountScale }</a>
                                        </li>
                                        <li class="list-group-item">
                                            <b>打折金额上限</b> 
                                            <a class="pull-right">${couponTemplate.discountMoneyMax }</a>
                                        </li>
                                    </c:when>
                                </c:choose>
                                
                                <li class="list-group-item">
                                    <b>已生成数量</b> 
                                    <a class="pull-right">${couponTemplate.numCreated}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>已领取数量</b> 
                                    <a class="pull-right">${couponTemplate.numProvided}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>优惠券介绍</b> 
                                    <br/>
                                    <a>${couponTemplate.introduction}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${couponTemplate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注信息</b> 
                                    <a class="pull-right">${couponTemplate.remarks}</a>
                                </li>
                            </ul>
                            
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