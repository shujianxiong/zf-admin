/**输入框检测 star **/
var text="";
function keyCheck(){
	if(formValidate.isNull($("#searchKey"))){
		$(".search_history").css("display","block");
		$(".search_history hot").css("display","block");
		$(".search_autoHint").css("display","none");
	}else if($("#searchKey").val()!=text){
		$(".search_history").css("display","none");
		$(".search_history hot").css("display","none");
		$(".search_autoHint").css("display","block");
		loadSearchPrompt();
		text=$("#searchKey").val();
	}
}
/**输入框检测 end **/

/**
 * 加载自动提示
 */
function loadSearchPrompt(){
	console.log("加载自动提示")
}

/**
 * 加载查询记录
 */
function loadSearchCace(){
	var searchCace=cookieUtil.getCookie("searchCace");
	if(searchCace==null||searchCace==""){
		$("#searchHistoryUl").html("");
		return;
	}
	var searchArray=searchCace.split("-");
	var html=""
	for(var i=0;i<searchArray.length&&i<10;i++){
		if(searchArray[i]==null||searchArray[i]==""||searchArray[i]=="null")
			continue;
		html+="<li data-type=item onclick=setSearchKey(\'"+searchArray[i]+"\')><p>"+searchArray[i]+"</p></li>";
	}
	$("#searchHistoryUl").html(html);
}

/**
 * 保存查询记录
 */
function saveSearchCace(){
	var searchCace=cookieUtil.getCookie("searchCace");
	if(searchCace==null)
		searchCace="";
	var searchArray=searchCace.split("-");
	for(var i=0;i<searchArray.length&&i<10;i++){
		if(searchArray[i]==null||searchArray[i]==""||searchArray[i]=="null")
			continue;
		if($("#searchKey").val()==searchArray[i])
			return;
	}
	var str=$("#searchKey").val()+"-"+searchCace;
	cookieUtil.setCookie("searchCace",str);
} 

/**
 * 表单提交
 */
function formSubmit(){
	if(!formValidate.isNull($("#searchKey"))){
		saveSearchCace();
	}
	return true;
}

/**
 * 设置搜索框内容
 * @param str
 */
function setSearchKey(str){
	$("#searchKey").val(str);
}

/**
 * 初始化
 */
$(function(){
	//加载本地搜索记录
	loadSearchCace();
	
	//输入框检测启用
	$("#searchKey").on("focus",function(){
		var time=setInterval(keyCheck, 500)
		$("#searchKey").on('blur',function(){  
            clearInterval(time);  
        });
	})
	//点击确认搜素
	$("#searchSubmit").on("click",function(){
		if(!formValidate.isNull($("#searchKey"))){
			saveSearchCace();
		}
		document.searchForm.submit();
	})
	//删除查询记录
	$("#delSearchCace").on("click",function(){
		cookieUtil.setCookie("searchCace","");
		loadSearchCace();
	})
})
