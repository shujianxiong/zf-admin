<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>消息管理</title>
    <meta name="decorator" content="adminLte"/>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/crm/ns/notify/">消息列表</a></small>
            <shiro:hasPermission name="crm:ns:notify:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/crm/ns/notify/form?id=${notify.id}">消息${not empty notify.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="notify" action="${ctx}/crm/ns/notify/save" method="post" class="form-horizontal">
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
                                    <label class="col-sm-2 control-label">类型</label>
                                    <div class="col-sm-9">
                                        <form:select path="type" data-verify="false" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option value="" label="请选择"/>
											<form:option value="1" label="公告"/>
											<form:option value="2" label="提醒"/>
											<form:option value="3" label="信息"/>
										</form:select>
                                    </div>
                                </div>
                                <div id="remindTargetTypeDiv" class="form-group">
                                    <label class="col-sm-2 control-label">目标类型</label>
                                    <div class="col-sm-9">
                                    	<form:select path="remindTargetType" data-verify="false" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option value="" label="请选择"/>
											<form:options items="${fns:getDictList('crm_ns_notify_remindTargetType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
                                    </div>
                                </div>
                                <div id="remindTargetActionDiv" class="form-group">
                                    <label class="col-sm-2 control-label">目标动作类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="remindTargetAction" tip="请选择目标动作类型" verifyType="-1" dictName="crm_ns_notify_remindTargetAction" id="remindTargetAction"></sys:selectverify>
                                    </div>
                                </div>
                                <div id="messageCodeDiv" class="form-group">
                                    <label class="col-sm-2 control-label">编码</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="messageCode" name="messageCode" tip="请输入编码，必填项" maxlength="64" verifyType="-1"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="title" name="title" tip="请输入标题，必填项" maxlength="188" verifyType="-1"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">内容</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="content" htmlEscape="false" data-verify="false" rows="4" maxlength="200" placeholder="请输入内容，必填项" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">短信标记</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="smsFlag" tip="请选择消息类型" verifyType="-1" dictName="yes_no" id="smsFlag"></sys:selectverify>
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
                                <c:if test="${empty notify.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="crm:ns:notify:edit"><button type="button" onclick="formSubmit();" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
            
        	var remindTargetActionDicts = ${fns:getDictListJson('crm_ns_notify_remindTargetAction')};
        	var notify = ${fns:toJson(notify)};
        	console.log(notify);
        	
        	
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });

			$("#messageCodeDiv").css('display', 'none');
			$("#remindTargetTypeDiv").css('display', 'none');
			$("#remindTargetActionDiv").css('display', 'none');
            
           	ZF.formVerify(true,-1,$("#type").val())?$("#type").attr("data-verify","true"):$("#type").attr("data-verify","false");
            $("#type").on("change", function(){
           		if(!ZF.formVerify(true,-1,$(this).val())){
           			$("span[role=combobox]",$(this).next()).addClass("zf-input-err")
           			if($("#typeErr").length<=0)
           				$(this).next().after("<label id=\"typeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择类型</label>")
           			$(this).attr("data-verify","false");
       				$("#messageCodeDiv").css('display', 'none');
       				$("#remindTargetTypeDiv").css('display', 'none');
       				$("#remindTargetActionDiv").css('display', 'none');
       				$("input[data-verify]").val('');
       				$("textarea[data-verify]").val('');
           		}else{
           			if($("#typeErr").length>0){
           				$("span[role=combobox]",$(this).next()).removeClass("zf-input-err");
           				$("#typeErr").remove();
           			}
           			$(this).attr("data-verify","true");
           			if($(this).val() == '1'){
           				$("#messageCodeDiv").css('display', 'none');
           				$("#remindTargetTypeDiv").css('display', 'none');
           				$("#remindTargetActionDiv").css('display', 'none');
           				$("#messageCode").val('');
           				$("#messageCode").attr("data-verify","true");
           				$("#remindTargetType").select2('');
           				$("#remindTargetType").attr("data-verify","true");
           				$("#remindTargetAction").select2('');
           				$("#remindTargetAction").attr("data-verify","true");
           			}else if($(this).val() == '2'){
           				$("#messageCodeDiv").css('display', 'none');
           				$("#remindTargetTypeDiv").css('display', 'block');
           				$("#remindTargetActionDiv").css('display', 'block');
           				$("#messageCode").val('');
           				$("#messageCode").attr("data-verify","true");
           	           	ZF.formVerify(true,0,$("#remindTargetType").val())?$("#remindTargetType").attr("data-verify","true"):$("#remindTargetType").attr("data-verify","false");
           	           	ZF.formVerify(true,0,$("#remindTargetAction").val())?$("#remindTargetAction").attr("data-verify","true"):$("#remindTargetAction").attr("data-verify","false");
           			}else if($(this).val() == '3'){
           				$("#messageCodeDiv").css('display', 'block');
           	           	ZF.formVerify(true,0,$("#messageCode").val())?$("#messageCode").attr("data-verify","true"):$("#messageCode").attr("data-verify","false");
           				$("#remindTargetType").select2('');
           				$("#remindTargetType").attr("data-verify","true");
           				$("#remindTargetAction").select2('');
           				console.log("设置为TRUE")
           				$("#remindTargetAction").attr("data-verify","true");
           				$("#remindTargetTypeDiv").css('display', 'none');
           				$("#remindTargetActionDiv").css('display', 'none');
           			}
           		}
            });
            
            
            ZF.formVerify(true,-1,$("#remindTargetType").val())?$("#remindTargetType").attr("data-verify","true"):$("#remindTargetType").attr("data-verify","false");
            $("#remindTargetType").on("change", function(){
           		if(!ZF.formVerify(true,-1,$(this).val())){
           			if($("#type").val() == '2' ){
           				$("span[role=combobox]",$(this).next()).addClass("zf-input-err")
               			if($("#remindTargetTypeErr").length<=0)
               				$(this).next().after("<label id=\"remindTargetTypeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择目标类型</label>")
               			$(this).attr("data-verify","false");
           			}
					$("#remindTargetAction option").remove();
       				$("#remindTargetAction").prepend("<option value='' selected = selected >请选择</option>"); 
       				for(let remindTargetActionDict of remindTargetActionDicts){
   						$("#remindTargetAction").append('<option value='+remindTargetActionDict.value+'>'+remindTargetActionDict.label+'</option>'); 
       				}
       				$("#remindTargetAction").select2('');
           		}else{
           			if($("#remindTargetTypeErr").length>0){
           				$("span[role=combobox]",$(this).next()).removeClass("zf-input-err");
           				$("#remindTargetTypeErr").remove();
           			}
           			$(this).attr("data-verify","true");
					$("#remindTargetAction option").remove();
       				$("#remindTargetAction").prepend("<option value='' selected = selected >请选择</option>"); 
       				for(let remindTargetActionDict of remindTargetActionDicts){
       					if(!(remindTargetActionDict.value.indexOf($(this).val())<0)){
       						$("#remindTargetAction").append('<option value='+remindTargetActionDict.value+'>'+remindTargetActionDict.label+'</option>'); 
       					}
       				}
       				$("#remindTargetAction").select2('');
           		}
            });
            
            ZF.formVerify(true,-1,$("#content").val())?$("#content").attr("data-verify","true"):$("#content").attr("data-verify","false");
        	$("#content").on("change",function(){
        		if(!ZF.formVerify(true, -1, $(this).val())){
        			$(this).addClass("zf-input-err")
        			if($("#1contentErr").length<=0)
        				$(this).after("<label id=\"1contentErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入消息内容</label>")
        			$(this).attr("data-verify","false");
        		}else{
        			if($("#1contentErr").length>0){
        				$(this).removeClass("zf-input-err");
        				$("#1contentErr").remove();
        			}
        			$(this).attr("data-verify","true");
        		}
        	})
        	
        	if(notify.type&&notify.type!=''){
        		$("#type").trigger('change');
        		$("#remindTargetType").trigger('change');
        		if(notify.remindTargetAction&&notify.remindTargetAction!=''){
	   				$("#remindTargetAction").select2('val',notify.remindTargetAction);
        		}
        		$("#type").attr('disabled', true);
        	}
        });
        
        function formSubmit(){
        	if($("#type").val() == null||$("#type").val() == ''||$("#type").val() == undefined){
        		ZF.showTip("请先选择类型","info");
        		$("#type").trigger("change");
        	}else{
        		let flag = ZF.formSubmit();
            	console.log(flag);
            	if(flag){
            		if($("#publishFlag").val() == '1'){
            			confirm('确定要立即发布改消息吗？','warning',function(){
            				$("#inputForm").submit();	
            			})
            		}else{
        				$("#inputForm").submit();	
            		}
            	}
        	}
        	return false;
        }
    </script>
    
</body>
 
</html>