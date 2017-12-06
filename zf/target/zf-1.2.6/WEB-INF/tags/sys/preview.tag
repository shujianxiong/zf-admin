<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="预览框标题"%>
<%@ attribute name="content" type="java.lang.String" required="false" description="待显示内容"%>
<%@ attribute name="width" type="java.lang.String" required="true" description="弹出框的宽度"%>
<%@ attribute name="height" type="java.lang.String" required="true" description="弹出框的高度"%>

 
<button id="${id }Button" type="button" class="btn btn-default btn-info" onclick=""><i class="fa"></i>预览</button>
 
<div id="${id }Modal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="${title }" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">${title}</h4>
         </div>
         <div class="modal-body">
            <div id="${id}Content">
                ${content }
            </div>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>


<script type="text/javascript">
var ctxStatic = "${ctxStatic}";
$("#${id }Button").on('click',function(){
	var html = '<div style=""><img src="' + ctxStatic + '/adminLte/dist/img/iphone6s-plus.png" width="100%" height="100%"><div style="position: absolute;height: 68.3%;width: 48%;overflow:hidden;margin:auto;top: 16%;left: 26.2%;"><div id="scrollWapper">'
    html += editor.getData() + '</div></div>';
    
    $("#${id}Content").html(html);
    $("#${id}Modal").modal('toggle');//显示模态框
    
    $('#scrollWapper').slimScroll({
    	height: '100%',
    	width: '100%'
    });
});
</script> 
