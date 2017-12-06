<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>服务申请管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/ser/sa/serviceApply/">服务申请列表</a></small>
            <shiro:hasPermission name="ser:sa:serviceApply:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/ser/sa/serviceApply/form?id=${serviceApply.id}">服务申请处理</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <div class="content">
        <form:form id="inputForm" modelAttribute="serviceApply" action="${ctx}/ser/sa/serviceApply/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
            <form:hidden path="id"/>
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5 class="box-title">申请单基本信息</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">服务单编号</label>
                                        <div class="col-sm-8">
                                            <form:input path="no" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">来源订单类型</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="orderType" tip="" verifyType="99" isMandatory="false" dictName="bus_order_type" id="orderType" disabled="true"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group">
                                      <label class="col-sm-3 control-label">订单号</label>
                                      <div class="col-sm-8">
                                          <form:input path="experienceOrder.orderNo" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                      </div>
                                  </div>
                              </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">申请时机类型</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="applyTimeType" tip="" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_applyTimeType" id="applyTimeType" disabled="true"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">申请处理类型</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="applyDealType" tip="" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_applyDealType" id="applyDealType" disabled="true"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">申请原因类型</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="applyReasonType" tip="" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_applyReasonType" id="applyReasonType" disabled="true"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">状态</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="status" tip="" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_status" id="status" disabled="true"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">申请原因说明</label>
                                        <div class="col-sm-8">
                                            <form:input path="applyRemarks" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">申请人类型</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="applyByType" tip="" verifyType="99" isMandatory="false" dictName="operater_type" id="applyByType" disabled="true"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">申请人</label>
                                        <div class="col-sm-8">
                                            <c:if test="${serviceApply.applyByType eq 'M'}">
                                                <sys:inputverify id="applyById" name="applyById" forbidInput="true" value="${fns:getMemberById(serviceApply.applyById).usercode}" tip="" verifyType="99" isMandatory="false" isSpring="false" maxlength="20"></sys:inputverify>
                                            </c:if>
                                            <c:if test="${serviceApply.applyByType eq 'U'}">
                                                <sys:inputverify id="applyById" name="applyById" forbidInput="true" value="${fns:getUserById(serviceApply.applyById).name}" tip="" verifyType="99" isMandatory="false" isSpring="false" maxlength="20"></sys:inputverify>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">订单类型</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="experienceOrder.type" tip="" verifyType="99" isMandatory="false" dictName="bus_oe_experience_order_type" id="type" disabled="true"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">订单系统状态</label>
                                        <div class="col-sm-8">
                                           <sys:selectverify name="experienceOrder.statusSystem" tip="" verifyType="99" isMandatory="false" dictName="bus_oe_experience_order_statusSystem" id="statusSystem" disabled="true"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="row">
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5 class="box-title">产品信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">产品编号</label>
                                        <div class="col-sm-8">
                                           <form:input path="produce.code" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">产品名称</label>
                                        <div class="col-sm-8">
                                            <form:input path="produce.name" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">产品图片</label>
                                        <div class="col-sm-8">
                                            <img onerror="imgOnerror(this);"  src="${imgHost }${serviceApply.produce.goods.samplePhoto}" data-big data-src="${imgHost }${serviceApply.produce.goods.samplePhoto}" width="20px" height="20px" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5 class="box-title">申请人凭证</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table">
                                <c:forEach items="${serviceApply.applyPhotos }" var="img" varStatus="status">
                                    <tr>
                                        <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于客服售后'>图片${(status.index)+1}</span></th>
                                        <td><img onerror="imgOnerror(this);" src="${imgHost }${img}" data-big data-src="${imgHost }${img}" width="50px" height="50px" /></td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5 class="box-title">会员信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">会员名称</label>
                                        <div class="col-sm-8">
                                            <sys:inputverify id="nickname" name="nickname" forbidInput="true" value="${fns:getMemberById(serviceApply.experienceOrder.member.id).nickname}" tip="" verifyType="99" isMandatory="false" isSpring="false" maxlength="20"></sys:inputverify>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">会员账号</label>
                                        <div class="col-sm-8">
                                            <sys:inputverify id="usercode" name="usercode" forbidInput="true" value="${fns:getMemberById(serviceApply.experienceOrder.member.id).usercode}" tip="" verifyType="99" isMandatory="false" isSpring="false" maxlength="20"></sys:inputverify>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">体验次数</label>
                                        <div class="col-sm-8">
                                            <form:input path="experienceNum" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">购买次数</label>
                                        <div class="col-sm-8">
                                            <form:input path="buyNum" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">售后次数</label>
                                        <div class="col-sm-8">
                                            <form:input path="applyNum" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">订单取消次数</label>
                                        <div class="col-sm-8">
                                            <form:input path="applyCancelNum" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5 class="box-title">会员损坏物品类型次数</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <c:forEach items="${serviceApply.damageTypeNumMap}" var="map">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">${fns:getDictLabel(map.key, 'bus_or_repair_order_breakdownType', '')}次数</label>
                                            <div class="col-sm-8">
                                                <input class="form-control" type="text" value="${map.value}" readonly>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5 class="box-title">客服处理</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="col-sm-1 control-label">售后类型</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="dealReasonType" tip="" verifyType="99" isMandatory="false" dictName="ser_sa_service_apply_applyReasonType" id="dealReasonType"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="col-sm-1 control-label">备注</label>
                                        <div class="col-sm-8">
                                            <form:textarea path="dealRemarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <c:if test="${serviceApply.applyTimeType eq '1'}">
                                    <shiro:hasPermission name="ser:sa:serviceApply:edit"><button type="button" class="btn btn-info btn-sm" onclick="refuse('${serviceApply.id}')"><i class="fa fa-save"></i>拒绝</button></shiro:hasPermission>
                                </c:if>
                                <shiro:hasPermission name="ser:sa:serviceApply:edit"><button type="submit" class="btn btn-info btn-sm" ><i class="fa fa-save"></i>通过</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>
   <!--  </section> -->
     </div>
    </div>
    <script type="text/javascript">

        $(function () {
            ZF.bigImg();
        })
        function refuse(id) {
            window.location.href="${ctx}/ser/sa/serviceApply/refuse?id="+id;
        }
    </script>
</body>
</html>