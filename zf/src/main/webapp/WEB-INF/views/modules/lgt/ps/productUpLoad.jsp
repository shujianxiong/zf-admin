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
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/product/list">货品列表</a></small>
            <shiro:hasPermission name="lgt:ps:product:edit">
                <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/product/upload?id=${returnProduct.id}">坏货货品图片上传</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="product" action="${ctx}/lgt/ps/product/update" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-success">
                        <div class="box-body">
                            <form:hidden path="id" />
                            <div class="form-group    ">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">上传图片<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="适用于:坏货图片">?</span></label>
                                    <div class="col-sm-8">
                                        <form:hidden id="brokenPhoto" path="brokenPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="brokenPhoto" model="true" selectMultiple="true"></sys:fileUpload>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <c:if test="${empty product.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="lgt:ps:product:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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