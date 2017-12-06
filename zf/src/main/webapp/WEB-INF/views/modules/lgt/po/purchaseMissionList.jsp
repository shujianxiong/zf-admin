<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>采购任务列表</title>
<meta name="decorator" content="adminLte" />
<script type="text/javascript">
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchPurchaseForm").submit();
		return false;
	};

	function removePurchase(url, id) {
		confirm("确认要删除该采购单吗？", "warning", function() {
			window.location.href = url + "?id=" + id;
		});
	};
</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/po/purchaseMission/list">采购任务列表</a>
				</small>
				<shiro:hasPermission name="lgt:po:purchaseMission:edit">
					<small>|</small>
					<small>
						<i class="fa-form-edit"></i><a href="${ctx}/lgt/po/purchaseMission/form">采购任务添加</a>
					</small>
				</shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}" />
		<section class="content">
			<form:form id="searchPurchaseForm" modelAttribute="purchaseMission"	action="${ctx}/lgt/po/purchaseMission/list" method="post" class="form-horizontal">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
							<button type="button" class="btn btn-box-tool" data-widget="remove">
								<i class="fa fa-remove"></i>
							</button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >任务编号</label>
									<div class="col-sm-7">
										<form:input id="batchNo" path="batchNo" htmlEscape="false" maxlength="64" class="form-control"  placeholder="请输入任务编号"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="code" class="col-sm-3 control-label" >任务状态</label>
									<div class="col-sm-7">
										<form:select path="missionStatus" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('lgt_po_purchase_mission_missionStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="beginCreateDate" class="col-sm-3 control-label">起始创建时间</label>
									<div class="col-sm-7">
										<sys:datetime id="beginCreateDate" inputId="beginCreateDate" inputName="beginCreateDate" value="${purchaseMission.beginCreateDate}" tip="请选择起始创建时间" isMandatory="false"></sys:datetime>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="endCreateDate" class="col-sm-3 control-label">截止创建时间</label>
									<div class="col-sm-7">
										<sys:datetime id="endCreateDate" inputId="endCreateDate" inputName="endCreateDate" value="${purchaseMission.endCreateDate}" tip="请选择截止创建时间" isMandatory="false"></sys:datetime>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="produceCode" class="col-sm-3 control-label" >关联产品编码</label>
									<div class="col-sm-7">
										<form:input id="produceCode" path="produceCode" htmlEscape="false" maxlength="64" class="form-control"  placeholder="请输入产品编码"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
							<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()">
								<i class="fa fa-refresh"></i>重置
							</button>
							<button type="submit" class="btn btn-info btn-sm">
								<i class="fa fa-search"></i>查询
							</button>
						</div>
					</div>
				</div>
			</form:form>

			<div class="box box-soild">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 pull-right"></div>
					</div>
					<div class="table-responsive">
						<table id="contentTable" class="table table-hover table-bordered table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th>任务编号</th>
									<th>任务状态</th>
									<th>创建者</th>
									<th>创建时间</th>
									<th>更新者</th>
									<th>更新时间</th>
									<th>备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="purchaseMission" varStatus="pstatus">
									<tr id="${purchaseMission.id}" data-index="${pstatus.index}${status.index}">
										<td nowrap>${purchaseMission.batchNo}</td>
										<td>
											<c:choose>
												<c:when test="${purchaseMission.missionStatus == 1 }">
													<span class="label label-default">${fns:getDictLabel(purchaseMission.missionStatus,'lgt_po_purchase_mission_missionStatus','')}</span>
												</c:when>
												<c:when test="${purchaseMission.missionStatus == 2 }">
													<span class="label label-warning">${fns:getDictLabel(purchaseMission.missionStatus,'lgt_po_purchase_mission_missionStatus','')}</span>
												</c:when>
												<c:when test="${purchaseMission.missionStatus == 3 }">
                                                    <span class="label label-info">${fns:getDictLabel(purchaseMission.missionStatus,'lgt_po_purchase_mission_missionStatus','')}</span>
                                                </c:when>
												<c:when test="${purchaseMission.missionStatus == 4 }">
													<span class="label label-primary">${fns:getDictLabel(purchaseMission.missionStatus,'lgt_po_purchase_mission_missionStatus','')}</span>
												</c:when>
												<c:when test="${purchaseMission.missionStatus == 5 }">
													<span class="label label-success">${fns:getDictLabel(purchaseMission.missionStatus,'lgt_po_purchase_mission_missionStatus','')}</span>
												</c:when>
												<c:otherwise>
													<span class="label label-danger"></span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>${fns:getUserById(purchaseMission.createBy.id).name}</td>
										<td><fmt:formatDate value="${purchaseMission.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td>${fns:getUserById(purchaseMission.updateBy.id).name}</td>
										<td><fmt:formatDate value="${purchaseMission.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td title="${purchaseMission.remarks}">${fns:abbr(purchaseMission.remarks,15)}</td>
										<td>
											<div class="btn-group zf-tableButton">
												<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/po/purchaseMission/info?id=${purchaseMission.id}'">详情</button>
												<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
                                                <shiro:hasPermission name="lgt:po:purchaseMission:edit">
												    <c:choose>
	                                                   <c:when test="${purchaseMission.missionStatus eq '1' && purchaseMission.createBy.id eq user.id}">
                                                            <li><a href="${ctx}/lgt/po/purchaseMission/form?id=${purchaseMission.id}" style="color:#fff">修改</a></li>
                                                            <li><a href="${ctx}/lgt/po/purchaseMission/submit?id=${purchaseMission.id}" onclick="return ZF.delRow('确认提交该采购任务？<br/>提交后该采购任务将进入待审批状态，任务及产品将不可修改和删除！',this.href);" style="color:#fff">提交审批</a></li>
                                                            <li><a href="${ctx}/lgt/po/purchaseMission/delete?id=${purchaseMission.id}" onclick="return ZF.delRow('确认删除该采购任务？',this.href);" style="color:#fff">删除</a></li>
	                                                   </c:when>
	                                                 </c:choose>
	                                             </shiro:hasPermission>
	                                             <shiro:hasPermission name="lgt:po:purchaseMission:approve"><!-- 拥有审批采购任务权限的人，才能看到审批菜单 -->
	                                                 <c:choose>
	                                                     <c:when test="${purchaseMission.missionStatus eq '2'}">
															 <li><a href="${ctx}/lgt/po/purchaseMission/checkForm?id=${purchaseMission.id}">审批</a></li>
	                                                     </c:when>
	                                                 </c:choose>
	                                             </shiro:hasPermission>
													<li><a href="javascript:void(0);" onclick="remarksFun('${purchaseMission.id}','${purchaseMission.remarks}')">修改备注</a></li>
												</ul>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="box-footer">
					<div class="dataTables_paginate paging_simple_numbers">${page}</div>
				</div>
			</div>

			<div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="修改备注" aria-hidden="true">
				<div class="modal-dialog" style="width:30%;height:300px;" >
					<div class="modal-content" style="width:100%;height:100%;">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title">修改备注</h4>
						</div>
						<div class="modal-body">
								<input id="purchase_id" name="id" type="hidden"/>
								<div>
									<label for="remarks">备注</label>
									<textarea class="form-control" style="height:100px;" maxlength="255" name="remarks" id="remarks"  placeholder="请输入备注">
									</textarea>
								</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="commitBtn">提交</button>
						</div>
					</div><!-- /.modal-content -->
				</div><!-- /.modal -->
			</div>
		</section>
	</div>
	<script type="text/javascript">
		var purchaseId = null;
        function remarksFun(id,remarks) {
            $("#purchase_id").val(id);
            $("#remarks").val(remarks);
            $("#geneteModal").modal('toggle');
        }
		$(function() {
			//表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,//关闭搜索
				"order": [[ 5, "desc" ]],			// 指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
                    {"orderable":false,targets:0},
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},	//第 2、3、4、5、6、7列不排序
					{"orderable":false,targets:4},
					{"orderable":false,targets:6},
					{"orderable":false,targets:7}
		       ],
				"ordering" : true,
				"info" : false,
				"multiline":true,//是否开启多行表格
				"isRowSelect":true,//是否开启行选中
				"isRowSelect" : true,//是否开启行选中
				"rowSelect" : function(tr) {
					purchaseId = tr.attr("data-value");
				},
				"rowSelectCancel" : function(tr) {
					purchaseId = null;
				}
			})


			$("#purchaseUserName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#purchaseUserId").val(list[0].id);
						$("#purchaseUserName").val(list[0].text);
					}
				})
			});
			$("#orderUserName").on("click", function() {
				selectUserinit({
					"selectCallBack" : function(list) {
						$("#orderUserId").val(list[0].id);
						$("#orderUserName").val(list[0].text);
					}
				})
			});
            $("#geneteModal #commitBtn").on("click",function () {
                var purchase_id = $("#purchase_id").val();
                var remarksVal = $("#remarks").val();
                if(remarksVal == null || remarksVal == "" || $.trim(remarksVal).length == 0) {
                    ZF.showTip("请输入备注!","info");
                    return false;
                }
                var url = "${ctx}/lgt/po/purchaseMission/updateRemarks";
                $.post(url,{id:purchase_id,remarks:remarksVal},function(result){
                    window.location.reload();
                });
            });
		});

	</script>
</body>

<%@include file="/WEB-INF/views/include/treetable.jsp" %>
</html>