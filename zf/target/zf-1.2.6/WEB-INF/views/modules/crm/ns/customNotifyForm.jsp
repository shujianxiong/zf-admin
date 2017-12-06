<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>自定义消息管理</title>
    <meta name="decorator" content="adminLte"/>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/crm/ns/customNotify/">自定义消息列表</a></small>
            <shiro:hasPermission name="crm:ns:customNotify:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/crm/ns/customNotify/form?id=${notify.id}">自定义消息${not empty notify.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="notify" action="${ctx}/crm/ns/customNotify/save" method="post" class="form-horizontal">
                	<input type="hidden" id="memberIds" name="memberIds" >
                	<input type="hidden" id="notifyMemberVOType" name="notifyMemberVO.type" >
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
                                        <form:select path="type" htmlEscape="false" maxlength="50" class="form-control select2" disabled="true">
											<form:option value="4" label="自定义消息"/>
										</form:select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">会员</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="text" name="usercode" id="usercode" placeholder="必选项" class="form-control zf-input-readonly" readonly="readonly"/>
                                            <span class="input-group-btn">
                                                <button id="memberButton" type="button" class="btn btn-info btn-flat">选择会员</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="title" name="title" tip="请输入标题，必填项" maxlength="50" verifyType="-1"  isSpring="true"></sys:inputverify>
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
    
<%--     <sys:selectmutil id="memberSelect" title="会员列表" url="" isDisableCommitBtn="true" width="1500" height="700" ></sys:selectmutil> --%>
		<div id="memberSelectModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="录入产品促销折扣信息" aria-hidden="true">
			<div class="modal-dialog" style="width: 1500px; height: 700px;">
				<div class="modal-content" style="width: 100%; height: 100%;">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">选择会员信息</h4>
					</div>
					<div class="modal-body" style="width: 100%; height: 80%;">
         				<input type="hidden" id="memberSelectModalUrl" />
            			<iframe id="memberSelectIframe" src="" width="100%" height="100%" frameborder="0"></iframe>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="commitBtn">提交生成</button>
						<button type="button" class="btn btn-success" id="allBtn">全部提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
				<!-- /.modal -->
		</div>
	</div>

	<script type="text/javascript">
		var memberFlag = false;
		$(function() {

			localStorage.removeItem('usercode');
			//读取 
		    let str = localStorage.getItem('memberMap');
			map = JSON.parse(str);
			let memberIds = [];
			for(let prop in map){
			    if(map.hasOwnProperty(prop)){
			    	localStorage.removeItem(prop); 
			    }
			}
			localStorage.removeItem('memberMap');
			
			$("#memberButton").on('click',function() {
				if($("#memberSelectIframe").attr("src")==null || $("#memberSelectIframe").attr("src")==undefined
						|| $("#memberSelectIframe").attr("src")==""){
					$("#memberSelectIframe").attr("src","${ctx}/crm/mi/member/notifySelect");
				}
				$("#memberSelectModal").modal('toggle');//显示模态框
			});

			$("#memberSelectModal #commitBtn").on("click",function() {
				$("#memberSelectModal").modal("hide");
				//读取 
			    let str = localStorage.getItem('memberMap');
				map = JSON.parse(str);
				let memberIds = [];
				for(var prop in map){
				    if(map.hasOwnProperty(prop)){
				        for(let i=0;i<map[prop].length;i++){
				        	memberIds.push(map[prop][i]);
				        }
				    }
				}
				console.log(memberIds);
				if (memberIds != undefined&& memberIds.length > 0) {
					let usercode = localStorage.getItem("usercode");
					if(usercode){
						$("#usercode").val(usercode + "等" + memberIds.length+ "名会员");
					}else{
						$("#usercode").val("共选择了" + memberIds.length+ "名会员");
					}
					$("#memberIds").val(memberIds);
					$("#notifyMemberVOType").val('');
					memberFlag = true;
				}else{
					memberFlag = false;
				}
			});
			
			$("#memberSelectModal #allBtn").on("click",function() {
				var table = $("#memberSelectIframe").contents().find("tbody");
				if($(table).children("tr").length <= 1){
					ZF.showTip("请先查询到有效的会员信息！", "info");
					memberFlag = false;
					return false;
				}else{
					$("#memberSelectModal").modal("hide");
					var form = $("#memberSelectIframe").contents().find("form");
					//先获取数据
					$("select", form).each(function(){
						$("#notifyMemberVOType").val($(this).val());
					});
					let me;
					$("input[type=text]", form).each(function(){
						me = $(this).clone();
						me.removeAttr("data-verify");
						me.attr('type', 'hidden');
						me.attr("name","notifyMemberVO."+$(this).attr('id'));
						$("#memberIds").after(me);
					});
					$("#usercode").val('按条件全部提交');
					memberFlag = true;
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
        	});
		});
		
		function formSubmit() {
			if(memberFlag){
				let flag = ZF.formSubmit();
				console.log(flag)
				if (flag) {
					confirm('确定要立即发布该消息吗？', 'warning', function() {
						localStorage.removeItem('usercode');
						//读取 
					    let str = localStorage.getItem('memberMap');
						map = JSON.parse(str);
						let memberIds = [];
						for(let prop in map){
						    if(map.hasOwnProperty(prop)){
						    	localStorage.removeItem(prop); 
						    }
						}
						localStorage.removeItem('memberMap');
						$("#inputForm").submit();
					});
				}
				return flag;
			}else{
				ZF.showTip("请先选择会员！", "info");
				return memberFlag;
			}
		}
	</script>

</body>
 
</html>