<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="输入框ID"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框NAME"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="输入框值"%>
<%@ attribute name="dictName" type="java.lang.String" required="true" description="输入框值"%>
<%@ attribute name="verifyType" type="java.lang.String" required="true" description="验证类型"%>
<%@ attribute name="tip" type="java.lang.String" required="true" description="输入框提示文本"%>
<%@ attribute name="isMandatory" type="java.lang.String" required="false" description="是否必填"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>

<c:if test="${empty verifyType}">
	<c:set var="verifyType" value="-1"/>
</c:if>
<c:if test="${empty isMandatory}">
	<c:set var="isMandatory" value="true"/>
</c:if>
<c:if test="${empty readonly}">
    <c:set var="readonly" value="false"/>
</c:if>
<c:if test="${empty disabled}">
    <c:set var="disabled" value="false"/>
</c:if>

<form:select id="${id }" path="${name }" data-verify="false" htmlEscape="false" maxlength="50" class="form-control select2" disabled="${disabled }">
	<form:option value="" label="请选择"/>
	<form:options items="${fns:getDictList(dictName)}" itemLabel="label" itemValue="value" htmlEscape="false"/>
</form:select>

<!-- 
verifyType 说明如为-1则不验证
0 非空验证
1 手机号验证
2 身份证验证
3 邮箱验证
4 整数验证
5 浮点数验证
 -->
<script type="text/javascript">
$(function(){
	ZF.formVerify(${isMandatory},"${verifyType}",$("#${id}").val())?$("#${id}").attr("data-verify","true"):$("#${id}").attr("data-verify","false");
	$("#${id}").on("change",function(){
		if(!ZF.formVerify(${isMandatory},"${verifyType}",$(this).val())){
			$("span[role=combobox]",$(this).next()).addClass("zf-input-err")
			if($("#${id}Err").length<=0)
				$(this).next().after("<label id=\"${id }Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>${tip}</label>")
			$(this).attr("data-verify","false");
		}else{
			if($("#${id}Err").length>0){
				$("span[role=combobox]",$(this).next()).removeClass("zf-input-err");
				$("#${id}Err").remove();
			}
			$(this).attr("data-verify","true");
		}
	})
	
})
</script>