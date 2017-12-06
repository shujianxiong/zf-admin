<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>批量导入模板信息</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
<section class="content-header content-header-menu">
		<h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/tf/transportFee/">运费模板列表</a></small>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form id="inputForm" action="${ctx }/lgt/po/purchaseProductExport/import"  enctype="multipart/form-data"  method="post" class="form-horizontal" onsubmit="return formSubmit();">
                    <form:hidden path="purchaseOrderId"/>
                    <form:hidden path="produceId"/>
                    <div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>批量导入模板信息</h5>
				            <div class="box-tools">
				               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
				            </div>
		    			</div>
						<div class="box-body">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">上传文件</label>
                                <div class="col-sm-9">
                                    <input type="file" id="inputFile" name="file" accept="application/vnd.ms-excel">
                                    <p class="help-block text-red">
                                                                                    文件只限Excel文本文件,后缀为.xlsx<br/>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">内容格式</label>
                                <div class="col-sm-9">
                                    <p class="help-block text-red">
                                        第一列：货品克重，第二列：货品采购价，第三列：货品证书编号，第四列：货品是否合格(1或0)，第五列：货品备注
                                    </p>
                                    <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                                       <!--  <thead>
                                            <tr>
                                                <th>第一列：国家</th>
                                                <th>第二列：省</th>
                                                <th>第三列：市</th>
                                                <th>第四列：区</th>
                                            </tr>
                                        </thead> -->
                                        <tbody>
                                            <tr>
                                                <td>2.3652</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>569.00</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td>ZS1012902</td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>1</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>货品采购导入</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
						</div>
						<div class="box-footer">
		    				<div class="pull-right box-tools">
				               	<button type="button" onclick="importFile('${purchaseOrderId}','${produceId}')" class="btn btn-info btn-sm"><i class="fa fa-save"></i>导入</button>
					        </div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
	</div>
	<script type="text/javascript">
        function importFile(purchaseOrderId,produceId) {
        var file = $("#inputFile").val();
        if(file == null || file == "") {
            ZF.showTip("请先上传模板Excel表!", "info");
            return false;
        }
        window.location.href="${ctx}/lgt/po/purchaseProductImport/importFile?purchaseOrderId="+purchaseOrderId+"&produceId="+produceId;
    }
	</script>
	
</body>
</html>