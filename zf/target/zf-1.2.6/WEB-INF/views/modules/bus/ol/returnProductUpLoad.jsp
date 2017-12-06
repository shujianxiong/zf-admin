<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货货品管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/ol/returnProduct/index">退货货品列表</a></small>
            <shiro:hasPermission name="bus:ol:returnProduct:edit">
                <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/returnProduct/form?id=${returnProduct.id}">退货货品图片上传</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="returnProduct" action="${ctx}/bus/ol/returnProduct/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                <label class="col-sm-2 control-label">货品编码</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="code" name="product.code" tip="请输入货品编码" verifyType="99"  isSpring="true" forbidInput="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">损坏类型</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="damageType" tip="请选择损坏类型" verifyType="99" isMandatory="false" dictName="bus_or_repair_order_breakdownType" id="damageType" disabled="true"></sys:selectverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">质检金额</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="decMoney" name="decMoney" tip="请输入质检金额" verifyType="99"  isSpring="true" forbidInput="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">责任人</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="responsibilityType" tip="请选择责任人" verifyType="99" isMandatory="false" dictName="bus_ol_return_product_responsibilityType" id="responsibilityType" disabled="true"></sys:selectverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">上传图片<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="适用于:质检坏货图片">?</span></label>
                                    <div class="col-sm-8">
                                        <form:hidden id="brokenPhotos" path="brokenPhotos" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="brokenPhotos" model="true" selectMultiple="true"></sys:fileUpload>
                                    </div>
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
                                <c:if test="${empty returnProduct.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="bus:ol:returnProduct:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>

        <sys:userselect height="550" url="${ctx}/sys/office/treeData"
                        width="550" isOffice="true" isMulti="false" title="机构选择"
                        id="selectOffice" dataType="Office"></sys:userselect>

        <sys:userselect height="550" url="${ctx}/sys/area/treeData"
                        width="550" isOffice="true" isMulti="false" title="区域选择"
                        id="selectArea"></sys:userselect>

        <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
                        width="550" isOffice="false" isMulti="false" title="人员选择"
                        id="selectUser" ></sys:userselect>

    </section>
</div>
</body>
</html>