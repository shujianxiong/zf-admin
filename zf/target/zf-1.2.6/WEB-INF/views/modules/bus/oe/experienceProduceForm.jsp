<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验产品管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/oe/experienceProduce/">体验产品列表</a></small>
            <shiro:hasPermission name="bus:oe:experienceProduce:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/oe/experienceProduce/form?id=${experienceProduce.id}">体验产品${not empty experienceProduce.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="experienceProduce" action="${ctx}/bus/oe/experienceProduce/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">体验单ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="experienceProduce.id" name="experienceProduce.id" tip="请输入体验单ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">产品ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="produce.id" name="produce.id" tip="请输入产品ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="num" name="num" tip="请输入数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">商品标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="goodsTitle" name="goodsTitle" tip="请输入商品标题" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">产品名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="produceName" name="produceName" tip="请输入产品名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">购买价格</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="priceBuy" name="priceBuy" tip="请输入购买价格" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">体验状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="status" name="status" tip="请输入体验状态" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">消费决策（退/买/换购/预购）</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="decisionType" name="decisionType" tip="请输入消费决策（退/买/换购/预购）" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">消费购买单ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="decisionBuyOrder.id" name="decisionBuyOrder.id" tip="请输入消费购买单ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">结算扣减金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="moneySettlementDec" name="moneySettlementDec" tip="请输入结算扣减金额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">结算优惠金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="moneySettlementPre" name="moneySettlementPre" tip="请输入结算优惠金额" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty experienceProduce.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:oe:experienceProduce:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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