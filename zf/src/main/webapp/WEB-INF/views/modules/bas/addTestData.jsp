<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>测试数据管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</head>
<body>

	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bas/addTestData/page">测试数据管理</a></small>
			</h1>
		</section>
		<section class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>添加测试数据</h5>
				</div>
				<div class="box-footer">
					<div class="pull-left box-tools">
	               		<button type="button" class="btn btn-info btn-sm"
	               			onclick="doExe('${ctx}/bas/addTestData/addScanCodeProduct')"
	               			><i class="fa fa-plus"></i>新增货品电子码</button>
	               			说明：新增200个货品电子码（货品电子码从100001开始）。如果已有货品电子码，则在最后一个的基础上新增200个。
		        	</div>
				</div>
				<div class="box-footer">
					<div class="pull-left box-tools">
	               		<button type="button" class="btn btn-info btn-sm"
	               			onclick="doExe('${ctx}/bas/addTestData/addScanCodeWareplace')"
	               			><i class="fa fa-plus"></i>新增货位电子码</button>
	               			说明：新增200个货位电子码（货位电子码从200001开始）。如果已有货位电子码，则在最后一个的基础上新增200个。
		        	</div>
				</div>
				<div class="box-footer">
					<div class="pull-left box-tools">
	               		<button type="button" class="btn btn-info btn-sm"
	               			onclick="doExe('${ctx}/bas/addTestData/addProduct')"
	               			><i class="fa fa-plus"></i>添加货品</button>
	               			说明：查询所有产品（不含新建）、空货位及所有货位，为所有产品新增1-10个随机货品，先存到空货位上，空货位不足则随机存放到所有货位，并更新产品对应库存（注：新增的货品无电子码）
		        	</div>
				</div>
				<div class="box-footer">
					<div class="pull-left box-tools">
	               		<button type="button" class="btn btn-info btn-sm"
	               			onclick="doExe('${ctx}/bas/addTestData/resetProductScanCode')"
	               			><i class="fa fa-plus"></i>重置货品电子码</button>
	               			说明：清空所有货品的电子码，并依次为所有货品设置电子码，电子码不足则结束
		        	</div>
				</div>
				<div class="box-footer">
					<div class="pull-left box-tools">
	               		<button type="button" class="btn btn-info btn-sm"
	               			onclick="doExe('${ctx}/bas/addTestData/resetWareplaceScanCode')"
	               			><i class="fa fa-plus"></i>重置货位电子码</button>
	               			说明：清空所有货位的电子码，并依次为所有货位设置电子码，电子码不足则结束
		        	</div>
				</div>
			</div>
		</section>
		<sys:tip content="${message}"/>
	</div>
	<script type="text/javascript">
		var exeFlag = true;
		function doExe(url){
			if(exeFlag){
				window.location.href=url;
				exeFlag = false;
			}else {
				alert("执行中，请稍等......");
			}
		}
	</script>
</body>
</html>