<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>短信发送管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            $("#officeName").on("click", function() {
                selectOfficeinit({
                    "selectCallBack" : function(list) {
                        $("#officeId").val(list[0].id);
                        $("#officeName").val(list[0].text);
                    }
                })
            });
            
            $("#areaName").on("click", function() {
                selectAreainit({
                    "selectCallBack" : function(list) {
                        $("#areaId").val(list[0].id);
                        $("#areaName").val(list[0].text);
                    }
                })
            });
            
            $("#userName").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#userId").val(list[0].id);
                        $("#userName").val(list[0].text);
                    }
                })
            });
            
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/crm/sl/smsLink/">短信链接模块列表</a></small>
            <shiro:hasPermission name="crm:sl:smsLink:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/crm/sl/smsLink/toSend?id=${smsLink.id}">短信群发</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="smsLink" action="${ctx}/crm/sl/smsLink/send" method="post" class="form-horizontal" onsubmit="return formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                                <input type="hidden" id="memberusercodes" name="memberusercodes" >
                            <form:hidden path="id" />
                                <input id="smsLinkId" type="hidden" value="${smsLink.id}">
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">内容（%s替换链接）</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="context" name="context" disabled="disabled" class="form-control" value="${smsLink.context }"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">内置链接</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="link" name="link" disabled="disabled" class="form-control" value="${smsLink.link }"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">链接参数</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="parameter" name="parameter" disabled="disabled" class="form-control" value="${smsLink.parameter }"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">会员</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="text" name="usercode" id="usercode" placeholder="必选项" class="form-control zf-input-readonly" readonly="readonly"/>
                                            <span class="input-group-btn">
                                                    <button id="memberChButton" type="button" class="btn btn-info btn-flat">选择会员</button>
                                                </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">类型</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="type" name="type" disabled="disabled" class="form-control" value="${fns:getDictLabel(smsLink.type, 'sms_link_type', '')}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">批量导入</label>
                                    <div class="col-sm-9">
                                        <button type="button" id ="btn" onclick="showImportModal()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>导入</button>
                                    </div>
                                </div>

                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <c:if test="${empty smsLink.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="crm:sl:smsLink:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>短信群发</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        <sys:selectmutil id="memberSelect" title="用户选择" url="" isDisableCommitBtn="true" width="1200" height="700" isRefresh="false"></sys:selectmutil>
    </section>
         <div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="批量导入手机号" aria-hidden="true">
     	     <form:form id="inputForm1" modelAttribute="smsLink" action="${ctx}/crm/sl/smsLink/smsLinkImport/importFile"  enctype="multipart/form-data"  method="post" class="form-horizontal" onsubmit="return importFile();">
                 <input name ="context" type="hidden"  id="contexts">
                 <input name ="link" type="hidden" id="links">
                 <input name ="parameter" type="hidden" id="parameters">
                 <input name ="type" type="hidden"  id="types">
                 <input name ="id" type="hidden" id="ids">
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
        </form:form>
    </div>
    </div>
    <script>
        var memberFlag = false;
        $(function(){
            localStorage.removeItem('usercode');
            //读取
            let str = localStorage.getItem('memberMap');
            map = JSON.parse(str);
            let memberusercodes = [];
            for(let prop in map){
                if(map.hasOwnProperty(prop)){
                    localStorage.removeItem(prop);
                }
            }
            localStorage.removeItem('memberMap');

            $("#memberChButton").on('click',function() {
                $("#memberSelectModalUrl").val("${ctx}/crm/sl/smsLink/memberSelect")//带参数请求URL设置方式
                $("#memberSelectModal").modal('toggle');//显示模态框
            });

            $("#memberSelectModal #commitBtn").on("click",function() {
                $("#memberSelectModal").modal("hide");
                //读取
                let str = localStorage.getItem('memberMap');
                map = JSON.parse(str);
                let memberusercodes = [];
                for(var prop in map){
                    if(map.hasOwnProperty(prop)){
                        for(let i=0;i<map[prop].length;i++){
                            memberusercodes.push(map[prop][i]);
                        }
                    }
                }
                console.log(memberusercodes);
                if (memberusercodes != undefined&& memberusercodes.length > 0) {
                    let usercode = localStorage.getItem("usercode");
                    if(usercode){
                        $("#usercode").val(usercode + "等" + memberusercodes.length+ "名会员");
                    }else{
                        $("#usercode").val("共选择了" + memberusercodes.length+ "名会员");
                    }
                    $("#memberusercodes").val(memberusercodes);
                    memberFlag = true;
                }else{
                    memberFlag = false;
                }
            });

            $("#memberSelectModal #allBtn").on("click",function() {
                var table = $("#memberSelectIframe").contents().find("tbody");
                if($(table).children("tr").length <= 1){
                    ZF.showTip("请先查询到有效的会员信息！", "info");
                    memberFlag = false;
                    return false;
                }else{
                    $("#memberSelectModal").modal("hide");
                    var form = $("#memberSelectIframe").contents().find("form");
                    $("#usercode").val('按条件全部提交');
                    memberFlag = true;
                }
            });
        });
        //过滤已有数据
        function checkExsit(memberArray){
            for(var i=0;i<memberArray.length;i++){
                $("#tBody").children('tr').each(function(){
                    if(memberArray != null && memberArray!=undefined &&memberArray.length>0){
                        if(memberArray[i][0]==$(this).attr("data-value")){
                            memberArray.splice(i,1);
                        }
                    }
                })
            }
            return memberArray;
        }
        function formSubmit() {
            var usercode = $("#usercode").val();
            if (usercode == null || usercode == "") {
                ZF.showTip("请选择用户！", "danger");
                return false;
            }
        }
        
        function showImportModal(){
        	var context =$("#context").val();
        	var link =$("#link").val();
        	var parameter =$("#parameter").val();
        	var type =$("#type").val();
        	var id  =$("#smsLinkId").val();
            $("#contexts").val(context);
            $("#links").val(link);
            $("#parameters").val(parameter);
            $("#types").val(type);
            $("#ids").val(id);
            $("#geneteModal").modal('toggle');
        }
    	function importFile() {
    		var context =$("#contexts").val();
        	var link =$("#links").val();
        	var parameter =$("#parameters").val();
        	var type =$("#types").val();
        	var id  =$("#ids").val();
            var file = $("#inputFile").val();
            if(file == null || file == "") {
                ZF.showTip("请先上传模板Excel表!", "info");
                return false;
            }
            //window.location.href="${ctx}/spm/ss/sendSms/sendSmsImport/importFile?context="+context+"&file="+file;
           // $("#inputForm1").submit();
    	};
    </script>
</body>
</html>