<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>积分商品管理</title>
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
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/pm/pointGoods/">积分商品列表</a></small>
            <shiro:hasPermission name="spm:pm:pointGoods:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/pm/pointGoods/form?id=${pointGoods.id}">积分优惠券${not empty pointGoods.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="pointGoods" action="${ctx}/spm/pm/pointGoods/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
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
                                    <label class="col-sm-2 control-label">来源类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="srcType" tip="请选择来源类型，必选项" verifyType="0" dictName="spm_pm_point_goods_srcType" id="srcType"></sys:selectverify>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">来源</label>
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <input type="hidden" name="srcId" id="srcId" value="${pointGoods.srcId }"/>
                                            <input type="text" name="displayName" placeholder="请选择优惠券来源，必选项" data-verify="false" id="displayName" value="${pointGoods.displayName }" class="form-control zf-input-readonly" readonly="readonly"/>
                                            <span class="input-group-btn">
                                                <button id="couponTemplateButton" type="button" class="btn btn-info btn-flat">选择优惠券</button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <sys:selectmutil id="couponTemplateSelect" title="优惠券模板列表" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">编号</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="code" name="code" tip="请输入编号，必填项" maxlength="10" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入名称，必填项" maxlength="50" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">上架标记</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="upFlag" tip="请选择上架标记，必选项" verifyType="0" dictName="yes_no" id="upFlag"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">获取限制类型</label>
                                    <div class="col-sm-9">
                                        <sys:selectverify name="gainType" tip="请选择获取限制类型，必选项" verifyType="0" dictName="spm_pm_point_goods_gainType" id="gainType"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">列表图片</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="listPhoto" path="listPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="listPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">主图片</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="mainPhoto" path="mainPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="mainPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">展示金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="displayPrice" name="displayPrice" tip="请输入展示金额,如500,必填项" maxlength="5" isMandatory="true" verifyType="9" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">奖品介绍</label>
                                    <div class="col-sm-9">
                                        <form:textarea id="introduce" path="introduce" htmlEscape="false" onfocus="if(value=='请输入奖品介绍，必填项'){value=''}"  
    onblur="if (value ==''){value='请输入奖品介绍，必填项'}"  rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">所需积分</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="point" name="point" tip="请输入所需积分,如1000,必填项" maxlength="5" verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">总库存数量</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="totalNum" name="totalNum" tip="请输入总库存数量,如1000,必填项" maxlength="5" verifyType="4"  isSpring="true"></sys:inputverify>
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
                                <c:if test="${empty pointGoods.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:pm:pointGoods:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
        
    </section>
    </div>
    <script type="text/javascript">
         $(function() {
        	 if($("#introduce").val().length == 0) {
	        	 $("#introduce").val("请输入奖品介绍，必填项");
        	 }
        	 
        	 $("#name").on("change", function() {
        		 var flag = $(this).attr("data-verify");
        		 if(!flag) {
        			 $(this).toggle();
        		 }
        	 });
        	 
        	 $("#displayName").on("change", function() {
        		 var val = $(this).val();
        		 if(val == null || val == "" || val == undefined) {
        			 if($("#displayNameErr").length<=0) {
        				 $("#displayName").attr("data-verify", true);
                         $("#displayName").addClass("zf-input-err");                      
                         $("#displayName").parent().after("<label id=\"displayNameErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择优惠券</label>");
                     }
        		 } else {
        			 $("#displayName").removeClass("zf-input-err");
        			 $("#displayNameErr").remove(); 
        			 $("#displayName").attr("data-verify", true);
        		 }
        	 });
        	 
        	 /* $("#displayPrice").on("change", function() {
                 var val = $(this).val();
                 if(val == null || val == "" || val == undefined) {
                     $(this).addClass("zf-input-err");
                     if($("#displayPriceErr").length<=0) {
                         $("#displayPrice").addClass("zf-input-err");                      
                         $("#displayPrice").after("<label id=\"displayPriceErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入展示金额</label>");
                     }
                     $(this).attr("data-verify", false);
                 } else {
                     $("#displayPrice").removeClass("zf-input-err");
                     $("#displayPriceErr").remove(); 
                     $(this).attr("data-verify", true);
                 }
             }); */
        	 
        	 $("#introduce").on("change", function() {
                 var val = $(this).val();
                 if(val == null || val == "" || val == undefined) {
                     $(this).addClass("zf-input-err");
                     if($("#introduceErr").length<=0) {
                         $("#introduce").addClass("zf-input-err");                      
                         $("#introduce").after("<label id=\"displayNameErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请填写介绍,必填项</label>");
                     }
                 } else {
                     $("#introduce").removeClass("zf-input-err");
                     $("#introduceErr").remove(); 
                 }
             });
        	 
        	 
        	 
        	 
        	 $("#couponTemplateButton").on('click',function(){
                 $("#couponTemplateSelectModalUrl").val("${ctx}/spm/ci/couponTemplate/select")//带参数请求URL设置方式
                 $("#couponTemplateSelectModal").modal('toggle');//显示模态框
             });
             
             $("#couponTemplateSelectModal #commitBtn").on("click",function () {
                 $("#couponTemplateSelectModal").modal("hide");       
                 var content = $("#couponTemplateSelectModalIframe").contents().find("body");
                 $("input[type=radio]", content).each(function(){
                     if($(this).prop("checked")){
                         var selVal = $(this).val();
                         var arr = selVal.split("=");
                         $("#srcId").val(arr[0]);
                         $("#displayName").val(arr[1]);
                         $("#name").val(arr[1]);
                         $("#introduce").val(arr[2]);
                         
                         if($("#nameErr").length > 0) {
                             $("#name").removeClass("zf-input-err");
                             $("#nameErr").remove(); 
                         }
                         
                         if($("#displayNameErr").length > 0) {
                        	 $("#displayName").removeClass("zf-input-err");
                        	 $("#displayNameErr").remove();
                        	 $("#displayName").attr("data-verify", true);
                         }
                         
                     }
                 });
             });
        	 
        	 
         });
         
         
         function formSubmit() {
        	 var verify=true;
        	 var form = $("#inputForm");
             var inputs=$("input[data-verify=false]",form);
             for(var i=0;i<inputs.length;i++){
                 if($(inputs[i]).attr('data-type') == "date"){
                     $(inputs[i]).parent().trigger('dp.change');
                 }else{
                     $(inputs[i]).trigger('change');
                 }
                 verify=false;
             }
             var selects=$("select[data-verify=false]",form);
             for(var i=0;i<selects.length;i++){
                 $(selects[i]).trigger('change');
                 verify=false;
             }
             var listPhoto = $("#listPhoto").val();
             if(listPhoto == null || listPhoto == "" || listPhoto == undefined) {
            	 ZF.showTip("请上传列表图片!", "info");
            	 verify = false;
             }
             var mainPhoto = $("#mainPhoto").val();
             if(mainPhoto == null || mainPhoto == "" || mainPhoto == undefined) {
            	 ZF.showTip("请上传主图片!", "info");
            	 verify = false;
             }
             
             var intro = $("#introduce").val();
             if(intro == null || intro == "" || intro == undefined || intro == "请输入奖品介绍，必填项") {
                 if($("#introduceErr").length<=0) {
                     $("#introduce").addClass("zf-input-err");   
                     $("#introduce").after("<label id=\"introduceErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入奖品介绍，必填项</label>");
                 }
                 verify = false;
             }
             
             return verify;
         }
    </script>
</body>
</html>