<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/mobile/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" /><!--viewport网页缩放-->
	<meta charset="utf-8" /><!-- UTF-8编码 -->
	<meta name="keywords" content="珠宝租赁" /><!-- 关键词 -->
	<meta name="format-detection" content="telephone=no" /><!-- 禁用自动识别电话号码 -->
	<meta name="apple-mobile-web-app-capable" content="yes" /><!-- 强制全屏 -->
	<meta name="msapplication-tap-highlight" content="no" /><!-- 禁用点击高光效果 -->
    <title>参与调研</title>
    <link rel="stylesheet" media="screen and (max-width:330px)" href="${ctxMobile}/baseConfig/base320.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:331px) and (max-width:380px)" href="${ctxMobile}/baseConfig/base360.css" type="text/css" />
    <link rel="stylesheet" media="screen and (min-width:381px)" href="${ctxMobile}/baseConfig/base414.css" type="text/css" />
    <link rel="stylesheet/less" href="${ctxMobile}/pages/loginRegist/login.less" />
    <script src="${ctxMobile}/lib/js/less-1.3.3.min.js" type="text/javascript"></script>
    <script src="${ctxMobile}/lib/js/zepto.min.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/lib/js/zfutils.js" type="text/javascript" ></script>
    <script src="${ctxMobile}/pages/activity/activityResearch/arInviteForm.js" type="text/javascript" ></script>
   <style type="text/css">
    	.qsnWarp{
    		height: 150px;
    		width: 100%;
    		margin-top: 20px;
    	}
    	.answer{
    		float:right;
    		margin:5px 10px;
    	}
    </style>
