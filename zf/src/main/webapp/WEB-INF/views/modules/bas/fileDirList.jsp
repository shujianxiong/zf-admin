<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文件目录管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#contentTable").treeTable({expandLevel : 3});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false; 
        }
		
		function removeFileDir(url,id){
			confirm("要删除该目录及所有子目录吗？","warning",function(){
				window.location.href=url+"?id="+id;
			});
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bas/fileDir/">文件目录列表</a></small>
	        <small>|</small>
	       <%--  <shiro:hasPermission name="bas:fileDir:edit"> --%>
	        <small><i class="fa-form-edit"></i><a href="${ctx}/bas/fileDir/form?id=${fileDir.id}">文件目录${not empty fileDir.id?'修改':'添加'}</a></small>
	        <%-- </shiro:hasPermission> --%>
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
									<th>目录名称</th>
									<th>目录编码</th>
									<th>是否公开</th>
									<th>目录排序</th>
									<th>上级目录</th>
									<th>备注</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list}" var="fileDir">
								<tr id="${fileDir.id}" pId="${fileDir.parent.id ne '1'?fileDir.parent.id:'0'}">
									
									<td nowrap>
										${fileDir.name}
									</td>
									<td>
                                        ${fileDir.code}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fileDir.type eq '0' }">
                                                <span class="label label-primary">${fns:getDictLabel(fileDir.type, 'yes_no', '')}</span>
                                            </c:when>
                                            <c:when test="${fileDir.type eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(fileDir.type, 'yes_no', '')}</span>
                                            </c:when>
                                        </c:choose>
                                        
                                    </td>
									<td>
										${fileDir.orderNo}
									</td>
									<td>
									    ${fileDir.parent.name }
									</td>
									<td>
										${fileDir.remarks }
									</td>
									<td>
										<shiro:hasPermission name="bas:fileDir:edit">
											<div class="btn-group zf-tableButton">
							                  <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/bas/fileDir/form?id=${fileDir.id}'">修改</button>
							                  <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                    <span class="caret"></span>
							                  </button>
							                  <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                     <c:choose>
							                         <c:when test="${fileDir.type eq '0' }">
							                             <li><a href="${ctx}/bas/fileDir/updateStatus?id=${fileDir.id}&type=1">公开</a></li>
							                         </c:when>
							                         <c:when test="${fileDir.type eq '1' }">
							                             <li><a href="${ctx}/bas/fileDir/updateStatus?id=${fileDir.id}&type=0">隐藏</a></li>
							                         </c:when>
							                     </c:choose>
							                     
							                    <li><a href="#this" onclick="removeFileDir('${ctx}/bas/fileDir/delete','${fileDir.id}')" style="color:#fff">删除</a></li>
							                    <li><a href="${ctx}/bas/fileDir/form?parent.id=${fileDir.id}">添加下级目录</a></li>
							                  </ul>
							                </div>
										</shiro:hasPermission>
										<shiro:lacksPermission name="bas:fileDir:edit">
											<div class="btn-group zf-tableButton">
							                  <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/bas/fileDir/info?id=${fileDir.id}'">详情</button>
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
	    </section>
	</div>
</body>
</html>