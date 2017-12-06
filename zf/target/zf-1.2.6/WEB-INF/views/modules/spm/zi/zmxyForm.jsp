<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>芝麻信用配置管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            
        });
        
        function formSubmit(){
      		var flag = ZF.formSubmit();
       	  	if(flag){
       		  	if(($("#scoreMax").val()-$("#scoreMin").val()) < 0 ){
       			  	ZF.showTip("分值上限不得低于分值下限", "warning");
       			  	flag=false;
       			 	$("button[type=submit]").attr('disabled', false);
       		  	}
       	  	}
       	  	return flag;	
        }
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/zi/zmxy/">芝麻信用配置列表</a></small>
            <shiro:hasPermission name="spm:zi:zmxy:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/zi/zmxy/form?id=${zmxy.id}">芝麻信用配置${not empty zmxy.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="zmxy" action="${ctx}/spm/zi/zmxy/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
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
                                    <label class="col-sm-2 control-label">名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入名称" verifyType="99"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">简介</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="summary" name="summary" tip="请输入简介" verifyType="99"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">分值上限</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="scoreMax" name="scoreMax" tip="请输入分值上线" verifyType="4" maxlength="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">分值下限</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="scoreMin" name="scoreMin" tip="请输入分值下线" verifyType="4" maxlength="4" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">押金比例</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="depositRate" name="depositRate" tip="请输入押金比例，两位小数" verifyType="9" maxlength="4" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">持续时间(天)</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="duration" name="duration" tip="请输入持续时间(天)，正整数" maxlength="6" verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">限定金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="amount" name="amount" tip="请输入限定金额，两位小数" verifyType="9" maxlength="8"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">限制下单数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="limitOrderNum" name="limitOrderNum" tip="请输入限制下单数量，正整数" verifyType="4"  maxlength="6" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">启用状态</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="activeFlag" tip="请选择启用状态" verifyType="0" dictName="yes_no" id="activeFlag"></sys:selectverify>
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
                                <c:if test="${empty zmxy.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:zi:zmxy:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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