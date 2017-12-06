<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品列表管理</title>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/spm/pr/prize/list">奖品列表</a></small>
				
				<shiro:hasPermission name="spm:pr:prize:edit"><small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/spm/pr/prize/form">奖品${not empty prize.id?'修改':'添加'}</a></small></shiro:hasPermission>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		
		<section  class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
	
				<form:form id="searchForm" modelAttribute="prize" action="${ctx}/spm/pr/prize/list" method="post" class="form-horizontal">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input id="id" name="id" type="hidden"/>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="name" class="col-sm-3 control-label">奖品名称</label>
									<div class="col-sm-7">
										<sys:inputverify name="name" id="name" verifyType="0" tip="请输入查询的奖品名称" isMandatory="false" isSpring="true"></sys:inputverify>
									</div>
								</div>
							</div>
							
							<div class="col-md-4">
								<div  class="form-group">
									<label for="brandStatusId" class="col-sm-3 control-label">奖品类型</label>
									<div class="col-sm-7">
										<sys:selectverify name="type" tip="请选择奖品类型" verifyType="0" dictName="SPM_PR_PRIZE_TYPE" id="typeId" isMandatory="false" value="${prize.type }"></sys:selectverify>
									</div>
								</div>
							</div>
							
							<div class="col-md-4">
								<div  class="form-group">
									<label for="brandStatusId" class="col-sm-3 control-label">奖品状态</label>
									<div class="col-sm-7">
										<sys:selectverify name="status" tip="请选择奖品状态" verifyType="0" dictName="SPM_PR_PRIZE_STATUS" id="statusId" isMandatory="false" value="${prize.status }"></sys:selectverify>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
			        	</div>
					</div>
	            </form:form>
				</div>
				<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>奖品编号</th>
									<th>奖品名称</th>
									<th>奖品类型</th>
									<th>奖品状态</th>
									<th>展示金额</th>
<!-- 									<th>奖品介绍</th> -->
									<th>预览图</th>
									<th>展示图片</th>
									<th>所需积分</th>
									<th>库存数量</th>
									<th>可用库存数量</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<th style="display:none;">备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="prize" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td>
											${prize.code }
										</td>
										<td>
											${prize.name}
										</td>
										<td>
											${fns:getDictLabel(prize.type,'SPM_PR_PRIZE_TYPE','') }
										</td>
										<td>
											<c:if test="${prize.status=='1'||prize.status=='2' }">
												${fns:getDictLabel(prize.status,'SPM_PR_PRIZE_STATUS','') }
											</c:if>
											<c:if test="${prize.status=='3' }">
												<span class="label label-success">${fns:getDictLabel(prize.status,'SPM_PR_PRIZE_STATUS','') }</span>
											</c:if>
											<c:if test="${prize.status=='4' }">
												<span class="label label-primary">${fns:getDictLabel(prize.status,'SPM_PR_PRIZE_STATUS','') }</span>
											</c:if>
										</td>
										<td  class="zf-table-money">
											<span class="text-red">${prize.displayPrice}</span>
										</td>
