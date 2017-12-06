<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>好坏货调动记录管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/goodBadChange/">好坏货调动记录列表</a></small>
            <shiro:hasPermission name="lgt:ps:goodBadChange:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/goodBadChange/form?id=${goodBadChange.id}">好坏货调动记录${not empty goodBadChange.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="goodBadChange" action="${ctx}/lgt/ps/goodBadChange/save" method="post" class="form-horizontal">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">货品编码</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="text" id="productCode" name="product.code" class="form-control">
                                            <span class="input-group-btn">
                                                <button type="button" id="stateButton" class="btn btn-info btn-flat">查询状态</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">定损金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="assessmentAmount" name="assessmentAmount" tip="请输入定损金额，两位小数" verifyType="9"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">图片</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="photo" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">货品当前货位</label>
                                    <div class="col-sm-9">
                                        <input id="preWareplace"  type="text"  readonly="readonly" class="form-control"/>
                                    </div>
                                </div>
                                <sys:inputtree id="postWarehouse" 	name="" 				url="${ctx}/lgt/ps/warehouse/warehouseListData" 	postParam="" onchange="warehouseOnchange" 									isQuery="false"	inputWidth="9" labelWidth="2" label="调整后仓库" labelValue="" labelName="" value="" tip="请选择仓库，必填项" title="调整后仓库"></sys:inputtree>
                                <sys:inputtree id="postWarearea" 	name="" 				url="${ctx}/lgt/ps/warearea/wareareaListData" 		postParam="{postName:[\"warehouse.id\"],inputId:[\"postWarehouseId\"]}" 	isQuery="true" 	inputWidth="9" labelWidth="2" label="调整后区域" labelValue="" labelName="" value="" tip="请选择区域，必填项" title="调整后区域"></sys:inputtree>
                                <sys:inputtree id="postWarecounter"	name="" 				url="${ctx}/lgt/ps/warecounter/warecounterListData"	postParam="{postName:[\"warearea.id\"],inputId:[\"postWareareaId\"]}" 		isQuery="true" 	inputWidth="9" labelWidth="2" label="调整后货柜" labelValue="" labelName="" value="" tip="请选择货柜，必填项" title="调整后货柜"></sys:inputtree>
                                <sys:inputtree id="postWareplace" 	name="postWareplace.id"	url="${ctx}/lgt/ps/wareplace/wareplaceListData" 	postParam="{postName:[\"warecounter.id\"],inputId:[\"postWarecounterId\"]}" isQuery="true" 	inputWidth="9" labelWidth="2" label="调整后货位" labelValue="" labelName="" value="" tip="请选择货位，必填项" title="调整后货位"></sys:inputtree>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">变动原因类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify id="reasonType" name="reasonType" dictName="lgt_ps_good_bad_change_reasonType" verifyType="0" tip="请选择变动原因类型"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">责任人</label>
                                    <div class="col-sm-9">
                                        <input type="hidden" id="personLiableId" name="personLiable.id"/>
                                        <sys:inputverify id="personLiableName" name="" tip="请选择责任人" verifyType="0" isSpring="true" isMandatory="false"></sys:inputverify>
                                        <sys:userselect id="personLiable" url="${ctx}/sys/office/userTreeData" isMulti="false" title="人员选择" height="550" width="550"></sys:userselect>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">备注</label>
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
                                <c:if test="${empty goodBadChange.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="lgt:ps:goodBadChange:edit"><button type="button" onclick="formSubmit()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
    </section>
    </div>


    <script>
        $(function(){


            // 设置调后持有人(弹出公司人员选择树)
            $("#personLiableName").on('click',function(){
                personLiableinit({
                    "selectCallBack":function(list){
                        if(list.length>0){
                            $("#personLiableId").val(list[0].id);
                            $("#personLiableName").val(list[0].text);
                        }
                    }
                });
            });


            $('#productCode').change(function () {
                if($(this).val() == ''){
                    resetProductCode();
                    return false;
                }else {
                    ZF.ajax(true, 'get', '${ctx}/lgt/ps/product/code/'+$(this).val(),{}, function (data) {
                        if (data.isNewRecord){
                            ZF.showTip('当前编码不存在，请确认！', 'error');
                            resetProductCode();
                            return false;
                        }else if(data.status =='1' || data.status == '2'){
                            if(data.status == '1'){
                                $('#stateButton').text('正常状态');
                                $('#stateButton').css('background-color', '#00a65a');
                                $('#stateButton').css('border-color', '#00a65a');
                            }else if(data.status == '2') {
                                $('#stateButton').text('锁定状态');
                                $('#stateButton').css('background-color', '#d2d6de');
                                $('#stateButton').css('border-color', '#d2d6de');
                            }
                            if(data.wareplace != null && data.wareplace.code != null && data.wareplace.code != ""){
                                $("#preWareplace").val(data.wareplace.warecounter.warearea.warehouse.code
                                    +"-"+data.wareplace.warecounter.warearea.code
                                    +"-"+data.wareplace.warecounter.code
                                    +"-"+data.wareplace.code);
                            }
                            return false;
                        }else {
                            ZF.showTip('当前货品非锁定或正常状态！', 'error');
                            resetProductCode();
                            return false;
                        }
                    }, function () {
                        ZF.showTip('系统出错，请联系管理员!', 'error');
                        resetProductCode();
                        return false;
                    } );
                }

            });


        });


        // 仓库变动时的方法调用
        function warehouseOnchange(){
            // 清空仓库区域、货柜、货位
            $("#postWareareaId").val("");
            $("#postWareareaName").val("");
            $("#postWarecounterId").val("");
            $("#postWarecounterName").val("");
            $("#postWareplaceId").val("");
            $("#postWareplaceName").val("");
        }
        
        
        function formSubmit() {
            let flag = ZF.formSubmit();
            if (flag){
                if ($('#productCode').val() == ''){
                    ZF.showTip('货品编码不得为空！', 'error');
                    return false;
                }else if($('#postWareplaceId').val() == ''){
                    ZF.showTip('调整后货位不得为空', 'error');
                    return false;
                }else if ($('#personLiableId').val() == ''){
                    ZF.showTip('责任人不得为空', 'error');
                    return false;
                }else {
                    $('#inputForm').submit();
                }
            }
        }


        function resetProductCode() {
            $('#stateButton').text('查询状态');
            $('#stateButton').css('background-color', '#00acd6');
            $('#stateButton').css('border-color', '#00acd6');
            $('#productCode').val('');
            $("#preWareplace").val('');
        }
    </script>


</body>

</html>