<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="输入框ID"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框NAME"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="输入框值"%>
<%@ attribute name="maxlength" type="java.lang.Integer" required="false" description="输入最大长度"%>
<%@ attribute name="isSpring" type="java.lang.String" required="false" description="是否spring input标签"%>
<%@ attribute name="verifyType" type="java.lang.String" required="true" description="验证类型"%>
<%@ attribute name="tip" type="java.lang.String" required="true" description="输入框提示文本"%>
<%@ attribute name="forbidInput" type="java.lang.String" required="false" description="是否禁止输入"%>
<%@ attribute name="isMandatory" type="java.lang.String" required="false" description="是否必填"%>
<%@ attribute name="type" type="java.lang.String" required="false" description="文本框输入类型"%>

<c:if test="${empty verifyType}">
	<c:set var="verifyType" value="-1"/>
</c:if>
<c:if test="${empty isSpring}">
	<c:set var="isSpring" value="false"/>
</c:if>
<c:if test="${empty forbidInput}">
	<c:set var="forbidInput" value="false"/>
</c:if>
<c:choose>
	<c:when test="${empty forbidInput}">
		<c:set var="forbidInput" value="false"/>
	</c:when>
	<c:when test="${ forbidInput == true}">
		<c:set var="classReadonly" value="zf-input-readonly"></c:set>
	</c:when>
</c:choose>

<c:if test="${empty maxlength}">
	<c:set var="maxlength" value="50"/>
</c:if>
<c:if test="${empty isMandatory}">
	<c:set var="isMandatory" value="true"/>
</c:if>
<c:if test="${empty type}">
    <c:set var="type" value="text"/>
</c:if>


<c:choose>
	<c:when test="${isSpring}">
		<form:input id="${ id}" type="${type }" path="${name }" readonly="${forbidInput }" maxlength="${maxlength }" data-verify="false" htmlEscape="false" placeholder="${tip }" class="form-control ${classReadonly}"/>
	</c:when>
	<c:otherwise>
		<input id="${ id}"  type="${type }" name="${name }" ${forbidInput?'readonly="readonly"':''} value="${value }" maxlength="${maxlength }" data-verify="false" placeholder="${tip }" class="form-control ${classReadonly}"/>
	</c:otherwise>
</c:choose>

<!-- 
verifyType
	 * 		0 文本验证(由原来的不验证，现在更改为过滤特殊字符)
	 * 		1 手机号验证
	 * 		2 身份证验证
	 * 		3 邮箱验证
	 * 		4 整数验证
	 * 		5 浮点数验证
	 * 		6 传真
	 * 		7 电话
	 *		8 IP地址
	 *		9 两位小数
	 *		10 四位小数
	 *      11 邮政编码
	 *      12 国际通用手机号码
	 *      99 不验证
 -->
<script type="text/javascript">
$(function(){
	ZF.formVerify(${isMandatory}, "${verifyType}", $("#${id}").val())?$("#${id}").attr("data-verify","true"):$("#${id}").attr("data-verify","false");
	$("#${id}").on("change",function(){
		if(!ZF.formVerify(${isMandatory}, "${verifyType}", $(this).val())){
			$(this).addClass("zf-input-err")
			if($("#${id}Err").length<=0)
				$(this).after("<label id=\"${id }Err\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>${tip}</label>")
			$(this).attr("data-verify","false");
		}else{
			if($("#${id}Err").length>0){
				$(this).removeClass("zf-input-err");
				$("#${id}Err").remove();
			}
			$(this).attr("data-verify","true");
		}
	})
	
})
</script>