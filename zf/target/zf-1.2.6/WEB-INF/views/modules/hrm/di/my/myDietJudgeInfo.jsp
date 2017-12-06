<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>我的日常菜谱评价</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/hrm/di/myDiet/">菜谱列表</a></small>
            <shiro:hasPermission name="hrm:di:dietJudge:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/hrm/di/myDiet/info?id=${dietJudge.id}&dietId=${dietJudge.diet.id }">菜谱评价详情</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="dietJudge" action="${ctx}/hrm/di/myDiet/judgeSave" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
                    <div class="box box-primary">
                        <div class="box-header with-border zf-query">
                            <h5>菜谱评价详情</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">菜谱日期</label>
                                <div class="col-sm-9">
                                    <input id="diet.date" readonly="readonly" value="<fmt:formatDate value='${dietJudge.diet.date}' pattern='yyyy-MM-dd'/>" class="form-control zf-input-readonly"/>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">评价级别</label>
                                <div class="col-sm-9">
                                    <input id="judgeLevel" readonly="readonly" value="${fns:getDictLabel(dietJudge.judgeLevel,'hrm_di_judgeLevel','') }" class="form-control zf-input-readonly"/>
                                </div>
                            </div>
                            <div class="form-group    ">
                                <label class="col-sm-2 control-label">备注信息</label>
                                <div class="col-sm-9">
                                    <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control" readonly="true"/>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
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