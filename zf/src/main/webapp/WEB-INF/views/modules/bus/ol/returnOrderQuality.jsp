<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货单管理</title>
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
    <section class="content-header">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/ol/returnOrder/list">回货质检</a></small>
            <small>|</small>
            <shiro:hasPermission name="bus:ol:returnOrder:edit"><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/returnOrder/toQuality?id=${returnOrder.id}&returnOrderNo=${returnOrder.returnOrderNo}">&nbsp;退货单质检</a></small></shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="content-wrapper sub-content-wrapper">
            <div class="row">
                <div class="col-md-12">
                    <form:form id="inputForm" name="inputForm" modelAttribute="returnOrder" action="" method="post" class="form-horizontal" >
                        <div class="box box-success">
                            <div class="box-header with-border zf-query">

                            </div>
                            <form:hidden path="orderId"/>
                            <form:hidden path="id"/>
                            <form:hidden path="status"/>
                            <div class="box-body">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label  class="col-sm-2 control-label">回货单号</label>
                                        <div class="col-sm-8">
                                            <input name="returnOrderNo" readonly="readonly" value="${returnOrder.returnOrderNo}" maxlength="64" class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label  class="col-sm-2 control-label">质检人</label>
                                        <div class="col-sm-8">
                                            <form:hidden id="qcUserId" path="checkBy.id" />
                                            <form:input id="qcUserName" path="checkBy.name"
                                                        htmlEscape="false" maxlength="100" class="form-control zf-input-readonly"
                                                        placeholder="请选择质检人" readonly="true"/>
                                            <sys:userselect id="selectUser" url="${ctx}/sys/office/userTreeData" height="550" width="550" isOffice="false" isMulti="false" title="人员选择"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box box-success">
                            <div class="box-header with-border zf-query">
                                <h5>退货货品设置列表</h5>
                            </div>
                            <div class="box-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                                        <thead>
                                        <tr>
                                            <th>货品编码</th>
                                            <th>货品图片</th>
                                            <th>货品名称</th>
                                            <th>损坏问题描述</th>
                                            <th>损坏类型</th>
                                            <th>损坏金额</th>
                                            <th>责任人类型</th>
                                            <th>备注</th>
                                        </tr>
                                        </thead>
                                        <tbody id="tBody">
                                        <c:forEach items="${returnOrder.returnProductList}" var="returnProduct" varStatus="status">
                                            <form:hidden path="returnProductList[${status.index}].returnProduce.id" />
                                            <form:hidden path="returnProductList[${status.index}].id" />
                                            <form:hidden path="returnProductList[${status.index}].product.produce.id" />
                                            <form:hidden path="returnProductList[${status.index}].product.id" />
                                            <tr>
                                                <input type="hidden" name="produceId" value="${returnProduct.product.produce.id}">
                                                <td>
                                                        ${returnProduct.product.code }
                                                </td>
                                                <td>
                                                    <img onerror="imgOnerror(this);"  src="${imgHost }${returnProduct.product.goods.samplePhoto}" data-big data-src="${imgHost }${returnProduct.product.goods.samplePhoto}" width="21" height="21" />
                                                </td>
                                                <td>
                                                        ${returnProduct.product.goods.name}
                                                </td>
                                                <td>
                                                    <sys:selectverify  name="returnProductList[${status.index}].problemDescription" tip="请选择" verifyType="99" dictName="bus_or_repair_order_breakdownType_description" id="problemDescription"></sys:selectverify>
                                                </td>
                                                <td>
                                                    <form:select data-item="item" onchange="selectDamage(this.options[this.options.selectedIndex].value,'${status.index}','${returnProduct.priceSrc}')" path="returnProductList[${status.index}].damageType" data-verify="false" htmlEscape="false" maxlength="50" class="form-control select2" disabled="false">
                                                        <form:option value="" label="请选择"/>
                                                        <form:options items="${fns:getDictList('bus_or_repair_order_breakdownType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                                    </form:select>
                                                </td>
                                                <td>
                                                    <input placeholder="请输入金额,两位小数"  id="decMoney${status.index}" type="text" data-verify="false" maxlength="5" data-type="item" name="returnProductList[${status.index}].decMoney"
                                                           class="form-control" value="${returnProduct.decMoney}"/>
                                                </td>
                                                <td>
                                                    <sys:selectverify  name="returnProductList[${status.index}].responsibilityType" tip="请选择" verifyType="99" dictName="bus_ol_return_product_responsibilityType" id="responsibilityType"></sys:selectverify>
                                                </td>
                                                <td>
                                                    <input id="remarks${status.index}" type="text" data-verify="false" maxlength="100" data-type="item" name="returnProductList[${status.index}].remarks"
                                                           class="form-control" value="${returnProduct.remarks}"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="box-footer">
                                <div class="pull-left box-tools">
                                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                                </div>

                                <div class="pull-right box-tools">
                                    <shiro:hasPermission name="bus:ol:returnOrder:edit"><button type="button" name="Button" onclick="submit1()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>质检保存</button></shiro:hasPermission>
                                </div>

                                <div class="pull-right box-tools">
                                    <shiro:hasPermission name="bus:ol:returnOrder:edit"><button type="button"  name="Submit2" class="btn btn-info btn-sm" onclick="hang()"><i class="fa fa-save"></i>挂起</button> &nbsp; &nbsp; &nbsp;</shiro:hasPermission>
                                </div>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </section>
