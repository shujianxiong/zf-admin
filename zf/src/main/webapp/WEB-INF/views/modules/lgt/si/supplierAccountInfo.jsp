<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>供应商周范账号信息</title>
<meta name="decorator" content="adminLte" />

</head>
<body>
	<div class="content-wrapper sub-content-wrapper">

		<section class="content">
			<div class="row">
				<div class="col-md-4">
					<div class="box box-primary">
						<div class="box-body box-profile">
							<img class="profile-user-img img-responsive img-circle" src="${imgHost }${user.photo}" alt="User profile picture">
                            <h3 class="profile-username text-center">${user.name}</h3>
                            <p class="text-muted text-center">
                                <c:forEach items="${user.roleList }" var="role">
                                    |${role.name }|
                                </c:forEach>
                            </p>
                            <ul class="list-group list-group-unbordered">
								<li class="list-group-item">
	                              <b>帐号</b> <a class="pull-right">${user.loginName}</a>
	                            </li>
	                            <li class="list-group-item">
	                              <b>工号</b> <a class="pull-right">${user.no}</a>
	                            </li>
	                            <li class="list-group-item">
	                              <b>邮箱</b> <a class="pull-right">${user.email}</a>
	                            </li>
	                            <li class="list-group-item">
	                              <b>电话</b> <a class="pull-right">${user.phone}</a>
	                            </li>
	                            <li class="list-group-item">
	                              <b>手机</b> <a class="pull-right">${user.mobile}</a>
	                            </li>
	                            <li class="list-group-item">
	                              <b>用户类型</b>
	                              <a class="pull-right">
	                                 <span class="label label-primary">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</span>
	                              </a>
	                            </li>
	                            <li class="list-group-item">
	                              <b>上次登录IP</b> <a class="pull-right">${user.oldLoginIp}</a>
	                            </li>
	                            <li class="list-group-item">
	                              <b>上次登录时间</b> <a class="pull-right"><fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full"/></a>
	                            </li>
	                            <li class="list-group-item">
	                                <b>备注</b><a class="pull-right">${user.remarks}</a>
	                            </li>
	                        </ul>
						</div>
						<div class="box-footer">
							<button type="button" class="btn btn-default btn-sm"
								onclick="javascript:history.go(-1)">
								<i class="fa fa-mail-reply"></i>返回
							</button>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
</html>