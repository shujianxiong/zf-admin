<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员列表管理</title>
	<meta name="decorator" content="adminLte"/>
	
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function setMemberStatus(url,id,message){
			confirm(message,"warning",function(){
				$("#memberId").val(id);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			});
		}
		
		function setUsercodeStatus(url,id,status,message){
			confirm(message,"warning",function(){
				$("#memberId").val(id);
				$("#status").val(status);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			});
		}
		
		function setBlackwhiteStatus(url,id,status,message){
			confirm(message,"warning",function(){
				$("#memberId").val(id);
				$("#status").val(status);
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			});
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/mi/member/select">会员列表</a></small>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
		    <form:form id="searchForm" modelAttribute="member" action="${ctx}/crm/mi/member/select" method="post" class="form-horizontal">
			    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input id="memberId" type="hidden" name="id"/>
				<input id="status" type="hidden" name="status"/>
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
				        			<div class="form-group">
				        				<label for="searchParameter.keyWord" class="col-sm-3 control-label">关键字</label>
				        				<div class="col-sm-7">
				        					<form:input path="searchParameter.keyWord" class="form-control" placeholder="昵称、账号模糊匹配查询" />
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
	    			<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
						<thead>
							<tr>
								<th></th>
								<th>会员账号</th>
								<th>昵称</th>
								<th>性别</th>
								<th>年龄</th>
								<th>级别</th>
								<th>类型</th>
								<!-- <th>审核状态</th> -->
								<th>注册来源</th>
								<th>注册时间</th>
<!-- 								<th>会员状态</th> -->
<!-- 								<th>账号状态</th> -->
<!-- 								<th>黑白名单状态</th> -->
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="member" varStatus="status">
								<tr>
									<td>
										<div class="zf-check-wrapper-padding">
											<input type="radio" name="selectName" value="${member.id}" data-name="${member.usercode}"/>
										</div>
									</td>
									<td>
										${member.usercode}
									</td>
									<td>
										${member.nickname}
									</td>
									<td>
										${fns:getDictLabel(member.sex, 'sex', '')}
									</td>
									<td>
										${member.age}
									</td>
									<td>
										${fns:getDictLabel(member.level, 'crm_mi_member_level', '')}
									</td>
									<td>
										${fns:getDictLabel(member.type, 'crm_mi_member_type', '')}
									</td>
									<%-- <td>
										<c:choose>
											<c:when test="${member.idCardCheckStatus eq '0'}">
												<span class="label label-primary">${fns:getDictLabel(member.idCardCheckStatus, 'crm_mi_member_id_card_status', '')}</span>
											</c:when>
											<c:when test="${member.idCardCheckStatus eq '1'}">
												<span class="label label-warning">${fns:getDictLabel(member.idCardCheckStatus, 'crm_mi_member_id_card_status', '')}</span>
											</c:when>
											<c:when test="${member.idCardCheckStatus eq '2'}">
												<span class="label label-success">${fns:getDictLabel(member.idCardCheckStatus, 'crm_mi_member_id_card_status', '')}</span>
											</c:when>
										</c:choose>
									</td> --%>
									<td>
										${fns:getDictLabel(member.registerPlatform, 'crm_mi_member_registerPlatform', '')}
									</td>
									<td>
										<fmt:formatDate value="${member.registerTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<%-- <td>
										<c:choose>
											<c:when test="${member.memberStatus eq '1'}">
												<span class="label label-success">${fns:getDictLabel(member.memberStatus, 'crm_mi_member_memberStatus', '')}</span>
											</c:when>
											<c:when test="${member.memberStatus eq '2'}">
												<span class="label label-warning">${fns:getDictLabel(member.memberStatus, 'crm_mi_member_memberStatus', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${member.usercodeStatus eq '1'}">
												<span class="label label-success">${fns:getDictLabel(member.usercodeStatus, 'crm_mi_member_usercodeStatus', '')}</span>
											</c:when>
											<c:when test="${member.usercodeStatus eq '2'}">
												<span class="label label-info">${fns:getDictLabel(member.usercodeStatus, 'crm_mi_member_usercodeStatus', '')}</span>
											</c:when>
											<c:when test="${member.usercodeStatus eq '3'}">
												<span class="label label-warning">${fns:getDictLabel(member.usercodeStatus, 'crm_mi_member_usercodeStatus', '')}</span>
											</c:when>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${member.blackwhiteStatus eq '1'}">
												<span class="label label-success">${fns:getDictLabel(member.blackwhiteStatus, 'crm_mi_member_blackwhiteStatus', '')}</span>
											</c:when>
											<c:when test="${member.blackwhiteStatus eq '2'}">
												<span class="label label-info">${fns:getDictLabel(member.blackwhiteStatus, 'crm_mi_member_blackwhiteStatus', '')}</span>
											</c:when>
											<c:when test="${member.blackwhiteStatus eq '3'}">
												<span class="label label-danger">${fns:getDictLabel(member.blackwhiteStatus, 'crm_mi_member_blackwhiteStatus', '')}</span>
											</c:when>
											<c:when test="${member.blackwhiteStatus eq '4'}">
												<span class="label label-warning">${fns:getDictLabel(member.blackwhiteStatus, 'crm_mi_member_blackwhiteStatus', '')}</span>
											</c:when>
										</c:choose>
									</td> --%>
								</tr>
							</c:forEach>
						</tbody>
					</table>
	    		</div>
	    		<div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
	            </div>
	    	</div>
	    </section>
	</div>
	
<script>
	  $(function () {
		  
	  	$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
		  //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"order": [[ 4, "asc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:5},
				{"orderable":false,targets:6},
				{"orderable":false,targets:7}
            ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		})
	  	
	  });
</script>
</body>
</html>