</div>
<script type="text/javascript">
    var damage;
    $(function() {
        ZF.bigImg();
        $("#qcUserName").on("click", function() {
            selectUserinit({
                "selectCallBack" : function(list) {
                    $("#qcUserId").val(list[0].id);
                    $("#qcUserName").val(list[0].text);
                }
            })
        });

    });
    function selectDamage(v,index,priceSrc) {
        damage = v;
        ajax('${ctx}/bus/ol/returnOrder/getRateBreak?breakdownType='+v,'post',{},function(data){
            //var obj = eval("("+data+")"); //转换为json对象
            var price = data.moneyLossPercent*priceSrc;
            if(data.moneyLossPercent == undefined){
                price="";
            }else{
                price = price.toFixed(4);
            }
            var decName ="#decMoney"+index;
            $(decName).val(price)
        });

    }
    function ajax(url,postType,postData,callBack){
        $.ajax({
            url:url,
            data:postData,//memberId 当前用户ID
            type:postType,
            dataType:'json',
            success:callBack
        });
    }
    function hang() {
        var arr = new Array();
        var i =0;
        var submit = true;
        $('[data-item="item"]').each(function()
        {
            $(this).parent()
            arr[i] =$(this).val();
            i++;
        });
        $('[id="responsibilityType"]').each(function()
        {
            var str =$(this).val();
            if(str == undefined || str == ""){
                ZF.showTip("请选择责任人类型","danger");
                submit =false;
                return false;
            }
        });
        if($.inArray("3", arr) == -1 && $.inArray("5", arr) == -1){
            ZF.showTip("损坏类型必须是换新或者遗失才能挂起","danger");
            return false;
        }else if(submit){
            document.inputForm.action="${ctx}/bus/ol/returnOrder/hang";
            document.inputForm.submit();
        }
    }
    function submit1() {
        var serviceApplyList = ${serviceApplyList};
        var arr = new Array();
        let produceIds = [];
        var map ={};
        var j =0;
        $('[data-item="item"]').each(function()
        {
            produceIds.push($(this).parent().parent().children('input').val());
            arr[j] =$(this).val();
            j++;
        });
        for(var i=0;i<produceIds.length;i++){
            if(!map[produceIds[i]]){
                map[produceIds[i]] = 1;
            }else{
                map[produceIds[i]]++;
            }
        }
        if($.inArray("3", arr) == 1 ){
            ZF.showTip("损坏类型存在换新或者遗失不能质检保存，需挂起","danger");
            return false;
        }
        if($.inArray("5", arr) == 1 && serviceApplyList.length > 0){
            for(var k = 0;k < serviceApplyList.length;k++){
                if(map[serviceApplyList[k].orderProduceId] != serviceApplyList[k].orderProduceNum){
                    ZF.showTip("损坏类型存在遗失,且用户报备与质检结果不服，需挂起","danger");
                    return false;
                }
            }
            if(map.length != serviceApplyList.length){
                ZF.showTip("损坏类型存在遗失,且用户报备数量与质检结果不服，需挂起","danger");
                return false;
            }
        }else if($.inArray("5", arr) == 1 && serviceApplyList.length == 0){
            ZF.showTip("损坏类型存在遗失,且用户没有报备不能质检保存，需挂起","danger");
            return false;
        }
        var qcUserName=  $("#qcUserName").val();
        var submit = true;
        if(qcUserName ==null || qcUserName == ""){
            ZF.showTip("请选择质检人","danger");
            return false;
        }
        $('#responsibilityType').each(function()
        {
            var str =$(this).val();
            if(str == undefined || str == ""){
                ZF.showTip("请选择责任人类型","danger");
                submit = false;
                return false;
            }
        });
        if(submit){
            document.inputForm.action="${ctx}/bus/ol/returnOrder/batchSave";
            document.inputForm.submit();
        }
    }
</script>
</body>
</html>