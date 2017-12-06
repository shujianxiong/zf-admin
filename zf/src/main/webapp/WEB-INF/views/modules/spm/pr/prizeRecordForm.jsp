<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品领取记录管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section  class="content-header content-header-menu">
		<h1>
			<small><i class="fa-list-style"></i><a href="${ctx}/spm/pr/prizeRecord/list">奖品领取记录列表</a></small>
			
			<shiro:hasPermission name="spm:pr:prizeRecord:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/pr/prizeRecord/form?id=${prizeRecord.id}">奖品领取记录${not empty prizeRecord.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="prizeRecord" action="${ctx}/spm/pr/prizeRecord/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
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
								<label class="col-sm-2 control-label">会员</label>
								<div class="col-sm-9">
									<div class="input-group">
										<form:hidden path="member.id" class="form-control" id="memberId"/>
										<form:input path="member.usercode" class="form-control zf-input-readonly" htmlEscape="false" maxlength="50" placeholder="请选择" readonly="true" id="memberUsercode" onclick="selectMember();"/>
										<span class="input-group-addon" onclick="selectMember();"><i class="fa fa-search"></i></span>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">奖品</label>
								<div class="col-sm-9">
									<div class="input-group">
										<form:hidden path="prize.id" id="prizeId"/>
										<form:input path="prize.name" class="form-control zf-input-readonly" htmlEscape="false" maxlength="50" placeholder="请选择" readonly="true" id="prizeName" onclick="selectPrize();"/>
										<span class="input-group-addon" onclick="selectPrize();"><i class="fa fa-search"></i></span>
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">领取原因</label>
								<div class="col-sm-9">
									<sys:selectverify name="reasonType" tip="请选择领取原因,必填项" verifyType="0" dictName="SPM_PR_PRIZE_RECORD_REASON_TYPE" id="reasonType"></sys:selectverify>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">领取状态</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="receiveStatus" items="${fns:getDictList('SPM_PR_PRIZE_RECORD_RECEIVE_STATUS')}"  itemLabel="label" itemValue="value" class="minimal" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;" htmlEscape="false"/>
								</div>
							</div>
							
							<div class="form-group" id="rTime" style="display: none;">
								<label class="col-sm-2 control-label">领取时间</label>
								<div class="col-sm-9">
									<sys:datetime id="receiveTime" inputName="receiveTime" tip="请选择领取时间" isMandatory="false" value="${prizeRecord.receiveTime }" inputId="receiveTimeID"></sys:datetime>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-9">
									<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
		    					<c:if test="${empty prizeRecord.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="spm:pr:prizeRecord:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<sys:selectmutil id="select" title="会员列表" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
	</section>
	</div>
	<script type="text/javascript">
		$(function() {
			
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});
			
			$("input[type='radio'][name='receiveStatus']").on("ifChecked", function() {
				var status = $(this).val();
				if(status == 1) {
					$("#rTime").show();
				} else {
					$("#rTime").hide();
				}
			});
			
			var checkVal = $("input[type='radio'][name='receiveStatus']:checked").val();
		 	if(checkVal == 1) {
		 		$("#rTime").show();
		 	} else {
		 		$("#rTime").hide();
		 	}
			
		});
		
		
		
		function formSubmit() {
			var verify=true;
			var inputs=$("input[data-verify=false]");
			for(var i=0;i<inputs.length;i++){
				if($(inputs[i]).attr('data-type') == "date"){
					$(inputs[i]).parent().trigger('dp.change');
				}else{
					$(inputs[i]).trigger('change');
				}
				verify=false;
			}
			var selects=$("select[data-verify=false]");
			for(var i=0;i<selects.length;i++){
				$(selects[i]).trigger('change');
				verify=false;
			}
			
			var mcode = $("#memberUsercode").val();
			if(mcode == null || mcode == '') {
				$("#memberUsercode").addClass("zf-input-err");
				if($("#memberUsercodeErr").length<=0)
					$("#memberUsercode").after("<label id=\"memberUsercodeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择领取会员，必选项</label>");
				$("#memberUsercode").attr("data-verify","false");
				verify = false;
			}
			var pname = $("#prizeName").val();
			if(pname == null || pname == '') {
				$("#prizeName").addClass("zf-input-err");
				if($("#prizeNameErr").length<=0)
					$("#prizeName").after("<label id=\"prizeNameErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择待领取奖品，必选项</label>");
				$("#memberUsercode").attr("data-verify","false");
				verify = false;
			}
			
			if(verify){
				$("button[type=submit]").attr('disabled',true);
			}
			
			return verify;
		}
		
		function selectMember() {
			var url="${ctx}/crm/mi/member/select?memberStatus=1&usercodeStatus=1&blackwhiteStatus=1";
			$(".modal-title").text("选择会员")
			$("#selectModalUrl").val(url);
			$("#commitBtn").unbind("click");
			$("#commitBtn").on("click",function () {
				var content = $("#selectModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
				$("input[type=radio]", content).each(function(){
    				if($(this).prop("checked")){
    					//重新选择产品清空原来数据
						$("tr",$("#tableList")).each(function(){
							$(this).remove();
						})
						$("#memberId").val($(this).val());
						$("#memberUsercode").val($(this).attr("data-name"));
						
						$("#memberUsercode").removeClass("zf-input-err");
						$("#memberUsercode").attr("data-verify","true");
						
						if($("#memberUsercodeErr").length > 0) {
							$("#memberUsercodeErr").remove();
						}
						
						$("#selectModal").modal('hide');
    				}
    			});
			});
			$("#selectModal").modal('toggle');
		}
		
		function selectPrize() {
			var url="${ctx}/spm/pr/prize/select?status=3";
			$(".modal-title").text("选择奖品")
			$("#selectModalUrl").val(url);
			$("#commitBtn").unbind("click");
			$("#commitBtn").on("click",function () {
				var content = $("#selectModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
				$("input[type=radio]", content).each(function(){
    				if($(this).prop("checked")){
    					//重新选择产品清空原来数据
						$("tr",$("#tableList")).each(function(){
							$(this).remove();
						})
						$("#prizeId").val($(this).val());
						$("#prizeName").val($(this).attr("data-name"));
						
						$("#prizeName").removeClass("zf-input-err");
						$("#prizeName").attr("data-verify","true");
						
						if($("#prizeNameErr").length > 0) {
							$("#prizeNameErr").remove();
						}
						
	    				$("#selectModal").modal('hide');
    				}
    			});
			});
			$("#selectModal").modal('toggle');
		}
	</script>
</body>
</html>