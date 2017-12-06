<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>资金账户余额管理</title>
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
			<small><i class="fa-list-style"></i><a
				href="${ctx}/crm/bb/bankbookBalance/">资金账户余额列表</a></small>
			<shiro:hasPermission name="crm:bb:bankbookBalance:edit">
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a
					href="${ctx}/crm/bb/bankbookBalance/form?id=${bankbookBalance.id}">资金账户余额${not empty bankbookBalance.id?'修改':'添加'}</a></small>
			</shiro:hasPermission>
		</h1>
	</section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="bankbookBalance" action="${ctx}/crm/bb/bankbookBalance/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
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
                                        <input type="text" value="${fns:getMemberById(bankbookBalance.member.id).usercode}" disabled="disabled" class="form-control zf-input-readonly"/>
                                    </div>
                                </div>
                                
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">会员姓名</label>
                                    <div class="col-sm-9">
                                        <input type="text" value="${fns:getMemberById(bankbookBalance.member.id).name}" disabled="disabled" class="form-control zf-input-readonly"/>
                                    </div>
                                </div>
                                
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">可用余额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="usableBalance" name="usableBalance" tip="请输入可用余额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">冻结余额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="frozenBalance" name="frozenBalance" tip="请输入冻结余额" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">最后流水编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="lastItemNo" name="lastItemNo" tip="请输入最后流水编号" verifyType="0"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty bankbookBalance.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="crm:bb:bankbookBalance:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
    </section>
    </div>
    
</body>
</html>