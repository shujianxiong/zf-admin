<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>视频管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {

            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
	    <section class="content-header content-header-menu">
			<h1>
				<small><i class="fa fa-repeat"></i><a
					href="${ctx}/bas/video/">视频列表</a></small>
				<shiro:hasPermission name="bas:video:edit">
					<small>|</small>
					<small class="menu-active"><i class="fa fa-repeat"></i><a
						href="${ctx}/bas/video/form?id=${video.id}">视频${not empty video.id?'修改':'上传'}</a></small>
				</shiro:hasPermission>
			</h1>
		</section>
    	<sys:tip content="${message}"/>
	    <section class="content">
	        <div class="row">
	            <div class="col-md-6">
	                <form:form id="inputForm" modelAttribute="video" action="${ctx}/bas/video/save" method="post" enctype="multipart/form-data" class="form-horizontal" onsubmit="return ZF.formSubmit();">
	                    <div class="box box-success">
	                        <div class="box-header with-border zf-query">
	                            <h5>请完善表单填写</h5>
	                            <div class="box-tools">
	                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	                            </div>
	                        </div>
	                        <div class="box-body">
	                            <form:hidden path="id" />
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">视频类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="type" tip="请选择业务类型" verifyType="0"  dictName="bas_video_type" id="type" isMandatory="false"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                	<label class="col-sm-2 control-label" for="exampleInputFile">视频文件</label>
                                	<div class="col-sm-9">
										<c:choose>
											<c:when test="${video.fileUrl eq null }">
											<input type="file" name="file" id="exampleInputFile">
											</c:when>
											<c:otherwise>
												<video width="320" height="240" controls="controls" style="object-fit:fill;">
													<source src="http://img.chinazhoufan.com/${video.fileUrl }" type="video/mp4">
												</video>
												<input type="file" name="file" id="exampleInputFile">
											</c:otherwise>
										</c:choose>
                                	</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">视频标签</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify name="tag" id="tag" verifyType="99" isMandatory="false" tip="请输入标签" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">备注信息</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
	                            
	                        </div>
	                        <div class="box-footer">
	                            <div class="pull-left box-tools">
	                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	                            </div>
	                            <div class="pull-right box-tools">
	                                <c:if test="${not empty video.id}">
	                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
	                                </c:if>
	                                <shiro:hasPermission name="bas:video:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
	                            </div>
	                        </div>
	                    </div>
	                </form:form>
	            </div>
	        </div>
	    </section>
    </div>
    
</body>
</html>