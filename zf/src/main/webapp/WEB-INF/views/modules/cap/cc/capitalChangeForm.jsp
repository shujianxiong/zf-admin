<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>公司资产变更记录管理</title>
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
            
            $("#userName").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#userId").val(list[0].id);
                        $("#userName").val(list[0].text);
                    }
                })
            });
            
            $("#newUseOfficeName").on("click", function() {
                selectOfficeinit({
                    "selectCallBack" : function(list) {
                        $("#newUseOfficeId").val(list[0].id);
                        $("#newUseOfficeName").val(list[0].text);
                    }
                })
            });
            
            $("#newUseUserName").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#newUseUserId").val(list[0].id);
                        $("#newUseUserName").val(list[0].text);
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
			<small><i class="fa-list-style"></i><a
				href="${ctx}/cap/cc/capitalChange/">公司资产变更记录列表</a></small>
			<shiro:hasPermission name="cap:cc:capitalChange:edit">
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/cap/cc/capitalChange/form?id=${capitalChange.id}">公司资产变更记录${not empty capitalChange.id?'修改':'添加'}</a></small>
			</shiro:hasPermission>
		</h1>
	</section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="capitalChange" action="${ctx}/cap/cc/capitalChange/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            <form:hidden path="capital.id"/>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">资产全称</label>
                                    <div class="col-sm-9">
                                        <form:input path="capital.fullName" readonly="true"  class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">变动类型</label>
                                    <div class="col-sm-9">
                                        <form:select path="changeType" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_change_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">变动原因类型</label>
                                    <div class="col-sm-9">
                                        <form:select path="changeReasonType" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_change_reason_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">原固定资产编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="oldCapitalNo" name="oldCapitalNo" tip="请输入原固定资产编号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">原数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="oldNum" name="oldNum" tip="请输入原数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">原使用部门</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="officeId" path="oldUseOffice.id" />
                                        <form:input id="officeName" path="oldUseOffice.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="选择归属部门" />
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">原使用地点</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="oldUsePlace" name="oldUsePlace" tip="请输入原使用地点" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">原使用员工</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="userId" path="oldUseUser.id" />
                                        <form:input id="userName" path="oldUseUser.name" htmlEscape="false" 
                                            maxlength="100" class="form-control zf-input-readonly"
                                            placeholder="选择原使用员工" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">原资产状态</label>
                                    <div class="col-sm-9">
                                        <form:select path="oldCapitalStatus" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_capital_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">原使用状态</label>
                                    <div class="col-sm-9">
                                        <form:select path="oldUseStatus" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_use_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">新固定资产编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="newCapitalNo" name="newCapitalNo" tip="请输入新固定资产编号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">新数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="newNum" name="newNum" tip="请输入新数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">新使用部门</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="newUseOfficeId" path="newUseOffice.id" />
                                        <form:input id="newUseOfficeName" path="newUseOffice.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="选择归属部门" />
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">新使用地点</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="newUsePlace" name="newUsePlace" tip="请输入新使用地点" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">新使用员工</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="newUseUserId" path="newUseUser.id" />
                                        <form:input id="newUseUserName" path="newUseUser.name" htmlEscape="false" 
                                            maxlength="100" class="form-control zf-input-readonly"
                                            placeholder="选择新使用员工" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">新资产状态</label>
                                    <div class="col-sm-9">
                                        <form:select path="newCapitalStatus" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_capital_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">新使用状态</label>
                                    <div class="col-sm-9">
                                        <form:select path="newUseStatus" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_use_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
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
                                <c:if test="${empty capitalChange.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="cap:cc:capitalChange:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
        <sys:userselect height="550" url="${ctx}/sys/office/treeData"
            width="550" isOffice="true" isMulti="false" title="机构选择"
            id="selectOffice" dataType="Office"></sys:userselect>
            
        <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
            width="550" isOffice="false" isMulti="false" title="人员选择"
            id="selectUser" ></sys:userselect>
        
    </section>
    </div>
    
</body>
</html>