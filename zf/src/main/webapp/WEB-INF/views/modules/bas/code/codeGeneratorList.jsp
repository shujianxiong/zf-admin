<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>编码生成器管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
		
			//标签用法 	
			//autoTip='true'  标记需要自动补全 
			//keyWorld 提交到后台的查询属性名
			//tipUrl 查询的路径 
			$("input[autoTip='true']").on('keyup', autoTip);
		});
		
		function autoTip(){
			console.log("触发了事件");
			var val  = $(this).val();
			var param = "{\""+$(this).attr("keyWorld")+"\":\""+val+"\"}";
			if(val == '' || val == null){
				return;
			}
			param = $.parseJSON(param);
			
			$.ajax({
			    type: "POST",
			    url: $(this).attr("tipUrl"),
			    data: param,
			    success: function(data){
			    	$("input[autoTip='true']").autocomplete({
					    source: $.parseJSON(data)
					});
			    },
			    error:function(data){
			    	console.log(data);
			    }
			});
		}
		//清空查询条件
		function clearQueryParam(){
			$("#codeHandle").val("");
			$("#s2id_dateType").select2("val","");
		}		
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
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bas/code/codeGenerator">编码生成器列表</a></small>
	        <small>|</small>
	        <small><i class="fa-form-edit"></i><a href="${ctx}/bas/code/codeGenerator/form">编码生成器新增</a></small>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
		    <form:form id="searchForm" modelAttribute="codeGenerator" action="${ctx}/bas/code/codeGenerator/" method="post" class="form-horizontal">
			    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<input id="id" name="id" type="hidden" value="${codeGenerator.id }"/>
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
				                  <label for="codeHandle" class="col-sm-3 control-label">生成器代码</label>
				                  <div class="col-sm-7">
<%-- 				                 	<input name="codeHandle" autocomplete="off" keyWorld="keyWorld" autoTip="true" tipUrl="${ctx}/bas/code/codeGenerator/autoTip" class="form-control" data-toggle="tooltip" placeholder="输入生成器代码模糊匹配查询" type="text" value="" /> --%>
				                  	    <input id="codeHandle" name="codeHandle" value="${codeGenerator.codeHandle }" class="form-control" placeholder="输入生成器代码模糊匹配查询"/>
				                  </div>
				                </div>
			        		</div>
			        		<div class="col-md-4">
			        			<div class="form-group">
				                  <label for="dateType" class="col-sm-3 control-label">日期类型</label>
				                  <div class="col-sm-7">
				                    <form:select path="dateType" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('bas_code_generator_dateType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
									
									<%-- <select name="dateType" class="form-control select2">
									   <form:option value="" label="所有"/>
									   <c:forEach items="${fns:getDictList('bas_code_generator_dateType')}" var="t">
									       <option  value="${t.value}"  ${codeGenerator.dateType eq t.value ? 'selected':'' }>${t.label }</option>
									   </c:forEach>
									</select> --%>
									
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
								<th>生成器代码</th>
								<th>编码名称</th>
								<th>前缀</th>
								<th>日期类型</th>
								<th>日期值</th>
								<th>中缀</th>
								<th>主值随机类型</th>
								<th>主值长度</th>
								<th>主值</th>
								<th>后缀</th>
								<th style="display: none">创建者</th>
								<th style="display: none">创建时间</th>
								<th style="display: none">更新者</th>
								<th style="display: none">更新时间</th>
								<th>最后生成编码</th>
								<th>备注</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="codeGenerator" varStatus="status">
							<tr data-index="${status.index }">
								<td class="details-control text-center">
									<i class="fa fa-plus-square-o text-success"></i>
								</td>
								<td>
									${codeGenerator.codeHandle}
								</td>
								<td>
									${codeGenerator.codeName}
								</td>
								<td>
									${codeGenerator.prefix}
								</td>
								<td>
									${fns:getDictLabel(codeGenerator.dateType, 'bas_code_generator_dateType', '')}
								</td>
								<td>
									${codeGenerator.dateValue}
								</td>
								<td>
									${codeGenerator.midfix}
								</td>
								<td>
									${fns:getDictLabel(codeGenerator.mainValueType, 'bas_code_generator_mainValueType', '')}
								</td>
								<td>
									${codeGenerator.mainValueLength}
								</td>
								<td>
									${codeGenerator.mainValue}
								</td>
								<td>
									${codeGenerator.postfix}
								</td>
								<td data-hide="true">
									${fns:getUserById(codeGenerator.createBy.id).name }
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${codeGenerator.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td data-hide="true">
									${fns:getUserById(codeGenerator.updateBy.id).name }
								</td>
								<td data-hide="true">
									<fmt:formatDate value="${codeGenerator.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td>
									${codeGenerator.lastCode}
								</td>
								<td title="${codeGenerator.remarks}">
									${fns:abbr(codeGenerator.remarks,15)}
								</td>
								<td>
					              	<div class="btn-group zf-tableButton">
											<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/bas/code/codeGenerator/info?id=${codeGenerator.id}'">详情</button>
											<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
												<span class="caret"></span>
											</button>
											<shiro:hasPermission name="bas:code:codeGenerator:edit">
												<ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
													<li><a href="#" onclick="return test('${codeGenerator.id}');"  title="生成编码测试">测试生成</a></li>
													<li><a href="${ctx}/bas/code/codeGenerator/form?id=${codeGenerator.id}">修改</a></li>
													<li><a href="${ctx}/bas/code/codeGenerator/delete?id=${codeGenerator.id}" onclick="return ZF.delRow('确认要删除该业务编码吗？', this.href)">删除</a></li>
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
		  //表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			"ordering" : false,//关闭排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){}//行取消选中回调
		});
	  	
	  });
	  
	  
	  function test(id) {
		  ZF.showTip("生成编码测试功能暂时关闭，避免产生干扰数据!", "info");
		  //$("#id").val(id);
		  //$("#searchForm").attr("action","${ctx}/bas/code/codeGenerator/test");
		  //$("#searchForm").submit();
		  //$("#searchForm").attr("action", "${ctx}/bas/code/codeGenerator/");
	  }
</script>
	<!-- 原数据 -->
</body>
</html>