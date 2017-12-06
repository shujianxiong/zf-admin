<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>免押金活动配置表管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/fd/freeDeposit/">免押金活动配置表列表</a></small>
            <shiro:hasPermission name="spm:fd:freeDeposit:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/fd/freeDeposit/form?id=${freeDeposit.id}">免押金活动配置表${not empty freeDeposit.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="freeDeposit" action="${ctx}/spm/fd/freeDeposit/save" method="post" class="form-horizontal">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">简介</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="summary" name="summary" tip="请输入简介" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">开始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime format="YYYY-MM-DD" id="startTime" inputName="startTime" tip="请选择开始时间" inputId="startTimeId" isMandatory="true" value="${freeDeposit.startTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">结束时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime format="YYYY-MM-DD" id="endTime" inputName="endTime" tip="请选择结束时间" inputId="endTimeId" isMandatory="true" value="${freeDeposit.endTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">注册名额比例</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="registerPlaces" name="registerPlaces" tip="请输入注册名额比例，正整数" verifyType="4" maxlength="2"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">总名额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="places" name="places" tip="请输入总名额，正整数" maxlength="4" verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">初始名额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="initPlaces" name="initPlaces" tip="请输入初始名额，正整数" maxlength="4" verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">启用状态</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="activeFlag" tip="请选择启用状态" verifyType="-1" dictName="yes_no" id="activeFlag"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
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
                                <c:if test="${empty freeDeposit.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:fd:freeDeposit:edit"><button onclick="formSubmit()" type="button" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
    </section>
    </div>
    <script type="text/javascript">
	    function formSubmit(){
    		let flag = ZF.formSubmit();
        	console.log(flag);
        	if(flag){
        		if($("#endTimeId").val() < $("#startTimeId").val()){
        			ZF.showTip("结束时间不得小于开始时间", "error");
        			flag = false;
        		}else{
        			$("#inputForm").submit();	
        		}
        	}
	    	return flag;
	    }
    </script>
</body>
</html>