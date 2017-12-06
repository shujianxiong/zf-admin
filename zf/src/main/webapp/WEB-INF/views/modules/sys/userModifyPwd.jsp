<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改密码</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	    <!-- Content Header (Page header) -->
	    <section class="content-header content-header-menu">
			<h1>
		        <small class="menu-active">
		        	<i class="fa fa-repeat"></i><a href="#this" onclick="javascript:history.go(0)">修改密码</a>
		        </small>
	      	</h1>
		</section>
	    <sys:tip content="${message}"/>
	    <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwdEdit" method="post" class="form-horizontal" onsubmit="return formSubmit();">
	    <form:hidden path="id"/>
	    <input type="hidden" name="token" value="${token }" />
	    <section class="content">
	    	<div class="col-md-6">
	            <div class="box box-success">
		            <div class="box-header with-border">
		              <h5>密码信息</h5>
		            </div>
		            <!-- /.box-header -->
	            	<div class="box-body">
		                <div class="form-group">
		                  <label for="oldPassword" class="col-sm-2 control-label">旧密码</label>
		                  <div class="col-sm-10">
		                     
		                    <sys:inputverify name="oldPassword" id="oldPassword" type="password" verifyType="99" maxlength="50" tip="请输入您当前的登录密码"></sys:inputverify> 
		                  
		                    <!-- <input id="oldPassword" name="oldPassword" type="password" value="" maxlength="50" minlength="3" class="form-control" placeholder="请输入您当前的登录密码"/> -->
		                  </div>
		                </div>
		                <div class="form-group">
		                  <label for="newPassword" class="col-sm-2 control-label">新密码</label>
		                  <div class="col-sm-10">
		                     
		                     <sys:inputverify name="newPassword" id="newPassword" type="password" maxlength="50" verifyType="0" tip="请输入新密码"></sys:inputverify>
		                  
		                  	<!-- <input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="form-control" placeholder="请输入新密码"/> -->
		                  </div>
		                </div>
		                <div class="form-group">
		                  <label for="inputPassword3" class="col-sm-2 control-label">确认新密码</label>
		                  <div class="col-sm-10">
		                    
		                    <sys:inputverify name="confirmNewPassword" id="confirmNewPassword" type="password" maxlength="50" verifyType="0" tip="请输入确认密码, 必须和新密码保持一致"></sys:inputverify>  
		                      
		                  	<!-- <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="form-control" placeholder="请输入确认密码, 必须和新密码保持一致" required="required"/> -->
		                  </div>
		                </div>
	            	</div>
	            	<div class="box-footer">
		                <button type="submit" class="btn btn-info pull-right"><i class="fa fa-save"></i>保存</button>
		            </div>
	            </div>
            </div>
	    </section>
   </form:form>
   <script type="text/javascript">
    	$(function(){
    		setTimeout(function(){
                $("#oldPassword").focus();
            },1500);
    		
    		$("#confirmNewPassword").on("change", function() {
    			var np = $("#newPassword").val();
                if(np == null || np == "" || np == undefined) {
                    ZF.showTip("请输入新密码!", "info");
                    return false;
                }
                var cp = $(this).val();
                if(cp != np) {
                	ZF.showTip("新密码与确认密码不一致，请重输!", "info");
                	$("button[type=submit]").attr('disabled',true);
                    return false;
                }
                $("button[type=submit]").attr('disabled',false);
    		});
    	});
    	
    	function formSubmit() {
    		var flag = ZF.formSubmit();
    		if(flag) {
    			var np = $("#newPassword").val();
                if(np == null || np == "" || np == undefined) {
                    ZF.showTip("请输入新密码!", "info");
                    return false;
                }
                var cp = $("#confirmNewPassword").val();
                if(cp != np) {
                    ZF.showTip("新密码与确认密码不一致，请重输!", "info");
                    $("button[type=submit]").attr('disabled',true);
                    return false;
                }
    		}
    		return flag;
    	}
	</script>
</div>
</body>
</html>