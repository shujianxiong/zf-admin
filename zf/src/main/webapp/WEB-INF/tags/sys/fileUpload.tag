<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="input" type="java.lang.String" required="true" description="标记"%>
<%@ attribute name="model" type="java.lang.String" required="true" description="上传模式：默认 true公开模式适用于APP类资源文件，false隐藏模式适用于业务类资源文件比如合同、往来附件等"%>
<%@ attribute name="fileDirCode" type="java.lang.String" required="false" description="上传目录编码，只支持隐藏模式"%>
<%@ attribute name="selectMultiple" type="java.lang.Boolean" required="false" description="是否允许多选"%>
<c:if test="${empty model}">
	<c:set var="model" value="true"/>
</c:if>
<c:choose>
	<c:when test="${model }">
		<c:set var="width" value="8"/>
	</c:when>
	<c:otherwise>
		<c:set var="width" value="12"/>
	</c:otherwise>
</c:choose>

<ol id="${input}Preview"  class="nav nav-tabs"></ol>
<a href="javascript:void" onclick="${input}FinderOpen();" class="btn">选择</a>&nbsp;<a href="javascript:" onclick="${input}clear();" class="btn">清除</a>

<div id="${input }Modal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="上传文件" aria-hidden="true">
	   <div class="modal-dialog" style="width:90%;height:100%;" >
	      <div class="modal-content" style="width:100%;height:100%;">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                  <span aria-hidden="true">&times;</span></button>
	            <h4 class="modal-title">上传文件</h4>
	         </div>
	         <div class="modal-body" style="width:100%;height:80%;">
	            <iframe id="${input }ModalIframe" src="" width="100%" height="100%" frameborder="0"></iframe>
	         </div>
	         <div class="modal-footer">
	            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	            <button type="button" class="btn btn-primary" id="${input }commitBtn">提交更改</button>
	         </div>
	      </div><!-- /.modal-content -->
	    </div><!-- /.modal -->
</div>

<script type="text/javascript">	

	function ${input}FinderOpen(){
		
		$(".modal-title").text("上传文件");
		
		$("#${input }commitBtn").unbind("click");
		$("#${input }commitBtn").on("click",function () {
			var content;
			var model = ${model};
			if(model) {
				content = $("#${input }ModalIframe").contents().find("#fileContent").contents().find("body");
			} else {
				content = $("#${input }ModalIframe").contents().find("body");	
			}
			var selectFiles=$("input[type=checkBox]:checked", content);
			console.log("选择文件个数"+selectFiles.length);
			var files=[];
			for(var i=0;i<selectFiles.length;i++){
				var entity={};
				entity.name=$(selectFiles[i]).attr("data-fileName");
				entity.url=$(selectFiles[i]).attr("data-fileUrl");
				entity.type=$(selectFiles[i]).attr("data-fileType");
				files.push(entity);
			}
            var urls = $("#${input}").val();
            if(urls.length == 0){
                urls="";
			}else{
                urls=urls+"|";
			}
			${input}Preview(files,urls);
			$("#${input }Modal").modal('hide');
		});
		$("#${input }Modal").modal('toggle');
	}	
	
	function ${input}Del(obj){
		var url = $(obj).prev().attr("url");
		var index=$(obj).prev().attr("data-index");
		var urls=$("#${input}").val();
		var files=urls.split("|");
		files.splice(index,1);
		urls="";
		for(var i=0;i<files.length;i++){
			if(files[i]==null||files[i].length<=0)
				continue;
			if(i==files.length-1)
				urls=urls+files[i];
			else
				urls=urls+files[i]+"|";
		}
		$("#${input}").val(urls);
		$(obj).parent().remove();
	}	
	
	function ${input}init(){
		var url="${ctx}/bas/fileLibrary/uploadViewIndex?selectMultiple=${selectMultiple}";
		if(!${model })
			url="${ctx}/bas/fileLibrary/hideUploadView?selectMultiple=${selectMultiple}&fileDirCode=${fileDirCode}";
        //modal show时触发
		$("#${input}Modal").on("show.bs.modal",function () {
			$("#${input }ModalIframe").attr("src",url);
		});
        
		$("#${input}Modal").on("hide.bs.modal",function(){
			$("#${input}ModalIframe").attr("src","");
		});
		
		var urls=$("#${input}").val();
		if(urls=="")
			return;
		urls=urls.split("|");
		 console.log("上次文件个数"+urls.length);
		var files=[];
		for(var i=0;i<urls.length;i++){
			if(urls[i] != null && urls[i] != "" && urls[i] != undefined) {
				var data='{"url":"'+urls[i]+'"}';
                $.ajax({
                    type: "post",
                    url: "${ctx}/bas/fileLibrary/fileInfo",
                    cache:false,
                    async:false,
                    dataType:"json",
					data: $.parseJSON(data),
                    success: function(data){
                        /* console.log(data); */
                        if(data.status==1){
                            var entity={};
                            entity.name=data.data.name;
                            entity.url=data.data.fileUrl;
                            entity.type=data.data.type;
                            files.push(entity);
                            if(files.length==urls.length){
                                ${input}Preview(files,"");
                            }
                        }
                    },
                    error:function(data){
                        console.log("fileUpload.tag 获取文件信息失败");
                    }

                });

				<%--ZF.ajaxQuery(false,"${ctx}/bas/fileLibrary/fileInfo",$.parseJSON(data),function(data){--%>
					<%--/* console.log(data); */--%>
					<%--if(data.status==1){--%>
						<%--var entity={};--%>
						<%--entity.name=data.data.name;--%>
						<%--entity.url=data.data.fileUrl;--%>
						<%--entity.type=data.data.type;--%>
						<%--files.push(entity);--%>
						<%--if(files.length==urls.length){--%>
							<%--${input}Preview(files,"");--%>
						<%--}--%>
					<%--}--%>
				<%--},function(){--%>
					<%--console.log("fileUpload.tag 获取文件信息失败");--%>
				<%--});--%>
			}
		}
	}	
	
	function ${input}Preview(files,urls){
        console.log("文件个数"+files.length);
		for(var i=0;i<files.length;i++){
			if(files[i]==null||files[i].length<=0)
				continue;
			var li;
			if(files[i].type=="1"){
				li = "<li class=\"zf-img-list\"><img src=\""+imgHost+files[i].url+"\" url=\""+files[i].url+"\" data-index=\""+i+"\" style=\"max-width:100px;max-height:100px;border:0;padding:3px;\"><a href=\"javascript:\" onclick=\"${input}Del(this);\">×"+files[i].name+"</a></li>";
			}else{
				li = "<li class=\"zf-img-list\"><img src=\"${ctxStatic }/adminLte/plugins/swfupload/file.png\" url=\""+files[i].url+"\" data-index=\""+i+"\" style=\"max-width:100px;max-height:100px;border:0;padding:3px;\"><a href=\"javascript:\" onclick=\"${input}Del(this);\">×"+files[i].name+"</a></li>";
			}
			if("${selectMultiple}" == "true") {
				$("#${input}Preview").append(li);
			} else {
				$("#${input}Preview").html(li);
			}
			if(i==files.length-1)
				urls=urls+files[i].url;
			else
				urls=urls+files[i].url+"|";
		}
		$("#${input}").val(urls);
	}	
	
	function ${input}clear(){
		$("#${input}Preview").html("");
		$("#${input}").val("");
	}	
	
    ${input}init();
	
</script>