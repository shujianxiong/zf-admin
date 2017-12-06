<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公众号聊天记录列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
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
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/wcp/ar/msgRecord/list">公众号聊天记录列表</a></small>
			</h1>
		</section>
		<sys:tip content="${message}"/>
		<section  class="content">
			<form:form id="searchForm" modelAttribute="msgRecord" action="${ctx}/wcp/ar/msgRecord/list" method="post" class="form-horizontal">
		    	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
							<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div  class="form-group">
									<label for="sendType" class="col-sm-3 control-label">消息发送类型</label>
									<div class="col-sm-7">
										<form:select path="sendType" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('wcp_ar_msg_record_sendType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div  class="form-group">
									<label for="contentType" class="col-sm-3 control-label">内容类型</label>
									<div class="col-sm-7">
										<form:select path="contentType" htmlEscape="false" maxlength="50" class="form-control select2">
											<form:option label="所有" value="" />
											<form:options items="${fns:getDictList('wcp_ar_auto_reply_contentType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
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
				</div>
            </form:form>
			<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>消息发送平台</th>
									<th>发送类型</th>
									<th>回复类型</th>
									<th>发送人账号</th>
									<th>接收人账号</th>
									<th>内容类型</th>
									<th>内容</th>
									<th>自动回复名称</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<th>备注信息</th>
									<th><shiro:hasPermission name="wcp:ar:msgRecord:view">操作</shiro:hasPermission></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="msgRecord" varStatus="status">
									<tr data-index="${status.index }">
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td>
											<c:choose>
												<c:when test="${msgRecord.platformType eq 'WC' }">
													<span class="label label-primary">${fns:getDictLabel(msgRecord.platformType, 'wcp_ar_msg_record_platformType', '') }</span>
												</c:when>
												<c:otherwise>
													<span class="label label-info">${fns:getDictLabel(msgRecord.platformType, 'wcp_ar_msg_record_platformType', '') }</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${msgRecord.sendType eq 'SEND' }">
													<span class="label label-primary">${fns:getDictLabel(msgRecord.sendType, 'wcp_ar_msg_record_sendType', '') }</span>
												</c:when>
												<c:when test="${msgRecord.sendType eq 'REPLY' }">
													<span class="label label-success">${fns:getDictLabel(msgRecord.sendType, 'wcp_ar_msg_record_sendType', '') }</span>
												</c:when>
												<c:otherwise>
													<span class="label label-info">${fns:getDictLabel(msgRecord.sendType, 'wcp_ar_msg_record_sendType', '') }</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${msgRecord.replyType eq 'U' }">
													<span class="label label-primary">${fns:getDictLabel(msgRecord.replyType, 'wcp_ar_msg_record_replyType', '') }</span>
												</c:when>
												<c:when test="${msgRecord.replyType eq 'S' }">
													<span class="label label-success">${fns:getDictLabel(msgRecord.replyType, 'wcp_ar_msg_record_replyType', '') }</span>
												</c:when>
												<c:otherwise>
													<span class="label label-info">${fns:getDictLabel(msgRecord.replyType, 'wcp_ar_msg_record_replyType', '') }</span>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${msgRecord.sendType eq 'SEND' }">
													${fns:getMemberById(msgRecord.fromUserId).usercode }
												</c:when>
												<c:otherwise>
													周范公众号
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:choose>
												<c:when test="${msgRecord.sendType eq 'REPLY' }">
													${fns:getMemberById(msgRecord.toUserId).usercode }
												</c:when>
												<c:otherwise>
													周范公众号
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											${fns:getDictLabel(msgRecord.contentType, 'wcp_ar_auto_reply_contentType', '') }
										</td>
										<td title="${msgRecord.content }">
											${fns:abbr(msgRecord.content, 30) }
										</td>
										<td>
											${msgRecord.autoReply.name }
										</td>
										<td data-hide="true">
											${fns:getUserById(msgRecord.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${msgRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(msgRecord.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${msgRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td title="${msgRecord.remarks }">
											${fns:abbr(msgRecord.remarks, 30) }
										</td>
										<td>
							            	<div class="btn-group zf-tableButton">
							                  	<button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/wcp/ar/msgRecord/info?id=${msgRecord.id}'">详情</button>
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
		</section>
	</div>
	<script type="text/javascript">
		$(function() {
			ZF.bigImg();
			
			 //表格初始化
			ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,				// 关闭搜索
// 				"order": [[ 1, "desc" ]],			// 指定默认初始化按第几列排序，默认排序升序，降序
// 				"columnDefs":[
// 					{"orderable":false,targets:0},	//第0列和第14列不排序
// 					{"orderable":false,targets:4},
// 					{"orderable":false,targets:5},
// 					{"orderable":false,targets:6},
// 					{"orderable":false,targets:7},
// 					{"orderable":false,targets:9},
// 					{"orderable":false,targets:10},
// 					{"orderable":false,targets:11},
// 					{"orderable":false,targets:12},
// 					{"orderable":false,targets:13},
// 					{"orderable":false,targets:14}
// 		       ],
				"ordering" : false,					// 关闭排序
				"info" : false,
				"autoWidth" : false,
				"multiline":true,					// 是否开启多行表格
				"isRowSelect":true,					// 是否开启行选中
				"rowSelect":function(tr){},			// 行选中回调
				"rowSelectCancel":function(tr){}	//行取消选中回调
			});
		});

	</script>
</body>
</html>