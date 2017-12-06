<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工消息中心管理</title>
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
	    
	    <section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/msg/um/myUmMessage/list">收件箱</a></small>
	        <small>|</small>
	        <small><i class="fa-mail-send"></i><a  href="${ctx}/msg/um/myUmMessage/sendList">发件箱</a></small>
	        <small>|</small>
	        <small><i class="fa-mail-all"></i><a href="${ctx}/msg/um/myUmMessage/listAllMy">所有</a></small>
          	<small>|</small>
	        <small><i class="fa-form-edit"></i><a href="${ctx}/msg/um/umMessage/form">发消息</a></small>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	   
	    <section class="content">
	    	<form:form id="searchForm" modelAttribute="umMessage" action="${ctx}/msg/um/myUmMessage/list" method="post" class="form-horizontal">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<input id="umMessageId" name="id" type="hidden"/>
		    	<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
							<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
				                  <label for="title" class="col-sm-3 control-label">关键字</label>
				                  <div class="col-sm-7">
				                    <form:input id="title" path="title" htmlEscape="false" maxlength="100" class="form-control" placeholder="按标题查询"/>
				                  </div>
				                </div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
				                  <label for="status" class="col-sm-3 control-label">消息状态</label>
				                  <div class="col-sm-7">
				                    <form:select path="status" class="form-control select2" style="width: 100%;">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('msg_um_message_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
	    			<div class="row">
						<div class="col-sm-12 pull-right">
				          	<button type="button" class="btn btn-sm btn-info" onclick="info('${ctx}/msg/um/umMessage/info',getSelectTrId())"><i class="fa fa-check-square">详情</i></button>
				            <button type="button" class="btn btn-sm btn-dropbox" onclick="view('${ctx}/msg/um/myUmMessage/view',getSelectTrId(),'确定要标记为已查看吗？')"><i class="fa fa-edit">标记为已查看</i></button>
					   		<shiro:hasPermission name="msg:um:myUmMessage:edit">
					   		<button type="button" class="btn btn-sm btn-github" onclick="del('${ctx}/msg/um/myUmMessage/delete',getSelectTrId(), '确认要删除该消息记录吗？')"><i class="fa fa-remove">删除</i></button>
							</shiro:hasPermission>
						</div>
					</div>
	    			<div class="table-responsive">
		    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
									<th class="zf-dataTables-multiline"></th>
									<th>类型</th>
									<th>接收时间</th>
									<th>标题</th>
									<th>内容</th>
									<th>消息状态</th>
									<th>发出人</th>
									<th>查看时间</th>
									<th style="display: none">接收人</th>
									<th style="display: none">创建者</th>
									<th style="display: none">创建时间</th>
									<th style="display: none">更新者</th>
									<th style="display: none">更新时间</th>
									<th style="display: none">备注</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="umMessage" varStatus="status">
								<tr data-id="${umMessage.id}" data-index="${status.index }">
									<td class="details-control text-center">
										<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td>
										${fns:getDictLabel(umMessage.type, 'msg_um_message_type', '')}/${fns:getDictLabel(umMessage.category, 'msg_um_message_category', '')}
									</td>
									<td>
										<fmt:formatDate value="${umMessage.pushTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										${umMessage.title}
									</td>
									<td>
										<span data-toggle='tooltip' data-placement='top' data-original-title='${umMessage.content}'>${fns:abbr(umMessage.content,32)}</span>
									</td>
									<td>
										<c:choose>
											<c:when test="${umMessage.status eq '1' }">
												<span class="label label-primary">${fns:getDictLabel(umMessage.status, 'msg_um_message_status', '')}</span>
											</c:when>
											<c:when test="${umMessage.status eq '0' }">
												<span class="label label-success">${fns:getDictLabel(umMessage.status, 'msg_um_message_status', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										${fns:getUserById(umMessage.sendUser.id).name}
									</td>
									<td>
										<fmt:formatDate value="${umMessage.viewTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(umMessage.receiveUser.id).name}
									</td>
									<td data-hide="true">
										${fns:getUserById(umMessage.createBy.id).name }
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${umMessage.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(umMessage.updateBy.id).name }
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${umMessage.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${umMessage.remarks}
									</td>
									<td>
						              	<div class="btn-group zf-tableButton">
							                  <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/msg/um/umMessage/info?id=${umMessage.id}'">详情</button>
							                  <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                    <span class="caret"></span>
							                  </button>
						                     <shiro:hasPermission name="msg:um:myUmMessage:edit">
								                  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                  		<%-- <c:if test="${umMessage.status eq '0' }">
		  													<li><a href="#this" onclick="view('${ctx}/msg/um/myUmMessage/view','${umMessage.id}','确定要标记为已查看吗？')">标记为已查看</a></li>
							                  		</c:if> --%>
								                    <li><a href="${ctx}/msg/um/myUmMessage/delete?id=${umMessage.id}" style="color:#fff" onclick="return ZF.delRow('确认要删除该消息记录吗？',this.href)">删除</a></li>
								                  </ul>
						                    </shiro:hasPermission>
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
<script>
  $(function () {
	  //表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"order": [[ 2, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:5},
				{"orderable":false,targets:6},
				{"orderable":false,targets:14}
          ],
			"ordering" : true,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){}//行取消选中回调
		});
  	
  });
  	
  	//获取行选中ID
	function getSelectTrId(){
		var trs=$("tr");
		for(var i=0;i<trs.length;i++){
			if($(trs[i]).hasClass('selected')){
				return $(trs[i]).attr("data-id");
			}
		}
		return "";
	}
	//详情
	function info(url, id) {
		if(id == null || id == "" || id == undefined) {
			ZF.showTip("请先选择消息记录!", "info");
			return;
		}
		confirm(message,"info",function(){
            $("#umMessageId").val(id);
            $("#searchForm").attr("action",url);
            $("#searchForm").submit();
        })
	}
	
	//删除
	function del(url, id, message) {
		if(id == null || id == "" || id == undefined) {
            ZF.showTip("请先选择消息记录!", "info");
            return;
        }
		confirm(message,"info",function(){
            $("#umMessageId").val(id);
            $("#searchForm").attr("action",url);
            $("#searchForm").submit();
        })
	}
	
	//标记为已查看
	function view(url,id,message){
		if(id == null || id == "" || id == undefined) {
            ZF.showTip("请先选择消息记录!", "info");
            return;
        }
		confirm(message,"info",function(){
			$("#umMessageId").val(id);
			$("#searchForm").attr("action",url);
			$("#searchForm").submit();
		})
	}
</script>
</body>
</html>