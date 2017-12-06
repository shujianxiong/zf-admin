<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>快递预约记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            $("#areaName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#areaId").val(list[0].id);
                        $("#areaName").val(list[0].text);
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
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/tn/expressAppointRecord/">快递预约记录列表</a></small>
            <shiro:hasPermission name="lgt:tn:expressAppointRecord:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/lgt/tn/expressAppointRecord/form?id=${expressAppointRecord.id}">快递预约记录${not empty expressAppointRecord.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="expressAppointRecord" action="${ctx}/lgt/tn/expressAppointRecord/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">会员ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="member.id" name="member.id" tip="请输入会员ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">来源订单类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderType" name="orderType" tip="请输入来源订单类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">来源订单ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderId" name="orderId" tip="请输入来源订单ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">预约状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="status" name="status" tip="请输入预约状态" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">预约起始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="appointStartTime" inputName="appointStartTime" tip="请选择预约起始时间" inputId="appointStartTimeId" isMandatory="true" value="${expressAppointRecord.appointStartTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">预约结束时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="appointEndTime" inputName="appointEndTime" tip="请选择预约结束时间" inputId="appointEndTimeId" isMandatory="true" value="${expressAppointRecord.appointEndTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">取件地址ID</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="areaId" path="area.id" />
                                        <form:input id="areaName" path="area.name" htmlEscape="false" maxlength="100" class="form-control zf-input-readonly" placeholder="选择归属区域" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">取件地址</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="areaDetail" name="areaDetail" tip="请输入取件地址" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty expressAppointRecord.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="lgt:tn:expressAppointRecord:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
        <sys:userselect height="550" url="${ctx}/sys/area/treeData"
            width="550" isOffice="true" isMulti="false" title="区域选择"
            id="selectArea"></sys:userselect>
            
    </section>
    </div>
    
</body>
</html>