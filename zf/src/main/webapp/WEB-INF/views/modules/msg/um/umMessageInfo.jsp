<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工消息中心管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			
	    </section>
	    
	    <section class="invoice">
	    	<div class="table-responsive">
	            <table class="table">
	              <tr>
	                <th width="10%">消息类型</th>
	                <td>${fns:getDictLabel(umMessage.type, 'msg_um_message_type', '')}/${fns:getDictLabel(umMessage.category, 'msg_um_message_category', '')}</td>
	              </tr>
	              <tr>
	                <th>接收时间</th>
	                <td><fmt:formatDate value="${umMessage.pushTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	              </tr>
	              <tr>
	                <th>标题</th>
	                <td>${umMessage.title }</td>
	              </tr>
	              <tr>
	                <th>内容</th>
	                <td>
	                	<p class="text-muted well well-sm no-shadow">
	                		${umMessage.content }
	                	</p>
	                </td>
	              </tr>
	              <tr>
	                <th>消息状态</th>
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
	              </tr>
	              <tr>
	                <th>发出人</th>
	                <td>${fns:getUserById(umMessage.sendUser.id).name}</td>
	              </tr>
	              <tr>
	                <th>查看时间</th>
	                <td><fmt:formatDate value="${umMessage.viewTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	              </tr>
	              <tr>
	                <th>接收用户</th>
	                <td>${fns:getUserById(umMessage.receiveUser.id).name}</td>
	              </tr>
	              <tr>
	                <th>备注</th>
	                <td>
	                	<p class="text-muted well well-sm no-shadow">
	                		${umMessage.remarks }
	                	</p>
	                </td>
	              </tr>
	            </table>
          	</div>
          	<div class="row no-print">
          		<div class="col-xs-12">
          			<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
          		</div>
          	</div>
	    </section>
	    
	</div>
		
</body>
</html>