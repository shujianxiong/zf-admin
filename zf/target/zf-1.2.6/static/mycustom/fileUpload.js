function fileUpload(model, inputId, selectMultiple, fileDirCode, ctxPath) {
	if(model == null || model == "") {
		model = true;
	}
	var html = "";
	html += "<ol id='"+inputId+"Preview'  class='nav nav-tabs'></ol>";
	html += "<a href='javascript:void' onclick='finderOpen("+model+", \""+inputId+"\", "+selectMultiple+", "+fileDirCode+", \""+ctxPath+"\");' class='btn'>选择</a>&nbsp;<a href='javascript:' onclick='clear("+inputId+");' class='btn'>清除</a>";
	html += "<div id='"+inputId+"Modal' class='modal fade' data-backdrop='false' data-keyboard='false' tabindex='-1' role='dialog' aria-labelledby='上传文件' aria-hidden='true'>";
	html += "<div class='modal-dialog' style='width:1280px;height:800px;' >" +
			"<div class='modal-content' style='width:100%;height:100%;'>" +
			"<div class='modal-header'>" +
			"<button type='button' class='close' data-dismiss='modal' aria-label='Close'>" +
			"<span aria-hidden='true'>&times;</span></button>" +
			"<h4 class='modal-title'>上传文件</h4>" +
			"</div>" +
			"<div class='modal-body' style='width:100%;height:80%;'>" +
			"<iframe id='"+inputId+"ModalIframe' src='' width='100%' height='100%' frameborder='0'></iframe>" +
			"</div>" +
			"<div class='modal-footer'>" +
			"<button type='button' class='btn btn-default' data-dismiss='modal'>关闭</button>" +
			"<button type='button' class='btn btn-primary' id='"+inputId+"commitBtn'>提交更改</button>" +
			"</div>" +
			"</div><!-- /.modal-content -->" +
			"</div><!-- /.modal -->" +
			"</div>";
	
	return html;
}

function finderOpen(model, inputId, selectMultiple, fileDirCode, ctxPath){
	init(model, inputId, selectMultiple, fileDirCode, ctxPath);
	
	$("#"+inputId+"commitBtn").unbind("click");
	$("#"+inputId+"commitBtn").on("click",function () {
		var content = $("#"+inputId+"ModalIframe").contents().find("body");
		var selectFiles=$("input[type=checkBox]:checked", content);
		var files=[];
		for(var i=0;i<selectFiles.length;i++){
			var entity={};
			entity.name=$(selectFiles[i]).attr("data-fileName");
			entity.url=$(selectFiles[i]).attr("data-fileUrl");
			entity.type=$(selectFiles[i]).attr("data-fileType");
			files.push(entity);
		}
		preview(files, inputId);
		$("#"+inputId+"Modal").modal("hide");
	});
	$("#"+inputId+"Modal").modal("toggle");
}	

function del(obj,inputId){
	var url = $(obj).prev().attr("url");
	var index=$(obj).prev().attr("data-index");
	var urls=$("#"+inputId+"").val();
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
	$("#"+inputId+"").val(urls);
	$(obj).parent().remove();
}	

function init(model, inputId, selectMultiple, fileDirCode, ctxPath){
	
	var url= ctxPath+"/bas/fileLibrary/uploadView?selectMultiple="+selectMultiple;
	if(!model)
		url= ctxPath+"/bas/fileLibrary/hideUploadView?selectMultiple="+selectMultiple+"&fileDirCode="+fileDirCode;
    //modal show时触发
	$("#"+inputId+"Modal").on("show.bs.modal",function () {
		$("#"+inputId+"ModalIframe").attr("src",url);
	})
	$("#"+inputId+"Modal").on("hide.bs.modal",function(){
		$("#"+inputId+"ModalIframe").attr("src","");
	});
	var urls=$("#"+inputId+"").val();
	if(urls=="")
		return;
	urls=urls.split("|");
	/* console.log(urls) */
	var files=[];
	for(var i=0;i<urls.length;i++){
		var data='{"url":"'+urls[i]+'"}';
		ZF.ajaxQuery(false, ctxPath+"/bas/fileLibrary/fileInfo",$.parseJSON(data),function(data){
			/* console.log(data) */
			if(data.status==1){
				var entity={};
				entity.name=data.data.name;
				entity.url=data.data.fileUrl;
				entity.type=data.data.type;
				files.push(entity);
				if(files.length==urls.length){
					preview(files, inputId);
				}
			}
		},function(){
			console.log("fileUpload.tag 获取文件信息失败");
		});
	}
}	

function preview(files, inputId){
	var urls="";
	for(var i=0;i<files.length;i++){
		if(files[i]==null||files[i].length<=0)
			continue;
		var li;
		if(files[i].type=="1"){
			li = "<li class=\"zf-img-list\"><img src=\""+imgHost+files[i].url+"\" url=\""+files[i].url+"\" data-index=\""+i+"\" style=\"max-width:100px;max-height:100px;border:0;padding:3px;\"><a href=\"javascript:\" onclick=\"del(this, "+inputId+");\">×"+files[i].name+"</a></li>";
		}else{
			li = "<li class=\"zf-img-list\"><img src=\"${ctxStatic }/adminLte/plugins/swfupload/file.png\" url=\""+files[i].url+"\" data-index=\""+i+"\" style=\"max-width:100px;max-height:100px;border:0;padding:3px;\"><a href=\"javascript:\" onclick=\"del(this, "+inputId+");\">×"+files[i].name+"</a></li>";
		}
		$("#"+inputId+"Preview").append(li);
		if(i==files.length-1)
			urls=urls+files[i].url;
		else
			urls=urls+files[i].url+"|";
	}
	$("#"+inputId+"").val(urls);
}	

function clear(inputId){
	$("#"+inputId+"Preview").html("");
	$("#"+inputId+"").val("");
}	

