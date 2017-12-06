<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>体验包管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/ep/experiencePack/">体验包列表</a></small>
            <shiro:hasPermission name="spm:ep:experiencePack:edit">
                <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/ep/experiencePack/form?id=${experiencePack.id}">体验包${not empty experiencePack.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="experiencePack" action="${ctx}/spm/ep/experiencePack/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                <label class="col-sm-2 control-label">名称</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="name" name="name" tip="请输入名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">类型</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="type" tip="请选择类型" verifyType="0" isMandatory="false" dictName="experience_pack_type" id="type"></sys:selectverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">标题</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="title" name="title" tip="请输入标题，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">背景图<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="体验包">?</span></label>
                                <div class="col-sm-8">
                                    <form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="photo" model="true" selectMultiple="false"></sys:fileUpload>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">简介</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="summary" name="summary" tip="请输入简介" verifyType="0"  isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">价格</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="price" name="price" tip="请输入价格，两位小数" verifyType="9"  isSpring="true" maxlength="8"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">邀请人数</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="persons" name="persons" tip="请输入邀请人数，整数" verifyType="4"  isSpring="true" maxlength="5"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">体验次数</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="times" name="times" tip="请输入体验次数，整数" verifyType="4"  isSpring="true" maxlength="5"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">购买折扣</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="discountScale" name="discountScale" tip="请输入购买折扣，四位小数" verifyType="10"  isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">押金折扣</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="depositScale" name="depositScale" tip="请输入押金折扣，四位小数" verifyType="10"  isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">购买上限</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="buyLimit" name="buyLimit" tip="请输入购买上限，四位小数" verifyType="10"  isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">卡券ID</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="cardId" name="cardId" tip="请输入卡券ID" verifyType="-1"  isSpring="true" isMandatory="false"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">免回程运费</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="expressMoney" tip="请选择" verifyType="0" isMandatory="false" dictName="express_money_type" id="expressMoney"></sys:selectverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">持续时间</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="days" name="days" tip="请输入持续时间，天数" verifyType="4"  isSpring="true" maxlength="8"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">启用状态</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="activeFlag" tip="请选择启用状态" verifyType="0" isMandatory="false" dictName="yes_no" id="activeFlag"></sys:selectverify>
                                </div>
                            </div>
                            <div class="form-group ">
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
                                <c:if test="${empty experiencePack.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:ep:experiencePack:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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