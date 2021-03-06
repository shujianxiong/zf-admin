<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>周范秀场管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/sa/showArea/">周范秀场列表</a></small>
            <shiro:hasPermission name="idx:sa:showArea:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/idx/sa/showArea/form?id=${showArea.id}">周范秀场${not empty showArea.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="showArea" action="${ctx}/idx/sa/showArea/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">会员账号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="musercode" name="member.usercode" value="${fns:getMemberById(showArea.member.id).usercode}" tip="请输入会员账号，必填项" verifyType="99" isMandatory="true" isSpring="false" maxlength="20"></sys:inputverify>
                                    </div>
                                </div>
                                <sys:inputtree name="deo.id" url="${ctx}/bas/video/videoTreeData?type=2" id="deo" label="视频选择" labelValue="" labelWidth="2" inputWidth="9"
                                               labelName="deo.code" value="" tip="请选择视频" ></sys:inputtree>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="title" name="title" tip="请输入标题，必填项" verifyType="0"  isSpring="true" maxlength="50"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">展示时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="displayTime" inputName="displayTime" tip="请选择展示时间" inputId="displayTimeId" isMandatory="true" value="${showArea.displayTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">播放次数</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="playNum" name="playNum" tip="请输入播放次数,整数，必填项" verifyType="4"  isSpring="true" maxlength="8"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">是否启用</label>
                                    <div class="col-sm-9">
                                        <form:radiobuttons path="usableFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required" />
                                    </div>
                                </div>
                                <div class="form-group    ">
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
                                <c:if test="${empty showArea.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="idx:sa:showArea:edit"><button type="submit" onclick="submitForm()" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
        <sys:userselect height="550" url="${ctx}/sys/office/treeData"
            width="550" isOffice="true" isMulti="false" title="机构选择"
            id="selectOffice" dataType="Office"></sys:userselect>
            
        <sys:userselect height="550" url="${ctx}/sys/area/treeData"
            width="550" isOffice="true" isMulti="false" title="区域选择"
            id="selectArea"></sys:userselect>
            
        <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
            width="550" isOffice="false" isMulti="false" title="人员选择"
            id="selectUser" ></sys:userselect>
        
    </section>
    </div>
    <script type="text/javascript">
        // 提交表单
        function submitForm(){
            // 视频选择
            if($("#deoId").val() == null || $("#deoId").val() == ""){
                ZF.showTip("请选择视频！","info");
                return;
            }
            $("#inputForm").submit();
        }
    </script>
</body>
</html>