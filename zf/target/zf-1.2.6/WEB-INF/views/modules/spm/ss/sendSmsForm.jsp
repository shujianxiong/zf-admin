<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发送短信记录管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/ss/sendSms/">发送短信记录列表</a></small>
            <shiro:hasPermission name="spm:ss:sendSms:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/ss/sendSms/form?id=${sendSms.id}">发送短信记录${not empty sendSms.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="sendSms" action="${ctx}/spm/ss/sendSms/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">名称</label>
                                    <div class="col-sm-9">
                                        <input class="form-control" id="phone" name="phone" placeholder="请输入手机号"  maxlength="11"  onchange="changePhone();"></input>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">简介</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="context" name="context" tip="请输入短信内容" verifyType="99"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">备注信息</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">批量导入</label>
                                    <div class="col-sm-9">
                                        <button type="button" id ="btn" onclick="showImportModal('${context}')" class="btn btn-info btn-sm"><i class="fa fa-save"></i>导入</button>
                                    </div>
                                </div>
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <c:if test="${empty sendSms.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:ss:sendSms:edit"><button  onclick="submitForm();" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </section>
    <div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="批量导入手机号" aria-hidden="true">
     	<form id="inputForm1" action="${ctx}/spm/ss/sendSms/sendSmsImport/importFile"  enctype="multipart/form-data"  method="post" class="form-horizontal" onsubmit="return importFile();">
                 <input name ="contexts" type="hidden" id="contexts">
                 <div class="modal-dialog" style="width:30%;height:45%;" >
                     <div class="modal-content" style="width:100%;height:100%;">
                          <div class="modal-header">
                             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">&times;</span></button>
                             <h4 class="modal-title">批量导入模板信息</h4>
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
                                                  第一列：手机号
                         </p>
                         <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                             <tbody>
                             <tr>
                                 <td>131123456789</td>
                             </tr>
                             </tbody>
                         </table>
                     </div>
                 </div>
             </div>
                 <div class="box-footer">
                     <div class="pull-right box-tools">
                         <button type="submit"  class="btn btn-info btn-sm"><i class="fa fa-save"></i>导入</button>
                     </div>
                 </div>
              </div>
            </div>
        </form>
    </div>
    </div>
    
    <script type="text/javascript">
    function submitForm(){
        	var verify = true;
        	var context =$("#context").val();
        		if(context == null || context == "" || context == undefined) {
        			ZF.showTip("请先输入简介！", "info");
        			verify = false;
        		}
        	var phone =$("#phone").val();
    		if(phone == null || phone == "" || phone == undefined) {
    			ZF.showTip("请先输入名称！", "info");
    			verify = false;
    		} else {
    			 $('#btn').attr('disabled', true);
    		}
        	if(!verify) {
                return false;
            }
	}
    function changePhone(){
    	$('#btn').attr('disabled', true);
    }
    
    function showImportModal(context){
    	var context =$("#context").val();
    	if(context == null || context == "" || context == undefined) {
			ZF.showTip("请先输入简介！", "info");
			return;
		}
        $("#contexts").val(context);
        $("#geneteModal").modal('toggle');
    }
	function importFile() {
		var contexts =$("#contexts").val();
		var remarks =$("#remarks").val();
        var file = $("#inputFile").val();
        if(file == null || file == "") {
            ZF.showTip("请先上传模板Excel表!", "info");
            return false;
        }
        //window.location.href="${ctx}/spm/ss/sendSms/sendSmsImport/importFile?context="+context+"&file="+file;
        $("#inputForm1").submit();
	};
    </script>
</body>
</html>