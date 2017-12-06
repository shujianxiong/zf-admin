<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>周范后台管理系统</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet"
	href="${ctxStatic }/adminLte/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${ctxStatic }/adminLte/dist/font-awesome-4.4.0/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="${ctxStatic }/adminLte/dist/ionicons-2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${ctxStatic }/adminLte/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="${ctxStatic }/adminLte/dist/css/skins/_all-skins.min.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
<!-- toastr 页面提示消息-->
<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/toastr/css/toastr.min.css">

<link rel="stylesheet" href="${ctxStatic }/adminLte/plugins/zfFrame/zf.css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
<script type="text/javascript">
	  var menuList = ${supplierMenuListJson};
	  console.log(menuList);
	  var ctx="${gtx}";
	  function showMainMenu(key){
		  var menuUl=$("#mainMenu");
		  menuUl.append("<li class='treeview'><a href='#' onclick=\"addTab('-1','首页','/sys/dashboard')\"><span>首页</span></a></li>");
		  for(var i=0;i<menuList.length;i++){
			  if(menuList[i].parentId=='1'&&menuList[i].isShow=='1'){
				  if(key!=""&&menuList[i].name.indexOf(key) == -1)
					  continue;
				  var html="";
				  html+="<li class='treeview'>";
	    		  html+="<a href='#this'><i class='fa fa-folder-o'></i><span>"+menuList[i].name+"</span><i class='fa fa-angle-left pull-right'></i></a>";
	   			  html+="<ul class='treeview-menu'>";
	   			  html+=showMenu(menuList[i].id,"");
	   			  html+="</ul>";
	    		  html+="</li>";
	    		  menuUl.append(html);
			  }
		  }
	  }
	  
	//加载二级以下菜单
    function showMenu(pId,key){
    	var html="";
    	for(var i=0;i<menuList.length;i++){
    		if(menuList[i].parentId==pId&&menuList[i].isShow=='1'){
    			if(key!=""&&menuList[i].name.indexOf(key)  == -1)
  				  continue;
    			if(isParent(menuList[i].id)){
    				html+="<li>";
    				html+="<a href='#this'><i class='fa fa-folder-o'></i><span>"+menuList[i].name+"</span><i class='fa fa-angle-left pull-right'></i></a>";
    				html+="<ul class='treeview-menu'>";
    				html+=showMenu(menuList[i].id,key);
    				html+="</ul>";
    			}else{
    				var str = menuList[i].href+"?sysUserId=${user.id}";
    				html+="<li><a href='#this' onclick=\"addTab('"+menuList[i].id+"','"+menuList[i].name+"','"+str+"')\"><i class='fa fa-link'></i>"+menuList[i].name+"</a>";
    			}
    			html+="</li>";
    		}
    	}
    	return html;
    }
	  
	  //判断是否为顶级
	  function isParent(pId){
	  	for(var i=0;i<menuList.length;i++){
	  		if(menuList[i].parentId==pId&&menuList[i].isShow=='1'){
	  			return true;
	  		}
	  	}
	  	return false;
	  }
	  
	  function searchMenu(obj){
		  var menuUl=$("#mainMenu");
		  var key=$(obj).val();
		  menuUl.html("");
		  showMainMenu(key);
	  }
	  
	  function addTab(menuId,menuName,href){
		  var neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight();
	      var window_height = document.body.scrollHeight;
	      console.log(document.body.scrollHeight)
		  var minHeight=window_height-neg;
		  var tabHeader=$("#tabHeader");
		  var a=null;
		  $("a[data-toggle='tab']",tabHeader).each(function(){
			  if ($(this).text()==menuName){
				  a=$(this);
				  return  
			  }
		  });
		  if(a!=null){
			  a.tab('show');
			  return;
		  }
		  var li=$("<li></li>")
		  a=$("<a id='navTab"+menuId+"' href='#"+menuId+"' data-toggle='tab'><span data-toggle='tooltip' data-placement='top' data-original-title='双击关闭'>"+menuName+"</span></a>");
		  li.append(a);
		  tabHeader.append(li);
		  var tabContent=$("#tabContent");
		  tabContent.append("<div class='tab-pane' id='"+menuId+"' style='min-height:"+minHeight+"px'><iframe src='${ctx}"+href+"' frameborder='0' width='100%' height='"+minHeight+"px' scrolling='auto' ></iframe></div>")
	  	  a.tab('show');
		  a.dblclick(function(){
			  $("#navTab"+menuId).remove()
			  $("#"+menuId).remove()
			  var aArray=$("a[data-toggle='tab']",tabHeader);
			  if(aArray.length>0){
				  console.log(aArray[aArray.length-1])
				  $(aArray[aArray.length-1]).tab("show");
			  }
		  })
	  }
	  
  </script>
