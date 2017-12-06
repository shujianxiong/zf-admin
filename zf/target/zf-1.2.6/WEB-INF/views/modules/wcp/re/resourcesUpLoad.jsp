<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图文素材上传</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
	</script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<section  class="content-header content-header-menu">
		<h1>
			<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/re/mp/resources">素材列表</a></small>
			<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/form">文件上传</a></small>
			<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/toAddMedia">图文素材新增</a></small>
			<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/toMesUp">图文消息内的图片上传</a></small>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form:form id="inputForm" modelAttribute="media" action="${ctx}/re/mp/resources/upload" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();" enctype="multipart/form-data">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
							<h5>请完善表单填写</h5>
							<div class="box-tools">
								<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
							</div>
						</div>
						<div class="box-body">
							<div class="form-group">
								<label class="col-sm-2 control-label">类型</label>
								<div class="col-sm-9">
									<form:select path="type" htmlEscape="false" maxlength="50" class="form-control select2">
										<form:options items="${fns:getDictList('media_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">上传文件（图片）</label>
								<div class="col-sm-9">
									<input type="file" id="inputFile" name="file" accept="audio/*,video/*,image/*" >
									<p class="help-block text-red">
										图片（image）: 2M，支持bmp/png/jpeg/jpg/gif格式<br>
										语音（voice）：2M，播放长度不超过60s，mp3/wma/wav/amr格式<br>
										视频（video）：10MB，支持MP4格式<br>
										缩略图（thumb）：64KB，支持JPG格式
									</p>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
								<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
							</div>
							<div class="pull-right box-tools">
								<shiro:hasPermission name="re:mp:resources:view"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</section>
</div>
<script type="text/javascript">
    $(function() {

    });
</script>
</body>
</html>