<!-- 										<td> -->
<%-- 											${prize.introduce } --%>
<!-- 										</td> -->
										<td>
											<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(prize.mainPhoto, '|', '')}" data-big data-src="${imgHost }${fn:replace(prize.mainPhoto, '|', '')}"  width="20" height="20">
										</td>
										<td>
											<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(prize.displayPhotos, '|', '')}" data-big data-src="${imgHost }${fn:replace(prize.displayPhotos, '|', '')}"  width="20" height="20">
										</td>
										<td>${prize.costPoint }</td>
										<td>${prize.stockNum }</td>
										<td>${prize.usableNum }</td>
										<td data-hide="true">
											${fns:getUserById(prize.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${prize.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(prize.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${prize.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td  data-hide="true">
											${prize.remarks }
										</td>
										<td>
											 <shiro:hasPermission name="spm:pr:prize:edit">
												<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/pr/prize/info?id=${prize.id}'">详情</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
									                </button>
								                  	<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
								                  	<c:choose>
								                  		<c:when test="${prize.status eq '0'}">
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/form" data-message="" data-json="{'id':'${prize.id }'}" onclick="return ZF.xconfirm(this);">修改</a></li>
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/delete" data-message="确定要删除该奖品吗？" data-json="{'id':'${prize.id }'}" onclick="return ZF.xconfirm(this);">删除</a></li>
								                  		</c:when>
								                  		<c:when test="${prize.status eq '1'}">
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/changeFlag" data-message="确定要发布该奖品么?" data-json="{'id':'${prize.id }','status':'2'}" onclick="return ZF.xconfirm(this);">发布</a></li>
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/form" data-message="" data-json="{'id':'${prize.id }'}" onclick="return ZF.xconfirm(this);">修改</a></li>
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/delete" data-message="确定要删除该奖品吗？" data-json="{'id':'${prize.id }'}" onclick="return ZF.xconfirm(this);">删除</a></li>
								                  		</c:when>
								                  		<c:when test="${prize.status eq '2' }">
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/changeFlag" data-message="确定要上架该奖品么?" data-json="{'id':'${prize.id }','status':'3'}" onclick="return ZF.xconfirm(this);">上架</a></li>
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/changeFlag" data-message="确定要下架该奖品么?" data-json="{'id':'${prize.id }','status':'4'}" onclick="return ZF.xconfirm(this);">下架</a></li>
								                  		</c:when>
								                  		<c:when test="${prize.status eq '3' }">
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/changeFlag" data-message="确定要下架该奖品么?" data-json="{'id':'${prize.id }','status':'4'}" onclick="return ZF.xconfirm(this);">下架</a></li>
								                  		</c:when>
								                  		<c:when test="${prize.status eq '4' }">
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/changeFlag" data-message="确定要上架该奖品么?" data-json="{'id':'${prize.id }','status':'3'}" onclick="return ZF.xconfirm(this);">上架</a></li>
								                  			<li><a href="#this" data-href="${ctx}/spm/pr/prize/form" data-message="" data-json="{'id':'${prize.id }'}" onclick="return ZF.xconfirm(this);">修改</a></li>
								                  		<li><a href="#this" data-href="${ctx}/spm/pr/prize/delete" data-message="确定要删除该奖品吗？" data-json="{'id':'${prize.id }'}" onclick="return ZF.xconfirm(this);">删除</a></li>
								                  		</c:when>
								                  		<c:otherwise>
								                  			
								                  		</c:otherwise>
								                  	</c:choose>
												  	</ul>
												</div>
								            </shiro:hasPermission>
								            <shiro:lacksPermission name="spm:pr:prize:edit">
								            	<div class="btn-group zf-tableButton">
								                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/spm/pr/prize/info?id=${prize.id}'">详情</button>
								                  	<button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
								                    	<span class="caret"></span>
									                </button>
									            </div>
								            </shiro:lacksPermission>
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
		</section>
	</div>
	<script type="text/javascript">
	function changeFlag(message,href){
		confirm(message,"info",function(){
			window.location.href=href;
		});
		return false;
	}
	
	$(function() {
		ZF.bigImg();
		//表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:6},
				{"orderable":false,targets:7},
				{"orderable":false,targets:11},
				{"orderable":false,targets:12},
				{"orderable":false,targets:16}
            ],
			"ordering" : true,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){},//行取消选中回调
			"addRow":{
				"eventId":"#addRow",
				"getData":function(){
					return ["<td class=\"details-control text-center\"><i class=\"fa fa-plus-square-o text-success\"></i></td>",
					        "<td>2</td>",
					        "<td>3</td>",
					        "<td>4</td>",
					        "<td>5</td>",
					        "<td>6</td>",
					        "<td>7</td>",
					        "<td data-hide=\"true\">8</td>",
					        "<td data-hide=\"true\">9</td>",
					        "<td data-hide=\"true\">10</td>",
					        "<td data-hide=\"true\">11</td>",
					        "<td title=\"测试\">12</td>",
					        "<td>13</td>"
					       ];
				},
				"callBack":function(){
					console.log("行添加结束")
				}
				
			}
		});
	});
	</script>
</body>
</html>