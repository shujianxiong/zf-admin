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
			<small><i class="fa-area"></i><a href="${ctx}/sys/area/listByType?isDistrict=1">区域列表</a></small>
			
			<shiro:hasPermission name="sys:area:edit">
               <small>|</small>
               <small>
                   <i class="glyphicon glyphicon-edit"></i>
                   <a href="${ctx}/sys/area/form?id=${area.id}">区域${not empty area.id?'修改':'添加'}</a>
               </small>
            </shiro:hasPermission>
			<shiro:hasPermission name="sys:area:import">
               <small>|</small>
               <small class="menu-active">
                   <i class="fa fa-repeat"></i>
                   <a href="${ctx }/sys/area/importForm">区域批量导入</a>
               </small>
            </shiro:hasPermission>
		</h1>
	</section>
	<sys:tip content="${message}"/>
	<section class="content">
		<div class="row">
			<div class="col-md-6">
				<form id="inputForm" action="${ctx }/sys/area/import"  enctype="multipart/form-data"  method="post" class="form-horizontal" onsubmit="return formSubmit();">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
		    				<h5>批量导入区域信息</h5>
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
                                                                                    第一列：国家，第二列：省，第三列：市，第四列：区，目前不包括港澳台，仅限国内省市区数据
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
                                                <td>100000=中国</td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>110000=北京市</td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td>110100=市辖区</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>110101=东城区</td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>110105=朝阳区</td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>120000=天津市</td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td>120100=市辖区</td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>120106=红桥区</td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td>120113=北辰区</td>
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
				               	<shiro:hasPermission name="sys:area:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
            ZF.showTip("请先上传区域Excel表!", "info");
            return false;
        }
        return true;
    }
	</script>
	
</body>
</html>