</head>
<body>
	
	
<%-- 	<input type="hidden" id=activityId value="${activityId }"/> --%>
<%-- 	<input type="hidden" id=respondentsId value="${respondentsId.id }"/> --%>
</body>
   
   <script type="text/javascript">
   
   
   var a=${fns:toJson(respondentsId)};
   
   $(function(){
// 	   console.log($.parseJson(a));
	   
	   
	   
   })
   
   
	var activityId = $("#activityId").val();
	var param={"activityId":activityId}
	var url = ctxWeb+"/member/queAndAns";
	console.log(url);
	$.ajax({
	    type: 'POST',
	    url: url,
	    data: param,
	    success: pages,
	    error:function(data){
	    	console.log(data);
	    }
	});
	function pages(data){
		var data=$.parseJSON(data);
    	var quenstionList =data.data.questionnaire.questionnaireQueList;   //问题列表
		var quenstionList=quenstionList.sort(by("levelNum"));//问题排序
		console.log(quenstionList)
    	var RespondentsId =data.data.respondents.id;   //答卷ID
    	var RespondentsAnsList =data.data.respondents.respondentsAnsList;   //答卷列表
		var questionnaireId = data.data.questionnaire.id;   //问卷ID
		for(var i=0;i<quenstionList.length;i++){
			var html=""
			html+="<div class=\"qsnWarp\">";
			html+="<h2>"+quenstionList[i].baseQuestion.name+"</h2>";
			var answerType = quenstionList[i].baseQuestion.answerType;
			var answerList =quenstionList[i].baseQuestion.answerList;  //答案列表
			var quenstionId = quenstionList[i].id;   //问题ID
			if(answerType ==1){ 
				for(var j=0;j<answerList.length;j++){
					var answerId = quenstionList[i].baseQuestion.answerList[j].id;   //答案ID
// 					console.log(answerId)
					if(getRecord(answerId)){
 						console.log("111111111111")
						var ResQid= getRespondentsQid(answerId);
 						console.log(ResQid)
						html+="<div class=\"answer\">"+answerList[j].name+"<input type=\"radio\" name = \""+i+"\" checked=\"checked\" id=\"" +answerList[j].id+"\" onclick=\"postAnswer('"+RespondentsId+"','"+quenstionId+"','"+answerId+"',null,'"+ResQid+"')\"/></div>";
					}else{
// 						console.log("222222222222")
						html+="<div class=\"answer\">"+answerList[j].name+"<input type=\"radio\" name = \""+i+"\" id=\"" +answerList[j].id+"\" onclick=\"postAnswer('"+RespondentsId+"','"+quenstionId+"','"+answerId+"')\"/></div>";
					}
				}
			}else if(answerType ==2){
				for(var j=0;j<answerList.length;j++){
					var answerId = quenstionList[i].baseQuestion.answerList[j].id;   //答案ID
					if(getRecord(answerId)){
						var ResQid= getRespondentsQid(answerId);
						html+="<div class=\"answer\">"+answerList[j].name+"<input type=\"checkbox\" checked=\"checked\" name =\""+answerList[j].name+"\" id=\"" +answerList[j].id+"\" onclick=\"postAnswer('"+RespondentsId+"','"+quenstionId+"','"+answerId+"',null,'"+ResQid+"')\"/></div>";
					}else{
						html+="<div class=\"answer\">"+answerList[j].name+"<input type=\"checkbox\" name =\""+answerList[j].name+"\" id=\"" +answerList[j].id+"\" onclick=\"postAnswer('"+RespondentsId+"','"+quenstionId+"','"+answerId+"')\"/></div>";
					}
				}			}else{ 
				var answerValue =$(this).val();
				html+="<div class=\"answer\">"+ quenstionList[i].baseQuestion.name +"<input type=\"text\" onblur=\"postAnswer('"+RespondentsId+"','"+quenstionId+"',null,this)\"/></div>";
			}
			html+='</div>';
			$("body").append(html)
		}
		//匹配答卷,返回true/false
		function getRecord(anId){
			
			if(typeof(RespondentsAnsList)== "undefined"){
				return false
			}else
				for(var i=0;i<RespondentsAnsList.length;i++){
			    	var RespondentsQid =data.data.respondents.respondentsAnsList[i].id;   //答卷答题ID
	                var RespondentsA =RespondentsAnsList[i].baseAnswer.id          //答卷答案ID
	                if(anId==RespondentsA){
	                	return true
	                }
		  		}
			return false
		}
		//匹配答卷,返回答卷答题ID
		function getRespondentsQid(anId){
			
			if(typeof(RespondentsAnsList)== "undefined"){
				return false
			}else
				for(var i=0;i<RespondentsAnsList.length;i++){
			    	var RespondentsQid =data.data.respondents.respondentsAnsList[i].id;   //答卷答题ID
	                var RespondentsA =RespondentsAnsList[i].baseAnswer.id          //答卷答案ID
	                if(anId==RespondentsA){
	                	return RespondentsQid
	                }
		  		}
		}
		//排序方法
		function by(name) {
			return function(o, p) {
				var a, b;
				if (typeof o === "object" && typeof p === "object" && o && p) {
					a = o[name];
					b = p[name];
					if (a === b) {
						return 0
					}
					if (typeof a === typeof b) {
						return a < b ? -1 : 1
					}
					return typeof a < typeof b ? -1 : 1
				} else {
					throw ("error");
				}
			}
		}
	}
	//发送答题数据
   	function postAnswer(RespondentsId,quenstionId,answerId,answerValue,RespondentsQid){
   		
   		var url = ctxWeb+"/member/respondentsAns";
   		var activityId = $("#activityId").val();
   		
 		var answerValue =$(answerValue).val();
   		var postData={
   				"questionnaireQue.id":quenstionId,//问卷问题ID
   				"id":RespondentsQid,     //答卷答题ID
   				"respondents.id":RespondentsId, //答卷ID
   				"baseAnswer.id":answerId,     //答卷答案ID
   				"answerValue":answerValue,//问卷问题ID
   				"activityId":activityId,   //活动ID
   				"del_Flag":1           //标记
   			}
   		
   		console.log(url);
   		
   		$.ajax({
   		    type: 'POST',
   		    url: url,
   		    data: postData,
   		    success: function(data){
   		    	console.log(data);
   		    },
   		    error:function(data){
   		    	console.log(data);
   		    }
   		});
   		
   	}	
   		
   		
   </script>
   
</html>

