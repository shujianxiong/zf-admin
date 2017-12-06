<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>运费模板管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/tf/transportFee/">运费模板列表</a></small>
            <shiro:hasPermission name="lgt:tf:transportFee:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/lgt/tf/transportFee/form?id=${transportFee.id}">运费模板${not empty transportFee.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="transportFee" action="${ctx}/lgt/tf/transportFee/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            
                                <sys:inputtree id="warehouse" name="warehouse.id" verifyType="true" url="${ctx}/lgt/ps/warehouse/warehouseListData" 
                                    inputWidth="9" labelWidth="2" label="调入仓库" 
                                    labelValue="" labelName="warehouse.name" value="" 
                                    tip="请选择发货仓库" title="调入仓库"></sys:inputtree>
                                    
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">收货地区</label>
                                    <div class="col-sm-9">
                                        <sys:cascading name="receiveArea.id" parentIds="${transportFee.receiveArea.parentIds }" provinceList="${provinceList }" cityList="${cityList }" districtList="${districtList }" value="${transportFee.receiveArea.id  }"></sys:cascading>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">快递公司价格</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="costMoney" name="costMoney" tip="请输入快递公司价格" maxlength="4" verifyType="9"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">运费</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="money" name="money" tip="请输入运费" maxlength="4" verifyType="9"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">寄送耗时</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="days" name="days" tip="请输入寄送耗时" verifyType="4" maxlength="2"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">启用状态</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="usableFlag" tip="请选择启用状态" verifyType="0" dictName="yes_no" id="usableFlag"></sys:selectverify>
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
                                <c:if test="${empty transportFee.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="lgt:tf:transportFee:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
            
    </section>
    </div>
    <script type="text/javascript">
    function formSubmit() {
        var flag = ZF.formSubmit();
        $("button[type=submit]").attr('disabled',false);
        if(flag) {
            var province = $("#province").val();
            if(province == null || province == '-1') {
                ZF.showTip("请选择收货地区!", "info");
                return false;
            }
            var city = $("#city").val();
            if(city == null || city == '-1') {
                ZF.showTip("请选择收货地区!", "info");
                return false;
            }
            var district = $("#district").val();
            if(district == null || district == '-1') {
                ZF.showTip("请选择收货地区!", "info");
                return false;
            }
        }
        return flag;
    }
    
    
    </script>
</body>
</html>