<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#contentTable").treeTable({expandLevel : 1});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false; 
        }
		
		function removeArea(url,id){
			confirm("要删除该区域及所有子区域项吗？","warning",function(){
				window.location.href=url+"?id="+id;
			});
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/sys/area/">区域列表</a></small>
	        
	        <shiro:hasPermission name="sys:area:edit">
	           <small>|</small>
	           <small>
	               <i class="glyphicon glyphicon-edit"></i>
	               <a href="${ctx}/sys/area/form?id=${area.id}">区域${not empty area.id?'修改':'添加'}</a>
	           </small>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="sys:area:import">
               <small>|</small>
               <small>
                   <i class="glyphicon glyphicon-import"></i>
                   <a href="${ctx }/sys/area/importForm">区域批量导入</a>
               </small>
            </shiro:hasPermission>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<div class="box box-soild">
	    		<div class="box-body">
	    			<div class="table-responsive">
	    				<table id="contentTable" class="table table-hover table-bordered table-condensed zf-tbody-font-size">
							<thead>
								<tr>
									<th>区域名称</th>
									<th>区域编码</th>
									<th>区域类型</th>
									<th>备注</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="area">
								<tr id="${area.id}" pId="${area.parent.id ne '1'?area.parent.id:'0'}">
									
									<td nowrap>
										<%-- <a href="${ctx}/sys/area/info?id=${area.id}"> --%>
										${area.name}
										<!-- </a> -->
									</td>
									<td>
										${area.code}
									</td>
									<td>
										${fns:getDictLabel(area.type, 'sys_area_type', '无')}
									</td>
									<td>
										${area.remarks }
									</td>
									<td>
										<shiro:hasPermission name="sys:area:edit">
											<div class="btn-group zf-tableButton">
							                  <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/area/form?id=${area.id}'">修改</button>
							                  <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                    <span class="caret"></span>
							                  </button>
							                  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                    <li><a href="#this" onclick="removeArea('${ctx}/sys/area/delete','${area.id}')" style="color:#fff">删除</a></li>
							                    <li><a href="${ctx}/sys/area/form?parent.id=${area.id}">添加下级区域</a></li>
							                    <li><a href="${ctx}/sys/area/info?id=${area.id}">详情</a></li>
							                  </ul>
							                </div>
										</shiro:hasPermission>
										<shiro:lacksPermission name="sys:area:edit">
											<div class="btn-group zf-tableButton">
							                  <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/sys/area/info?id=${area.id}'">详情</button>
							                  <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
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
	    	</div>
	    	
	    	
	    	<%-- <div id="importModal" class="modal fade">
             <div class="modal-dialog">
                 <div class="modal-content">
                     <div class="modal-header">
                         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                         <span aria-hidden="true">&times;</span></button>
                         <h4 class="modal-title">批量导入区域信息</h4>
                     </div>
                     <div class="modal-body divScroll">
                         <form:form id="inputForm" action="${ctx }/sys/area/import"  enctype="multipart/form-data"  modelAttribute="area" method="post" onsubmit="return formSubmit();">
                            <div class="box-body">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">上传文件</label>
                                    <div class="col-sm-9">
                                        <input type="file" id="inputFile" name="file" accept="application/vnd.ms-excel">
                                        <p class="help-block text-red">
                                                                                        文件只限Excel文本文件<br/>
                                        </p>
                                    </div>
                                </div>
                            </div>
                         </form:form>
                     </div>
                     <div class="modal-footer">
                         <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
                         <button type="button" id="importCommit" class="btn btn-primary">提交</button>
                     </div>
                </div>
           </div>
        </div> --%>
	    </section>
	    <script type="text/javascript">
	         $(function() {
	        	 /* $("#batchBtn").on("click", function() {
	        		 $("#importModal").modal('toggle');//显示模态框
	        	 });
	        	 
	        	 $("#importCommit").on("click", function() {
	        		 $(this).attr("disabled", true);
	                  $("#inputForm").submit();
	              }); */
	         });
	         
	         /* function formSubmit() {
	        	 var file = $("#inputFile").val();
	        	 if(file == null || file == "") {
	        		 ZF.showTip("请先上传区域Excel表!", "info");
	        		 return false;
	        	 }
	        	 return true;
	         } */
	    </script>
	</div>
</body>
</html>