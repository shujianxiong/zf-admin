<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>实时金价管理</title>
    <meta name="decorator" content="adminLte"/>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
			<small><i class="fa-list-style"></i><a
				href="${ctx}/bas/gold/basGoldPriceGather/">实时金价列表</a></small>
			<shiro:hasPermission name="bas:gold:basGoldPriceGather:edit">
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/bas/gold/basGoldPriceGather/form?id=${basGoldPriceGather.id}">实时金价${not empty basGoldPriceGather.id?'修改':'添加'}</a></small>
			</shiro:hasPermission>
		</h1>
    <!--</section>-->
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="basGoldPriceGather" action="${ctx}/bas/gold/basGoldPriceGather/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">显示名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入显示名称，必填项" verifyType="0" isMandatory="true"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">采集类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="priceType" tip="请选择采集类型，必选项" verifyType="0" dictName="bas_gold_price_gather_priceType" id="priceType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">价格</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="price" name="price" tip="请输入价格，必填项" verifyType="9" isMandatory="true"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">获取时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="gatherTime" inputName="gatherTime" tip="请选择获取时间，必选项" inputId="gatherTimeId" isMandatory="true" value="${basGoldPriceGather.gatherTime}"></sys:datetime>
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
                                <c:if test="${not empty basGoldPriceGather.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bas:gold:basGoldPriceGather:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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