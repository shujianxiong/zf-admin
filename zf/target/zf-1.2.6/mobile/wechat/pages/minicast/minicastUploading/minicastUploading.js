
var error= "";

$(function(){
	error = $("#error").val();
	if(error != null && error != ''){
		tip.autoShow(error);
	}
	//初始化商品列表图片高度
	$("img[data-height=false]").each(function(){
		console.log("-");
		$(this).height($(this).width())
		$(this).attr("data-height","true")
	})

	$("span", ".tab").each(function(){
		$(this).on('click',function(){
			$("span", ".tab").removeClass("active");
			$(this).toggleClass("active");
		});
	});
	
	$("#saveMinicast").on('click',function(){
		if($(this).attr("is_click") =="1"){
			return false;
		}
		$(this).attr("is_click","1");
		$("#minicastForm").html("");
		var tag = getTag();
		var content = $("#content").val();
		if(!validateFrom(tag, content)){
			$(this).attr("is_click","0");
			return false;
		}
		$("li","#goodsContent").each(function(i){
			$("#minicastForm").append("<input type='hidden' name='goods"+(i+1)+".id' value='"+$(this).attr("g_id")+"'/>");
		});
		var type = $("#hiddenMinicastGoodsSource").val();
		$("#minicastForm").append("<input type='hidden' name='minicastGoodsSource' value='"+type+"'/>");
		$("#minicastForm").append("<input type='hidden' name='content' value='"+content+"'/>");
		$("#minicastForm").append("<input type='hidden' name='tag' value='"+tag+"'/>");
		//获得选择图片
		$("span","#addImg").each(function(i){
			if(i==0){
				return;
			}
			var imgStr = $("input[name='minicastFileText']",this).val();
			$("#minicastForm").append("<input type='hidden' name='photoStr["+(i-1)+"]' value='"+imgStr+"'/>");
		})
		if(type == '' || type ==null || type =='undefind'){
			tip.autoShow("选择的商品是非法的;建议刷新商品选择页,重新选择");
			$(this).attr("is_click","0");
			return false;
		}
		$("#minicastForm").submit();
	});
})

// 小咖秀表单验证
function validateFrom(tag, content){
	if(tag==null||tag ==''){
		tip.autoShow("请选择小咖秀标签");
		return false;
	}
	if(content==null||content ==''){
		tip.autoShow("请输入小咖秀内容");
		return false;
	}
	return true;
}
//获取选择的小咖秀标签
function getTag(){
	var tags = "";
	$("span", ".tab").each(function(){
		if($(this).hasClass("active")){
			tags +=$(this).attr("dict-val")+",";
		}
	});
	return tags.substring(0,tags.length-1);
}

$("#minicastFile").localResizeIMG({
    width: 400,
    quality: 0.8,
    success: function (result) {
  	  console.log(result)
  	  var html="<span id='' >";
		  html+="<input type='hidden' name='minicastFileText' value='"+result.clearBase64+"'/>";
		  html+="<img src='"+result.base64+"'/>";
		  html+="</span>";
  	  $("#addImg").append(html);
    }
});