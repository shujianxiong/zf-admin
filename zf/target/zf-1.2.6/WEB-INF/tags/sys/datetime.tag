<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="inputId" type="java.lang.String" required="true" description="输入框编号"%>
<%@ attribute name="inputName" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.util.Date" required="false" description="输入框值"%>
<%@ attribute name="tip" type="java.lang.String" required="true" description="输入框提示值"%>
<%@ attribute name="format" type="java.lang.String" required="false" description="输入框提示值"%>
<%@ attribute name="isMandatory" type="java.lang.String" required="false" description="是否必录项"%>
<%@ attribute name="defaultDate" type="java.util.Date" required="false" description="默认时间"%>
<%@ attribute name="minDate" type="java.util.Date" required="false" description="限制从某一天开始，日期可选，小于这个时间，全部禁止" %>
<c:if test="${empty value }">
	<c:set var="value" value=""/>
</c:if>
<c:if test="${empty format }">
	<c:set var="format" value="LTS" />
</c:if>
<c:if test="${empty defaultDate }">
	<c:set var="defaultDate" value="" />
</c:if>
<c:if test="${empty isMandatory }">
	<c:set var="isMandatory" value="false" />
</c:if>
<c:if test="${empty minDate }">
	<c:set var="minDate" value=""/>
</c:if>
	<div class='input-group date' id='${id }'>
          <input type='text' class="form-control" id="${ inputId}" data-verify="${isMandatory?false:true }" data-type="date" name="${ inputName}" value="<fmt:formatDate value="${value}" pattern="yyyy-MM-dd HH:mm:ss"/>"  placeholder="${tip }"/>
          <span class="input-group-addon">
          	<span class="glyphicon glyphicon-calendar"></span>
          </span>
      </div>
	<script type="text/javascript">
          $(function () {
        	  var optionData=new Array();
        	  
        	 var minDate = '${minDate}';
        	  
        	  var options = {
       			  
        	  }
        	  
 			  if(minDate!=null&&minDate!=undefined&&minDate!=""){
	 				 options = {
	       			  locale:'zh-cn',
	        		  format:'${format}',
	        		  defaultDate:'${defaultDate}',
	           		  minDate:'${minDate}'
	        	  }
        	  }else{
        		  options = {
    	       			  locale:'zh-cn',
    	        		  format:'${format}',
    	        		  defaultDate:'${defaultDate}'
        		  }
        	  }
        	  
              $('#${id}').datetimepicker(options);
          	  ZF.formVerify(${isMandatory},99,$("#${ inputId}").val())?$("#${ inputId}").attr("data-verify","true"):$("#${ inputId}").attr("data-verify","false");
          	  
	          	$("#${ id}").on("dp.change",function(){
	        		if(!ZF.formVerify(${isMandatory},99,$("#${ inputId}").val())){
	        			$("#${ inputId}").addClass("zf-input-err")
	        			$("#${ inputId}").attr("data-verify","false");
	        		}else{
        				$("#${ inputId}").removeClass("zf-input-err");
	        			$("#${ inputId}").attr("data-verify","true");
	        		}
	        	});
	          	
          });
      </script>