<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>供应商产品管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/si/supplier/">供应商列表</a></small>
            <small>|</small>
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/si/supplierProduce/list?supplier.id=${supplier.id}">供应商【${supplier.name }】产品列表</a></small>
            <small>|</small>
            <small class="menu-active">
                <i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/supplierProduce/edit?supplierId=${supplier.id}&goodsId=${goods.id}">供应商【${supplier.name }】产品${not empty supplierProduce.id?'修改':'添加'}</a>
            </small>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form:form id="inputForm" modelAttribute="supplierProduce" action="${ctx}/lgt/si/supplierProduce/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                        
		                    <input type="hidden" id="supplierId" name="supplier.id" value="${supplier.id }"/>
                            
                            <sys:selectmutil id="goodsSelect" title="商品列表" url="" isDisableCommitBtn="true" isRefresh="false" width="1200" height="700" ></sys:selectmutil>
                            <fieldset>
                                <legend>商品信息</legend>
                                <c:if test="${empty supplierProduce.id }">
		                            <div class="row">
		                                <div class="col-md-4">
				                            <div class="form-group">
				                                <label class="col-sm-2 control-label">商品</label>
				                                <div class="col-sm-9">
				                                    <div class="input-group">
				                                        <button type="button" class="btn btn-sm btn-default" id="goodsButton"><i class="fa fa-search"></i>选择商品</button>
				                                    </div>
				                                </div>
				                            </div>
		                                </div>
		                            </div>
                                </c:if>
	                            <div class="row">
	                                   <div class="col-md-4">
                                          <div class="form-group">
                                              <label class="col-sm-2 control-label">商品名称</label>
                                              <div class="col-sm-9">
                                                  <input type="text" name="goods.name" value="${goods.name }" disabled="disabled" class="form-control" readonly="readonly"/>
                                              </div>
                                          </div>
                                      </div>
	                                  <div class="col-md-4">
	                                      <div class="form-group">
	                                          <label class="col-sm-2 control-label">商品编码</label>
	                                          <div class="col-sm-9">
	                                              <input type="hidden" data-name="goods" name="goods.id" value="${goods.id }"/>
	                                              <input type="text" name="goods.code" value="${goods.code }" disabled="disabled" class="form-control" readonly="readonly"/>
	                                          </div>
	                                      </div>
	                                  </div>
	                                  <div class="col-md-4">
                                          <div class="form-group">
                                              <label class="col-sm-2 control-label">原厂编码</label>
                                              <div class="col-sm-9">
                                                  <input type="text" name="goods.factoryCode" value="${supplierProduce.goodsFactoryCode }"  class="form-control" />
                                              </div>
                                          </div>
                                      </div>
	                              </div>
                            </fieldset>
                            
                            
                            <fieldset>
                                <legend>金工石信息</legend>
	                            <div class="row">
	                                <div class="col-md-4">
		                                <div class="form-group">
			                                <label class="col-sm-2 control-label">工费</label>
			                                <div class="col-sm-9">
			                                    <sys:inputverify id="workFee" name="workFee" tip="请输入工费，默认两位小数" maxlength="8" verifyType="9"  value="${supplierProduce.workFee }" isMandatory="false"></sys:inputverify>
			                                </div>
			                            </div>
	                                </div>
	                                <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">起板费</label>
                                            <div class="col-sm-9">
                                                <sys:inputverify id="templetFee" name="templetFee" tip="请输入起板费，默认两位小数" maxlength="8" verifyType="9"  value="${supplierProduce.templetFee }" isMandatory="false"/>
                                            </div>
                                        </div>
                                    </div>
	                            </div>
	                            <div class="row">    
		                            <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">电金工艺</label>
                                            <div class="col-sm-9">
                                                 <select  id="electrolyticGoldCrafts" name="electrolyticGoldCrafts" class="form-control">
	                                               <option value="">请选择</option>
	                                               <c:forEach items="${fns:getDictList('lgt_si_supplier_produce_egCrafts') }" var="c">
	                                                   <option value="${c.value }" ${c.value eq  supplierProduce.electrolyticGoldCrafts ? 'selected' : ''}>${c.label }</option>
	                                               </c:forEach>
	                                            </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">电金颜色</label>
                                            <div class="col-sm-9">
                                                 <select  id="electrolyticGoldColour" name="electrolyticGoldColour" class="form-control">
                                                   <option value="">请选择</option>
                                                   <c:forEach items="${fns:getDictList('lgt_si_supplier_produce_egColour') }" var="c">
                                                       <option value="${c.value }" ${c.value eq  supplierProduce.electrolyticGoldColour ? 'selected' : ''}>${c.label }</option>
                                                   </c:forEach>
                                                </select> 
                                            </div>
                                        </div>
                                    </div>
	                            </div>
	                            <div class="row">    
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">电金厚度(mm)</label>
                                            <div class="col-sm-9">
                                                <sys:inputverify id="electrolyticGoldThickness" name="electrolyticGoldThickness" tip="请输入电金厚度，默认四位小数" maxlength="6" verifyType="10"  value="${supplierProduce.electrolyticGoldThickness }" isMandatory="false"></sys:inputverify>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">电金价格</label>
                                            <div class="col-sm-9">
                                                <sys:inputverify id="electrolyticGoldPrice" name="electrolyticGoldPrice" tip="请输入电金价格，默认两位小数" maxlength="6" verifyType="9"  value="${supplierProduce.electrolyticGoldPrice }" isMandatory="false"></sys:inputverify>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            
                            <fieldset>
                                <legend>产品信息</legend>
                                <table  id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                                    <thead>
	                                    <tr>
	                                        <th>图片展示</th>
											<th>产品名称</th>
											<th>镶口费</th>
											<th>镶口数</th>
											<th>金价</th>
											<th>损耗</th>
											<th>金重下限</th>
											<th>金重上限</th>
											<th>主石重量</th>
											<th>主石价格</th>
											<th>辅石重量</th>
											<th>辅石价格</th>
											<th>采购价下限</th>
											<th>采购价上限</th>
											<th>操作</th>
										</tr>
                                    </thead>
									<tbody>
									   <c:forEach items="${spList }" var="sp" varStatus="index">
										   <tr id="tr_${index.index }">
										       <td>
										          <img alt="" src="${imgHost }${sp.goods.samplePhoto}" data-big data-src="${imgHost }${sp.goods.samplePhoto}"  width="20px;" height="20px;">
										       </td>
										       <td>
										          <input type="hidden" id="id_${index.index }" name="spList[${index.index }].id" value="${sp.id }"/>
                                                  <input type="hidden" data-name="produce" id="produceId_${index.index }" name="spList[${index.index }].produce.id" value="${sp.produce.id }" class="form-control"/>
										          ${sp.produce.name } 
										       </td>
										       <td>
                                                  <input data-verify="true" data-index="${index.index }" verifyType="9" data-item="true" maxlength="8" id="inlayFee_${index.index }" name="spList[${index.index }].inlayFee" placeholder="镶口费,两位小数" value="${sp.inlayFee }" class="form-control"/>
                                               </td>
                                               <td>
                                                  <input data-verify="true" data-index="${index.index }"  verifyType="4" data-item="true" maxlength="8" id="inlayNum_${index.index }" name="spList[${index.index }].inlayNum" placeholder="镶口数，整数" value="${sp.inlayNum }" class="form-control"/>
                                               </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="9" data-item="true" maxlength="8" id="goldPrice_${index.index }" name="spList[${index.index }].goldPrice" placeholder="金价,两位小数" value="${sp.goldPrice }" class="form-control"/>
										       </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="9" data-item="true" maxlength="8" id="lossFee_${index.index }" name="spList[${index.index }].lossFee" placeholder="损耗，两位小数" value="${sp.lossFee }" class="form-control"/>
										       </td>
										       <td>
                                                  <input data-verify="true" data-index="${index.index }"  verifyType="10" data-item="true" maxlength="6" id="goldWeightMin_${index.index }" name="spList[${index.index }].goldWeightMin" placeholder="金重下限，四位小数" value="${sp.goldWeightMin }" class="form-control"/>
                                               </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="10" data-item="true" maxlength="6" id="goldWeightMax_${index.index }" name="spList[${index.index }].goldWeightMax" placeholder="金重上限，四位小数" value="${sp.goldWeightMax }" class="form-control"/>
										       </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="10" data-item="true" maxlength="6" id="mainStoneWeight_${index.index }" name="spList[${index.index }].mainStoneWeight" placeholder="主石重量，四位小数"  value="${sp.mainStoneWeight }" class="form-control"/>
										       </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="9" data-item="true" maxlength="8" id="mainStonePrice_${index.index }" name="spList[${index.index }].mainStonePrice" placeholder="主石价格，两位小数"  value="${sp.mainStonePrice }" class="form-control"/>
										       </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="10" data-item="true" maxlength="6" id="subsidiaryStoneWeight_${index.index }" name="spList[${index.index }].subsidiaryStoneWeight" placeholder="辅石重量，四位小数"  value="${sp.subsidiaryStoneWeight }" class="form-control"/>
										       </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="9" data-item="true" maxlength="8" id="subsidiaryStonePrice_${index.index }" name="spList[${index.index }].subsidiaryStonePrice" placeholder="辅石价格，两位小数"  value="${sp.subsidiaryStonePrice }" class="form-control"/>
										       </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="9" data-item="false" maxlength="8" id="pricePurchaseMin_${index.index }" name="spList[${index.index }].pricePurchaseMin" placeholder="采购价下限，两位小数"  value="${sp.pricePurchaseMin }" class="form-control"/>
										       </td>
										       <td>
										          <input data-verify="true" data-index="${index.index }"  verifyType="9" data-item="false" maxlength="8" id="pricePurchaseMax_${index.index }" name="spList[${index.index }].pricePurchaseMax" placeholder="采购价上限，两位小数"  value="${sp.pricePurchaseMax }" class="form-control"/>
										       </td>
										       <td>
										          <button type="button" class="btn btn-sm btn-github" onclick="delRow(this);"><i class="fa fa-remove">删除</i></button>
										       </td>
										   </tr>
									   </c:forEach>
									</tbody>
                                </table>
                            </fieldset>
                            
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <shiro:hasPermission name="lgt:si:supplierProduce:edit"><button type="submit"  class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </section>
    </div>
    <script type="text/javascript">
    
     $(function() {
    	 
    	ZF.bigImg(); 
    	 
    	 
	    $("#goodsButton").on('click',function(){
	        $("#goodsSelectModalUrl").val("${ctx}/lgt/ps/goods/selectRadio")//带参数请求URL设置方式
	        $("#goodsSelectModal").modal('toggle');//显示模态框
	    });
	    
	    $("#goodsSelectModal #commitBtn").on("click",function () {
	        $("#goodsSelectModal").modal("hide");       
	        var content = $("#goodsSelectModalIframe").contents().find("body");
	        var ids = new Array();
	        var names = new Array();
	        var existIds = $("#allGoodIds").val();
	        $("input[type=radio]", content).each(function(){
	            if($(this).prop("checked")){
	               var selVal = $(this).val();
	               var arr = selVal.split("=");
                   $("#goodsId").val(arr[0]);
                   $("#goodsCode").val(arr[1]);
                   $("#goodsName").val(arr[2]);
                   window.location.href = "${ctx}/lgt/si/supplierProduce/edit?goodsId="+arr[0]+"&supplierId="+$("#supplierId").val();
	            }
	        });
	    });
    	
	    
	    $("input[data-item='true']").on("change", function() {
	    	var verifyType = $(this).attr("verifyType");
	    	var val = $(this).val();
	    	var id = $(this).attr("id");
	    	var tip = $(this).attr("placeholder");
		    ZF.formVerify(false, verifyType, val ? $(this).attr("data-verify","true"):$(this).attr("data-verify","false"));
	        if(!ZF.formVerify(false, verifyType, val)){
	            $(this).addClass("zf-input-err")
	            if($("#"+id+"Err").length<=0)
	                $(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>"+tip+"</label>");
	            $(this).attr("data-verify","false");
	        }else{
	            if($("#"+id+"Err").length>0){
	                $(this).removeClass("zf-input-err");
	                $("#"+id+"Err").remove();
	            }
	            $(this).attr("data-verify","true");
	          
	            var index = $(this).attr("data-index");
	            var dataArr = cal(index);
	            
	            var workFee = $("#workFee").val();
                if(workFee != null && workFee != '' && workFee != undefined) {
                    dataArr[0] += parseFloat(workFee);
                    dataArr[1] += parseFloat(workFee);
                }
                
                var gprice = $("#electrolyticGoldPrice").val();
                if(gprice != null && gprice != '' && gprice != undefined) {
                    dataArr[0] += parseFloat(gprice);
                    dataArr[1] += parseFloat(gprice);
                }
                
                $("#pricePurchaseMin_"+index).val(dataArr[0] == 0 ? '' : dataArr[0].toFixed(2));
                $("#pricePurchaseMax_"+index).val(dataArr[1] == 0 ? '' : dataArr[1].toFixed(2));
	        }
	        
	    });
	    
	    
	    $("#workFee").on("change", function() {
	    	var verifyType = $(this).attr("verifyType");
            var val = $(this).val();
            var id = $(this).attr("id");
            var tip = $(this).attr("placeholder");
            ZF.formVerify(false, verifyType, val ? $(this).attr("data-verify","true"):$(this).attr("data-verify","false"));
            if(!ZF.formVerify(false, verifyType, val)){
                $(this).addClass("zf-input-err")
                if($("#"+id+"Err").length<=0)
                    $(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>"+tip+"</label>");
                $(this).attr("data-verify","false");
            }else{
                if($("#"+id+"Err").length>0){
                    $(this).removeClass("zf-input-err");
                    $("#"+id+"Err").remove();
                }
                $(this).attr("data-verify","true");
                $("input[data-item='true']").each(function() {
                	var index = $(this).attr("data-index");
                    var dataArr = cal(index);
	               
                    var workFee = $("#workFee").val();
                    if(workFee != null && workFee != '' && workFee != undefined) {
	                    dataArr[0] += parseFloat(workFee);
	                    dataArr[1] += parseFloat(workFee);
                    }
                    
	                var gprice = $("#electrolyticGoldPrice").val();
	                if(gprice != null && gprice != '' && gprice != undefined) {
	                    dataArr[0] += parseFloat(gprice);
	                    dataArr[1] += parseFloat(gprice);
	                }
                    
                    $("#pricePurchaseMin_"+index).val(dataArr[0] == 0 ? '' : dataArr[0].toFixed(2));
                    $("#pricePurchaseMax_"+index).val(dataArr[1] == 0 ? '' : dataArr[1].toFixed(2));
	                
               });
            }
	    });
	    
	    
	    
	    $("#electrolyticGoldPrice").on("change", function() {
            var verifyType = $(this).attr("verifyType");
            var val = $(this).val();
            var id = $(this).attr("id");
            var tip = $(this).attr("placeholder");
            ZF.formVerify(false, verifyType, val ? $(this).attr("data-verify","true"):$(this).attr("data-verify","false"));
            if(!ZF.formVerify(false, verifyType, val)){
                $(this).addClass("zf-input-err")
                if($("#"+id+"Err").length<=0)
                    $(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>"+tip+"</label>");
                $(this).attr("data-verify","false");
            }else{
                if($("#"+id+"Err").length>0){
                    $(this).removeClass("zf-input-err");
                    $("#"+id+"Err").remove();
                }
                $(this).attr("data-verify","true");
                $("input[data-item='true']").each(function() {
                    var index = $(this).attr("data-index");
                    var dataArr = cal(index);
                    
                    var workFee = $("#workFee").val();
                    if(workFee != null && workFee != '' && workFee != undefined) {
                        dataArr[0] += parseFloat(workFee);
                        dataArr[1] += parseFloat(workFee);
                    }
                    
                    var gprice = $("#electrolyticGoldPrice").val();
                    if(gprice != null && gprice != '' && gprice != undefined) {
                        dataArr[0] += parseFloat(gprice);
                        dataArr[1] += parseFloat(gprice);
                    }
                    
                    $("#pricePurchaseMin_"+index).val(dataArr[0] == 0 ? '' : dataArr[0].toFixed(2));
                    $("#pricePurchaseMax_"+index).val(dataArr[1] == 0 ? '' : dataArr[1].toFixed(2));
                    
               });
            }
        });
	    
	    $("input[data-item='false']").on("change", function() {
            var verifyType = $(this).attr("verifyType");
            var val = $(this).val();
            var id = $(this).attr("id");
            var tip = $(this).attr("placeholder");
            ZF.formVerify(false, verifyType, val ? $(this).attr("data-verify","true"):$(this).attr("data-verify","false"));
            if(!ZF.formVerify(false, verifyType, val)){
                $(this).addClass("zf-input-err")
                if($("#"+id+"Err").length<=0)
                    $(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>"+tip+"</label>");
                $(this).attr("data-verify","false");
            }else{
                if($("#"+id+"Err").length>0){
                    $(this).removeClass("zf-input-err");
                    $("#"+id+"Err").remove();
                }
                $(this).attr("data-verify","true");
            }
	    });
	    
	    
    	 
     });
     
     function formSubmit() {
    	var verify = true;
    	$("input[data-name=goods]").each(function() {
    		var val = $(this).val();
    		if(val == null || val == "" || val == undefined) {
    			ZF.showTip("请先选择商品！", "info");
    			verify = false;
    		}
    	});
    	if(!verify) {
            return false;
        }
    	
    	if($("input[data-name=produce]").length == 0) {
    		ZF.showTip("产品信息不能为空!", "info");
    		verify = false;
    	} else {
	    	$("input[data-name=produce]").each(function() {
	    		var val = $(this).val();
	    		if(val == null || val == "" || val == undefined) {
	    			if(c == 0) {
		    			ZF.showTip("产品信息不能为空!", "info");
		    			verify = false;
	    			}
	    		}
	    	});
    	}
    	if(!verify) {
    		return false;
    	}
    	/* $("input[data-item=true]").each(function() {
    		var val = $(this).val();
    		if(val == null || val == "" || val == undefined) {
    			verify = false;
    			var id = $(this).attr("id");
                var tip = $(this).attr("placeholder");
    			
    			$(this).addClass("zf-input-err");
    			if($("#"+id+"Err").length<=0)
                    $(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>"+tip+"</label>");
	    		
    		}
    	});
    	if(!verify) {
            return false;
        }
    	
    	$("input[data-item=false]").each(function() {
            var val = $(this).val();
            if(val == null || val == "" || val == undefined) {
                verify = false;
                var id = $(this).attr("id");
                var tip = $(this).attr("placeholder");
                
                $(this).addClass("zf-input-err");
                if($("#"+id+"Err").length<=0)
                    $(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>"+tip+"</label>");
                
            }
        });
        if(!verify) {
            return false;
        } */
    	
    	
    	/* var craft = $("#electrolyticGoldCrafts").val();
        if(craft == null || craft == "") {
            ZF.showTip("请选择电金工艺!", "info");
            return false;
        }
        
        var color = $("#electrolyticGoldColour").val();
        if(color == null || color == "") {
            ZF.showTip("请选择电金颜色!", "info");
            return false;
        } */
    	var form = $("#inputForm");
        var inputs=$("input[data-verify=false]",form);
        for(var i=0;i<inputs.length;i++){
            $(inputs[i]).trigger('change');
            verify=false;
        }
        var selects=$("select[data-verify=false]",form);
        for(var i=0;i<selects.length;i++){
            $(selects[i]).trigger('change');
            verify=false;
        }
        
        return verify;
     }
     
     
     function delRow(btn) {
    	 $(btn).parent().parent().remove();
     }
     
     
     function cal(index) {
    	 var totalMax = 0;
         var totalMin = 0;  
         //运算采购价上限，采购价下限
         var inlayFee = $("#inlayFee_"+index).val();
         var inlayNum = $("#inlayNum_"+index).val();
         
         if(inlayFee != null && inlayFee != '' && inlayNum != null && inlayNum != '') {
             totalMax += inlayFee*inlayNum;
             totalMin += inlayFee*inlayNum;
         }

         var goldPrice = $("#goldPrice_"+index).val();
         var lossFee = $("#lossFee_"+index).val();
         if(goldPrice != null && goldPrice != '' && lossFee != null && lossFee != '') {
             totalMax += goldPrice*lossFee;
             totalMin += goldPrice*lossFee;
         }
         var goldWeightMax = $("#goldWeightMax_"+index).val();
         if(goldPrice != null && goldPrice != '' && goldWeightMax != null && goldWeightMax != '') {
             totalMax += goldPrice*goldWeightMax;
         }
         var goldWeightMin = $("#goldWeightMin_"+index).val();
         if(goldPrice != null && goldPrice != '' && goldWeightMin != null && goldWeightMin != '') {
             totalMin += goldPrice*goldWeightMin;
         }
         /* var mainStoneWeight = $("#mainStoneWeight_"+index).val(); */
         var mainStonePrice = $("#mainStonePrice_"+index).val();
         if(mainStonePrice != null && mainStonePrice != '') {
             totalMax += parseFloat(mainStonePrice);
             totalMin += parseFloat(mainStonePrice);
         }
         /* var subsidiaryStoneWeight = $("#subsidiaryStoneWeight_"+index).val(); */
         var subsidiaryStonePrice = $("#subsidiaryStonePrice_"+index).val();
         if(subsidiaryStonePrice != null && subsidiaryStonePrice != '') {
             totalMax += parseFloat(subsidiaryStonePrice);
             totalMin += parseFloat(subsidiaryStonePrice);
         }
         
        /*  var workFee = $("#workFee").val();
         totalMax += parseFloat(workFee);
         totalMin += parseFloat(workFee);
         console.log("totalMin====="+totalMin+",   totalMax======"+totalMax); 
         $("#pricePurchaseMin_"+index).val(totalMin.toFixed(2));
         $("#pricePurchaseMax_"+index).val(totalMax.toFixed(2));*/
         return [totalMin, totalMax];
     }
    </script>
    
</body>
</html>