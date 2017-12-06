<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公众号菜单编辑</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small>
					<i class="fa-list-style"></i><a href="${ctx}/wcp/mn/menu/list?mpType=${mpType}">公众号菜单列表</a>
				</small>
				<shiro:hasPermission name="wcp:mn:menu:edit">
					<small>|</small>
					<small class="menu-active">
						<i class="fa fa-repeat"></i><a href="${ctx}/wcp/mn/menu/form?mpType=${mpType}">公众号菜单编辑</a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		
		<sys:tip content="${message}" />
		
		<section class="content">
			<form:form id="inputForm" modelAttribute="menuVo" action="${ctx}/wcp/mn/menu/save?mpType=${mpType}" method="post" class="form-horizontal">
			<div class="row">
		    	<div class="col-md-12">
		            <div class="box box-success">
			            <div class="box-header with-border zf-query">
			            	<h5>菜单设置</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			              	</div>
			            </div>
			            <div class="box-body">
							<div class="table-responsive">
								<table id="contentTable" class="table table-hover table-bordered table-striped zf-tbody-font-size">
									<thead>
										<tr>
											<th colspan="2">菜单标题</th>
											<th>响应动作类型</th>
											<th>菜单KEY值</th>
											<th>图文mediaId</th>
											<th>网页链接</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody id="contentTableTbody">
										<c:set var="pIndex" value="0"></c:set>
										<c:forEach items="${menuList }" var="menu" varStatus="stat">
											<c:set var="pIndex" value="${stat.index }"></c:set>
											<tr data-id="${stat.index }" >
												<td colspan="2">
													<input type="text" value="${menu.name}" placeholder="请输入菜单标题,必填项" class="form-control"/>
												</td>
												<td>
													<c:choose>
														<c:when test="${empty menu.subButtons }">
															<div data-hide>
														</c:when>
														<c:otherwise>
															<div data-hide style="display: none;">
														</c:otherwise>
													</c:choose>
														<select>
															<option value="click" <c:if test="${menu.type eq 'click' }">selected</c:if> >点击推事件</option>
															<option value="view" <c:if test="${menu.type eq 'view' }">selected</c:if> >跳转URL</option>
															<option value="scancode_push" <c:if test="${menu.type eq 'scancode_push' }">selected</c:if> >扫码推事件</option>
															<option value="scancode_waitmsg" <c:if test="${menu.type eq 'scancode_waitmsg' }">selected</c:if> >扫码推事件2</option>
															<option value="pic_sysphoto" <c:if test="${menu.type eq 'pic_sysphoto' }">selected</c:if> >弹出系统拍照发图</option>
															<option value="pic_photo_or_album" <c:if test="${menu.type eq 'pic_photo_or_album' }">selected</c:if> >弹出拍照或者相册发</option>
															<option value="pic_weixin" <c:if test="${menu.type eq 'pic_weixin' }">selected</c:if> >弹出微信相册发图器</option>
															<option value="location_select" <c:if test="${menu.type eq 'location_select' }">selected</c:if> >弹出地理位置选择器</option>
															<option value="media_id" <c:if test="${menu.type eq 'media_id' }">selected</c:if> >下发消息(除文本消息)</option>
															<option value="view_limited" <c:if test="${menu.type eq 'view_limited' }">selected</c:if> >跳转图文消息URL</option>
														</select>
													</div>
												</td>
												<td>
													<c:choose>
														<c:when test="${empty menu.subButtons }">
															<input data-hide type="text" value="${menu.key}" placeholder="请输入菜单KEY值" class="form-control"/>
														</c:when>
														<c:otherwise>
															<input data-hide type="text" value="${menu.key}" placeholder="请输入菜单KEY值" class="form-control" style="display: none;"/>
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													<c:choose>
														<c:when test="${empty menu.subButtons }">
															<input data-hide type="text" value="${menu.mediaId}" placeholder="请输入菜单mediaId值" class="form-control"/>
														</c:when>
														<c:otherwise>
															<input data-hide type="text" value="${menu.mediaId}" placeholder="请输入菜单mediaId值" class="form-control" style="display: none;"/>
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													<c:choose>
														<c:when test="${empty menu.subButtons }">
															<input data-hide type="text" value="${menu.url}" placeholder="请输入菜单网页链接" class="form-control"/>
														</c:when>
														<c:otherwise>
															<input data-hide type="text" value="${menu.url}" placeholder="请输入菜单网页链接" class="form-control" style="display: none;"/>
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													<div class="btn-group zf-tableButton">
														<button type="button" class="btn btn-default" onclick="delMenu(this)">删除</button>
														<button type="button" class="btn btn-default" onclick="addSubMenu(this)">新增子菜单</button>
													</div>
												</td>
											</tr>
											<c:forEach items="${menu.subButtons}" var="submenu" varStatus="substatus">
												<tr data-pId="${pIndex }">
													<td></td>
													<td>
														<input type="text" value="${submenu.name}" placeholder="请输入子菜单标题,必填项" class="form-control"/>
													</td>
													<td>
														<select>
															<option value="click" <c:if test="${submenu.type eq 'click' }">selected</c:if> >点击推事件</option>
															<option value="view" <c:if test="${submenu.type eq 'view' }">selected</c:if> >跳转URL</option>
															<option value="scancode_push" <c:if test="${submenu.type eq 'scancode_push' }">selected</c:if> >扫码推事件</option>
															<option value="scancode_waitmsg" <c:if test="${submenu.type eq 'scancode_waitmsg' }">selected</c:if> >扫码推事件2</option>
															<option value="pic_sysphoto" <c:if test="${submenu.type eq 'pic_sysphoto' }">selected</c:if> >弹出系统拍照发图</option>
															<option value="pic_photo_or_album" <c:if test="${submenu.type eq 'pic_photo_or_album' }">selected</c:if> >弹出拍照或者相册发</option>
															<option value="pic_weixin" <c:if test="${submenu.type eq 'pic_weixin' }">selected</c:if> >弹出微信相册发图器</option>
															<option value="location_select" <c:if test="${submenu.type eq 'location_select' }">selected</c:if> >弹出地理位置选择器</option>
															<option value="media_id" <c:if test="${submenu.type eq 'media_id' }">selected</c:if> >下发消息(除文本消息)</option>
															<option value="view_limited" <c:if test="${submenu.type eq 'view_limited' }">selected</c:if> >跳转图文消息URL</option>
														</select>
													</td>
													<td>
														<input type="text" value="${submenu.key}" placeholder="请输入子菜单KEY值" class="form-control"/>
													</td>
													<td>
														<input type="text" value="${submenu.mediaId}" placeholder="请输入菜单mediaId值" class="form-control"/>
													</td>
													<td>
														<input type="text" value="${submenu.url}" placeholder="请输入菜单网页链接" class="form-control"/>
													</td>
													<td>
														<div class="btn-group zf-tableButton">
															<button type="button" class="btn btn-default btn-block" onclick="delMenu(this)">删除</button>
														</div>
													</td>
												</tr>
											</c:forEach>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="row">
								<div class="col-sm-12 pull-right">
									<button type="button" onclick="addMenu()" class="btn btn-sm btn-success"><i class="fa fa-plus">新增菜单</i></button>
								</div>
							</div>
    					</div>
		    			<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
			               		<button type="button" onclick="formSubmit()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button>
				        	</div>
	    				</div>
	    			</div>
    			</div>
    		</div>		
            </form:form>
        </section>
	</div>
	<script type="text/javascript">
	var selectTemp="<select data-hide>";
	selectTemp+="<option value=\"click\">点击推事件</option>";
	selectTemp+="<option value=\"view\">跳转URL</option>";
	selectTemp+="<option value=\"scancode_push\">扫码推事件</option>";
	selectTemp+="<option value=\"scancode_waitmsg\">扫码推事件2</option>";
	selectTemp+="<option value=\"pic_sysphoto\">弹出系统拍照发图</option>";
	selectTemp+="<option value=\"pic_photo_or_album\">弹出拍照或者相册发</option>";
	selectTemp+="<option value=\"pic_weixin\">弹出微信相册发图器</option>";
	selectTemp+="<option value=\"location_select\">弹出地理位置选择器</option>";
	selectTemp+="<option value=\"media_id\">下发消息(除文本消息)</option>";
	selectTemp+="<option value=\"view_limited\">跳转图文消息URL</option></select>";
	
	var inputTemp="<input $hide data-key=\"$id\" type=\"text\"  placeholder=\"$tip\" class=\"form-control\"/>";
	
	var pIndex=${pIndex};
	
	function addMenu(){
		if($("[data-id]").length>=3){
			ZF.showTip("主菜单数量不能超过3个","warning")
			return;
		}
		pIndex++;
		var tbody=$("#contentTableTbody");
		var temp="<tr data-id=\""+pIndex+"\"><td colspan=\"2\">"+inputTemp.replace("$tip","请输入菜单标题,必填项").replace("$id",pIndex)+"</td>";
		temp+="<td><div data-hide>"+selectTemp+"</div></td><td>"+inputTemp.replace("$tip","请输入菜单KEY值").replace("$id",pIndex).replace("$hide","data-hide")+"</td><td>"+inputTemp.replace("$tip","请输入图文mediaId值").replace("$id",pIndex).replace("$hide","data-hide")+"</td><td>"+inputTemp.replace("$tip","请输入菜单网页链接").replace("$id",pIndex).replace("$hide","data-hide")+"</td><td>";
		temp+="<div class=\"btn-group zf-tableButton\"><button type=\"button\" class=\"btn btn-default\" onclick=\"delMenu(this)\">删除</button><button type=\"button\" class=\"btn btn-default\" onclick=\"addSubMenu(this)\">新增子菜单</button></div></td></tr>";
		var trObj=$(temp);
		tbody.append(trObj);
		$("select",trObj).select2();
	}
	
	function addSubMenu(obj){
		var pTrObj=$(obj).parent().parent().parent();
		var dataId=pTrObj.attr("data-id");
		if($("[data-pId="+dataId+"]").length>=5){
			ZF.showTip("子菜单数量不能超过5个","warning")
			return;
		}
		var tbody=$("#contentTableTbody");
		var temp="<tr data-pId=\""+dataId+"\"><td></td><td>"+inputTemp.replace("$tip","请输入菜单标题,必填项").replace("$id",pIndex)+"</td>";
		temp+="<td>"+selectTemp+"</td><td>"+inputTemp.replace("$tip","请输入菜单KEY值").replace("$id",pIndex)+"</td><td>"+inputTemp.replace("$tip","请输入图文mediaId值").replace("$id",pIndex)+"</td><td>"+inputTemp.replace("$tip","请输入菜单网页链接").replace("$id",pIndex)+"</td><td>";
		temp+="<div class=\"btn-group zf-tableButton\"><button type=\"button\" class=\"btn btn-default\" onclick=\"delMenu(this)\">删除</button></div></td></tr>";
		var trObj=$(temp);
		var cTrs=$("[data-pId="+dataId+"]");
		if(cTrs.length>=1){
			var cTr=cTrs[cTrs.length-1];
			$(cTr).after(trObj);
		}else{
			pTrObj.after(trObj);
		}
		$("[data-hide]",pTrObj).hide();
		$("input[data-hide]",pTrObj).val("");
		$("select",$("div[data-hide]",pTrObj)).select2("val","");
		$("select",trObj).select2();
	}
	
	function delMenu(obj){
		var trObj=$(obj).parent().parent().parent();
		var dataId=trObj.attr("data-pId");
		if(dataId!=null&&dataId.length>0&&$("[data-pId="+dataId+"]").length==1){
			$("[data-hide]",trObj.prev()).show();
		}
		$(obj).parent().parent().parent().remove();
		
		dataId=trObj.attr("data-id");
		if(dataId!=null&&dataId.length>0&&$("[data-pId="+dataId+"]").length>0){
			$("[data-pId="+dataId+"]").remove();
		}
	}
	
	function isHaveSubMenu(id){
		if($("[data-pId="+id+"]").length>0)
			return true;
		return false;
	}
	function sel(val,index) {
		
    }
	
	function formSubmit(){
		$("[data-type=hidden]").remove();
		var form=$("#inputForm");
		var temp="<input data-type=\"hidden\" name=\"$name\" value=\"$value\" type=\"hidden\"  />";
		var html="";
		var pTrs=$("[data-id]");
		for(var i=0;i<pTrs.length;i++){
			var pId=$(pTrs[i]).attr("data-id");
			var inputs=$("input",$(pTrs[i]));
			var selects=$("select",$(pTrs[i]));
			var cTrs=$("[data-pId="+pId+"]");
			//菜单名检测
			if($(inputs[0]).val()==""){
				ZF.showTip("第[ "+(i+1)+" ]个一级菜单名称未填写","warning");
				return;
			}
			
			//一级菜单数据验证
			/*if(cTrs.length<=0){
				if($(inputs[1]).val()==""&&$(inputs[2]).val()==""){
					ZF.showTip("第[ "+(i+1)+" ]个一级菜单key值或网页链接地址必须填写一项","warning");
					return;
				}
			}*/
			
			html=temp.replace("$name","menus["+i+"].name").replace("$value",$(inputs[0]).val());
			form.append(html);
			html=temp.replace("$name","menus["+i+"].type").replace("$value",$(selects[0]).select2("val"));
			form.append(html);
			html=temp.replace("$name","menus["+i+"].key").replace("$value",$(inputs[1]).val());
			form.append(html);
            html=temp.replace("$name","menus["+i+"].mediaId").replace("$value",$(inputs[2]).val());
            form.append(html);
			html=temp.replace("$name","menus["+i+"].url").replace("$value",$(inputs[3]).val());
			form.append(html);
			for(var j=0;j<cTrs.length;j++){
				var cinputs=$("input",$(cTrs[j]));
				var cselects=$("select",$(cTrs[j]));
				/*if($(cinputs[0]).val()==""){
					ZF.showTip("第[ "+(i+1)+" ]个一级菜单,第[ "+(j+1)+" ]个子菜单菜单名未填写","warning");
					return;
				}*/

				html=temp.replace("$name","menus["+i+"].subButtons["+j+"].name").replace("$value",$(cinputs[0]).val());
				form.append(html);
				html=temp.replace("$name","menus["+i+"].subButtons["+j+"].type").replace("$value",$(cselects[0]).select2("val"));
				form.append(html);
				html=temp.replace("$name","menus["+i+"].subButtons["+j+"].key").replace("$value",$(cinputs[1]).val());
				form.append(html);
                html=temp.replace("$name","menus["+i+"].subButtons["+j+"].mediaId").replace("$value",$(cinputs[2]).val());
                form.append(html);
				html=temp.replace("$name","menus["+i+"].subButtons["+j+"].url").replace("$value",$(cinputs[3]).val());
				form.append(html);
			}
		}
		form.submit();
	}
	</script>
</body>
</html>