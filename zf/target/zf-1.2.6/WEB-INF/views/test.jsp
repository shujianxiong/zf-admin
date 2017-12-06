<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>接口测试</title>
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet" />
<style type="text/css">
	div span{
		display: block;
	}
</style>
<script type="text/javascript">
	$(function(){
		var data = {};
		var type = "";
		$("#sub").click(function(){
			
			var paramter = $("#parm").find("span");
			$(paramter).each(function(i, n){
				var key = $($(this).find("input")[0]).val();
				var value = $($(this).find("input")[1]).val();
				data[key]=value;
			});
			var url = "${ctxWeb}"+$("#url").val();
			$("#methodType").find("input").each(function(){
				if('checked' == $(this).attr("checked")){
					type = $(this).val();
					return;
				}
			});
			
			if('' !=url){
				ajaxRequest(url,type,data);
			}else{
				alert("请求路径不能为空");
			}
		});
		
	});
	
	function rest(){
		$("input[type='text']").val("");
		$("#retjson").val("");
	}
	
	function addParaFnc(){
		var div = $("#parm");
		var span = $("<span></span>")
		 span.append("<input placeholder='参数名' type='text' style='width: 20%; height: 2em;'/>")
		.append("<input placeholder='参数值' type='text' style='width: 20%; height: 2em;'/>")
		.append("<input type='button' value='移除' onclick='javascript:rem(this);' style='width: 5%; height: 2em;'/>");
		div.append(span).trigger("create");
	}

	function ajaxRequest(url, type, data){
		$.ajax({
		   type: type,
		   url: url,
		   data: data,
		   success: successResult,
		   error:errorResult
		});
	}
	function successResult(data){
		console.log(data);
		if('checked' == $("#resultJsonType").attr("checked")){
			$("#retjson").val(format(data, true));
		}else{
			$("#retjson").val(format(data, false));
		}
	}
	
	function errorResult(xhr, type, exception){
			$("#retjson").val(xhr.responseText);
	}
	
	function rem(e){
		$(e).parent().remove();
	}
	
	function format(txt,compress/*是否为压缩模式*/){/* 格式化JSON源码(对象转换为JSON文本) */  
        var indentChar = '    ';   
        if(/^\s*$/.test(txt)){   
            alert('数据为空,无法格式化! ');   
            return;   
        }   
        try{var data=eval('('+txt+')');}   
        catch(e){   
            alert('数据源语法错误,格式化失败! 错误信息: '+e.description,'err');   
            return;   
        };   
        var draw=[],last=false,This=this,line=compress?'':'\n',nodeCount=0,maxDepth=0;   
           
        var notify=function(name,value,isLast,indent/*缩进*/,formObj){   
            nodeCount++;/*节点计数*/  
            for (var i=0,tab='';i<indent;i++ )tab+=indentChar;/* 缩进HTML */  
            tab=compress?'':tab;/*压缩模式忽略缩进*/  
            maxDepth=++indent;/*缩进递增并记录*/  
            if(value&&value.constructor==Array){/*处理数组*/  
                draw.push(tab+(formObj?('"'+name+'":'):'')+'['+line);/*缩进'[' 然后换行*/  
                for (var i=0;i<value.length;i++)   
                    notify(i,value[i],i==value.length-1,indent,false);   
                draw.push(tab+']'+(isLast?line:(','+line)));/*缩进']'换行,若非尾元素则添加逗号*/  
            }else   if(value&&typeof value=='object'){/*处理对象*/  
                    draw.push(tab+(formObj?('"'+name+'":'):'')+'{'+line);/*缩进'{' 然后换行*/  
                    var len=0,i=0;   
                    for(var key in value)len++;   
                    for(var key in value)notify(key,value[key],++i==len,indent,true);   
                    draw.push(tab+'}'+(isLast?line:(','+line)));/*缩进'}'换行,若非尾元素则添加逗号*/  
                }else{   
                        if(typeof value=='string')value='"'+value+'"';   
                        draw.push(tab+(formObj?('"'+name+'":'):'')+value+(isLast?'':',')+line);   
                };   
        };   
        var isLast=true,indent=0;   
        notify('',data,isLast,indent,false);   
        return draw.join('');   
    }  
</script>
</head>
<body>
	<div style="display: none;">
		<a href="${ctxWeb}/category/list">查询分类</a>
		<a href="${ctxWeb}/home/share">分享页面</a>
	</div>
	<div style="border: 1px red solid;">
		<h1 style="color:red;">周范接口测试页</h1>
		<div align="left" style="width: 60%">
			<span>
				<input name="url" type="text" id="url" value="" placeholder="输入测试Url" style="width: 41%; height: 2em;"/>
			</span>
		</div>
		<br>
		<div align="left" id="methodType" style="width: 60%">
			<input type="radio" name="type" checked="checked" id="post" value="POST"/>POST
			<input type="radio" name="type" id="get" value="GET"/>GET 
			<input type="radio" name="type" id="PUT" value="PUT"/>PUT
			<input type="radio" name="type" id="delete" value="DELETE"/>DELETE 
			
		</div>
		<br>
		<div align="left" style="width: 60%" id="parm" id="parm">
			<span>
				<input placeholder="参数名" type="text" value="" style="width: 20%; height: 2em;"/>
				<input placeholder="参数值" type="text" value="" style="width: 20%; height: 2em;"/>
			</span>
		</div>
		<div align="left" style="width: 60%">
			<input type="checkbox" id="resultJsonType" value="true"/>开启json压缩模式
		</div>
		<div align="left" style="width: 61%">
			<span>
				<input type="button" id="sub"  value="提交" style="width: 20%; height: 2em;"/>
				<input type="button" onclick="addParaFnc()" value="添加参数" style="width: 20%; height: 2em;"/>
				<input type="button" onclick="rest()" value="清空" style="width: 10%; height: 2em;"/>
			</span>
		</div>
			<br><br>
		<div align="left" style="width: 61%">
			<span>返回参数</span><br>
			<textarea style="width: 80%; height: 300px;" id="retjson"></textarea>
			<input type="button" onclick="javascript:$('#retjson').val('')" value="清空" style="width: 10%; height: 2em;"/>
		</div>
	</div>
</body>
</html>