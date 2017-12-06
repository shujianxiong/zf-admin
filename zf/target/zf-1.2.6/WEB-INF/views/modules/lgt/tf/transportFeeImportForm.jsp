<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
<section class="content-header content-header-menu">
		<h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/tf/transportFee/">运费模板列表</a></small>
            <shiro:hasPermission name="lgt:tf:transportFee:edit">
                <small>|</small>
                <small>
                    <i class="fa-form-edit"></i><a href="${ctx}/lgt/tf/transportFee/form">运费模板添加</a>
                </small>
            </shiro:hasPermission>
            <shiro:hasPermission name="lgt:tf:transportFee:edit">
                <small>|</small>
                <small>
                    <i class="glyphicon glyphicon-import"></i>
                    <a href="${ctx }/lgt/tf/transportFee/importForm">运费模板批量导入</a>
                </small>
            </shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form id="inputForm" action="${ctx }/lgt/tf/transportFee/import"  enctype="multipart/form-data"  method="post" class="form-horizontal" onsubmit="return formSubmit();">
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
                                                                                    第一列：仓库，第二列：快递公司价格，第三列：运费，第四列：寄送耗时，第五列：启用状态(1或0),第六列：省，第七列：市，第八把列：区（6-8列表示收货地址）
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
                                                <td>HY</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>15.00</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td>12.00</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>11</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>1</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>北京市</td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>市辖区</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>朝阳区</td>
                                            </tr>
                                            <tr>
                                                <td>HY</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
						</div>
						<div class="box-footer">
							<div class="pull-left box-tools">
					        	<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        </div>
		    				<div class="pull-right box-tools">
				               	<shiro:hasPermission name="lgt:tf:transportFee:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        </div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
	</div>
	<script type="text/javascript">
	function formSubmit() {
        var file = $("#inputFile").val();
        if(file == null || file == "") {
            ZF.showTip("请先上传运费模板Excel表!", "info");
            return false;
        }
        return true;
    }
	</script>
	
</body>
</html>