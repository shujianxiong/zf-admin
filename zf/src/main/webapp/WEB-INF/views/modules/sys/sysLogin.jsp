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
	  <style type="text/css">
	  	.body{
	  		overflow: hidden;
	  		padding-top:1px;
	  		height: 100%;
	  	}
	  </style>
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
				if(fIEVersion < 9){
					if(confirm("当前浏览器不兼容，建议使用chrome，是否前往下载")){
						window.location.href("http://rj.baidu.com/soft/detail/14744.html?ald");
					}
				}
			}
		}

		$(document).ready(function() {
			/* $('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				radioClass : 'iradio_minimal-blue'
			}); */

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
<body class="hold-transition login-page body">
<!-- 	<div class="header"> -->
<%-- 		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button> --%>
<%-- 			<label id="loginError" class="error">${message}</label> --%>
<%-- 			<sys:tip content="${message}"/> --%>
<!-- 		</div> -->
<!-- 	</div> -->
	
	<sys:tip content="${message}"/>
	
	
	<div id="loginPanel" class="login-box " style="position:fixed;opacity: 0;">
		<div class="login-logo" >
	    	<a href="#" style="color:#fff"><b>周范</b>后台管理系统</a>
	    </div>
	    <div class="login-box-body">
		    <p class="login-box-msg">请输入登录信息</p>
		    <form id="loginForm" action="${ctx}/login" method="post">
		      <div class="form-group has-feedback">
		        <input type="text" id="username" name="username" class="form-control" placeholder="用户名">
		        <span class="glyphicon glyphicon-user form-control-feedback"></span>
		      </div>
		      <div class="form-group has-feedback">
		        <input type="password" id="password" name="password" class="form-control" placeholder="密码">
		        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
		      </div>
	      	  <c:if test="${isValidateCodeLogin}"><div class="validateCode">
				<label class="input-label mid" for="validateCode">验证码</label>
				<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
			  </div></c:if>
		      <div class="row">
		        <div class="col-xs-8">
		        <!--    <div class="checkbox icheck"> -->
		        <!--     <label title="下次不需要再登录"> -->
		                <input type="checkbox" id="rememberMe" style="width: 20px;height: 20px;"  name="rememberMe" ${rememberMe ? 'checked' : ''}> 记住我（公共场所慎用）
		        <!--      </label>  -->
		        <!--    </div> -->
		        </div>
		        <div class="col-xs-4">
		          <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
		        </div>
		      </div>
		    </form>
	  	</div>
	</div>
	
	
	
	<footer class="main-footer" style="background: rgba(0,0,0,0);margin: 0px;position: absolute; width: 100%;bottom: 20px;border:none">
		<div style="text-align: center">
			<strong>Copyright &copy; 2016-2017 <a href="#this">杭州周范科技有限公司</a>.</strong> All rights reserved.<b>Version</b> 1.2.0
		</div>
	</footer>
	
	<script src="${ctxStatic }/adminLte/plugins/3dcloud/ThreeWebGL.js"></script>
	<script src="${ctxStatic }/adminLte/plugins/3dcloud/ThreeExtras.js"></script>
	<script src="${ctxStatic }/adminLte/plugins/3dcloud/Detector.js"></script>
	<script id="vs" type="x-shader/x-vertex">


		varying vec2 vUv;
	
		void main() {
	
			vUv = uv;
			gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
	
		}
	</script>
	<script id="fs" type="x-shader/x-fragment">


		uniform sampler2D map;
	
		uniform vec3 fogColor;
		uniform float fogNear;
		uniform float fogFar;
	
		varying vec2 vUv;
	
		void main() {
	
			float depth = gl_FragCoord.z / gl_FragCoord.w;
			float fogFactor = smoothstep( fogNear, fogFar, depth );
	
			gl_FragColor = texture2D( map, vUv );
			gl_FragColor.w *= pow( gl_FragCoord.z, 20.0 );
			gl_FragColor = mix( gl_FragColor, vec4( fogColor, gl_FragColor.w ), fogFactor );
	
		}
	</script>
	
	<script type="text/javascript">
		$(function(){
			var width=$(window).width()/2-$("#loginPanel").width()/2;
			$("#loginPanel").css("left",width);
			$("#loginPanel").css("opacity",0.85);
		})

		if ( ! Detector.webgl ) Detector.addGetWebGLMessage();
	
		// Bg gradient
	
		var canvas = document.createElement( 'canvas' );
		canvas.width = 32;
		canvas.height = window.innerHeight;
	
		var context = canvas.getContext( '2d' );
	
		var gradient = context.createLinearGradient( 0, 0, 0, canvas.height );
		gradient.addColorStop(0, "#1e4877");
		gradient.addColorStop(0.5, "#4584b4");
	
		context.fillStyle = gradient;
		context.fillRect(0, 0, canvas.width, canvas.height);
	
		document.body.style.background = 'url(' + canvas.toDataURL('image/png') + ')';
	
		// Clouds
	
		var container;
		var camera, scene, renderer, sky, mesh, geometry, material,
		i, h, color, colors = [], sprite, size, x, y, z;
	
		var mouseX = 0, mouseY = 0;
		var start_time = new Date().getTime();
	
		var windowHalfX = window.innerWidth / 2;
		var windowHalfY = window.innerHeight / 2;
	
		init();
		animate();
	
		function init() {
			
			container = document.createElement( 'div' );
			document.body.appendChild( container );
	
			camera = new THREE.Camera( 30, window.innerWidth / window.innerHeight, 1, 3000 );
			camera.position.z = 6000;
	
			scene = new THREE.Scene();
	
			geometry = new THREE.Geometry();
	
			var texture = THREE.ImageUtils.loadTexture( '${ctxStatic }/adminLte/plugins/3dcloud/cloud10.png' );
			texture.magFilter = THREE.LinearMipMapLinearFilter;
			texture.minFilter = THREE.LinearMipMapLinearFilter;
	
			var fog = new THREE.Fog( 0x4584b4, - 100, 3000 );
	
			material = new THREE.MeshShaderMaterial( {
	
				uniforms: {
	
					"map": { type: "t", value:2, texture: texture },
					"fogColor" : { type: "c", value: fog.color },
					"fogNear" : { type: "f", value: fog.near },
					"fogFar" : { type: "f", value: fog.far },
	
				},
				vertexShader: document.getElementById( 'vs' ).textContent,
				fragmentShader: document.getElementById( 'fs' ).textContent,
				depthTest: false
	
			} );
	
			var plane = new THREE.Mesh( new THREE.Plane( 64, 64 ) );
	
			for ( i = 0; i < 8000; i++ ) {
	
				plane.position.x = Math.random() * 1000 - 500;
				plane.position.y = - Math.random() * Math.random() * 200 - 15;
				plane.position.z = i;
				plane.rotation.z = Math.random() * Math.PI;
				plane.scale.x = plane.scale.y = Math.random() * Math.random() * 1.5 + 0.5;
	
				GeometryUtils.merge( geometry, plane );
	
			}
	
			mesh = new THREE.Mesh( geometry, material );
			scene.addObject( mesh );
	
			mesh = new THREE.Mesh( geometry, material );
			mesh.position.z = - 8000;
			scene.addObject( mesh );
	
			renderer = new THREE.WebGLRenderer( { antialias: false } );
			renderer.setSize( window.innerWidth, window.innerHeight );
			container.appendChild( renderer.domElement );
	
			document.addEventListener( 'mousemove', onDocumentMouseMove, false );
			window.addEventListener( 'resize', onWindowResize, false );
	
		}
	
		function onDocumentMouseMove( event ) {
	
			mouseX = ( event.clientX - windowHalfX ) * 0.25;
			mouseY = ( event.clientY - windowHalfY ) * 0.15;
	
		}
	
		function onWindowResize( event ) {
	
			camera.aspect = window.innerWidth / window.innerHeight;
			camera.updateProjectionMatrix();
	
			renderer.setSize( window.innerWidth, window.innerHeight );
	
		}
	
		function animate() {
	
			requestAnimationFrame( animate );
			render();
	
		}
	
		function render() {
	
			position = ( ( new Date().getTime() - start_time ) * 0.03 ) % 8000;
	
			camera.position.x += ( mouseX - camera.target.position.x ) * 0.01;
			camera.position.y += ( - mouseY - camera.target.position.y ) * 0.01;
			camera.position.z = - position + 8000;
	
			camera.target.position.x = camera.position.x;
			camera.target.position.y = camera.position.y;
			camera.target.position.z = camera.position.z - 1000;
	
			renderer.render( scene, camera );
	
		}


	</script>
</body>
</html>