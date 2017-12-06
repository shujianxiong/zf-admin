<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>修改密码</title>
    <meta name="decorator" content="adminLte"/>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="box-body box-profile">
                            <h5>${message }</h5>请重新<a href="${ctx }/loginOut">登录</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
     </div>
</body>
</html>