<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文件目录信息</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
 	<div class="content-wrapper sub-content-wrapper">
	    <sys:tip content="${message}"/>
	    <form:form id="inputForm" modelAttribute="fileDir" action="${ctx}/bas/fileDir/info" method="post" class="form-horizontal">
	    <section class="content">
            <div class="row">
            	<div class="col-md-6">
		            <div class="box box-primary">
			            <div class="box-header with-border">
			              <h5>文件目录信息</h5>
			              <div class="box-tools">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			              </div>
			            </div>
			            <!-- /.box-header -->
		            	<div class="box-body">
							
							<strong>上级目录</strong>
							<p class="text-primary">${fileDir.parent.name}</p>
							<hr class="zf-hr">
						
							<strong>目录名称</strong>
							<p class="text-primary">${fileDir.name}</p>
							<hr class="zf-hr">
							
							<strong>目录排序</strong>
							<p class="text-primary">${fileDir.orderNo}</p>
							<hr class="zf-hr">
							
							<strong>备注</strong>
							<p class="text-primary">${fileDir.remarks }</p>
							<hr class="zf-hr">
								
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
	    </form:form>
	 </div>
</body>
</html>