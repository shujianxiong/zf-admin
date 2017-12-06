<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品变更记录管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/produceItem/">产品变更记录列表</a></small>
            <shiro:hasPermission name="lgt:ps:produceItem:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produceItem/form?id=${produceItem.id}">产品变更记录${not empty produceItem.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="produceItem" action="${ctx}/lgt/ps/produceItem/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">新旧标记</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="newOldFlag" name="newOldFlag" tip="请输入新旧标记" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">旧记录ID</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="oldItem.id" name="oldItem.id" tip="请输入旧记录ID" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">产品编码</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="code" name="code" tip="请输入产品编码" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">属性字符串</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="propertyStr" name="propertyStr" tip="请输入属性字符串" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">SKU属性字符串</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="propertySkuStr" name="propertySkuStr" tip="请输入SKU属性字符串" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">产品原厂编码</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="factoryCode" name="factoryCode" tip="请输入产品原厂编码" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">产品名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入产品名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">风格类型</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="styleType" name="styleType" tip="请输入风格类型" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">产品状态</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="status" name="status" tip="请输入产品状态" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">标准克重</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="standardWeight" name="standardWeight" tip="请输入标准克重" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">采购价</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="pricePurchase" name="pricePurchase" tip="请输入采购价" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">运算成本价</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="priceOperation" name="priceOperation" tip="请输入运算成本价" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">运算加价系数</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="ratioOperation" name="ratioOperation" tip="请输入运算加价系数" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">销售价</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="priceSrc" name="priceSrc" tip="请输入销售价" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">体验费收取比例</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="scaleExperienceFee" name="scaleExperienceFee" tip="请输入体验费收取比例" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">促销特价</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="discountPrice" name="discountPrice" tip="请输入促销特价" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">促销折扣</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="discountScale" name="discountScale" tip="请输入促销折扣" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">促销筛选折扣</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="discountFilterScale" name="discountFilterScale" tip="请输入促销筛选折扣" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">促销筛选生效时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="discountFilterStart" inputName="discountFilterStart" tip="请选择促销筛选生效时间" inputId="discountFilterStartId" isMandatory="true" value="${produceItem.discountFilterStart}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">促销筛选失效时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="discountFilterEnd" inputName="discountFilterEnd" tip="请选择促销筛选失效时间" inputId="discountFilterEndId" isMandatory="true" value="${produceItem.discountFilterEnd}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">是否可购买</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="isBuy" name="isBuy" tip="请输入是否可购买" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">是否可体验</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="isExperience" name="isExperience" tip="请输入是否可体验" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">是否可预购</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="isForebuy" name="isForebuy" tip="请输入是否可预购" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">是否可预约体验</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="isForeexperience" name="isForeexperience" tip="请输入是否可预约体验" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">是否可预约体验日期</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="isForeexperienceDate" name="isForeexperienceDate" tip="请输入是否可预约体验日期" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">销量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="sellNum" name="sellNum" tip="请输入销量" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty produceItem.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="lgt:ps:produceItem:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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