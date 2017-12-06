<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	    <section class="content-header content-header-menu">
	    	<h1>
				<small><i class="fa-list-style"></i><a href="${ctx}/idx/pd/channel/">频道列表</a></small>
				<shiro:hasPermission name="idx:pd:channel:edit">
					<small>|</small>
				    <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/pd/channel/form">频道${not empty channel.id?'修改':'添加'}</a></small>
				</shiro:hasPermission>
			</h1>
	    </section>
	    <sys:tip content="${message}"/>
		<section class="content">
			<div class="row">
		    	<div class="col-md-6">
		    		<form:form id="inputForm" onsubmit="return formSubmit();" modelAttribute="channel" action="${ctx}/idx/pd/channel/save" method="post" class="form-horizontal">
			            <div class="box box-success">
				            <div class="box-header with-border zf-query">
				            	<h5>频道添加</h5>
				              	<div class="box-tools">
				                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				              	</div>
				            </div>
				            <div class="box-body">
								<form:hidden path="id"/>
				            	<div class="form-group">
	    							<label class="col-sm-2 control-label">频道名称</label>
									<div class="col-sm-9">
										<sys:inputverify id="name" name="name" tip="请输入频道名称,必填项" verifyType="0" isSpring="true" isMandatory="true"></sys:inputverify>
									</div>
	    						</div>
				            	<div class="form-group">
	    							<label class="col-sm-2 control-label">频道类型</label>
									<div class="col-sm-9">
									    <sys:selectverify name="type" tip="请选择频道类型,必选项" verifyType="0" dictName="idx_pd_channel_type" id="type" isMandatory="true"></sys:selectverify>
									</div>	
	    						</div>
	    						<div class="form-group">
	    							<label class="col-sm-2 control-label">展示区域</label>
									<div class="col-sm-9">
									    <sys:selectverify name="displayArea" tip="请选择展示区域,必选项" verifyType="0" dictName="idx_pd_channel_displayArea" id="displayArea"></sys:selectverify>
									</div>	
	    						</div>
	    						<div class="form-group">
	    							<label class="col-sm-2 control-label">图标</label>
									<div class="col-sm-9">
										<form:hidden id="icon" path="icon" htmlEscape="false" maxlength="255" class="form-control"/>
	                                    <sys:fileUpload input="icon" model="true" selectMultiple="false"></sys:fileUpload>
									</div>
								</div>
								<div class="form-group">
	    							<label class="col-sm-2 control-label">背景图</label>
									<div class="col-sm-9">
										<form:hidden id="bgPhoto" path="bgPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
	                                    <sys:fileUpload input="bgPhoto" model="true" selectMultiple="false"></sys:fileUpload>
									</div>
								</div>
								<div class="form-group">
	    							<label class="col-sm-2 control-label">链接地址</label>
									<div class="col-sm-9">
										<sys:inputverify id="url" name="url" tip="请输入频道链接地址"  verifyType="99" maxlength="150" isSpring="true" isMandatory="false"></sys:inputverify>
									</div>
	    						</div>
								<div class="form-group">
	    							<label class="col-sm-2 control-label">排列序号</label>
									<div class="col-sm-9">
										<sys:inputverify id="orderNo" name="orderNo" maxlength="8" tip="请输入正确的序号,整数，必填项" verifyType="0" isSpring="true" isMandatory="true"></sys:inputverify>
									</div>
	    						</div>
								
								<div class="form-group">
	    							<label class="col-sm-2 control-label">启用状态</label>
									<div class="col-sm-9">
										<form:select path="usableFlag" htmlEscape="false" maxlength="50" class="form-control select2" >
											<form:option value="" label="请选择"/>
											<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
	    						</div>
	    						<div class="form-group">
	    							<label class="col-sm-2 control-label">备注信息</label>
									<div class="col-sm-9">
										<textarea name="remarks" rows="4" maxlength="255" class="form-control input-xxlarge">${channel.remarks }</textarea>
									</div>
	    						</div>
								<div class="box box-success">
								<div class="box-header with-border zf-query">
									<h5>请选择关联场景</h5>
								</div>
								<div class="box-body">
									<c:if test="${empty whProduce.produce.id  }">
										<div class="row">
											<div class="col-sm-12 pull-right">
									            <button type="button" class="btn btn-sm btn-success" id="chooseSceneBtn"><i class="fa fa-hand-pointer-o">选择场景</i></button>
											</div>
										</div>
									</c:if>
									
									<div class="table-responsive">
										<table class="table table-bordered table-hover table-striped zf-tbody-font-size">
											<thead>
												<tr>
													<th>场景名称</th>
													<th>排列序号</th>
													<th width="10">&nbsp;操作&nbsp;</th>
												</tr>
											</thead>
											<tbody id="tBody">
													<c:forEach items="${channel.channelSceneList }" var="channelScene" varStatus="step">
													<tr data-value="${channelScene.scene.id }">
														<td style="display: none;">
															<input type="hidden" name="channelSceneList[${step.count-1}].id" value="${ channelScene.id }" />
															<input type="hidden" name="channelSceneList[${step.count-1}].scene.id" value="${ channelScene.scene.id }" />
														</td>
														<td>
															${channelScene.scene.name }
														</td>
														<td>
															<input type="text" data-type="item" data-verify="true" maxlength="5" name="channelSceneList[${step.count-1}].orderNo" 
																	class="form-control" value="${channelScene.orderNo }"/>
														</td>
														<td>
															<span data-type='delBtn' style='display:block;' class='close' title='删除'>&times;</span>
															<input type="hidden" name="channelSceneList[${step.count-1}].usableFlag" value="${ channelScene.usableFlag }" />
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
		    					    <c:if test="${empty channel.id}">
		    					       <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		    					    </c:if>
				               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
					        	</div>
		    				</div>
							</div>
							</div>
			            </div>
		            </form:form>
	            </div>
            </div>
        </section>
        <sys:selectmutil url="" id="sceneSelect" width="1200" title="选择场景列表" height="600" isDisableCommitBtn="true"></sys:selectmutil>
	</div>
	
