<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>明星穿搭管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            editor = CKEDITOR.replace( 'content', {
                on: {
                    instanceReady: function( ev ) {
                        this.dataProcessor.writer.setRules( 'p', {
                            indent: false,
                            breakBeforeOpen: false,   //<p>之前不加换行
                            breakAfterOpen: false,    //<p>之后不加换行
                            breakBeforeClose: false,  //</p>之前不加换行
                        breakAfterClose: false    //</p>之后不加换行7
                        });
                    }
                }
            });
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
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/sw/starsWear/">明星穿搭列表</a></small>
            <shiro:hasPermission name="idx:sw:starsWear:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/idx/sw/starsWear/form?id=${starsWear.id}">明星穿搭${not empty starsWear.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="starsWear" action="${ctx}/idx/sw/starsWear/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit()">
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
                                    <label class="col-sm-2 control-label">标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="titleInput" name="title" tip="请输入标题，必填项" verifyType="99"  isSpring="true" maxlength="100"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group    ">
                                    <label class="col-sm-2 control-label">展示日期</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="displayDate" format="YYYY-MM-DD" inputName="displayDate" tip="必须选择展示日期" inputId="displayDateId" isMandatory="true" value="${starsWear.displayDate}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">列表图<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:明星穿搭">?</span></label>
                                            <div class="col-sm-8">
                                                <form:hidden id="listPhoto" path="listPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                                <sys:fileUpload input="listPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">详情图<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:明星穿搭详情">?</span></label>
                                            <div class="col-sm-8">
                                                <form:hidden id="detailPhoto" path="detailPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                                <sys:fileUpload input="detailPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group    ">
                                            <label for="summary" class="col-sm-2 control-label">简介</label>
                                            <div class="col-sm-9">
                                                <sys:inputverify id="summary" name="summary" tip="请输入简介，必填项" verifyType="99"  isSpring="true" maxlength="200"></sys:inputverify>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">内容</label>
                                            <div class="col-sm-8">
                                                <textarea name="content">${starsWear.content}</textarea>
                                                <sys:preview id="preview"  title="内容预览" content="" width="1200" height="700"></sys:preview>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" >是否启用</label>
                                    <div class="col-sm-9 zf-check-wrapper-padding">
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
                                <c:if test="${empty starsWear.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="idx:sw:starsWear:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
    
</body>
</html>