<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搭配管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/gd/collocation/">搭配列表</a></small>
            <shiro:hasPermission name="idx:gd:collocation:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/idx/gd/collocation/form?id=${collocation.id}">搭配${not empty collocation.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="collocation" action="${ctx}/idx/gd/collocation/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
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
                                <label class="col-sm-2 control-label">所属父场景</label>
                                <div class="col-sm-9">
                                    <select id="scenePId" class="form-control select2">
                                        <option value="">请选择</option>
                                        <c:forEach items="${sceneParentList }" var="s"><!-- 子场景的父场景ID  == 父场景id -->
                                            <option value="${s.id }" ${s.id eq collocation.scene.scene.id ? "selected":"" }>${s.name }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">所属子场景</label>
                                <div class="col-sm-9" id="subDiv">
                                    <select id="sceneId" name="scene.id" class="form-control select2">
                                        <option value="">请选择</option>
                                        <c:forEach items="${sceneSubList }" var="s">
                                            <option value="${s.id }" ${s.id eq collocation.scene.id ? "selected":"" }>${s.name }</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">搭配名称</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="name" name="name" tip="请输入搭配名称" maxlength="50" verifyType="0" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">英文名称</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="englishName" name="englishName" maxlength="50" tip="请输入搭配英文名称" isMandatory="false" verifyType="0"  isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">色系</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="colourSystem" tip="请选择色系" verifyType="0" isMandatory="false" dictName="idx_gd_collocation_colourSystem" id="colourSystem"></sys:selectverify>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">搭配详情图</label>
                                <div class="col-sm-9">
                                    <form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="photo" model="true" selectMultiple="false"></sys:fileUpload>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">搭配描述</label>
                                <div class="col-sm-9">
                                    <form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">搜索关键词</label>
                                <div class="col-sm-9">
                                    <form:textarea path="searchKey" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">分享标题</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="shareTitle" name="shareTitle" tip="请输入分享标题" maxlength="20" verifyType="-99" isMandatory="false"  isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">分享描述</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="shareDescribe" name="shareDescribe" tip="请输入搭配描述" maxlength="50" verifyType="-99" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">分享图片</label>
                                <div class="col-sm-9">
                                    <form:hidden id="sharePhoto" path="sharePhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                    <sys:fileUpload input="sharePhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">是否启用</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="usableFlag" tip="请选择是否启用" verifyType="0" dictName="yes_no" id="usableFlag"></sys:selectverify>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">是否默认推荐</label>
                                <div class="col-sm-9">
                                    <sys:selectverify name="recommendFlag" tip="请选择是否默认推荐" verifyType="0" dictName="yes_no" id="recommendFlag"></sys:selectverify>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">排列序号</label>
                                <div class="col-sm-9">
                                    <sys:inputverify id="orderNo" name="orderNo" tip="请输入正确的序号,整数，必填项" maxlength="8" verifyType="4"  isSpring="true"></sys:inputverify>
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
		                        <c:if test="${empty collocation.id}">
		                            <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
		                        </c:if>
		                        <shiro:hasPermission name="idx:gd:collocation:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
		                    </div>
		                </div>
                    </div>
                </form:form>
            </div>
        </div>
    </section>
    </div>
    <script type="text/javascript">
    
         var sList = ${fns:toJson(sceneSubList)}; 
         console.log(sList);
         $(function() {
        	 $("#scenePId").on("change", function() {
        		 var pid = $(this).val();
        		 $("#subDiv").html("");
        		 var html = "<select id='sceneId' name='scene.id' class='form-control select2'><option value=''>请选择</option>";
        		 for(var i=0;i<sList.length;i++) {
        			 if(sList[i].scene.id == pid) {
        				 html += "<option value="+sList[i].id+">"+sList[i].name+"</option>";
        			 }
        		 }
        		 html += "</select>";
        		 $("#subDiv").html(html);
        		 $("#sceneId").select2();
        	 });
         });
    
    
         function formSubmit() {
        	 var flag = ZF.formSubmit();
        	 if(flag) {
        		 var sceneId = $("#sceneId").val();
        		 if(sceneId == null || sceneId == "") {
        			 ZF.showTip("请先选择所属场景","info");
                     flag = false;
        		 }
        		 var photo = $("#photo").val();
        		 if(photo == null || photo == "") {
                     ZF.showTip("请先上传搭配详情图","info");
                     flag = false;
                 }
        	 }
       		 $("button[type=submit]").attr('disabled',false); 
        	 return flag;
         }
    </script>
</body>
</html>