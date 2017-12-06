<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	
	  <meta charset="utf-8">
	  <meta http-equiv="X-UA-Compatible" content="IE=edge">
	  <!-- Tell the browser to be responsive to screen width -->
	  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	  <!-- Bootstrap 3.3.5 -->
	  <link rel="stylesheet" href="${ctxStatic}/adminLte/bootstrap/css/bootstrap.min.css">
	  <!-- Font Awesome -->
	  <link rel="stylesheet" href="${ctxStatic }/adminLte/dist/font-awesome-4.4.0/css/font-awesome.min.css">
	  <!-- Ionicons -->
	  <link rel="stylesheet" href="${ctxStatic }/adminLte/dist/ionicons-2.0.1/css/ionicons.min.css">
	  <!-- Theme style -->
	  <link rel="stylesheet" href="${ctxStatic}/adminLte/dist/css/AdminLTE.min.css">
	  <!-- iCheck -->
	  <link rel="stylesheet" href="${ctxStatic}/adminLte/plugins/iCheck/square/blue.css">
<!-- 	<meta name="decorator" content="adminLte"/> -->
	  <!-- jQuery 2.1.4 -->
	  <script src="${ctxStatic}/adminLte/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	  <!-- Bootstrap 3.3.5 -->
	  <script src="${ctxStatic}/adminLte/bootstrap/js/bootstrap.min.js"></script>
      <!-- iCheck -->
	  <script src="${ctxStatic}/adminLte/plugins/iCheck/icheck.min.js"></script>
	<script type="text/javascript">
		
		var ctxStatic = "${ctxStatic}";
		
		window.onload = function (){
			var userAgent = navigator.userAgent;
		    var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器
			var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器
			var isFF = userAgent.indexOf("Firefox") > -1; //判断是否Firefox浏览器
			var isSafari = userAgent.indexOf("Safari") > -1; //判断是否Safari浏览器
			
			if (isIE) {
				var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
				reIE.test(userAgent);
				var fIEVersion = parseFloat(RegExp["$1"]);
				console.log(fIEVersion);
				if(fIEVersion < 9){
					if(confirm("当前浏览器不兼容，建议使用chrome，是否前往下载")){
						window.location.href("http://www.baidu.com/");
					}
				}
			}
		}

		$(document).ready(function() {
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			});

			// 			$("#loginForm").validate({
			// 				rules: {
			// 					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
			// 				},
			// 				messages: {
			// 					username: {required: "请填写用户名."},password: {required: "请填写密码."},
			// 					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
			// 				},
			// 				errorLabelContainer: "#messageBox",
			// 				errorPlacement: function(error, element) {
			// 					error.appendTo($("#loginError").parent());
			// 				} 
			// 			});
		});

		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if (self.frameElement && self.frameElement.tagName == "IFRAME"
				|| $('#left').length > 0 || $('.jbox').length > 0) {
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}

	</script>
</head>
<body class="hold-transition login-page " style="background:#39cccc !important">

<!-- 	<div class="header"> -->
<%-- 		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button> --%>
<%-- 			<label id="loginError" class="error">${message}</label> --%>
<%-- 			<sys:tip content="${message}"/> --%>
<!-- 		</div> -->
<!-- 	</div> -->
	
	<sys:tip content="${message}"/>
	
	<div class="login-box ">
		<div class="login-logo">
	    	<a href="#"><b>周范</b>供应商管理平台</a>
	    </div>
	    <div class="login-box-body">
		    <p class="login-box-msg">请输入登录信息</p>
		    <form id="loginForm" action="${gtx}/login" method="post">
		      <div class="form-group has-feedback">
		        <input type="text" id="username" name="username" class="form-control" placeholder="用户名">
		        <span class="glyphicon glyphicon-user form-control-feedback"></span>
		      </div>
		      <div class="form-group has-feedback">
		        <input type="password" id="password" name="password" class="form-control" placeholder="密码">
		        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
		      </div>
		      <div class="row">
		        <div class="col-xs-8">
		          <div class="checkbox icheck">
		            <label title="下次不需要再登录">
		                <input type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}> 记住我（公共场所慎用）
		            </label>
		          </div>
		        </div>
		        <div class="col-xs-4">
		          <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
		        </div>
		      </div>
		    </form>
	  	</div>
	</div>
	
	
	
	<footer class="main-footer" style="background: #39cccc !important;margin-left: 0px;border-top:0;">
		<div style="text-align: center">
			<strong>Copyright &copy; 2016-2017 <a href="#this">杭州周范科技有限公司</a>.</strong> All rights reserved.<b>Version</b> 1.2.0
		</div>
	</footer>
	
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	
</body>
</html>