</head>
<body class="sidebar-mini skin-purple-light">
	<div class="wrapper">

		<header class="main-header">
			<!-- Logo -->
			<a href="index2.html" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"><b>周</b>范</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg"><b>周范</b>管理后台</span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top" role="navigation">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>

				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Notifications: style can be found in dropdown.less -->
						<li class="notifications-menu">
							<a id="goldPricA" href="#" class="dropdown-toggle" data-toggle="tooltip" data-placement="bottom" data-original-title="每20分钟更新一次">
								当前金价：
								<i class="fa fa-rmb"></i><span id="goldPrice" >读取中..</span><span>/g</span>
							</a>
						</li>
						<li class="dropdown notifications-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-bell-o"></i> <span id="messageLabel" class="label label-warning">0</span>
						</a>
							<ul class="dropdown-menu">
								<li id="messageListTitle" class="header">您暂时没有收到任何系统内消息！</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul id="messageList" class="menu">
										
									</ul>
								</li>
								<li class="footer"><a href="#" onclick="addTab(28,'我的消息','/msg/um/myUmMessage/list')">查看所有</a></li>
							</ul></li>
						<!-- Tasks: style can be found in dropdown.less -->
						<li class="dropdown tasks-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-flag-o"></i> <span class="label label-danger">9</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 9 tasks</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Design some buttons <small class="pull-right">20%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-aqua"
														style="width: 20%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">20% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Create a nice theme <small class="pull-right">40%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-green"
														style="width: 40%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">40% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Some task I need to do <small class="pull-right">60%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-red"
														style="width: 60%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">60% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Make beautiful transitions <small class="pull-right">80%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-yellow"
														style="width: 80%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">80% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
									</ul>
								</li>
								<li class="footer"><a href="#">View all tasks</a></li>
							</ul></li>
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img 
								src="${user.photo}" class="user-image" alt="User Image">
								<span class="hidden-xs">${user.name}</span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img src="${user.photo}"
									class="img-circle" alt="User Image">

									<p>
										${user.loginName} <small><fmt:formatDate
												value="${user.oldLoginDate}" type="both"
												dateStyle="full" /></small>
									</p></li>
								<!-- Menu Body -->
								<li class="user-body">
									<div class="row">
										<div class="col-xs-4 text-center">
											<a href="#">&nbsp;</a>
										</div>
										<div class="col-xs-4 text-center">
											<a href="#">角色</a>
										</div>
										<div class="col-xs-4 text-center">
											<a href="#">&nbsp;</a>
										</div>
									</div> <!-- /.row -->
								</li>
								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-left">
										<a href="#" class="btn btn-default btn-flat" data-toggle="modal" data-target="#myModal">个人详情</a>
									</div>
									<div class="pull-right">
										<a href="${gtx}/loginOut" class="btn btn-default btn-flat">登出</a>
									</div>
								</li>
							</ul></li>
						<!-- Control Sidebar Toggle Button -->
						<li><a href="#" data-toggle="control-sidebar"><i
								class="fa fa-gears"></i></a></li>
					</ul>
				</div>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="${user.photo}" class="img-circle"
							alt="User Image">
					</div>
					<div class="pull-left info">
						<p>${user.name}</p>
						<a href="#"><i class="fa fa-circle text-success"></i> 当前在线</a>
					</div>
				</div>
				<!-- search form -->
				<div class="sidebar-form">
					<div class="input-group">
						<input type="text" id="searchMenuKey" name="q"
							class="form-control" placeholder="搜索目录..."
							onchange="searchMenu(this)"> <span
							class="input-group-btn">
							<button type="submit" name="search" id="search-btn"
								class="btn btn-flat">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</div>
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul id="mainMenu" class="sidebar-menu">

					<!-- 目录 -->

				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- 内容区 -->
		<div class="content-wrapper">
			<section class="content">
				<div class="nav-tabs-custom">
					<ul id="tabHeader" class="nav nav-tabs">

					</ul>
					<div id="tabContent" class="tab-content"></div>
				</div>
			</section>
		</div>
		<!-- /.content-wrapper -->
		<footer class="main-footer">
			<div class="pull-right hidden-xs">
				<b>Version</b> 1.2.0
			</div>
			<strong>Copyright &copy; 2016-2017 <a href="#this">杭州周范科技有限公司</a>.
			</strong> All rights reserved.
		</footer>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li><a href="#control-sidebar-home-tab" data-toggle="tab"><i
						class="fa fa-home"></i></a></li>
				<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
						class="fa fa-gears"></i></a></li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li><a href="javascript::;"> <i
								class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
						</a></li>
						<li><a href="javascript::;"> <i
								class="menu-icon fa fa-user bg-yellow"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Frodo Updated His
										Profile</h4>

									<p>New phone +1(800)555-1234</p>
								</div>
						</a></li>
						<li><a href="javascript::;"> <i
								class="menu-icon fa fa-envelope-o bg-light-blue"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Nora Joined Mailing
										List</h4>

									<p>nora@example.com</p>
								</div>
						</a></li>
						<li><a href="javascript::;"> <i
								class="menu-icon fa fa-file-code-o bg-green"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Cron Job 254
										Executed</h4>

									<p>Execution time 5 seconds</p>
								</div>
						</a></li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li><a href="javascript::;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design <span
										class="label label-danger pull-right">70%</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger"
										style="width: 70%"></div>
								</div>
						</a></li>
						<li><a href="javascript::;">
								<h4 class="control-sidebar-subheading">
									Update Resume <span class="label label-success pull-right">95%</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-success"
										style="width: 95%"></div>
								</div>
						</a></li>
						<li><a href="javascript::;">
								<h4 class="control-sidebar-subheading">
									Laravel Integration <span
										class="label label-warning pull-right">50%</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-warning"
										style="width: 50%"></div>
								</div>
						</a></li>
						<li><a href="javascript::;">
								<h4 class="control-sidebar-subheading">
									Back End Framework <span class="label label-primary pull-right">68%</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-primary"
										style="width: 68%"></div>
								</div>
						</a></li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab
					Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Report panel
								usage <input type="checkbox" class="pull-right" checked>
							</label>

							<p>Some information about this general settings option</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Allow mail
								redirect <input type="checkbox" class="pull-right" checked>
							</label>

							<p>Other sets of options are available</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Expose author
								name in posts <input type="checkbox" class="pull-right" checked>
							</label>

							<p>Allow the user to show his name in blog posts</p>
						</div>
						<!-- /.form-group -->

						<h3 class="control-sidebar-heading">Chat Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Show me as
								online <input type="checkbox" class="pull-right" checked>
							</label>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Turn off
								notifications <input type="checkbox" class="pull-right">
							</label>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Delete chat
								history <a href="javascript::;" class="text-red pull-right"><i
									class="fa fa-trash-o"></i></a>
							</label>
						</div>
						<!-- /.form-group -->
					</form>
				</div>
				<!-- /.tab-pane -->
			</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->
	<!-- jQuery 2.1.4 -->
	<script src="${ctxStatic }/adminLte/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="${ctxStatic }/adminLte/plugins/jQueryUI/jquery-ui.min.js"></script>
	<!-- Bootstrap 3.3.5 -->
	<script src="${ctxStatic }/adminLte/bootstrap/js/bootstrap.min.js"></script>
	<!-- Sparkline -->
	<script src="${ctxStatic }/adminLte/plugins/sparkline/jquery.sparkline.min.js"></script>
	<!-- datepicker -->
	<script src="${ctxStatic }/adminLte/plugins/datepicker/bootstrap-datepicker.js"></script>
	<!-- toastr 2.1.2 -->
	<script src="${ctxStatic }/adminLte/plugins/toastr/js/toastr.min.js"></script>
	<!-- Bootstrap WYSIHTML5 -->
	<script src="${ctxStatic }/adminLte/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
	<script src="${ctxStatic }/adminLte/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<script src="${ctxStatic }/adminLte/plugins/zfFrame/zf.js"></script>
	<!-- AdminLTE App -->
	<script src="${ctxStatic }/adminLte/dist/js/app.js"></script>
	<script src="${ctxStatic }/adminLte/dist/js/demo.js"></script>
	<script>
		//获取黄金价格
		function getGoldPrice(){
			ZF.ajaxQuery(false,"${ctx}/bas/gold/basGoldPriceGather/doList",null,function(data){
				$("#goldPricA").attr("data-original-title","20分钟更新一次,更新时间："+ZF.curentTime())
				if(data!=null){
					$("#goldPrice").text(data.price)
				}
			})
		}
	
		$(function(){
			showMainMenu("");
			
			addTab('-1','首页','/sys/dashboard')
			
			//获取个人未读消息,每20秒检查一次
			getGoldPrice();
			ZF.getMyMessage();
		  	setInterval(function(){
		  		ZF.getMyMessage();
		  	},20000);
		})
	</script>
	
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">个人信息详情</h4>
				</div>
				<div class="modal-body">
					<div class="box-body box-profile">
						<ul class="list-group list-group-unbordered">
							<li class="list-group-item" style="height:210px;"><b>头像</b>
								<div class="pull-right">
									<img src=${user.photo } width="200" height="200" class="text-align:right;"/>
								</div>
							</li>
							<li class="list-group-item"><b>姓名</b> <a class="pull-right">${user.name}</a>
							</li>
							<li class="list-group-item"><b>帐号</b> <a class="pull-right">${user.loginName}</a>
							</li>
							<li class="list-group-item"><b>工号</b> <a class="pull-right">${user.no}</a>
							</li>
							<li class="list-group-item"><b>上次登录IP</b> <a
								class="pull-right">${user.oldLoginIp}</a></li>
							<li class="list-group-item"><b>上次登录时间</b> <a
								class="pull-right"><fmt:formatDate
										value="${user.oldLoginDate}" type="both"
										dateStyle="full" /></a></li>
							<li class="list-group-item"><b>用户类型</b> <a
								class="pull-right">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</a>
							</li>
							<li class="list-group-item"><b>角色</b> <a class="pull-right"
								id="roleRow">${user.roleNames}</a></li>
						</ul>
					</div>
				</div>
				<!-- <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary">提交更改</button>
				</div> -->
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	
</body>
</html>
