<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>优惠券管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/ci/coupon/">优惠券列表</a></small>
            <shiro:hasPermission name="spm:ci:coupon:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/ci/coupon/form?id=${coupon.id}">优惠券${not empty coupon.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="coupon" action="${ctx}/spm/ci/coupon/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">模板ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="couponTemplate.id" name="couponTemplate.id" tip="请输入模板ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">优惠券名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入优惠券名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">优惠券编码</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="code" name="code" tip="请输入优惠券编码" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">优惠券状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="status" name="status" tip="请输入优惠券状态（0未发1已发2已用）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">可用起始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="startTime" inputName="startTime" tip="请选择可用起始时间" inputId="startTimeId" isMandatory="true" value="${coupon.startTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">可用截止时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="endTime" inputName="endTime" tip="请选择可用截止时间" inputId="endTimeId" isMandatory="true" value="${coupon.endTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">优惠类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="type" name="type" tip="请输入优惠类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">达标金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="reachMoney" name="reachMoney" tip="请输入达标金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">扣减金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="decreaseMoney" name="decreaseMoney" tip="请输入扣减金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">打折比例</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="discountScale" name="discountScale" tip="请输入打折比例" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">打折金额上限</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="discountMoneyMax" name="discountMoneyMax" tip="请输入打折金额上限" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">所属会员ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="member.id" name="member.id" tip="请输入所属会员ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">领取方式</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="receiveType" name="receiveType" tip="请输入领取方式（兑换/发放）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">领取时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="receiveTime" inputName="receiveTime" tip="请选择领取时间" inputId="receiveTimeId" isMandatory="true" value="${coupon.receiveTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">使用订单ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="useHireOrder.id" name="useHireOrder.id" tip="请输入使用订单ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">使用扣减金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="useDecMoney" name="useDecMoney" tip="请输入使用扣减金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">使用时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="useTime" inputName="useTime" tip="请选择使用时间" inputId="useTimeId" isMandatory="true" value="${coupon.useTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">备注信息</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                            
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <c:if test="${empty coupon.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:ci:coupon:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
    </section>
    </div>
    
</body>
</html>