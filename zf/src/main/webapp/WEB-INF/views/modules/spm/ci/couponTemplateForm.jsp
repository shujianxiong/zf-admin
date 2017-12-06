<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<html>
<head>
    <title>优惠券模板管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/ci/couponTemplate/">优惠券模板列表</a></small>
            <shiro:hasPermission name="spm:ci:couponTemplate:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/ci/couponTemplate/form?id=${couponTemplate.id}">优惠券模板${not empty couponTemplate.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="couponTemplate" action="${ctx}/spm/ci/couponTemplate/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
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
                                    <label class="col-sm-2 control-label">模板名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="name" name="name" tip="请输入模板名称,必填项" maxlength="45" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">优惠券名称</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="couponName" name="couponName" tip="请输入优惠券名称,必填项" maxlength="45" verifyType="0"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">可用起始时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="startTime" inputName="startTime" tip="请选择可用起始时间,必选项" inputId="startTimeId" isMandatory="true" value="${couponTemplate.startTime}"></sys:datetime>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">可用截止时间</label>
                                    <div class="col-sm-9">
                                        <sys:datetime id="endTime" inputName="endTime" tip="请选择可用截止时间,必选项" inputId="endTimeId" isMandatory="true" value="${couponTemplate.endTime}"></sys:datetime>
                                    </div>
                                </div>
                                
                                <c:choose>
                                    <c:when test="${empty couponTemplate.id}">
                                        <div class="form-group">
		                                    <label class="col-sm-2 control-label">优惠类型</label>
		                                    <div class="col-sm-9">
		                                        <sys:selectverify name="couponType" tip="请输入优惠类型,必选项" verifyType="0" dictName="spm_ci_coupon_type" id="couponType"></sys:selectverify>
		                                    </div>
		                                </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="form-group">
		                                    <label class="col-sm-2 control-label">优惠类型</label>
		                                    <div class="col-sm-9">
		                                        <form:hidden path="couponType"/>
	                                            <form:select path="couponType" class="form-control select2" disabled="true">
		                                            <form:options items="${fns:getDictList('spm_ci_coupon_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		                                        </form:select>
		                                    </div>
		                                </div>
                                    </c:otherwise>
                                </c:choose>
                                
                                <div class="form-group" id="mjDiv">
                                    <label class="col-sm-2 control-label">达标金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="reachMoney" name="reachMoney" maxlength="10" tip="请输入达标金额,如1000,必填项" verifyType="4" isMandatory="false"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group" id="kjDiv">
                                    <label class="col-sm-2 control-label">扣减金额</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="decreaseMoney" name="decreaseMoney" maxlength="10" tip="请输入扣减金额,如100,必填项" verifyType="4" isMandatory="false"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group" id="zkDiv" style="display: none;">
                                    <label class="col-sm-2 control-label">打折比例</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="discountScale" name="discountScale" maxlength="5" tip="请输入打折比例,支持两位小数,比如0.88,必填项" verifyType="9"  isMandatory="false"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group" id="zkDiv2" style="display: none;">
                                    <label class="col-sm-2 control-label">打折金额上限</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="discountMoneyMax" name="discountMoneyMax" maxlength="5" tip="请输入打折金额上限,如500,必填项" isMandatory="false"  verifyType="4"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">优惠券介绍</label>
                                    <div class="col-sm-9">
                                        <form:textarea id="introduction" path="introduction" onfocus="if(value=='请输入优惠券介绍，必填项'){value=''}"  
    onblur="if (value ==''){value='请输入优惠券介绍，必填项'}"  htmlEscape="false" rows="4" maxlength="200"  class="form-control"/>
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
                                <c:if test="${empty couponTemplate.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if>
                                <shiro:hasPermission name="spm:ci:couponTemplate:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
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
        	
        	if($("#introduction").val().length == 0) {
	        	 $("#introduction").val("请输入优惠券介绍，必填项");
        	}
        	
        	//初始化 
        	var type = $("#couponType").val();
        	if(type == 1) {//满减
                $("#mjDiv").show();
                $("#kjDiv").show();
                $("#zkDiv").hide();
                $("#zkDiv2").hide();
            } else if(type == 2) {//扣减
                $("#mjDiv").hide();
                $("#kjDiv").show();
                $("#zkDiv").hide();
                $("#zkDiv2").hide();
            } else if(type == 3) {//折扣
                $("#mjDiv").hide();
                $("#kjDiv").hide();
                $("#zkDiv").show();
                $("#zkDiv2").show();
            } else if(type ==4) {//租赁费全免
                $("#mjDiv").hide();
                $("#kjDiv").hide();
                $("#zkDiv").hide();
                $("#zkDiv2").hide();
            }
        	
        	//操作触发
        	$("#couponType").on("change", function() {
        		var val = $(this).val();
        		if(val == 1) {//满减
        			$("#mjDiv").show();
        		    $("#kjDiv").show();
        		    $("#zkDiv").hide();
        		    $("#zkDiv2").hide();
        		} else if(val == 2) {//扣减
        			$("#mjDiv").hide();
                    $("#kjDiv").show();
                    $("#zkDiv").hide();
                    $("#zkDiv2").hide();
        		} else if(val == 3) {//折扣
        			$("#mjDiv").hide();
                    $("#kjDiv").hide();
                    $("#zkDiv").show();
                    $("#zkDiv2").show();
        		} else if(val ==4) {//租赁费全免
        			$("#mjDiv").hide();
                    $("#kjDiv").hide();
                    $("#zkDiv").hide();
                    $("#zkDiv2").hide();
        		}
        	});
        	
        	$("#startTime").on("dp.change", function() {
        		$("#startTimeId").removeClass("zf-input-err");
        		$("#startTimeErr").remove();
        	});
        	
        	$("#endTime").on("dp.change", function() {
        		$("#endTimeId").removeClass("zf-input-err");
                $("#endTimeErr").remove();
            });
        	
        	
        	$("#introduction").on("change", function() {
                 $(this).attr("data-verify", true);
                 $(this).removeClass("zf-input-err");   
                 $("#introductionErr").remove();
        	});
        	
        });
        
        function formSubmit() {
        	var verify=true;
        	
        	var name = $("#name").val();
        	if(name == null || name == "" || name == undefined) {
                if($("#nameErr").length<=0) {
                    $("#name").addClass("zf-input-err");                      
                    $("#name").after("<label id=\"nameErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入模板名称，必填项</label>");
                }
                verify = false;
            } else {
                $("#name").attr("data-verify", true);
                $("#name").removeClass("zf-input-err");  
                $("#nameErr").remove();
            }
        	
        	var couponName = $("#couponName").val();
        	if(couponName == null || couponName == "" || couponName == undefined) {
                if($("#couponNameErr").length<=0) {
                    $("#couponName").addClass("zf-input-err");                      
                    $("#couponName").after("<label id=\"couponNameErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入优惠券名称，必填项</label>");
                }
                verify = false;
            } else {
                $("#couponName").attr("data-verify", true);
                $("#couponName").removeClass("zf-input-err");  
                $("#couponNameErr").remove();
            }
        	
        	var startTime = $("#startTimeId").val();
        	if(startTime == null || startTime == "" || startTime == undefined) {
                if($("#startTimeErr").length<=0) {
                    $("#startTimeId").addClass("zf-input-err");                      
                    $("#startTimeId").parent().after("<label id=\"startTimeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择可用开始时间，必选项</label>");
                }
                verify = false;
            } else {
                $("#startTimeId").attr("data-verify", true);
                $("#startTimeId").removeClass("zf-input-err");  
                $("#startTimeErr").remove();
            }
        	
        	var endTime = $("#endTimeId").val();
        	if(endTime == null || endTime == "" || endTime == undefined) {
                if($("#endTimeErr").length<=0) {
                    $("#endTimeId").addClass("zf-input-err");                      
                    $("#endTimeId").parent().after("<label id=\"endTimeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请选择可用截止时间，必选项</label>");
                }
                verify = false;
            } else {
            	if(endTime <= startTime) {
            		if($("#endTimeErr").length<=0) {
                        $("#endTimeId").addClass("zf-input-err");                      
                        $("#endTimeId").parent().after("<label id=\"endTimeErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>截止时间必须大于开始时间，请核查</label>");
                    }
            		verify = false;
            	} else {
	                $("#endTimeId").attr("data-verify", true);
	                $("#endTimeId").removeClass("zf-input-err");  
	                $("#endTimeErr").remove();
            	}
            }
        	
        	var form = $("#inputForm");
            var selects=$("select[data-verify=false]",form);
            for(var i=0;i<selects.length;i++){
                $(selects[i]).trigger('change');
                verify=false;
            }
            var type = $("#couponType").val();
            if(type == 1) {//满减
                var rm = $("#reachMoney").val();
                var dm = $("#decreaseMoney").val();
                if(rm == null || rm == "" || rm == undefined) {
                	if($("#reachMoneyErr").length<=0) {
                		$("#reachMoney").addClass("zf-input-err");              		
                        $("#reachMoney").after("<label id=\"reachMoneyErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入达标金额,如1000，必填项</label>");
                	}
                    verify = false;
                } else {
                	$("#reachMoney").attr("data-verify", true);
                	$("#reachMoney").removeClass("zf-input-err");  
                	$("#reachMoneyErr").remove();
                }
                
                if(dm == null || dm == "" || dm == undefined) {
                    if($("#decreaseMoneyErr").length<=0) {
                    	$("#decreaseMoney").addClass("zf-input-err");                       	
                        $("#decreaseMoney").after("<label id=\"decreaseMoneyErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入扣减金额,如100,必填项</label>");
                    }
                    verify = false;
                } else {
                	$("#decreaseMoney").attr("data-verify", true);
                	$("#decreaseMoney").removeClass("zf-input-err");     
                	$("#decreaseMoneyErr").remove();
                }
                
            } else if(type == 2) {//扣减
            	 var dm = $("#decreaseMoney").val();
            	 if(dm == null || dm == "" || dm == undefined) {
                     if($("#decreaseMoneyErr").length<=0) {
                    	 $("#decreaseMoney").addClass("zf-input-err");  
                         $("#decreaseMoney").after("<label id=\"decreaseMoneyErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入扣减金额,如100,必填项</label>");
                     }
                     verify = false;
                 } else {
                	 $("#decreaseMoney").attr("data-verify", true);
                	 $("#decreaseMoney").removeClass("zf-input-err"); 
                	 $("#decreaseMoneyErr").remove();
                 }
            	    
            } else if(type == 3) {//折扣
                var ds = $("#discountScale").val();
                var dmm = $("#discountMoneyMax").val();
                
                if(ds == null || ds == "" || ds == undefined) {
                    if($("#discountScaleErr").length<=0) {
                    	$("#discountScale").addClass("zf-input-err");                	
                        $("#discountScale").after("<label id=\"discountScaleErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入打折比例,支持两位小数,比如0.88,必填项</label>");
                    }
                    verify = false;
                } else {
                	$("#discountScale").attr("data-verify", true);
                	$("#discountScale").removeClass("zf-input-err"); 
                	$("#discountScaleErr").remove();
                }
                
                if(dmm == null || dmm == "" || dmm == undefined) {
                    if($("#discountMoneyMaxErr").length<=0) {
                    	$("#discountMoneyMax").addClass("zf-input-err");   
                        $("#discountMoneyMax").after("<label id=\"discountMoneyMaxErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入最大折扣金额,如500, 必填项</label>");
                    }
                    verify = false;
                } else {
                	$("#discountMoneyMax").attr("data-verify", true);
                	$("#discountMoneyMax").removeClass("zf-input-err");   
                	$("#discountMoneyMaxErr").remove();
                }
            } 
            
            var intro = $("#introduction").val();
            if(intro == null || intro == "" || intro == undefined || intro == "请输入优惠券介绍，必填项") {
                if($("#introductionErr").length<=0) {
                    $("#introduction").addClass("zf-input-err");   
                    $("#introduction").after("<label id=\"introductionErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请输入优惠券介绍,必填项</label>");
                }
                verify = false;
            } else {
                $("#introduction").attr("data-verify", true);
                $("#introduction").removeClass("zf-input-err");   
                $("#introductionErr").remove();
            } 
            
            return verify;
        }
    </script>
    
</body>
</html>