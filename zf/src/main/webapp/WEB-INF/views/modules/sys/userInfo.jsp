<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人信息详情</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
 	<div class="content-wrapper sub-content-wrapper">
	    <!-- Content Header (Page header) -->
	    <section class="content-header">
	      <h1>
				<small id="ismall" class="menu-active"><i id="infoI" class="fa fa-repeat"></i><a  href="javascript:void(0);" onclick="showContent(1);">个人信息详情</a></small>
				<small>|</small>
	        	<small id="esmall"><i id="editI" class="fa-form-edit"></i><a href="javascript:void(0);" onclick="showContent(2);">个人信息维护</a></small>
	      </h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
        
	    <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
	    <section class="content">
	    	<div id="showUser" class="row">
	    		<div class="col-md-4">
	    			<div class="box box-primary">
	    				<div class="box-body box-profile">
	    					<img  onerror="imgOnerror(this);" class="profile-user-img img-responsive img-circle" src="${imgHost }${fns:getUser().photo}" alt="User profile picture">
	    					<h3 class="profile-username text-center">${fns:getUser().name}</h3>
			              	<p class="text-muted text-center">
			              		<c:forEach items="${fns:getUser().roleList }" var="role">
									|${role.name }|
								</c:forEach>
			              	</p>
			              	<ul class="list-group list-group-unbordered">
				                <li class="list-group-item">
				                  <b>帐号</b> <a class="pull-right">${fns:getUser().loginName}</a>
				                </li>
				                <li class="list-group-item">
				                  <b>工号</b> <a class="pull-right">${fns:getUser().no}</a>
				                </li>
				                <li class="list-group-item">
				                  <b>邮箱</b> <a class="pull-right">${fns:getUser().email}</a>
				                </li>
				                <li class="list-group-item">
				                  <b>电话</b> <a class="pull-right">${fns:getUser().phone}</a>
				                </li>
				                <li class="list-group-item">
				                  <b>手机</b> <a class="pull-right">${fns:getUser().mobile}</a>
				                </li>
				                <li class="list-group-item">
				                  <b>上次登录IP</b> <a class="pull-right">${fns:getUser().oldLoginIp}</a>
				                </li>
				                <li class="list-group-item">
				                  <b>上次登录时间</b> <a class="pull-right"><fmt:formatDate value="${fns:getUser().oldLoginDate}" type="both" dateStyle="full"/></a>
				                </li>
				                <li class="list-group-item">
				                  <b>用户类型</b> <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</span></a>
				                </li>
				                <li class="list-group-item">
				                	<b>备注</b><a class="pull-right">${fns:getUser().remarks}</a>
				                </li>
			              	</ul>
	    				</div>
	    			</div>
	    		</div>
	    	</div>
            
	        <div class="col-md-6" id="editUser" style="display: none;">
		            <div class="box box-success">
			            
			            <!-- /.box-header -->
		            	<form:hidden path="name" />
		            	<div class="box-body">
		            		<div class="form-group">
			                  <label for="inputPassword3" class="col-sm-2 control-label">头像</label>
			
			                  <div class="col-sm-10">
								<form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                <sys:fileUpload input="photo" model="false" selectMultiple="false" fileDirCode="profilePhoto"></sys:fileUpload>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="inputPassword3" class="col-sm-2 control-label">邮箱</label>
			
			                  <div class="col-sm-10">
			                    <sys:inputverify name="email" tip="请输入邮箱，必填项" verifyType="3" id="emailInput"  isSpring="true"></sys:inputverify>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="inputPassword3" class="col-sm-2 control-label">电话号码</label>
			                  <div class="col-sm-10">
			                    <sys:inputverify id="phoneInput" name="phone" tip="请输入电话，必填项" verifyType="7"   isSpring="true"></sys:inputverify>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="inputPassword3" class="col-sm-2 control-label">手机号码</label>
			                  <div class="col-sm-10">
			                    <sys:inputverify id="mobileInput" name="mobile" tip="请输入手机，必填项" verifyType="1"   isSpring="true"></sys:inputverify>
			                  </div>
			                </div>
			                <div class="form-group">
			                  <label for="inputPassword3" class="col-sm-2 control-label">备注信息</label>
			
			                  <div class="col-sm-10">
			                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
			                  </div>
			                </div>
		            	</div>
		            	<div class="box-footer">
			               <button type="submit" class="btn btn-info pull-right"><i class="fa fa-save">保存</i></button>
			            </div>
		            </div>
	            </div>
	        </section>
	    </form:form>
	 </div>
	 <script type="text/javascript">
	 	$(function(){
// 			var roleStr=$("#roleRow").text();
// 			var roles=roleStr.split(",");
// 			$("#roleRow").html("");
// 			var html="";
// 			for(var i=0;i<roles.length;i++){
// 				html+="<span class='label label-primary'>"+roles[i]+"</span>"
// 			}
// 			$("#roleRow").html(html);
		})
		
		function showContent(type) {
	 		if(type == 1) {//详情界面
	 			$("#showUser").show();
	 			$("#editUser").hide();
	 			$("#esmall").removeClass("menu-active");
	 			$("#ismall").addClass("menu-active");
	 			
	 			$("#infoI").addClass("fa fa-repeat");
	 			$("#infoI").removeClass("fa-user-info");
	 			
	 			$("#editI").removeClass("fa fa-repeat");
                $("#editI").addClass("fa-form-edit");
	 			
	 		} else if(type == 2) {//维护界面
	 			
	 			$("#editUser").show();
                $("#showUser").hide();
	 			
	 			$("#editI").removeClass("fa-form-edit");
                $("#editI").addClass("fa fa-repeat");
                
                $("#infoI").removeClass("fa fa-repeat");
                $("#infoI").addClass("fa-user-info");
                
                
	 			$("#esmall").addClass("menu-active");
	 			$("#ismall").removeClass("menu-active");
	 			
	 			
	 			
                
	 		}
	 	}
	 </script>
</body>
</html>