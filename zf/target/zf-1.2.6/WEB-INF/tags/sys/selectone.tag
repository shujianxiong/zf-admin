<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域值（ID）"%>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称（Name）"%>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值（Name）"%>
<%@ attribute name="tip" type="java.lang.String" required="false" description="输入框值提示语"%>
<%@ attribute name="title" type="java.lang.String" required="false" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="iframe加载的地址"%>
<%@ attribute name="isReadOnly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="width" type="java.lang.String" required="true" description="弹出框的宽度"%>
<%@ attribute name="height" type="java.lang.String" required="true" description="弹出框的高度"%>

<div id="${id }selectone" class="form-group">
  	<label for="Id" class="col-sm-2 control-label">${labelName}</label>
  	<div class="col-sm-10">
  		<input id="${id}Id" name="${name}" class="${cssClass}" type="hidden" value="${value}"/>
  		<input id="${id}Name" readonly="readonly"value="${value}" class="form-control"  placeholder="${tip }" />
    	<div class="modal fade" id="${id}NoPermissionModal">
		    <div class="modal-dialog" >
		        <div class="modal-content">
		          <div class="modal-header">
		            <button type="button" class="close"
		               data-dismiss="modal" aria-hidden="true">
		                  &times;
		            </button>
		            <h4 class="modal-title" id="myModalLabel"> ${title}</h4>
		         </div>
		            <div class="modal-body">
		                <iframe id="${id}NoPermissioniframe" src="${url}" width="100%" height="100%" frameborder="0" >
		                	
		                </iframe>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default " onclick="javascript:findiframe${id}();" data-dismiss="modal">    提交    </button>
		                <button type="button" class="btn btn-default " data-dismiss="modal">    关  闭    </button>
          			</div>
		        </div>
		    </div>
		</div>
  	</div>
</div>

<script type="text/javascript">
$(function(){
	$("#${id}Name").on("click",function(){
        $('#${id}NoPermissionModal').modal({ show: true,backdrop:'static'});
        $('#${id}NoPermissionModal .modal-dialog').css({"width":"${width}px","height":"${height}px"});
        $('#${id}NoPermissionModal .modal-dialog').find('.modal-content').css({height: '100%',width: '100%'});
        $('#${id}NoPermissionModal .modal-dialog').find('.modal-body').css({height:'75%'});
	});
});

/**
 *  该方法可以在 iframe 页面直接调用  
 * 如果是单选 则调用此方法
 * 给隐藏标签赋值
 */
function selectOption(label, val){
	$("#${id}Id").val(val);
	$("#${id}Name").val(label);
}

/**
 * 判断选择的checkbox  当有一个被被选中时 终止检测 
 */
function findiframe${id}(){
	var content = $("iframe","#${id}NoPermissionModal").contents().find("body")[0];
	$("input[type=checkBox]", content).each(function(){
		if($(this).attr("checked")=="checked"){
			$("${id}Id").val($(this).val());
			$("#${id}Name").val($(this).attr("showlable"));
			return false;
		}
	});
}
</script>