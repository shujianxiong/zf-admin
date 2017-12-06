<%
String errTitle="错误提示";
response.setStatus(500);
// 获取异常类
Throwable ex = Exceptions.getThrowable(request);
if (ex != null){
	LoggerFactory.getLogger("500.jsp").error(ex.getMessage(), ex);
}


// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print(ex.getMessage());
}

%>
<%@page import="org.slf4j.Logger,org.slf4j.LoggerFactory"%>
<%@page import="com.chinazhoufan.admin.common.web.Servlets"%>
<%@page import="com.chinazhoufan.admin.common.utils.Exceptions"%>
<%@page import="com.chinazhoufan.admin.common.utils.StringUtils"%>
<%@page import="com.chinazhoufan.admin.common.approve.exception.ApproveValidException"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>500 - <%=errTitle %></title>
	<%@include file="/WEB-INF/views/include/adminLteHead.jsp" %>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h3>
	        <small></small>
	      </h3>
	    </section>
	    <section class="content">
	    	<%
	    	if(ex!=null&&ex instanceof ApproveValidException){
	    		%>
	    		<div class="margin alert alert-warning alert-dismissible">
    				<h5><i class="icon fa fa-warning"></i> 操作提示</h5>
    				<h3><%=ex.getMessage() %></h3>
	    		</div>
	    	<%
	    	}else if(ex!=null){
	    	%>
	    	<div class="margin alert alert-danger alert-dismissible">
   				<h4><i class="icon fa fa-ban"></i> 操作提示</h4>
   				<h5><%=Exceptions.getStackTraceAsString(ex) %></h5>
    		</div>
	    	<%
	    	}else{
	    	%>
	    		<div>未知错误</div>
	    	<%
	    	}
	    	%>
	    	
	    	<div class="margin">
	    		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	    	</div>
	    </section>
	</div>
</body>
</html>