<script type="text/javascript">
	$(function() {

		$("#chooseSceneBtn").on('click',function() {
			$("#sceneSelectModalUrl").val("${ctx}/idx/gd/scene/selectSceneList");
			$("#sceneSelectModal").modal('toggle');//显示模态框
		});
		
		//给span绑定click事件,点击删除该行
		$("span[data-type='delBtn']").on("click",function(){
			let usableFlag = $(this).next().val();
			if($(this).parent().parent().attr("data-new")){
				$(this).parent().parent().remove();
			}else if(usableFlag == '0'){
				$(this).html("&times;").attr("title", "删除");
				$(this).next().val('1')
			}else if(usableFlag == '1'){
				$(this).html("&divide;").attr("title", "撤销删除");
				$(this).next().val('0')
			}
		});
	
		//给input绑定change事件
		$("[data-type=item]").on("change",function(){
			ZF.formVerify(true, 4, $(this).val())?$(this).attr("data-verify","true"):$(this).attr("data-verify","false");
			var id=$(this).attr("id");
			if(!ZF.formVerify(true,"4",$(this).val())){
				$(this).addClass("zf-input-err")
				if($("#"+id+"Err").length<=0)
					$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>排序不得为空且必须为正整数</label>")
				$(this).attr("data-verify","false");
			}else{
				if($("#"+id+"Err").length>0){
					$(this).removeClass("zf-input-err");
					$("#"+id+"Err").remove();
					$(this).attr("data-verify","true");
				}
			}
		});
		
		//点击提交按钮，关闭模态框
		$("#sceneSelectModal #commitBtn").on("click",function(){
			$("#sceneSelectModal").modal('toggle');//关闭模态框	
        	const content = $("#sceneSelectModalIframe").contents().find("body");
			let sceneArray = new Array();
			//先获取数据
			$("input[type=checkBox]", content).each(function(){
				if($(this).prop("checked")){
					let scene = new Array();
    				let sceneId = $(this).val();
    				scene.push(sceneId);
    				scene.push($(this).parent().parent().parent().next().text());
    				sceneArray.push(scene);
				}
			});
			//过滤掉已有数据
			sceneArray = checkExsit(sceneArray);
			console.log(sceneArray);
			var curLen =  $("#tBody").children('tr').length;
			//当sceneArray有数据时才遍历
			if(sceneArray != null && sceneArray!=undefined &&sceneArray.length>0){
				//拼接html
				for(var i=0;i<sceneArray.length;i++){
					let scene = sceneArray[i];
					let html="";
					let index = curLen == 0 ? i : curLen+i;
					html+="<tr data-value='"+scene[0]+"' data-new='true'>";
					html+="<td style='display:none'><input type='hidden' name='channelSceneList["+index+"].scene.id' value='"+scene[0]+"'/></td>";
					html+="<td>"+scene[1]+"</td>";
					html+="<td><input id="+i+"orderNo type='text' data-verify='false' data-type='item' data-name='排列序号' name='channelSceneList["+index+"].orderNo' class='form-control'/></td>";
					html+="<td><span data-type='delBtn' style='display:block;' class='close' title='删除'>&times;</span>";
					html+="<input type='hidden' name='channelSceneList["+index+"].usableFlag' value='1' /></td>";
					html+="</tr>";
					$("#tBody").append(html);
				}
				//给span绑定click事件,点击删除该行
				$("span[data-type='delBtn']").unbind("click");
				$("span[data-type='delBtn']").on("click",function(){
					let usableFlag = $(this).next().val();
					console.log(usableFlag);
					console.log($(this).parent().parent().attr("data-new"));
					if($(this).parent().parent().attr("data-new")){
						$(this).parent().parent().remove();
					}else if(usableFlag == '0'){
						console.log(11);
						$(this).html("&times;").attr("title", "删除");
						console.log($(this).next());
						$(this).next().val('1')
					}else if(usableFlag == '1'){
						console.log(22);
						$(this).html("&divide;").attr("title", "撤销删除");
						$(this).next().val('0')
					}
				});
				
				$("input[data-type=item]").each(function(){
		   			if($(this).val()!=null&&$(this).val()!=undefined&&$(this).val()!=""){
						$(this).attr("data-verify",true);
					}
		   		});
				//给input绑定change事件
				$("[data-type=item]").on("change",function(){
					ZF.formVerify(true, 4, $(this).val())?$(this).attr("data-verify","true"):$(this).attr("data-verify","false");
					var id=$(this).attr("id");
					if(!ZF.formVerify(true,"4",$(this).val())){
						$(this).addClass("zf-input-err")
						if($("#"+id+"Err").length<=0)
							$(this).after("<label id=\""+id+"Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>"+$(this).attr("data-name")+"不得为空且必须为正整数</label>")
						$(this).attr("data-verify","false");
					}else{
						if($("#"+id+"Err").length>0){
							$(this).removeClass("zf-input-err");
							$("#"+id+"Err").remove();
							$(this).attr("data-verify","true");
						}
					}
				});
			}

	 		$("select").select2();
		});
	
	});
	
	//过滤已有数据
	function checkExsit(sceneArray){
		for(var i=0;i<sceneArray.length;i++){
			$("#tBody").children('tr').each(function(){
				if(sceneArray != null && sceneArray!=undefined &&sceneArray.length>0){
					if(sceneArray[i][0]==$(this).attr("data-value")){
						sceneArray.splice(i,1);
					}
				}
			})
		}
		return sceneArray;
	}
	
	function formSubmit() {
		let flag = ZF.formSubmit();
		if (flag) {
			let count = 0;
			$("#tBody").children('tr').each(function(){
				if($(this).children(':last-child').children('input').val()=='1'){
					count++;
				}
			});
			if(count > 9){
				ZF.showTip("最多只能添加9个搭配！", "warning");
				flag = false;
				$("button[type=submit]").attr('disabled', false);
			}
		}
		return flag;
	}
	
</script>
</body>
</html>