<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>质检工单管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/ser/as/qualityWorkorder/list">质检工单列表</a></small>
            <small>|</small>
            <shiro:hasPermission name="ser:as:qualityWorkorder:edit"><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/ser/as/qualityWorkorder/form?id=${qualityWorkorder.id}">质检工单处理</a></small></shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="content-wrapper sub-content-wrapper">
            <div class="row">
                <div class="col-md-12">
                    <form:form id="inputForm" modelAttribute="qualityWorkorder" action="${ctx}/ser/as/qualityWorkorder/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
                        <div class="box box-success">
                            <div class="box-header with-border zf-query">

                            </div>
                            <form:hidden path="orderId"/>
                            <form:hidden path="id"/>
                            <form:hidden path="status"/>
                            <div class="box-body">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label  class="col-sm-2 control-label">质检工单号</label>
                                        <div class="col-sm-8">
                                            <input name="workorderNo" readonly="readonly" value="${qualityWorkorder.workorderNo}" maxlength="64" class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                        </div>
                        <div class="box box-success">
                            <div class="box-header with-border zf-query">
                                <h5>工单关联货品设置列表</h5>
                            </div>
                            <div class="box-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                                        <thead>
                                        <tr>
                                            <th>货品编码</th>
                                            <th>货品图片</th>
                                            <th>货品名称</th>
                                            <th>产品库存</th>
                                            <th>货品损坏图片</th>
                                            <th>损坏问题描述</th>
                                            <th>损坏类型</th>
                                            <th>损坏金额</th>
                                            <th>责任人类型</th>
                                            <th>备注</th>
                                        </tr>
                                        </thead>
                                        <tbody id="tBody">
                                        <c:forEach items="${qualityWorkorder.qualityWorkordProductList}" var="workProduct" varStatus="status">
                                            <form:hidden path="qualityWorkordProductList[${status.index}].returnProduceId" />
                                            <form:hidden path="qualityWorkordProductList[${status.index}].id" />
                                            <form:hidden path="qualityWorkordProductList[${status.index}].product.produce.id" />
                                            <form:hidden path="qualityWorkordProductList[${status.index}].workOrderId" />
                                            <form:hidden path="qualityWorkordProductList[${status.index}].product.id" />
                                            <form:hidden path="qualityWorkordProductList[${status.index}].produceNormal" />
                                            <form:hidden path="qualityWorkordProductList[${status.index}].priceSrc" />
                                            <tr>
                                                <td>
                                                        ${workProduct.product.code }
                                                </td>
                                                <td>
                                                    <img onerror="imgOnerror(this);"  src="${imgHost }${workProduct.product.goods.samplePhoto}" data-big data-src="${imgHost }${workProduct.product.goods.samplePhoto}" width="21" height="21" />
                                                </td>
                                                <td>
                                                        ${workProduct.product.goods.name}
                                                </td>
                                                <td>
                                                        ${workProduct.produceNormal}
                                                </td>
                                                <td>
                                                    <img onerror="imgOnerror(this);"  src="${imgHost }${workProduct.product.brokenPhoto}" data-big data-src="${imgHost }${workProduct.product.brokenPhoto}" width="21" height="21" />
                                                </td>
                                                <td>
                                                    <sys:selectverify  name="qualityWorkordProductList[${status.index}].problemDescription" tip="请选择" verifyType="99" dictName="bus_or_repair_order_breakdownType_description" id="problemDescription"></sys:selectverify>
                                                </td>
                                                <td>
                                                    <form:select id="damageType" onchange="selDamage(this.options[this.options.selectedIndex].value,'${status.index}','${workProduct.priceSrc}')" path="qualityWorkordProductList[${status.index}].damageType" data-verify="false" htmlEscape="false" maxlength="50" class="form-control select2" disabled="false">
                                                        <form:option value="" label="请选择"/>
                                                        <form:options items="${fns:getDictList('bus_or_repair_order_breakdownType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                                    </form:select>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${workProduct.damageType eq '4' or workProduct.damageType eq '3' or workProduct.damageType eq '5'}">
                                                            <input placeholder="请输入金额,两位小数"  id="decMoney${status.index}" type="text" data-verify="false" maxlength="5" data-type="item" name="qualityWorkordProductList[${status.index}].decMoney"
                                                                   class="form-control" value="${workProduct.decMoney}" readonly/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input placeholder="请输入金额,两位小数"  id="decMoney${status.index}" type="text" data-verify="false" maxlength="5" data-type="item" name="qualityWorkordProductList[${status.index}].decMoney"
                                                                   class="form-control" value="${workProduct.decMoney}"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${workProduct.damageType eq '4'}">
                                                            <sys:selectverify name="qualityWorkordProductList[${status.index}].responsibilityType" tip="请选择" verifyType="99" dictName="bus_ol_return_product_responsibilityType" id="responsibilityType" disabled="true"></sys:selectverify>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <sys:selectverify name="qualityWorkordProductList[${status.index}].responsibilityType" tip="请选择" verifyType="99" dictName="bus_ol_return_product_responsibilityType" id="responsibilityType"></sys:selectverify>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </td>
                                                <td>
                                                    <input id="remarks${status.index}" type="text" data-verify="false" maxlength="100" data-type="item" name="qualityWorkordProductList[${status.index}].remarks"
                                                           class="form-control" value="${workProduct.remarks}"/>
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
                                    <shiro:hasPermission name="ser:as:qualityWorkorder:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                                </div>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
        </div>
    </section>
</div>
<script type="text/javascript">
    $(function () {
        ZF.bigImg();
    });
    var damage;
    function formSubmit(){

        /* var decMoney=$("#decMoney").val();
         var p =/^[1-9](\d+(\.\d{1,2})?)?$/;
         var p1=/^[0-9](\.\d{1,2})?$/;
         if(p.test(decMoney) || p1.test(decMoney)){

         }else{
             ZF.showTip("请输入正确金额,两位小数","danger");
             return false;
         }*/
    }
    function selDamage(v,index,priceSrc) {
        damage = v;
        ajax('${ctx}/ser/as/qualityWorkorder/getRateBreak?breakdownType='+v,'post',{},function(data){
            //var obj = eval("("+data+")"); //转换为json对象
            var price = data.moneyLossPercent*priceSrc;
            if(data.moneyLossPercent == undefined){
                price="";
            }
            var decName ="#decMoney"+index;
            $(decName).val(price);
            if(damage !=1 && damage != 2){
                $(decName).attr('readonly', '');
            }else{
                $(decName).removeAttr('readonly');
            }
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
</script>
</body>
</html>