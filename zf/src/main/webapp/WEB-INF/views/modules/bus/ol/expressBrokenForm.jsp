<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>快递包裹损坏记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            $("#officeName").on("click", function() {
                selectOfficeinit({
                    "selectCallBack" : function(list) {
                        $("#officeId").val(list[0].id);
                        $("#officeName").val(list[0].text);
                    }
                })
            });
            
            $("#areaName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#areaId").val(list[0].id);
                        $("#areaName").val(list[0].text);
                    }
                })
            });
            
            $("#userName").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#userId").val(list[0].id);
                        $("#userName").val(list[0].text);
                    }
                })
            });
            
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i>快递包裹损坏核对</small>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="expressBroken" action="${ctx}/bus/ol/expressBroken/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请核对损坏包裹信息</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            <form:hidden path="returnOrder.id" />
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">退货单编号</label>
                                    <div class="col-sm-9">
                                        <input name="returnOrderNo" readonly="readonly" value="${expressBroken.returnOrder.returnOrderNo}" maxlength="64" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">包裹损坏类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="outsideBrokenType" tip="" verifyType="" isMandatory="false" dictName="bus_ol_express_broken_outsideBrokenType" id="outsideBrokenType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">包裹损坏照片</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="outsideBrokenPhotos" path="outsideBrokenPhotos" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="outsideBrokenPhotos" model="true" selectMultiple="true"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">内包装损坏类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="insideBrokenType" tip="" verifyType="" isMandatory="false" dictName="bus_ol_express_broken_insideBrokenType" id="insideBrokenType"></sys:selectverify>

                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">内包装损坏照片</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="insideBrokenPhotos" path="insideBrokenPhotos" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="insideBrokenPhotos" model="true" selectMultiple="true"></sys:fileUpload>

                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">内包装损坏金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="insideBrokenPrice" name="insideBrokenPrice" tip="请输入内包装损坏金额,限制两位小数" verifyType="9"  isSpring="true" maxlength="8"></sys:inputverify>
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
                                <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
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