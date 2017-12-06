<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>场景管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/gd/scene/findParentList">场景列表</a></small>
            <c:if test="${not empty scene.scene.id }">
                <small>|</small>
                <small><i class="fa-list-style"></i><a href="${ctx}/idx/gd/scene/findSubList?scene.id=${scene.scene.id}">子场景列表</a></small>
            </c:if>
            <shiro:hasPermission name="idx:gd:scene:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/idx/gd/scene/form?id=${scene.id}&scene.id=${scene.scene.id}">${empty scene.scene.id ? '场景':'子场景'}${not empty scene.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="scene" action="${ctx}/idx/gd/scene/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                            
                                <c:if test="${not empty scene.scene.id }">
	                                <div class="form-group">
	                                    <label class="col-sm-2 control-label">父场景</label>
	                                    <div class="col-sm-9">
	                                        <input type="hidden" name="subType" value="1"/>
	                                        <input type="hidden" name="indexFlag" value="0"/><!-- 默认不首页推荐 -->
	                                        <input type="hidden" name="scene.id" value="${scene.scene.id }"/>
	                                        <input type="text" name="scene.name" readonly="readonly" value="${scene.scene.name }" class="form-control zf-input-readonly"/>
	                                        <%-- <select id="sceneId" name="scene.id" class="select2">
	                                            <option value="">请选择</option>
	                                            <c:forEach items="${sceneList }" var="s">
	                                                <option value="${s.id }" ${s.id eq scene.scene.id ? "selected":"" }>${s.name }</option>
	                                            </c:forEach>
	                                        </select> --%>
	                                    </div>
	                                </div>
                                </c:if>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">场景名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" maxlength="50" tip="请输入场景名称" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">场景英文名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="englishName" name="englishName" maxlength="50" tip="请输入场景英文名称" verifyType="99"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">场景展示图</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="dpPhoto" path="dpPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="dpPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">场景头部图</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="topPhoto" path="topPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="topPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">分类图标(选中)</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="listIconChoose" path="listIconChoose" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="listIconChoose" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">分类图标(未选中)</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="listIconUnchoose" path="listIconUnchoose" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="listIconUnchoose" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">排列序号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="orderNo" name="orderNo" maxlength="8" tip="请输入正确的序号,整数，必填项" verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                
                                <c:if test="${empty scene.scene.id }">
	                                <div class="form-group">
	                                    <label class="col-sm-2 control-label">是否首页推荐</label>
	                                    <div class="col-sm-9">
	                                        <sys:selectverify name="indexFlag" tip="请选择是否首页推荐" verifyType="0" dictName="yes_no" id="indexFlag"></sys:selectverify>
	                                    </div>
	                                </div>
                                </c:if>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">是否启用</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="usableFlag" tip="请选择是否启用" verifyType="0" dictName="yes_no" id="usableFlag"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">场景描述</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="description" htmlEscape="false" rows="4" maxlength="1000" class="form-control"/>
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
                                <%-- <c:if test="${empty scene.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if> --%>
                                <shiro:hasPermission name="idx:gd:scene:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
      
    </section>
    </div>
    <script type="text/javascript">
           function formSubmit() {
        	   var flag = ZF.formSubmit();
        	    if(flag) {
        		  /*  var dpPhoto = $("#dpPhoto").val();
        		   if(dpPhoto == null || dpPhoto == "") {
        			   ZF.showTip("请先上传场景展示图","info");
        			   flag = false;
        		   } 
        		   var topPhoto = $("#topPhoto").val();
        		   if(topPhoto == null || topPhoto == "") {
                       ZF.showTip("请先上传场景头部图","info");
                       flag = false;
                   }*/
        		   /* var searchIcon = $("#searchIcon").val();
        		   if(searchIcon == null || searchIcon == "") {
                       ZF.showTip("请先上传场景搜索图","info");
                       flag = false;
                   } */
        	   }
        	   $("button[type=submit]").attr('disabled',false); 
        	   return flag;
           }
    </script>
</body>
</html>