<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>400 - 请求出错</title>
    <meta name="decorator" content="adminLte"/>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="box-body box-profile">
                            <h1>参数有误,服务器无法解析.</h1>
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