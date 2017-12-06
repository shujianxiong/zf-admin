<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自动回复列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<meta name="description" id="description" content="autoReply"/>
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
			<small><i class="fa-list-style"></i><a href="${ctx}/wcp/ar/autoReply/list">自动回复列表</a></small>
			
			<shiro:hasPermission name="wcp:ar:autoReply:edit"><small>|</small><small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/wcp/ar/autoReply/form?id=${autoReply.id}">自动回复${not empty autoReply.id?'修改':'添加'}</a></small></shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="autoReply" action="${ctx}/wcp/ar/autoReply/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>请完善表单填写</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						<div class="box-body">
							<form:hidden path="id" />
							<input type="hidden" id="flag" value="0"/>
							<div class="form-group">
								<label class="col-sm-2 control-label">规则代码</label>
								<div class="col-sm-9">
									<%-- <c:choose>
										<c:when test="${empty autoReply.id} ">
											<sys:inputverify id="code" name="code" tip="请输入规则代码，必填项"  verifyType="0" maxlength="60" isSpring="true" isMandatory="true"></sys:inputverify>
										</c:when>
										<c:otherwise>
											<form:hidden path="code"/>
											<input id="code" name="code" class="form-control" disabled="disabled" value="${autoReply.code }"/>
										</c:otherwise>
									</c:choose> --%>
									<sys:inputverify id="code" name="code" tip="请输入规则代码，必填项"  verifyType="0" maxlength="60" isSpring="true" isMandatory="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">规则名称</label>
								<div class="col-sm-9">
									<sys:inputverify id="name" name="name" tip="请输入规则名称，必填项" verifyType="0" maxlength="60" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">关键字</label>
								<div class="col-sm-9">
									<%-- <c:choose>
										<c:when test="${empty autoReply.id} ">
											<sys:inputverify name="keywords" id="keywords" verifyType="0" tip="请填写关键字,多个用逗号分隔，且不能重复，必填项"  maxlength="90" isSpring="true" isMandatory="true"></sys:inputverify>
										</c:when>
										<c:otherwise>
											<form:hidden path="keywords"/>
											<input id="keywords" name="keywords" class="form-control" disabled="disabled"  value="${autoReply.keywords }"/>
										</c:otherwise>
									</c:choose> --%>
									<sys:inputverify name="keywords" id="keywords" verifyType="99" tip="请填写关键字,多个用逗号分隔，且不能重复，必填项"  maxlength="90" isSpring="true" isMandatory="true"></sys:inputverify>
									<%-- <input type="text" name="keywords" id="keywords"  placeholder="请填写关键字,多个用逗号分隔，且不能重复，必填项" value="${autoReply.keywords }" class="form-control"/> --%>
								</div>
							</div>
							<div class="form-group">
	    						<label class="col-sm-2 control-label">类型</label>
								<div class="col-sm-9">
									<sys:selectverify name="contentType" tip="请选择回复内容类型，必填项" verifyType="0" dictName="wcp_ar_auto_reply_contentType" id="contentType"></sys:selectverify>
								</div>
	    					</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属公众号</label>
								<div class="col-sm-9">
									<sys:selectverify name="mp" tip="请选择公众号类型，必填项" verifyType="0" dictName="mp_type" id="mp"></sys:selectverify>
								</div>
							</div>
	    					<div class="form-group" id="textType">
								<label class="col-sm-2 control-label">文本</label>
								<div class="col-sm-9">
									<%--<sys:inputverify id="text" name="text" tip="请输入文本消息" verifyType="0" maxlength="60" isSpring="true"></sys:inputverify> --%>
									<form:textarea path="text"  htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
								</div>
							</div>
							<div class="form-group" id="picType" style="display: none;">
								<label class="col-sm-2 control-label">图片素材编号</label>
								<div class="col-sm-9">
									<sys:inputverify name="image" id="image" verifyType="0" tip="请输入图片素材编号" isMandatory="false" isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group" id="voiceType" style="display: none;">
								<label class="col-sm-2 control-label">音频媒体编号</label>
								<div class="col-sm-9">
									<sys:inputverify name="voice" id="voice" verifyType="0" tip="请输入音频媒体编号" isMandatory="false"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group" id="videoType" style="display: none;">
								<label class="col-sm-2 control-label">视频媒体编号</label>
								<div class="col-sm-9">
									<sys:inputverify name="video" id="video" verifyType="0" tip="请输入视频媒体编号" isMandatory="false"  isSpring="true"></sys:inputverify>
								</div>
							</div>
							<div class="form-group" id="articleMsgType" style="display: none;">
								<label class="col-sm-2 control-label">图文消息</label>
								<div class="col-sm-9">
									<div class="input-group">
										<input type="hidden" name="articleMsgIdList" id="articleMsgIdList" value="${autoReply.articleMsgIdList }"/>
										<input type="text" name="articleMsgNameList" id="articleMsgNameList" value="${autoReply.articleMsgNameList }" class="form-control zf-input-readonly"  htmlEscape="false" maxlength="50" placeholder="请选择"  readonly="true"  onclick="selectArticleMsg();"/>
										<span class="input-group-addon" onclick="selectArticleMsg();"><i class="fa fa-search"></i></span>										
									</div>
									<sys:selectmutil url="" id="select" width="1200" title="图文消息列表" height="700" isDisableCommitBtn="false" isRefresh="false"></sys:selectmutil>
								</div>
							</div>
	    					<div class="form-group">
								<label class="col-sm-2 control-label">启用状态</label>
								<div class="col-sm-9 zf-check-wrapper-padding">
									<form:radiobuttons path="activeFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" class="minimal"  htmlEscape="false" delimiter="&nbsp;&nbsp;&nbsp;&nbsp;"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">排列序号</label>
								<div class="col-sm-9">
									<sys:inputverify id="orderNo" name="orderNo" tip="请输入正确的序号,整数，必填项" verifyType="4" maxlength="8" isSpring="true"></sys:inputverify>
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
		    					<c:if test="${empty autoReply.id }">
						        	<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					</c:if>
				               	<shiro:hasPermission name="wcp:ar:autoReply:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
		var selVal = $("#contentType").val();
		if(selVal == null || selVal == '') {
			$("#textType").hide();
			$("#picType").hide();
			$("#voiceType").hide();
			$("#videoType").hide();
			$("#articleMsgType").hide();
		} else if(selVal == 'text') {
			$("#textType").show();
			$("#picType").hide();
			$("#voiceType").hide();
			$("#videoType").hide();
			$("#articleMsgType").hide();
		} else if(selVal == "news") {
			$("#articleMsgType").show();
			$("#videoType").hide();
			$("#voiceType").hide();
			$("#picType").hide();
			$("#textType").hide();
		} else if(selVal == 'img') {
			$("#picType").show();
			$("#textType").hide();
			$("#voiceType").hide();
			$("#videoType").hide();
			$("#articleMsgType").hide();
		} else if(selVal == 'voice') {
			$("#voiceType").show();
			$("#picType").hide();
			$("#textType").hide();
			$("#videoType").hide();
			$("#articleMsgType").hide();
		} else if(selVal == 'video') {
			$("#videoType").show();
			$("#voiceType").hide();
			$("#picType").hide();
			$("#textType").hide();
			$("#articleMsgType").hide();
		} 
		
		$("#contentType").on("change", function() {
			var type = $(this).val();
			if(type == null || type == '') {
				$("#textType").hide();
				$("#picType").hide();
				$("#voiceType").hide();
				$("#videoType").hide();
				$("#articleMsgType").hide();
			} else if (type == 'text') {
				$("#textType").show();
				$("#picType").hide();
				$("#voiceType").hide();
				$("#videoType").hide();
				$("#articleMsgType").hide();
			} else if(type == "news") {
				$("#articleMsgType").show();
				$("#videoType").hide();
				$("#voiceType").hide();
				$("#picType").hide();
				$("#textType").hide();
			} else if(type == 'img') {
				$("#picType").show();
				$("#textType").hide();
				$("#voiceType").hide();
				$("#videoType").hide();
				$("#articleMsgType").hide();
			} else if(type == 'voice') {
				$("#voiceType").show();
				$("#picType").hide();
				$("#textType").hide();
				$("#videoType").hide();
				$("#articleMsgType").hide();
			} else if(type == 'video') {
				$("#videoType").show();
				$("#voiceType").hide();
				$("#picType").hide();
				$("#textType").hide();
				$("#articleMsgType").hide();
			}  
		});
		
		$("#code").on("change", function() {
			ZF.ajaxQuery(false, "${ctx}/wcp/ar/autoReply/checkUniqueKeyworkdsOrCode", $.parseJSON("{\"code\":\""+$(this).val()+"\"}"), function(data) {
				if(data.status == "0") {
					$("#code").addClass("zf-input-err");
					if($("#codeErr").length<=0)
						$("#code").after("<label id=\"codeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>该规则代码已存在，请重新录入</label>")
					$("#code").attr("data-verify","false");
				} else {
					if($("#codeErr").length>0){
						$("#code").removeClass("zf-input-err");
						$("#codeErr").remove();
						$("#code").attr("data-verify","true");
					}
				}
			})
		});
		
		$("#keywords").on("change", function() {
			ZF.ajaxQuery(false, "${ctx}/wcp/ar/autoReply/checkUniqueKeyworkdsOrCode", $.parseJSON("{\"keywords\":\""+$(this).val()+"\"}"), function(data) {
				if(data.status == "0") {
					$("#keywords").addClass("zf-input-err");
					if($("#keywordsErr").length<=0)
						$("#keywords").after("<label id=\"keywordsErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>该关键字已存在，请重新录入</label>")
					$("#keywords").attr("data-verify","false");
				} else {
					if($("#keywordsErr").length>0){
						$("#keywords").removeClass("zf-input-err");
						$("#keywordsErr").remove();
						$("#keywords").attr("data-verify","true");
					}
				}
			})
		});
		
	});
	
	function selectArticleMsg() {
		var url="${ctx}/wcp/ar/articleMsg/select";
		$(".modal-title").text("选择图文消息");
		$("#selectModalUrl").val(url);
		$("#selectModal").modal('toggle'); 
 		$("#commitBtn").unbind("click");
		/* $("#commitBtn").on("click",function () {
 			var content = $("#selectModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
 			var msgId = [];
 			var msgName = [];
 			$("input[type=checkbox]", content).each(function(){
 				if($(this).prop("checked")){
 					//重新选择产品清空原来数据
 					$("tr",$("#tableList")).each(function(){
 						$(this).remove();
 					})
					msgId.push($(this).val());
					msgName.push($(this).attr("data-name"));
					
 					$("#selectModal").modal('hide');
 				}
 			});
			$("#articleMsgIdList").val(msgId.join(','));
			$("#articleMsgNameList").val(msgName.join(','));
		}); */
		
	}
	
	
	function formSubmit() {
		var verify=true;
		var inputs=$("input[data-verify=false]");
		for(var i=0;i<inputs.length;i++){
			
			console.log(inputs[i]);
			if($(inputs[i]).attr('data-type') == "date"){
				$(inputs[i]).parent().trigger('dp.change');
			}else{
				$(inputs[i]).trigger('change');
			}
			verify=false;
		}
		var selects=$("select[data-verify=false]");
		for(var i=0;i<selects.length;i++){
			console.log(selects[i]);
			$(selects[i]).trigger('change');
			verify=false;
		} 
		return verify;
	}
</script>
</body>
</html>