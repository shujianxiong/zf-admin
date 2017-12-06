<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>优惠券管理</title>
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
    
    <form:form id="inputForm" modelAttribute="coupon" action="${ctx}/spm/ci/coupon/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-4">
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            
                             <ul class="list-group list-group-unbordered">
                             
                                <li class="list-group-item">
                                    <b>优惠券名称</b> 
                                    <c:choose>
                                        <c:when test="${coupon.name.length() > 30 }">
                                            <br/>
                                            <a>${coupon.name}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="pull-right">${coupon.name}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>优惠券编码</b> 
                                    <a class="pull-right">${coupon.code}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>优惠类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(coupon.type , 'spm_ci_coupon_type', '')}</span></a>
                                </li>
                                
                                <c:choose>
                                    <c:when test="${coupon.type eq '1' }">
                                        <li class="list-group-item">
		                                    <b>达标金额</b> 
		                                    <a class="pull-right">${coupon.couponTemplate.reachMoney }</a>
		                                </li>
		                                <li class="list-group-item">
                                            <b>扣减金额</b> 
                                            <a class="pull-right">${coupon.couponTemplate.decreaseMoney }</a>
                                        </li>
                                    </c:when>
                                    <c:when test="${coupon.type eq '2' }">
                                        <li class="list-group-item">
                                            <b>扣减金额</b> 
                                            <a class="pull-right">${coupon.couponTemplate.decreaseMoney }</a>
                                        </li>
                                    </c:when>
                                    <c:when test="${coupon.type eq '3' }">
                                        <li class="list-group-item">
                                            <b>打折比例</b> 
                                            <a class="pull-right">${coupon.couponTemplate.discountScale }</a>
                                        </li>
                                        <li class="list-group-item">
                                            <b>打折金额上限</b> 
                                            <a class="pull-right">${coupon.couponTemplate.discountMoneyMax }</a>
                                        </li>
                                    </c:when>
                                </c:choose>
                                
                                <li class="list-group-item">
                                    <b>可用起始时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${coupon.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>可用截止时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${coupon.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>优惠券状态</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(coupon.status, 'spm_ci_coupon_status', '')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>所属会员</b> 
                                    <a class="pull-right">${fns:getMemberById(coupon.member.id).usercode}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>领取方式</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(coupon.receiveType, 'spm_ci_coupon_receiveType', '')}</span></a>
                                </li>
                                
                                 <li class="list-group-item">
                                    <b>领取时间</b> 
                                    <a class="pull-right"> <fmt:formatDate value="${coupon.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>使用订单号</b> 
                                    <a class="pull-right">${coupon.useBuyOrder}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>使用扣减金额</b> 
                                    <a class="pull-right">${coupon.useDecMoney}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>使用时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${coupon.useTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>更新人</b> 
                                    <a class="pull-right">${fns:getUserById(coupon.updateBy.id).name }</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${coupon.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${coupon.remarks}</a>
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
    </form:form>
</div>
</body>
</html>