<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>公司资产设备管理</title>
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
            
            $("#useOfficeName").on("click", function() {
                selectOfficeinit({
                    "selectCallBack" : function(list) {
                        $("#useOfficeId").val(list[0].id);
                        $("#useOfficeName").val(list[0].text);
                    }
                })
            });
            
            $("#useUserName").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#useUserId").val(list[0].id);
                        $("#useUserName").val(list[0].text);
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
				href="${ctx}/cap/cc/capital/">公司资产设备列表</a></small>
			<shiro:hasPermission name="cap:cc:capital:edit">
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/cap/cc/capital/form?id=${capital.id}">公司资产设备${not empty capital.id?'修改':'添加'}</a></small>
			</shiro:hasPermission>
		</h1>
	</section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="capital" action="${ctx}/cap/cc/capital/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                    <label class="col-sm-2 control-label">公司</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="officeId" path="sysOffice.id" />
                                        <form:input id="officeName" path="sysOffice.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="选择归属部门" />
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">资产名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入资产名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">资产全称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="fullName" name="fullName" tip="请输入资产全称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">规格型号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="modelNumber" name="modelNumber" tip="请输入规格型号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">固定资产编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="capitalNo" name="capitalNo" tip="请输入固定资产编号" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">资产类别</label>
                                    <div class="col-sm-9">
                                        <form:select path="category" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_category')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">资产类型</label>
                                    <div class="col-sm-9">
                                        <form:select path="type" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="num" name="num" tip="请输入数量" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">单位</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="unit" name="unit" tip="请输入单位" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">供应商</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="supplier" name="supplier" tip="请输入供应商" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">资产价值</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="price" name="price" tip="请输入资产价值" verifyType="9"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">购入时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="buyDate" inputName="buyDate" tip="请选择购入时间" inputId="buyDateId" isMandatory="true" value="${capital.buyDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">资产图片</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="photosUrl" path="photosUrl" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="photosUrl" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">归属类型</label>
                                    <div class="col-sm-9">
                                        <form:select path="belongType" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_belong_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">归属人</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="userId" path="belongUser.id" />
                                        <form:input id="userName" path="belongUser.name" htmlEscape="false" 
                                            maxlength="100" class="form-control zf-input-readonly"
                                            placeholder="选择归属人" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">使用部门</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="useOfficeId" path="useOffice.id" />
                                        <form:input id="useOfficeName" path="useOffice.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="选择归属部门" />
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">使用地点</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="usePlace" name="usePlace" tip="请输入使用地点" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">使用员工</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="useUserId" path="useUser.id" />
                                        <form:input id="useUserName" path="useUser.name" htmlEscape="false" 
                                            maxlength="100" class="form-control zf-input-readonly"
                                            placeholder="选择使用员工" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">资产状态</label>
                                    <div class="col-sm-9">
                                        <form:select path="capitalStatus" class="form-control">
                                            <form:option value="" label="请选择"/>
                                            <form:options items="${fns:getDictList('cap_cc_capital_capital_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">使用状态</label>
                                    <div class="col-sm-9">
                                        <form:select path="useStatus" class="form-control">
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
                                <c:if test="${empty capital.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="cap:cc:capital:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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