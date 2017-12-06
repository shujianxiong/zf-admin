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
		
	
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/crm/mi/member/notifySelect">会员列表</a></small>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
		    <form:form id="searchForm" modelAttribute="notifyMemberVO" action="${ctx}/crm/mi/member/notifySelect" method="post" class="form-horizontal" onsubmit="return onSubmit();">
			    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
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
				        				<label for="type" class="col-sm-3 control-label">用户类型</label>
				        				<div class="col-sm-7">
				        					<form:select path="type" class="form-control select2">
												<form:option value="" label="请选择类型"/>
												<form:option value="1" label="注册未交易用户"/>
												<form:option value="2" label="体验未购买用户"/>
												<form:option value="3" label="购买会员"/>
				        					</form:select>
				        				</div>
				        			</div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="startDate" class="col-sm-3 control-label">起始时间</label>
				        				<div class="col-sm-7">
				        					<sys:datetime id="startDate" inputName="startDate" tip="请选择起始时间" inputId="startDate" isMandatory="true" value="${notifyMemberVO.startDate}"></sys:datetime>
				        				</div>
				        			</div>
			        			</div>	
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="endDate" class="col-sm-3 control-label">结束时间</label>
				        				<div class="col-sm-7">
				        					<sys:datetime id="endDate" inputName="endDate" tip="请选择结束时间" inputId="endDate" isMandatory="true" value="${notifyMemberVO.endDate}"></sys:datetime>
				        				</div>
				        			</div>
				        		</div>	
				        	</div>
				        	<div class="row">
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="experienceCountStart" class="col-sm-3 control-label">体验次数从</label>
				        				<div class="col-sm-3">
				        					<form:input type="text" path="experienceCountStart" class="form-control"></form:input>
				        				</div>
				        				<label for="experienceCountEnd" class="col-sm-3 control-label" style="width: 40px;">到</label>
				        				<div class="col-sm-3">
				        					<form:input type="text" path="experienceCountEnd" class="form-control"></form:input>
				        				</div>
				        			</div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="buyCountStart" class="col-sm-3 control-label">购买次数从</label>
				        				<div class="col-sm-3">
				        					<form:input type="text" path="buyCountStart" class="form-control"></form:input>
				        				</div>
				        				<label for="buyCountEnd" class="col-sm-3 control-label" style="width: 40px;">到</label>
				        				<div class="col-sm-3">
				        					<form:input type="text" path="buyCountEnd" class="form-control"></form:input>
				        				</div>
				        			</div>
				        		</div>
				        		<div class="col-md-4">
				        			<div class="form-group">
				        				<label for="tradeMoneyStart" class="col-sm-3 control-label">交易金额从</label>
				        				<div class="col-sm-3">
				        					<form:input type="text" path="tradeMoneyStart" class="form-control"></form:input>
				        				</div>
				        				<label for="tradeMoneyEnd" class="col-sm-3 control-label" style="width: 40px;">到</label>
				        				<div class="col-sm-3">
				        					<form:input type="text" path="tradeMoneyEnd" class="form-control"></form:input>
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
								<th><input type="checkbox" id="allcheck"/>全选</th>
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
											<input type="checkBox" name="selectName" value="${member.id}" data-name="${member.usercode}"/>
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
	
	//读取 
	var mapStr = localStorage.getItem('memberMap');
	var map = JSON.parse(mapStr);
	if(map==null){
		map = {};
	}
	
    $(function () {
  		
		$("#type").change(function(){
			localStorage.removeItem('usercode');
			localStorage.removeItem('memberIds');
			$("[data-name]").iCheck('uncheck');
		});  
		
	  	$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
	  	var memberIds = localStorage.getItem("pageNo"+$("#pageNo").val())==null||localStorage.getItem("pageNo"+$("#pageNo").val())==undefined?[]:localStorage.getItem("pageNo"+$("#pageNo").val()).split(',');
  		var usercode = localStorage.getItem('usercode');
  		var existMemberIds = memberIds;

  		
  		
	  	if(memberIds!=undefined&&memberIds.length >0){
	  		for(let i=0;i<memberIds.length;i++){
	  			$("[data-name]").each(function(){
					if($(this).val() == memberIds[i]){
						$(this).iCheck('check');
					}
				});
	  		}
	  	}
	  	
	  	$("#allcheck").on("ifChecked", function(){
	  		$("[data-name]").iCheck('check');
	  	}).on("ifUnchecked", function() {
            $("[data-name]").iCheck('uncheck');
        });
	  	
	  	$("[data-name]").on("ifChecked",function(){
	  		memberIds = [];
			$("[data-name]").each(function(){
				if($(this).prop("checked")){
					memberIds.push($(this).val());
				}
			});
			if(memberIds.length > 0){
		  		localStorage.setItem('usercode', $(this).attr("data-name"));
		  		localStorage.setItem('pageNo'+$("#pageNo").val(), memberIds);
// 		  		map.set('pageNo'+$("#pageNo").val(), memberIds);
		  		map['pageNo'+$("#pageNo").val()] = memberIds;
		  		let str = JSON.stringify(map);
		  		localStorage.setItem('memberMap', str);
			}
	  	});
	  	
	  	$("[data-name]").on("ifUnchecked",function(){
	  		$("#allcheck").iCheck('uncheck');
	  		memberIds = [];
	  		if(usercode == $(this).attr("data-name")){
	  			usercode = null;
	  		}
			$("[data-name]").each(function(){
				if(usercode == null ||usercode == undefined){
					usercode = $(this).attr("data-name");
				}
				if($(this).prop("checked")){
					memberIds.push($(this).val());
				}
			});
			if(memberIds.length > 0){
		  		localStorage.setItem('usercode', $(this).attr("data-name"));
		  		localStorage.setItem('pageNo'+$("#pageNo").val(), memberIds);
// 		  		map.set('pageNo'+$("#pageNo").val(), memberIds);
		  		map['pageNo'+$("#pageNo").val()] = memberIds;
		  		let str = JSON.stringify(map);
		  		localStorage.setItem('memberMap', str);
			}else{
				localStorage.removeItem('usercode');
				localStorage.removeItem('pageNo'+$("#pageNo").val());
				//读取 
			    let str = localStorage.getItem('memberMap');
				map = JSON.parse(str);
				map['pageNo'+$("#pageNo").val()] = '';
				//重新保存
				str = JSON.stringify(map);
		  		localStorage.setItem('memberMap', str);
			}
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
	  
	  function onSubmit(){
			if($("#type").val() == null ||$("#type").val() == ''){
				ZF.showTip('请先选择类型', 'info');
				return false;
			}else if(!ZF.formVerify(false,'9', $("#tradeMoneyStart").val())||
					!ZF.formVerify(false,'9', $("#tradeMoneyEnd").val())){
				ZF.showTip('交易金额只能为两位小数', 'warning');
				return false;
			}
		}
	  
	
	  
</script>
</body>
</html>