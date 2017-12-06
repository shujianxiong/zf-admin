<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品更新审批管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/produceUpdate/">产品更新记录列表</a></small>
            <shiro:hasPermission name="lgt:ps:produceUpdate:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produceUpdate/form?id=${produceUpdate.id}&produce.id=${produceUpdate.produce.id}">产品更新审批${not empty produceUpdate.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <form:form id="inputForm" modelAttribute="produceUpdate" action="${ctx}/lgt/ps/produceUpdate/save" method="post" class="form-horizontal" >
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <form:hidden path="id" />
                        <form:hidden path="produce.id"/>
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-6">
		                             <div class="form-group">
		                                  <label class="col-sm-2 control-label">产品编码</label>
		                                  <div class="col-sm-9">
		                                      <c:choose>
		                                          <c:when test="${empty produceUpdate.id }">
		                                              <div class="input-group">
		                                                  <input type="text" id="pcode" name="produce.code" placeholder="请输入产品编码" value="${produceUpdate.produce.code }" class="form-control" />
		                                                  <span class="input-group-btn">
		                                                    <button id="produceBtn" type="button" class="btn btn-info btn-flat">获取产品数据</button>
		                                                  </span>
		                                              </div>
		                                          </c:when>
		                                          <c:otherwise>
		                                              <input type="text" id="pcode" name="produce.code" value="${produceUpdate.produce.code }" class="form-control" disabled="disabled"/>
		                                          </c:otherwise>
		                                      </c:choose>
		                                      
		                                  </div>
		                             </div>
		                             <div class="form-group">
                                          <label class="col-sm-2 control-label">产品名称</label>
                                          <div class="col-sm-9">
                                              <input type="text" id="pname" name="produce.name" value="${produceUpdate.produce.name }" class="form-control" disabled="disabled"/>
                                          </div>
                                     </div>  
			                    </div>
			                 </div>
                            <div class="row">
                                <div class="col-md-6">
			                         <div class="form-group">
			                             <label class="col-sm-2 control-label">原采购价</label>
			                             <div class="col-sm-9">
			                                 <input type="hidden" name="srcPricePurchase" value="${produceUpdate.srcPricePurchase }"/>
			                                 <input type="text" id="srcPricePurchase" name="srcPricePurchase" disabled="disabled" class="form-control" value="${produceUpdate.srcPricePurchase }"/>
			                             </div>
			                         </div>
			                         <div class="form-group">
			                             <label class="col-sm-2 control-label">原运算成本价</label>
			                             <div class="col-sm-9">
			                                 <input type="hidden" name="srcPriceOperation" value="${produceUpdate.srcPriceOperation }"/>
			                                 <input type="text" id="srcPriceOperation" name="srcPriceOperation" disabled="disabled" class="form-control" value="${produceUpdate.srcPriceOperation }"/>
			                             </div>
			                         </div>
			                         <div class="form-group">
                                         <label class="col-sm-2 control-label">原购买价格</label>
                                         <div class="col-sm-9">
                                             <input type="hidden" name="srcPriceBuy" value="${produceUpdate.srcPriceBuy }"/>
                                             <input type="text" id="srcPriceBuy" name="srcPriceBuy" disabled="disabled"  class="form-control" value="${produceUpdate.srcPriceBuy }"/>
                                         </div>
                                     </div>
                                     <div class="form-group">
                                         <label class="col-sm-2 control-label">原购买打折比例</label>
                                         <div class="col-sm-9">
                                             <input type="hidden" name="srcScaleDiscount" value="${produceUpdate.srcScaleDiscount }"/>
                                             <input type="text" id="srcScaleDiscount" name="srcScaleDiscount" disabled="disabled"  class="form-control" value="${produceUpdate.srcScaleDiscount }"/>
                                         </div>
                                     </div>
			                         <div class="form-group">
			                             <label class="col-sm-2 control-label">原是否可购买</label>
			                             <div class="col-sm-9">
			                                 <input type="hidden" name="srcIsBuy" value="${produceUpdate.srcIsBuy }"/>
			                                 <sys:selectverify name="srcIsBuy" tip="请选择" verifyType="" disabled="true" dictName="yes_no" id="srcIsBuy"></sys:selectverify>
			                             </div>
			                         </div>
			                         <div class="form-group">
			                             <label class="col-sm-2 control-label">原是否可体验</label>
			                             <div class="col-sm-9">
			                                 <input type="hidden" name="srcIsExperience" value="${produceUpdate.srcIsExperience }"/>
			                                <sys:selectverify name="srcIsExperience" tip="请选择" verifyType="" disabled="true" dictName="yes_no" id="srcIsExperience"></sys:selectverify>
			                             </div>
			                         </div>
			                         <div class="form-group">
			                             <label class="col-sm-2 control-label">原是否可预购</label>
			                             <div class="col-sm-9">
			                                 <input type="hidden" name="srcIsForebuy" value="${produceUpdate.srcIsForebuy }"/>
			                                 <sys:selectverify name="srcIsForebuy" tip="请选择" verifyType="" disabled="true" dictName="yes_no" id="srcIsForebuy"></sys:selectverify>
			                             </div>
			                         </div>
			                         
			                         <div class="form-group">
			                             <label class="col-sm-2 control-label">原是否可预约</label>
			                             <div class="col-sm-9">
			                                 <input type="hidden" name="srcIsForeexperience" value="${produceUpdate.srcIsForeexperience }"/>
			                                 <sys:selectverify name="srcIsForeexperience" tip="请选择" verifyType="" disabled="true" dictName="yes_no" id="srcIsForeexperience"></sys:selectverify>
			                             </div>
			                         </div>
			                         <div class="form-group">
                                         <label class="col-sm-2 control-label">原体验费收取比例</label>
                                         <div class="col-sm-9">
                                             <input type="hidden" name="srcScaleExperience" value="${produceUpdate.srcScaleExperience }"/>
                                             <input type="text" id="srcScaleExperience" name="srcScaleExperience" disabled="disabled"  class="form-control" value="${produceUpdate.srcScaleExperience }"/>
                                         </div>
                                     </div>
				                <!-- 审批字段 START -->
				                    <c:if test="${produceUpdate.checkStatus ne '2' and not empty produceUpdate.id}">
                                       <div class="form-group">
                                           <label class="col-sm-2 control-label">审批人</label>
                                           <div class="col-sm-9">
                                               <input type="hidden" class="form-control zf-input-readonly"  id="checkById" name="checkBy.id"/>
                                               <input type="text" class="form-control" disabled="disabled" id="checkByName" name="checkBy.name" value="${fns:getUserById(produceUpdate.checkBy.id).name }"/>
                                           </div>
                                       </div>
                                       <div class="form-group">
                                           <label class="col-sm-2 control-label">审批时间</label>
                                           <div class="col-sm-9">
                                               <input type="text" class="form-control" disabled="disabled" id="checkTime" name="checkTime"  value="<fmt:formatDate value='${produceUpdate.checkTime }' pattern='yyyy-MM-dd HH:mm:ss' />"/>
                                           </div>
                                       </div>
		                            </c:if>
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label">审批状态</label>
                                       <div class="col-sm-9">
                                           <input type="hidden" name="checkStatus" id="checkStatus" value="${produceUpdate.checkStatus }"/>
                                           <sys:selectverify name="checkStatus" tip="" verifyType="" disabled="true" dictName="lgt_ps_produce_update_checkStatus" isMandatory="false" id="checkStatus1"></sys:selectverify>
                                       </div>
                                    </div>
			                        <shiro:hasPermission name="lgt:ps:produceUpdate:approve">
			                            <c:if test="${produceUpdate.checkStatus eq '2' }">
		                                    <div class="form-group">
		                                        <label class="col-sm-2 control-label">审批备注</label>
		                                        <div class="col-sm-9">
		                                                <sys:inputverify id="checkRemarks" name="checkRemarks" tip="请输入审批备注" verifyType="99" isMandatory="false" isSpring="true"></sys:inputverify>
	                                            </div>
	                                        </div>        
			                            </c:if>
                                    </shiro:hasPermission>
                                     <c:if test="${produceUpdate.checkStatus ne '2' }">
	                                      <div class="form-group">
	                                          <label class="col-sm-2 control-label">审批备注</label>
	                                          <div class="col-sm-9">
	                                              <input type="hidden" name="checkRemarks" id="checkRemarks1" value="${produceUpdate.checkRemarks }"/>
	                                              <input type="text" id="checkRemarks" name="checkRemarks" class="form-control" disabled="disabled" value="${produceUpdate.checkRemarks }"/>
	                                           </div>
	                                     </div>
                                     </c:if>
				                <!-- 审批字段 END -->
				                </div>
				                
				                <div class="col-md-6">
				                    <div class="form-group">
				                        <label class="col-sm-2 control-label">新采购价</label>
				                        <div class="col-sm-9">
				                            <c:choose>
				                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
						                            <sys:inputverify id="desPricePurchase" name="desPricePurchase" maxlength="8" tip="请输入新采购价,两位小数,必填项" verifyType="9"  isSpring="true"></sys:inputverify>
				                                </c:when>
				                                <c:otherwise>
				                                    <input type="text" class="form-control" disabled="disabled" id="desPricePurchase" name="desPricePurchase" value="${produceUpdate.desPricePurchase }"/>
				                                </c:otherwise>
				                            </c:choose>
				                        </div>
				                    </div>
				                    <div class="form-group">
				                       <label class="col-sm-2 control-label">新运算成本价</label>
				                       <div class="col-sm-9">
				                            <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
                                                    <sys:inputverify id="desPriceOperation" name="desPriceOperation"  maxlength="8"  tip="请输入新运算成本价,两位小数,必填项" verifyType="9"  isSpring="true"></sys:inputverify>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="form-control" disabled="disabled" id="desPriceOperation" name="desPriceOperation" value="${produceUpdate.desPriceOperation }"/>
                                                </c:otherwise>
                                            </c:choose>
				                       </div>
				                    </div>
				                    <div class="form-group">
                                        <label class="col-sm-2 control-label">新购买价格</label>
                                        <div class="col-sm-9">
                                            <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
                                                    <sys:inputverify id="desPriceBuy" name="desPriceBuy"  maxlength="8"  tip="请输入新购买价格,两位小数,必填项" isMandatory="false" verifyType="9"  isSpring="true"></sys:inputverify>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="form-control" disabled="disabled" id="desPriceBuy" name="desPriceBuy" value="${produceUpdate.desPriceBuy }"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">新购买打折比例</label>
                                        <div class="col-sm-9">
                                            <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
                                                    <sys:inputverify id="desScaleDiscount" name="desScaleDiscount"  maxlength="9"  tip="请输入新购买打折比例,两位小数,必填项" isMandatory="false" verifyType="9"  isSpring="true"></sys:inputverify>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="form-control" disabled="disabled" id="desScaleDiscount" name="desScaleDiscount" value="${produceUpdate.desScaleDiscount }"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
				                    <div class="form-group">
				                        <label class="col-sm-2 control-label">新是否可购买</label>
				                        <div class="col-sm-9">
				                            <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
                                                    <sys:selectverify name="desIsBuy" tip="请选择" verifyType="" dictName="yes_no" id="desIsBuy"></sys:selectverify>
                                                </c:when>
                                                <c:otherwise>
                                                    <sys:selectverify name="desIsBuy" tip="请选择" verifyType="" dictName="yes_no" id="desIsBuy" disabled="true"></sys:selectverify>
                                                </c:otherwise>
                                            </c:choose>
				                        </div>
				                    </div>
				                    <div class="form-group">
				                       <label class="col-sm-2 control-label">新是否可体验</label>
				                       <div class="col-sm-9">
				                            <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
                                                    <sys:selectverify name="desIsExperience" tip="请选择" verifyType="" dictName="yes_no" id="desIsExperience"></sys:selectverify>
                                                </c:when>
                                                <c:otherwise>
                                                    <sys:selectverify name="desIsExperience" tip="请选择" verifyType="" dictName="yes_no" id="desIsExperience" disabled="true"></sys:selectverify>
                                                </c:otherwise>
                                            </c:choose>
				                       </div>
				                   </div>
				                   <div class="form-group">
				                       <label class="col-sm-2 control-label">新是否可预购</label>
				                       <div class="col-sm-9">
				                            <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
                                                    <sys:selectverify name="desIsForebuy" tip="请选择" verifyType="" dictName="yes_no" id="desIsForebuy"></sys:selectverify>
                                                </c:when>
                                                <c:otherwise>
                                                    <sys:selectverify name="desIsForebuy" tip="请选择" verifyType="" dictName="yes_no" id="desIsForebuy" disabled="true"></sys:selectverify>
                                                </c:otherwise>
                                            </c:choose>
				                       </div>
				                   </div>
				                   <div class="form-group">
				                       <label class="col-sm-2 control-label">新是否可预约</label>
				                       <div class="col-sm-9">
				                            <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
                                                    <sys:selectverify name="desIsForeexperience" tip="请选择" verifyType="" dictName="yes_no" id="desIsForeexperience"></sys:selectverify>
                                                </c:when>
                                                <c:otherwise>
                                                    <sys:selectverify name="desIsForeexperience" tip="请选择" verifyType="" dictName="yes_no" id="desIsForeexperience" disabled="true"></sys:selectverify>
                                                </c:otherwise>
                                            </c:choose>
				                       </div>
				                   </div>
				                   <div class="form-group">
                                       <label class="col-sm-2 control-label">新体验费收取比例</label>
                                       <div class="col-sm-9">
                                            <c:choose>
                                                <c:when test="${produceUpdate.checkStatus eq '1' }"><!-- 新建状态可以编辑，其他状态只能查看 -->
                                                    <sys:inputverify id="desScaleExperience" name="desScaleExperience"  maxlength="9"  tip="请输入新体验费收取比例,两位小数,必填项" isMandatory="true" verifyType="9"  isSpring="true"></sys:inputverify>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="form-control" disabled="disabled" id="desScaleExperience" name="desScaleExperience" value="${produceUpdate.desScaleExperience }"/>
                                                </c:otherwise>
                                            </c:choose>
                                       </div>
                                   </div>
				                   <div class="form-group">
                                       <label class="col-sm-2 control-label">备注信息</label>
                                       <div class="col-sm-9">
                                           <c:choose>
                                              <c:when test="${produceUpdate.checkStatus eq '1'}">
                                                   <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200"  class="form-control"/>
                                              </c:when>
                                              <c:otherwise>
                                                  <textarea rows="4" cols="" class="form-control" style="margin-left: 0px; margin-right: 0px; width: 565px;" disabled="disabled">${produceUpdate.remarks }</textarea>
                                              </c:otherwise>
                                           </c:choose>
                                       </div>
                                   </div>
				                   
				                   
				                </div>
                            </div>
			               
		                   <div class="box-footer">
	                            <div class="pull-left box-tools">
	                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	                            </div>
	                            <div class="pull-right box-tools">
		                              <%--  <c:if test="${not empty produceUpdate.id and produceUpdate.checkStatus eq '2'}">
			                                <shiro:hasPermission name="lgt:ps:produceUpdate:edit"><button type="button" class="btn btn-primary btn-sm" onclick="approve(0);"><i class="fa fa-close"></i>撤销审批</button></shiro:hasPermission>
		                               </c:if> --%>
		                               <c:if test="${produceUpdate.checkStatus eq '1' }">
			                                <shiro:hasPermission name="lgt:ps:produceUpdate:edit"><button type="button" class="btn btn-info btn-sm" onclick="approve(1);"><i class="fa fa-check"></i>提交审批</button></shiro:hasPermission>
		                               </c:if>
		                               <c:if test="${produceUpdate.checkStatus eq '2' }">
			                                <shiro:hasPermission name="lgt:ps:produceUpdate:approve"><button type="button" class="btn btn-primary btn-sm" onclick="approve(2);"><i class="fa fa-thumbs-o-down"></i>审批驳回</button></shiro:hasPermission>
			                                <shiro:hasPermission name="lgt:ps:produceUpdate:approve"><button type="button" class="btn btn-success btn-sm" onclick="approve(3);"><i class="fa fa-thumbs-o-up"></i>审批通过</button></shiro:hasPermission>
		                               </c:if>
	                            </div>
		                   </div>
                       </div>
                   </div>
               </div>
           </div>
      </form:form>
    </div>
</section>
<script type="text/javascript">
     $(function() {
    	 $("#produceBtn").on("click", function() {
    		    $("#inputForm").attr("action", "${ctx}/lgt/ps/produceUpdate/form");
    		    $("#inputForm").submit();  		 
    	 });
    	 
     });

     function approve(type) {
    	  if(type == 0) {
    		  $("#checkStatus").val("1");//撤销审批，状态变更为新建
    		  $("#inputForm").attr("action", "${ctx}/lgt/ps/produceUpdate/save");
    	  } else if(type == 2) {
    		  $("#checkStatus").val("1");//驳回审批，状态变更为新建
              $("#inputForm").attr("action", "${ctx}/lgt/ps/produceUpdate/approve");
    	  } else if(type == 1){
    		  //表单提交验证
    		  var pcode = $("#pcode").val();
    		  if(pcode == null || pcode == "") {
    			  ZF.showTip("请输入产品编码,获取产品信息","info");
                  return false;
    		  }
    		  var pname = $("#pname").val();
    		  if(pname == null  || pname == "") {
    			  ZF.showTip("请先根据产品编码，获取产品名称及相关信息","info");
                  return false;
    		  }
    		  //新采购价
              var desPricePurchase = $("#desPricePurchase").val();
              if(desPricePurchase == null || desPricePurchase == "") {
                  ZF.showTip("请输入新采购价","info");
                  return false;
              }
              //新运算成本价
              var desPriceOperation = $("#desPriceOperation").val();
              if(desPriceOperation == null || desPriceOperation == "") {
                  ZF.showTip("请输入新运算成本价","info");
                  return false;
              }
              //新是否可购买
              var desIsBuy = $("#desIsBuy").val();
              if(desIsBuy == null || desIsBuy == "") {
                  ZF.showTip("请选择新是否可购买","info");
                  return false;
              }
              //新购买价格
              var desPriceBuy = $("#desPriceBuy").val();
              if(desPriceBuy == null || desPriceBuy == "") {
                  ZF.showTip("请输入新购买价格","info");
                  return false;
              }
            　　　　　//新购买打折比例
              var desScaleDiscount = $("#desScaleDiscount").val();
              if(desScaleDiscount == null || desScaleDiscount == "") {
                  ZF.showTip("请输入新购买打折比例","info");
                  return false;
              }
              //新是否可体验
              var desIsExperience = $("#desIsExperience").val();
              if(desIsExperience == null || desIsExperience == "") {
                  ZF.showTip("请选择新是否可体验","info");
                  return false;
              }
              //新是否可预购
              var desIsForebuy = $("#desIsForebuy").val();
              if(desIsForebuy == null || desIsForebuy == "") {
                  ZF.showTip("请选择新是否可预购","info");
                  return false;
              }
              //新是否可预约
              var desIsForeexperience = $("#desIsForeexperience").val();
              if(desIsForeexperience == null || desIsForeexperience == "") {
                  ZF.showTip("请选择新是否可预约","info");
                  return false;
              }
    		  $("#checkStatus").val("2");//提交审批，状态变更为待审批
    		  $("#inputForm").attr("action", "${ctx}/lgt/ps/produceUpdate/save");
    	  } else if(type = 3) {
    		//审批信息提交验证
    		 /*  var checkRemarks = $("#checkRemarks").val();
    		  if(checkRemarks == null || checkRemarks == "") {
                  ZF.showTip("请填写审批备注","info");
                  return false;
              } */
    		  $("#checkStatus").val("3");//审批通过，状态变更为审批通过
	    	  $("#inputForm").attr("action", "${ctx}/lgt/ps/produceUpdate/approve");
    	  }	 
    	  $("#inputForm").submit();
     }
</script>
</div>
</body>
</html>