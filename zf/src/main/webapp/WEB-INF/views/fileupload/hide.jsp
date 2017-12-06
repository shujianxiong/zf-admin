<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片素材库</title>
	<meta name="decorator" content="adminLte"/>
	<script src="${ctxStatic }/adminLte/plugins/swfupload/swfupload.js"></script>
	<script src="${ctxStatic }/adminLte/plugins/swfupload/config.js"></script>
	<script type="text/javascript">
	//swfupload文件上传对象
	var swfu=null
	
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
    	return false;
    }
	
	function getNodes(id,data){
		var nodes=[];
		var node=null;
		for(var i=0;i<data.length;i++){
			if(id==data[i].pId){
				node={id:data[i].id,text:data[i].name,nodes:getNodes(data[i].id,data)}
				nodes.push(node);
			}
		}
		if(nodes.length<=0)
			return null;
		return nodes;
	}
	
	//上传成功
	function uploadSuccess(file, serverData){
		try {
			var text=$("#uploadMessage").text();
			if(serverData=="1"){
				text="上传成功";
			}else{
				text=text+"<br/><span style='color:red'>[ "+file.name+" ]上传失败</span>";
			}
			$("#uploadMessage").text(text)
		} catch (ex) {
			this.debug(ex);
		}
	}
	
	//文件加入上传队列,加入一个文件触发一次
	function fileQueued(file){
		var fileNum=parseInt($("#fileNum").attr("data-num"));
		fileNum++;
		$("#fileNum").attr("data-num",fileNum);
		$("#fileNum").text("您当前选择了"+fileNum+"个文件");
		$("#fileList").append('<li id="'+file.id+'">'+file.name+'</li>')
	}
	
	//取消上传
	function cancelUpload(){
		$("#fileNum").attr("data-num","0");
		$("#fileNum").text("您当前选择了0个文件");
		$("li","#fileList").each(function(){
			var fileId=$(this).attr("id");
			swfu.cancelUpload(fileId,false);
		})
		$("#fileList").html("");
	}
	
	//上传进度
	function uploadProgress(file, bytesLoaded) {
		
	}
	
	//上传出错
	function uploadError(file, errorCode, message){
		//特殊情况：临时处理404，上传七牛云可能改变头文件数据，导致flash认为404
		if(message=="404"){
			var text=$("#uploadMessage").text();
			text="上传成功"
			$("#uploadMessage").text(text)
		}else{
			var text=$("#uploadMessage").text();
			text=text+"<br/><span style='color:red'>[ "+file.name+" ]上传错误</span>"
			$("#uploadMessage").text(text)
		}
	}
	
	//确认上传
	function upload(obj){
		if($("li","#fileList").length<=0){
			alert("请选择上传文件.","warning")
			return;
		}	
		obj.disabled = "disabled";
		swfu.addPostParam("fileDirCode",$("#fileDirCode").val());
		swfu.startUpload();	
	}
	
	//上传队列出错
	function fileQueueError(file, errorCode, message) {
		try {
			var errorName = "";
			if (errorCode === SWFUpload.errorCode_QUEUE_LIMIT_EXCEEDED) {
				errorName = "文件上传错误";
			}
			if (errorName !== "") {
				alert(errorName);
				return;
			}
			
			switch (errorCode) {
			case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
				alert("文件大小为0","warning")
				break;
			case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
				alert("文件大小超过限制","warning")
				break;
			case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			default:
				alert(message,"warning")
				break;
			}

		} catch (ex) {
			this.debug(ex);
		}
	}
	
	//所有文件上传完成
	function uploadComplete(file) {
		try {
			if (this.getStats().files_queued > 0) {
				this.startUpload();
			} else {
				var text=$("#uploadMessage").text();
				alert(text,"info",function(){
					$("#uploadMessage").text("");
					$("#uploadSubmitBtn").disabled = "";
					//query page
					searchForm.submit();
				})
			}
		} catch (ex) {
			this.debug(ex);
		}
	}
	
	//选择好文件后提交
	function fileDialogComplete(){
		
	}
	
	$(document).ready(function(){
		$('input[type=checkBox]').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
			radioClass : 'iradio_minimal-blue'
		});
		
		if(!${selectMultiple }){
			$('input[type=checkBox]').on('ifClicked', function(event){
				$("input[type=checkBox]").iCheck('uncheck');
			});
		}
		
		swfu = new SWFUpload({
			upload_url: "${ctx}/bas/fileLibrary/upload",
			use_query_string:true,
			// File Upload Settings
			file_size_limit : "10 MB",	// 文件大小控制
			file_types : "*.*",
			file_types_description : "All Files",
			file_upload_limit : "0",
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : fileDialogComplete,//选择好文件后提交
			file_queued_handler : fileQueued,
			upload_progress_handler : uploadProgress,
			upload_error_handler : uploadError,
			upload_success_handler : uploadSuccess,
			upload_complete_handler : uploadComplete,
			button_placeholder_id : "spanButtonPlaceholder",
			button_width: 90,
			button_height: 30,
			button_text : '选择上传文件',
			button_text_top_padding: 5,
			button_image_url:ctxStatic+"/adminLte/plugins/swfupload/btnbg.png",
			button_text_left_padding: 5,
			button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
			button_cursor: SWFUpload.CURSOR.HAND,
			
			// Flash Settings
			flash_url : ctxStatic+"/adminLte/plugins/swfupload/swfupload.swf",

			custom_settings : {
				upload_target : "divFileProgressContainer"
			},
			// Debug Settings
			debug: false  //是否显示调试窗口
		});
		
	})
	
	function delFile(id){
		confirm("您确认要删除此图片吗?", "info", function() {
			var url=ctx+"/bas/fileLibrary/delFile";
			ZF.ajaxQuery(false,url,$.parseJSON('{"id":"'+id+'"}'),function(data){
				if(data.status!=1){
					alert(data.message,"warning",function(){
						searchForm.submit();
					});
				}else{
					alert("文件删除成功","info",function(){
						searchForm.submit();
					});
				}
				
			},function(){
				alert("文件删除失败","warning");
			});
		}, function() {
            
        });
	}
	
	
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
    <section class="content">
    	<form:form id="searchForm" modelAttribute="fileLibrary" action="${ctx}/bas/fileLibrary/hideUploadView" method="post" >
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="fileDirCode" name="fileDirCode" type="hidden" value="${fileDirCode }" />
		<input name="selectMultiple" type="hidden" value="${selectMultiple }" />
		<div class="row">
			<div class="col-md-12">
				<div class="box box-primary">
					<shiro:hasPermission name="bas:fileUpload">
	                        <div class="box-header with-border">
	                            <label>友情提示：选择上传文件前，请先选择左边要上传的文件目录！</label>
	                        </div>
							<div class="box-herder with-border">
							    &nbsp;
								<button id="spanButtonPlaceholder" type="button" class="btn btn-sm btn-default"></button>
								<button type="button" class="btn btn-sm btn-primary" style="margin-top:-22px" onclick="cancelUpload()"><i class="fa fa-remove">取消已选择</i></button>
								<button id="uploadSubmitBtn" type="button" class="btn btn-sm btn-success" style="margin-top:-22px" onclick="upload(this)"><i class="fa fa-cloud-upload">确认上传</i></button>
								<span id="fileNum" data-num="0" class="label label-primary" style="position:absolute;top:50px; margin-left: 4px;">您当前选择了0个文件</span>
								<ul id="fileList" style="display:none;"></ul>
							</div>
	                </shiro:hasPermission>
					<div class="box-body">
						<ul class="nav nav-tabs">
							<c:forEach items="${page.list }" var="item">
								<li class="zf-img-list">
					 				<div style="position:absolute;bottom:0;width:100%;height:30px;background:rgba(0,0,0,0.3);color:#fff;font-size:9px;">
					 					<div style="cursor:pointer;float:left;line-height:30px;text-align:center;width:100%;">${item.name }</div>
					 				</div>
					 				<shiro:hasPermission name="bas:fileUpload">
					 				    <i class=" fa fa-fw fa-trash-o " title="删除" style="cursor:pointer;position:absolute;top:0;right:0" onclick="delFile('${item.id}')"></i>
					 				</shiro:hasPermission>
					 				<div style="position: absolute;">
					 					<input id="${item.id }checkbox" type="checkbox" data-fileType="${item.type }" data-fileUrl="${item.fileUrl }" data-fileName="${item.name }" value=""/>
					 				</div>
					 				<c:choose>
					 					<c:when test="${item.type eq '1' }">
					 						<img src="${imgHost }${item.fileUrl }" style="cursor:pointer;" width="150"  height="150" />
					 					</c:when>
					 					<c:otherwise>
					 						<img src="${ctxStatic }/adminLte/plugins/swfupload/file.png" style="cursor:pointer;" width="150"  height="150" />
					 					</c:otherwise>
					 				</c:choose>
						 		</li>
							</c:forEach>
					 	</ul>
					</div>
					<div class="box-footer">
			        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
			        </div>
				</div>
			</div>
		</div>
		</form:form>
		<div id="uploadMessage" style="display:none;"></div>
    </section>
    </div>
</body>
</html>