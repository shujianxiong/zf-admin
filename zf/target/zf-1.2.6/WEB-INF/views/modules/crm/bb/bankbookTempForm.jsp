<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>资金账户条目管理</title>
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
			<small><i class="fa-list-style"></i><a
				href="${ctx}/crm/bb/bankbookTemp/">资金账户条目列表</a></small>
			<shiro:hasPermission name="crm:bb:bankbookTemp:edit">
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/crm/bb/bankbookTemp/form?id=${bankbookTemp.id}">资金账户条目${not empty bankbookTemp.id?'修改':'添加'}</a></small>
			</shiro:hasPermission>
		</h1>
	</section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="bankbookTemp" action="${ctx}/crm/bb/bankbookTemp/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            <form:hidden path="status"/>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">会员账号</label>
                                    <div class="col-sm-9">
                                        <c:choose>
                                            <c:when test="${empty bankbookTemp.id }">
                                                <sys:inputverify id="musercode" name="bankbookBalance.member.usercode" value="${fns:getMemberById(bankbookTemp.bankbookBalance.member.id).usercode }" tip="请输入会员账号，必填项" verifyType="0" isMandatory="true" isSpring="false"></sys:inputverify>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="bankbookBalance.member.usercode" value="${fns:getMemberById(bankbookTemp.bankbookBalance.member.id).usercode }" />
                                                <input type="text" readonly="readonly" class="form-control zf-input-readonly" value="${fns:getMemberById(bankbookTemp.bankbookBalance.member.id).usercode }" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">变动类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="changeType" tip="请选择" verifyType="0" dictName="crm_bb_bankbook_changeType" id="changeType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">资金类型</label>
                                    <div class="col-sm-9">
                                        <select name="moneyType" id="moneyType" class="form-control select2">
                                            <option value="-1">请选择</option>
	                                        <c:forEach items="${moneyTypeList }" var="mt">
	                                            <option value="${mt.value }"  <c:if test="${mt.value eq bankbookTemp.moneyType }">selected</c:if>>${mt.label }</option>
	                                        </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">变动金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="money" name="money" tip="请输入变动金额，必填项" verifyType="5"  isSpring="true" isMandatory="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
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
                                <c:if test="${empty bankbookTemp.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="crm:bb:bankbookTemp:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
    	
    	$("#changeType").on("change", function() {
    		var selVal = $(this).val();
            ZF.ajaxQuery(true,"${ctx}/sys/dict/listByTypeAndValueLike",{"type":"crm_bb_bankbook_moneyType", "value":selVal},function(data){
                  var html = "<select class=\"form-control select2\"><option value=\"-1\">请选择</option>";
                  for(var i=0;i<data.length;i++){
                      html += "<option value="+data[i].value+" >"+data[i].label+"</option>";
                  }
                  html += "</select>";
                  $("#moneyType").select2("val","-1");
                  $("#moneyType").html(html);
            })
    	});
    	
    	$("#moneyType").on("change", function() {
            var val = $(this).val();
            if(val == null  || val == "" || moneyType == "-1" || val == undefined) {
                if($("#moneyTypeErr").length<=0)
                    $("#moneyType").next().after("<label id=\"moneyTypeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择变动类型，必选项</label>");
                $("#moneyType").attr("data-verify","false");
                return false;
            } else {
                $("#moneyTypeErr").remove();
                $("#moneyType").attr("data-verify","true");
            }
        });
    	
    });
    
    
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
        if(verify) {
        	var moneyType = $("#moneyType").val();
        	if(moneyType == null || moneyType == "" || moneyType == "-1" || moneyType == undefined) {
        		$("#moneyType").addClass("zf-input-err");
        		if($("#moneyTypeErr").length<=0)
                    $("#moneyType").next().after("<label id=\"moneyTypeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择变动类型，必选项</label>");
                verify = false;
        	}
        }
        
        return verify;
    }
</script>
</body>
</html>