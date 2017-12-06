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
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/mi/member/list">会员列表</a></small>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
		    <form:form id="searchForm" modelAttribute="member" action="${ctx}/crm/mi/member/list" method="post" class="form-horizontal">
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
				        					<form:input path="searchParameter.keyWord" class="form-control" placeholder="姓名、电话、编号、邮箱、账号模糊匹配查询" />
				        				</div>
				        			</div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="level" class="col-sm-3 control-label">会员类型</label>
					                  <div class="col-sm-7">
					                    <form:select path="type" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('crm_mi_member_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="memberStatus" class="col-sm-3 control-label">会员状态</label>
					                  <div class="col-sm-7">
					                    <form:select path="memberStatus" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('crm_mi_member_memberStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        	</div>
				        	<div class="row">
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="usercodeStatus" class="col-sm-3 control-label">账号状态</label>
					                  <div class="col-sm-7">
					                    <form:select path="usercodeStatus" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('crm_mi_member_usercodeStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="blackwhiteStatus" class="col-sm-3 control-label" title="黑名单状态">黑名单状态</label>
					                  <div class="col-sm-7">
					                    <form:select path="blackwhiteStatus" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('crm_mi_member_blackwhiteStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
					                  <label for="registerPlatform" class="col-sm-3 control-label" title="黑注册来源">注册来源</label>
					                  <div class="col-sm-7">
					                    <form:select path="registerPlatform" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('crm_mi_member_registerPlatform')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
					                  </div>
					                </div>
				        		</div>
				        	</div>
				        	<div class="row">
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="beginRegisterTime" class="col-sm-3 control-label">注册开始时间</label>
				        				<div class="col-sm-7">
				        					<sys:datetime id="beginRegisterTimeDiv" inputName="beginRegisterTime" tip="请选择注册开始时间" value="${member.beginRegisterTime }" inputId="beginRegisterTime"></sys:datetime>
				        				</div>
				        			</div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="beginRegisterTime" class="col-sm-3 control-label">注册结束时间</label>
				        				<div class="col-sm-7">
				        					<sys:datetime id="endRegisterTimeDiv" inputName="endRegisterTime" tip="请选择注册结束时间" value="${member.endRegisterTime }" inputId="endRegisterTime"></sys:datetime>
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
								<th class="zf-dataTables-multiline"></th>
								<th>会员账号</th>
								<th>微信号</th>
								<th>会员编号</th>
								<th>昵称</th>
								<th>头像</th>
								<th>性别</th>
								<th>年龄</th>
								<th>级别</th>
								<th>类型</th>
								<th>注册时间</th>
								<th>积分</th>
								<th>信誉</th>
								<th>会员状态</th>
								<th>账号状态</th>
								<th>黑白状态</th>
								<th style="display:none">创建者</th>
								<th style="display:none">创建时间</th>
								<th style="display:none">更新者</th>
								<th style="display:none">更新时间</th>
								<th style="display:none">备注信息</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="member" varStatus="status">
								<tr data-index=${status.index }>
									<td class="details-control text-center">
										<i class="fa fa-plus-square-o text-success"></i>
									</td>
									<td>
										${member.usercode}
									</td>
									<td>
										${member.wechatCode}
									</td>
									<td title="${member.memberCode }">
										${fns:abbr(member.memberCode, 11)}
									</td>
									<td title="${member.nickname}">
										${fns:abbr(member.nickname, 15)}
									</td>
									<td>
										<img onerror="imgOnerror(this);" src="${imgHost }${member.gravatar}" data-big data-src="${imgHost }${member.gravatar}" width="20px" height="20px" />
									</td>
									<td>
										<span class="label label-primary">${fns:getDictLabel(member.sex, 'sex', '')}</span>
									</td>
									<td>
										${member.age}
									</td>
									<td>
									   <c:choose>
									       <c:when test="${fns:getSysConfig('memberLevelPoint5').configValue lt member.levelPoint  }">
									           <span class="label bg-black-active color-palette">${fns:getDictLabel('5', 'crm_mi_member_level', '')}</span>
									       </c:when>
									       <c:when test="${fns:getSysConfig('memberLevelPoint4').configValue lt member.levelPoint  }">
                                               <span class="label bg-maroon-active color-palette">${fns:getDictLabel('4', 'crm_mi_member_level', '')}</span>
                                           </c:when>
                                           <c:when test="${fns:getSysConfig('memberLevelPoint3').configValue lt member.levelPoint  }">
                                               <span class="label bg-purple-active color-palette">${fns:getDictLabel('3', 'crm_mi_member_level', '')}</span>
                                           </c:when>
                                           <c:when test="${fns:getSysConfig('memberLevelPoint2').configValue lt member.levelPoint  }">
                                               <span class="label bg-teal-active color-palette">${fns:getDictLabel('2', 'crm_mi_member_level', '')}</span>
                                           </c:when>
                                           <c:when test="${fns:getSysConfig('memberLevelPoint1').configValue lt member.levelPoint  }">
                                               <span class="label bg-orange-active color-palette">${fns:getDictLabel('1', 'crm_mi_member_level', '')}</span>
                                           </c:when>
									   </c:choose>
									</td>
									<td>
									    <c:choose>
                                           <c:when test="${member.type eq '1' }">
                                               <span class="label bg-orange-active color-palette">${fns:getDictLabel(member.type, 'crm_mi_member_type', '')}</span>
                                           </c:when>
                                           <c:when test="${member.type eq '2' }">
                                               <span class="label bg-teal-active color-palette">${fns:getDictLabel(member.type, 'crm_mi_member_type', '')}</span>
                                           </c:when>
                                           <c:when test="${member.type eq '3' }">
                                               <span class="label bg-purple-active color-palette">${fns:getDictLabel(member.type, 'crm_mi_member_type', '')}</span>
                                           </c:when>
                                           <c:when test="${member.type eq '4' }">
                                               <span class="label bg-maroon-active color-palette">${fns:getDictLabel(member.type, 'crm_mi_member_type', '')}</span>
                                           </c:when>
                                           <c:when test="${member.type eq '5' }">
                                               <span class="label bg-black-active color-palette">${fns:getDictLabel(member.type, 'crm_mi_member_type', '')}</span>
                                           </c:when>
                                       </c:choose>
										
									</td>
									<td>
										<fmt:formatDate value="${member.registerTime}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										${member.point}
									</td>
									<td>
										${member.credit}
									</td>
									<td>
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
									</td>
									<td data-hide="true">
										${fns:getUserById(member.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${member.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(member.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${member.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:abbr(member.remarks, 15)}
									</td>
									<td>
					              	 	<div class="btn-group zf-tableButton">
					                  		<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/crm/mi/member/info?id=${member.id}'">详情</button>
					                  		<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
						                    	<span class="caret"></span>
						                  	</button>
						                    <shiro:hasPermission name="crm:mi:member:edit">
						                  	   <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                    	<c:choose>
							                    		<c:when test="${ member.memberStatus eq '1'}">
															<li><a href="#this" onclick="setMemberStatus('${ctx}/crm/mi/member/setMemberStatus','${member.id}','确定要停用该会员账户吗？')">停用</a></li>
							                    		</c:when>
							                    		<c:when test="${ member.memberStatus eq'2'}">
							                    			<li><a href="#this" onclick="setMemberStatus('${ctx}/crm/mi/member/setMemberStatus','${member.id}','确定要启用该会员账户吗？')">启用</a></li>
							                    		</c:when>
							                    	</c:choose>
							                    	<c:choose>
							                    		<c:when test="${ member.usercodeStatus eq '1' }">
															<li><a href="#this" onclick="setUsercodeStatus('${ctx}/crm/mi/member/setUsercodeStatus','${member.id}','2','确定要设置该会员账号状态为冻结吗？')">冻结</a></li>
															<li><a href="#this" onclick="setUsercodeStatus('${ctx}/crm/mi/member/setUsercodeStatus','${member.id}','3','确定要设置该会员账号状态为限制下单吗？')">限制下单</a></li>
							                    		</c:when>
							                    		<c:when test="${ member.usercodeStatus eq '2' }">
							                    			<li><a href="#this" onclick="setUsercodeStatus('${ctx}/crm/mi/member/setUsercodeStatus','${member.id}','1','确定要为该会员账号状态解除冻结吗？')">解除冻结</a></li>
							                    		</c:when>
							                    		<c:when test="${ member.usercodeStatus eq '3' }">
							                    			<li><a href="#this" onclick="setUsercodeStatus('${ctx}/crm/mi/member/setUsercodeStatus','${member.id}','1','确定要为该会员账号状态解除限制下单吗？')">解除限制下单</a></li>
							                    			<li><a href="#this" onclick="setUsercodeStatus('${ctx}/crm/mi/member/setUsercodeStatus','${member.id}','2','确定要设置该会员账号状态为冻结吗？')">冻结</a></li>
							                    		</c:when>
							                    	</c:choose>
							                    	<c:choose>
							                    		<c:when test="${ member.blackwhiteStatus eq '1' }">
						                    				<li><a href="#this" onclick="setBlackwhiteStatus('${ctx}/crm/mi/member/setBlackwhiteStatus','${member.id}','2','确定要设置该会员黑白名单状态为白名单吗？')">设置白名单</a></li>
															<li><a href="#this" onclick="setBlackwhiteStatus('${ctx}/crm/mi/member/setBlackwhiteStatus','${member.id}','3','确定要设置该会员黑白名单状态为黑名单吗？')">设置黑名单</a></li>
							         						<li><a href="#this" onclick="setBlackwhiteStatus('${ctx}/crm/mi/member/setBlackwhiteStatus','${member.id}','4','确定要设置该会员黑白名单状态为风险顾客吗？')">设置风险顾客</a></li>
							                    		</c:when>
							                    		<c:when test="${ member.blackwhiteStatus eq '2' }">
							                    			<li><a href="#this" onclick="setBlackwhiteStatus('${ctx}/crm/mi/member/setBlackwhiteStatus','${member.id}','1','确定要为该会员解除白名单吗？')">解除白名单</a></li>
							                    		</c:when>
							                    		<c:when test="${ member.blackwhiteStatus eq '3' }">
							                    			<li><a href="#this" onclick="setBlackwhiteStatus('${ctx}/crm/mi/member/setBlackwhiteStatus','${member.id}','1','确定要为该会员解除黑名单吗？')">解除黑名单</a></li>
							                    		</c:when>
							                    		<c:when test="${ member.blackwhiteStatus eq '4' }">
							                    			<li><a href="#this" onclick="setBlackwhiteStatus('${ctx}/crm/mi/member/setBlackwhiteStatus','${member.id}','1','确定要为该会员解除风险顾客吗？')">解除风险顾客</a></li>
							                    		</c:when>
							                    	</c:choose>
						                  	   </ul>
						                    </shiro:hasPermission>
						                </div>
									</td>
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
			
			ZF.bigImg();
		  
		  	//表格初始化
			ZF.parseTable("#contentTable", {
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,
				"ordering" : true,
				"order": [[ 10, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
	                {"orderable":false,targets:0},
	                {"orderable":false,targets:1},
                    {"orderable":false,targets:2},
                    {"orderable":false,targets:3},
                    {"orderable":false,targets:4},
                    {"orderable":false,targets:5},
                    {"orderable":false,targets:6},
	                {"orderable":false,targets:7},
	                {"orderable":false,targets:8},
	                {"orderable":false,targets:9},
                    {"orderable":false,targets:14},
                    {"orderable":false,targets:15},
                    {"orderable":false,targets:16},
                    {"orderable":false,targets:17},
                    {"orderable":false,targets:18},
                    {"orderable":false,targets:19},
                    {"orderable":false,targets:20},
                    {"orderable":false,targets:21}
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