<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>售后工单管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/ser/as/workorder/myCreateList">我的售后工单</a></small>
            <shiro:hasPermission name="ser:as:workorder:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/ser/as/workorder/form?id=${workorder.id}">售后工单${not empty workorder.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="workorder" action="${ctx}/ser/as/workorder/save" method="post" class="form-horizontal">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                                <%-- <div class="form-group">
                                    <label class="col-sm-2 control-label">工单编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="workorderNo" name="workorderNo" tip="请输入工单编号" forbidInput="true" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div> --%>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">工单类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="workorderType" tip="请选择工单类型" verifyType="" dictName="ser_as_workorder_workorderType" id="workorderType"></sys:selectverify>
                                    </div>
                                </div>
                                <input type="hidden" name="status" id="status" value="${workorder.status }"/>
                               <%--  <div class="form-group">
                                    <label class="col-sm-2 control-label">工单状态</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="status" tip="请选择工单状态" verifyType="" dictName="ser_as_workorder_status" id="status"></sys:selectverify>
                                    </div>
                                </div> --%>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">会员</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="hidden" id="mid" name="member.id" value="${workorder.member.id }"/>
                                            <input type="text" name="usercode" id="usercode" value="${workorder.usercode }" placeholder="必选项" class="form-control zf-input-readonly" readonly="true"/>
                                            <span class="input-group-btn">
                                                <button id="memberButton" type="button" class="btn btn-info btn-flat">选择会员</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <sys:selectmutil id="memberSelect" title="会员列表" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
                                <sys:selectmutil id="orderSelect" title="订单列表" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
                                
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="orderType" tip="请选择订单类型" verifyType="" dictName="bus_order_type" id="orderType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">订单</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="hidden" id="orderId" name="orderId" value="${workorder.orderId }"/>
                                            <input type="text" name="orderNo" id="orderNo" value="${workorder.orderNo }" placeholder="必选项" class="form-control zf-input-readonly" readonly="true"/>
                                            <span class="input-group-btn">
                                                <button id="orderButton" type="button" class="btn btn-info btn-flat">选择订单</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">相关图片</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="photosUrl" path="photosUrl" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="photosUrl" model="false" selectMultiple="true" fileDirCode="workorder"></sys:fileUpload>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">问题描述</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">被指派人</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="hidden" id="userId" name="appointedUser.id" value="${appointedUser.id }"/>
                                            <input type="text" name="appointedUser.name" id="userName" value="${appointedUser.name }" placeholder="必选项" class="form-control zf-input-readonly" readonly="true"/>
                                            <span class="input-group-btn">
                                                <button id="userButton" type="button" class="btn btn-info btn-flat">选择指派人</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">要求完成时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="requiredTime" inputName="workorderDeal.requiredTime" tip="请选择要求完成时间" inputId="requiredTimeId" isMandatory="true" minDate="${curDate }" value="${workorderDeal.requiredTime}"></sys:datetime>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">要求处理方式</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="workorderDeal.requiredDealtype" tip="请选择要求处理方式" verifyType="" dictName="ser_as_workorder_deal_RequiredDealtype" id="requiredDealtype" isMandatory="false"></sys:selectverify>
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
                                <c:if test="${empty workorder.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="ser:as:workorder:edit"><button type="button" onclick="return formSubmit();" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
        <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
            width="550" isOffice="false" isMulti="false" title="人员选择"
            id="selectUser" ></sys:userselect>
        
    </section>
    </div>
    <script type="text/javascript">
    $(function() {
    	
    	$("#orderButton").on('click',function(){
    		var type = $("#orderType").val();
    		var usercode = $("#usercode").val();
            	
    		if(type == null || type == "" || type == undefined || usercode == null || usercode == "" || usercode == undefined) {
    			ZF.showTip("请先选择会员账号和订单类型!", "info");
    			return false;
    		}
    		var url = "";
    		var mid = $("#mid").val();
    		if(type == 1) {
    			url = "${ctx}/bus/oe/experienceOrder/select?type="+1+"&member.id="+mid;
    		} else if(type == 2) {
    			url = "${ctx}/bus/oe/experienceOrder/select?type="+2+"&member.id="+mid;
    		} else if(type == 3) {
    			url = "${ctx}/bus/ob/buyOrder/select?type="+1+"&member.id="+mid;
            } else if(type == 4) {
            	url = "${ctx}/bus/ob/buyOrder/select?type="+2+"&member.id="+mid;
            }
            $("#orderSelectModalUrl").val(url)//带参数请求URL设置方式
            $("#orderSelectModal").modal('toggle');//显示模态框
        });
        
        $("#orderSelectModal #commitBtn").on("click",function () {
            $("#orderSelectModal").modal("hide");       
            var content = $("#orderSelectModalIframe").contents().find("body");
            $("input[type=radio]", content).each(function(){
                if($(this).prop("checked")){
                    var selVal = $(this).val();
                    $("#orderId").val(selVal);
                    $("#orderNo").val($(this).attr("data-name"));
                    $("button[type=submit]").attr('disabled',false);
                    $("#orderNo").removeClass("zf-input-err");
                }
            });
        });
        
        $("#memberButton").on('click',function(){
            $("#memberSelectModalUrl").val("${ctx}/crm/mi/member/select")//带参数请求URL设置方式
            $("#memberSelectModal").modal('toggle');//显示模态框
        });
        
        $("#memberSelectModal #commitBtn").on("click",function () {
            $("#memberSelectModal").modal("hide");       
            var content = $("#memberSelectModalIframe").contents().find("body");
            $("input[type=radio]", content).each(function(){
                if($(this).prop("checked")){
                    var selVal = $(this).val();
                    $("#mid").val(selVal);
                    $("#usercode").val($(this).attr("data-name"));
                    $("button[type=submit]").attr('disabled',false);
                    $("#usercode").removeClass("zf-input-err");
                }
            });
        });
    	
        
        $("#userButton").on("click", function() {
            selectUserinit({
                "selectCallBack" : function(list) {
                    $("#userId").val(list[0].id);
                    $("#userName").val(list[0].text);
                }
            })
            
            $("button[type=submit]").attr('disabled',false);
            $("#userName").removeClass("zf-input-err");
        });
        
        
        $("#description").on("change", function() {
        	$("button[type=submit]").attr('disabled',false);
            $("#description").removeClass("zf-input-err");
        });
        
    });
    
    
    
    function formSubmit() {
    	
    	var flag = ZF.formSubmit();
    	
    	if(flag) {
	    	//会员
	    	var usercode = $("#usercode").val();
	    	if(usercode == null || usercode == "" || usercode == undefined) {
	    		ZF.showTip("请选择关联的会员!", "info");
	    		$("#usercode").addClass("zf-input-err");
	    		return false;
	    	}
	    	//订单
	    	var orderNo = $("#orderNo").val();
	    	if(orderNo == null || orderNo == "" || orderNo == undefined) {
	            ZF.showTip("请选择关联的订单!", "info");
	            $("#orderNo").addClass("zf-input-err");
	            return false;
	        }
	    	//指派人 
	    	var userName = $("#userName").val();
	    	if(userName == null || userName == "" || userName == undefined) {
	            ZF.showTip("请选择指派人!", "info");
	            $("#userName").addClass("zf-input-err");
	            return false;
	        }
	    	
	    	//相关图片
	    	/*var photosUrl = $("#photosUrl").val();
	    	if(photosUrl == null || photosUrl == "" || photosUrl == undefined) {
                ZF.showTip("请上传相关图片证明!", "info");
                $("button[type=submit]").attr('disabled',false);
                return false;
            }*/
	    	
	    	//描述
	    	var description = $("#description").val();
	    	if(description == null || description == "" || description == undefined) {
                ZF.showTip("请填写售后描述说明!", "info");
                $("#description").addClass("zf-input-err");
                return false;
            }
    	} 
    	
    	if(flag) {
	    	confirm("售后工单提交后不能修改，是否继续提交?", "info", function() {
	    		console.log("==============提交");
	    		$("#inputForm").submit();
	    	}, function() {
	    		console.log("==============取消");
	    	});
    	}
    }
    </script>
</body>
</html>