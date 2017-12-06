<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品明细列表管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/produce/list">产品列表</a></small>
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produce/form?id=${produce.id}">产品${not empty produce.id?'修改':'新增'}</a></small>
			</h1>
		</section>
		
		<sys:tip content="${message}"/>
		
		<section class="content">
			<div class="row">
				<div class="col-md-6">
					<form:form id="inputForm" modelAttribute="produce" action="${ctx}/lgt/ps/produce/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
						<form:hidden path="id"/>
						<form:hidden path="sellNum"/>
						<form:hidden path="goods.id"/>
						<form:hidden path="propertyStr"/>
						<form:hidden path="propertySkuStr"/>
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>产品${not empty produce.id?'修改':'新增'}录入表单</h5>
							</div>
							<div class="box-body">
								<div class="form-group">
									<label for="code" class="col-sm-2 control-label" >产品编码</label>
									<div class="col-sm-9">
										<form:input path="code" class="form-control" readonly="true"/>
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="col-sm-2 control-label" >产品名称</label>
									<div class="col-sm-9">
									    <sys:inputverify name="name" id="name" verifyType="99" tip="请输入产品名称，必填项" isMandatory="true" isSpring="true"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
                                    <label for="title" class="col-sm-2 control-label" >产品展示标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify name="title" id="title" verifyType="99" tip="请输入产品展示标题，必填项" isMandatory="true" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
								<div class="form-group">
                                    <label for="styleType" class="col-sm-2 control-label" >风格类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="styleType" tip="请选择风格类型" isMandatory="false" verifyType="0" dictName="lgt_ps_produce_styleType" id="styleType"></sys:selectverify>
                                    </div>
                                </div>
								<div class="form-group">
									<label for="status" class="col-sm-2 control-label" >产品状态</label>
									<div class="col-sm-9">
									    <input type="hidden" name="status" value="${produce.status }"/>   
									    <input type="text" name="statusLabel" class="form-control" readonly="readonly" value="${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }"/>
									</div>
								</div>
								<div class="form-group">
									<label for="standardWeight" class="col-sm-2 control-label" >标准克重</label>
									<div class="col-sm-9">
										<sys:inputverify name="standardWeight" id="standardWeight" value="${produce.standardWeight }" verifyType="10" isMandatory="false" tip="请录入标准克重,两位小数" maxlength="6"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label for="pricePurchase" class="col-sm-2 control-label" >采购价<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="取采购订单中供应商最高报价，不可手动修改">?</span></label>
									<div class="col-sm-9">
									     <input type="hidden" id="pricePurchase" name="pricePurchase" value="${produce.pricePurchase }"/>   
									     <input type="text" value="${produce.pricePurchase }" class="form-control" disabled="disabled"/>   
									</div>
								</div>
								<div class="form-group">
									<label for="priceOperation" class="col-sm-2 control-label" >运算成本价<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="在参考采购价的基础上，自定义要进行价格计算的基础数值">?</span></label>
									<div class="col-sm-9">
									    <div class="input-group">
											<sys:inputverify name="priceOperation" id="priceOperation" value="${produce.priceOperation }" verifyType="9" tip="请录入运算成本价,两位小数,必填项" maxlength="8"></sys:inputverify>
									        <span class="input-group-btn">
                                                <button type="button" onclick="computePrice();" class="btn btn-info btn-flat">运算价格</button>
                                            </span>
									    </div>
									</div>
								</div>
								<div class="form-group">
									<label for="ratioOperation" class="col-sm-2 control-label" >运算加价系数<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="加价系数默认取业务参数设置中加价系数，可对产品单独设置">?</span></label>
									<div class="col-sm-9">
										<sys:inputverify name="ratioOperation" id="ratioOperation" value="${produce.ratioOperation }" verifyType="9" tip="请录入运算加价系数,两位小数,必填项" maxlength="8"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label for="priceSrc" class="col-sm-2 control-label" >原价<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="(运算成本价*加价系数)，个位向上取整得到销售价，可单独调整">?</span></label>
									<div class="col-sm-9">
										<sys:inputverify name="priceSrc" id="priceSrc" value="${produce.priceSrc }" verifyType="9" tip="请录入购买价,两位小数,必填项" maxlength="8"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label for="scaleExperienceFee" class="col-sm-2 control-label" >体验费收取比例<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="此比例为百分比，即一百元销售价应收取的体验费数额">?</span></label>
									<div class="col-sm-9">
										<sys:inputverify name="scaleExperienceFee" id="scaleExperienceFee" value="${produce.scaleExperienceFee }" verifyType="9" isMandatory="false" tip="请录入体验费收取比例,两位小数" maxlength="8"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
                                    <label for="scaleExperienceDeposit" class="col-sm-2 control-label" >体验押金比例<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="此比例为百分比，即一百元销售价应收取的体验押金数额">?</span></label>
                                    <div class="col-sm-9">
                                        <sys:inputverify name="scaleExperienceDeposit" id="scaleExperienceDeposit" value="${produce.scaleExperienceDeposit }" verifyType="9" isMandatory="false" tip="请录入体验押金比例,两位小数" maxlength="8"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="priceDecPoint" class="col-sm-2 control-label" >积分可抵金额<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="此值为具体值，即一百元销售价中积分可低的最大金额值">?</span></label>
                                    <div class="col-sm-9">
                                        <sys:inputverify name="priceDecPoint" id="priceDecPoint" value="${produce.priceDecPoint }" verifyType="9" isMandatory="false" tip="请录入积分可低金额,两位小数" maxlength="8"></sys:inputverify>
                                    </div>
                                </div>
								<div class="form-group">
									<label for="discountPrice" class="col-sm-2 control-label" >促销特价<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="促销特价优先权排第一，设置了促销特价的产品以该特价销售">?</span></label>
									<div class="col-sm-9">
										<sys:inputverify name="discountPrice" id="discountPrice" value="${produce.discountPrice }" verifyType="9" isMandatory="false" tip="请录入促销特价,两位小数" maxlength="8"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label for="discountScale" class="col-sm-2 control-label" >促销折扣<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="促销折扣优先权排第二，未设置促销特价但设置了促销折扣的产品以该折扣打折销售">?</span></label>
									<div class="col-sm-9">
										<sys:inputverify name="discountScale" id="discountScale" value="${produce.discountScale }" verifyType="9" isMandatory="false" tip="请录入促销折扣,两位小数" maxlength="4"></sys:inputverify>
									</div>
								</div>
								<div class="form-group">
									<label for="discountFilterScale" class="col-sm-2 control-label" >促销筛选折扣<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="促销折扣优先权排第三，未设置促销特价、促销折扣但设置了促销筛选折扣的产品在对应生效时间范围内以该折扣打折销售，筛选折扣设置入口在“市场管理-营销管理-产品促销设置”功能">?</span></label>
									<div class="col-sm-9">
									    <input type="hidden" name="discountFilterScale" value="${produce.discountFilterScale }"/>   
										<input value="${produce.discountFilterScale}" class="form-control" disabled="disabled"/>
									</div>
								</div>
								<div class="form-group">
									<label for="discountFilterStart" class="col-sm-2 control-label" >促销筛选生效时间</label>
									<div class="col-sm-9">
									    <input type="hidden" name="discountFilterStart" value="<fmt:formatDate value='${produce.discountFilterStart}' pattern='yyyy-MM-dd HH:mm:ss'/>"/>   
										<input value="<fmt:formatDate value='${produce.discountFilterStart}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="form-control" disabled="disabled"/>
									</div>
								</div>
								<div class="form-group">
									<label for="discountFilterEnd" class="col-sm-2 control-label" >促销筛选失效时间</label>
									<div class="col-sm-9">
									    <input type="hidden" name="discountFilterEnd" value="<fmt:formatDate value='${produce.discountFilterEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>"/>   
										<input value="<fmt:formatDate value='${produce.discountFilterEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="form-control" disabled="disabled"/>
									</div>
								</div>
								<div class="form-group">
									<label for="discountScale" class="col-sm-2 control-label" >平台折扣<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="平台折扣优先权最低，未设置促销特价、促销折扣、促销筛选折扣的产品，根据平台折扣打折销售">?</span></label>
									<div class="col-sm-9">
										<input value="${dspValue}" class="form-control" disabled="disabled"/>
									</div>
								</div>
								
								<div class="form-group">
                                    <label for="isBuy" class="col-sm-2 control-label" >是否可购买</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="isBuy" tip="请选择" isMandatory="false" verifyType="0" dictName="yes_no" id="isBuy"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="isExperience" class="col-sm-2 control-label" >是否可体验</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="isExperience" tip="请选择" isMandatory="false" verifyType="0" dictName="yes_no" id="isExperience"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="isForeBuy" class="col-sm-2 control-label" >是否可预购</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="isForeBuy" tip="请选择"  isMandatory="false" verifyType="0" dictName="yes_no" id="isForeBuy"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="isForeExperience" class="col-sm-2 control-label" >是否可预约体验</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="isForeExperience" tip="请选择"  isMandatory="false" verifyType="0" dictName="yes_no" id="isForeExperience"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="isForeExperience" class="col-sm-2 control-label" >是否可预约体验日期</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="isForeexperienceDate" tip="请选择"  isMandatory="false" verifyType="0" dictName="yes_no" id="isForeexperienceDate"></sys:selectverify>
                                    </div>
                                </div>
								<div class="form-group">
									<label for="standardWeight" class="col-sm-2 control-label" >备注信息</label>
									<div class="col-sm-9">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control " placeholder="请输入备注" />
									</div>
								</div>
							</div>
							<div class="box-footer">
			    				<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
		    						<c:if test="${ empty produce.id}">
					        			<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    						</c:if>
		    						<!-- <button type="button" class="btn btn-info btn-sm" onclick="computePrice()"><i class="fa fa-refresh"></i>运算价格</button> -->
				               		<shiro:hasPermission name="lgt:ps:produce:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
			
			$("#pricePurchase").on("change",function(){
				$("#priceOperation").val("");
			})
			
		});
		
		// 运算价格
		function computePrice(){
			// 运算成本价如果未设置，则取值为采购价个位十位向上取整
			var priceOperationTemp = Math.ceil($("#pricePurchase").val()/100)*100;
			if($("#priceOperation").val()==null || $("#priceOperation").val()==""){
				$("#priceOperation").val(priceOperationTemp);
			}
			var priceOperation = $("#priceOperation").val();
			
			var ratioOperation = $("#ratioOperation").val();					// 购买价格运算系数a
			if(ratioOperation == null || ratioOperation == ""){
				ZF.showTip("购买价格运算系数未设置，请先设置运算加价系数后再使用自动计算价格功能！","danger");
				return;
			}
			
			var priceSrc = Math.ceil(priceOperation * ratioOperation/10)*10;					// 购买价格 = 运算成本价 * 购买价格运算系数a
			$("#priceSrc").val(priceSrc);
		}
		
		function formSubmit() {
			var verify=true;
			var form = $("#inputForm");
	        var inputs=$("input[data-verify=false]",form);
	        for(var i=0;i<inputs.length;i++){
	            if($(inputs[i]).attr('data-type') == "date"){
	                $(inputs[i]).parent().trigger('dp.change');
	            }else{
	                $(inputs[i]).trigger('change');
	            }
	            verify=false;
	        }
	        var selects=$("select[data-verify=false]",form);
	        for(var i=0;i<selects.length;i++){
	            $(selects[i]).trigger('change');
	            verify=false;
	        }
	        
	        return verify;
		}
	</script>
	
</body>
</html>