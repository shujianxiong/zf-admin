<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="隐藏域值（ID）"%>
<%@ attribute name="label" type="java.lang.String" required="true" description="label显示名称"%>
<%@ attribute name="labelWidth" type="java.lang.String" required="false" description="label显示宽度"%>
<%@ attribute name="inputWidth" type="java.lang.String" required="false" description="input显示宽度"%>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称（Name）"%>
<%@ attribute name="labelValue" type="java.lang.String" required="false" description="输入框值（Name）"%>
<%@ attribute name="tip" type="java.lang.String" required="true" description="输入框值提示语"%>
<%@ attribute name="title" type="java.lang.String" required="false" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="树结构数据地址"%>
<%@ attribute name="postData" type="java.lang.String" required="false" description="固定请求参数，JSON格式"%>
<%@ attribute name="postParam" type="java.lang.String" required="false" description="动态请求参数，JSON格式"%>
<%@ attribute name="isExpanded" type="java.lang.String" required="false" description="是否展开"%>
<%@ attribute name="isTag" type="java.lang.String" required="false" description="是否支持标签模式"%>
<%@ attribute name="tagName" type="java.lang.String" required="false" description="tag字段名称"%>
<%@ attribute name="isSearch" type="java.lang.String" required="false" description="是否支持搜索"%>
<%@ attribute name="isReadOnly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="isQuery" type="java.lang.String" required="false" description="是否每次展开都query"%>
<%@ attribute name="isMultiselect" type="java.lang.Boolean" required="false" description="是否支持多选"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="当值发生变更时回调，参数为JS方法名"%>
<%@ attribute name="verifyType" type="java.lang.String" required="false" description="验证类型"%>
<%@ attribute name="isDisplay" type="java.lang.String" required="false" description="是否显示"%>
<%@ attribute name="isChildrenSelect" type="java.lang.String" required="false" description="是否选择子元素"%>

<c:if test="${empty verifyType}">
	<c:set var="verifyType" value="false"/>
</c:if>
<c:if test="${empty isMultiselect}">
	<c:set var="isMultiselect" value="false"/>
</c:if>
<c:if test="${empty onchange}">
	<c:set var="onchange" value="null"/>
</c:if>
<c:if test="${empty postData}">
	<c:set var="postData" value="null"/>
</c:if>
<c:if test="${empty postParam}">
	<c:set var="postParam" value="null"/>
</c:if>
<c:if test="${empty labelWidth}">
	<c:set var="labelWidth" value="3"/>
</c:if>
<c:if test="${empty inputWidth}">
	<c:set var="inputWidth" value="7"/>
</c:if>
<c:if test="${empty isQuery}">
	<c:set var="isQuery" value="false"/>
</c:if>
<c:if test="${empty isReadOnly}">
	<c:set var="isReadOnly" value="false"/>
</c:if>
<c:if test="${empty isDisplay}">
	<c:set var="isDisplay" value="true"/>
</c:if>
<c:if test="${empty isChildrenSelect}">
	<c:set var="isChildrenSelect" value="false"/>
</c:if>
   
<div id="${id }treeInput" class="form-group">
  	<label for="${id}Id" class="col-sm-${labelWidth } control-label">${label}</label>
  	<div class="col-sm-${inputWidth }">
  		<div class="input-group">
  			<form:hidden id="${id}Id" path="${name}" value= "${value}"/>
  			<form:input id="${id}Name" path="${labelName }" data-verify="true" readOnly="true" class="form-control zf-input-readonly" value="${labelValue}" placeholder="${tip }"/>
  			<span id="${id}Span" class="input-group-addon" style="cursor:pointer;"><i class="fa fa-search"></i></span>
  		</div>
    	<div id="${id }treeBox" data-type="treeBox" style="position:absolute;top:34px;z-index:10;width:100%;box-sizing: border-box;padding:0 15px;left: 0;display:none">
    		<div id="${id }treeSolid" class="box box-solid" style="border:1px solid #d2d6de">
				<div class="box-header">
			      	<i class="fa fa-search"></i>
			      	<input id="${id}treeSearch" type="text" value="" placeholder="关键字搜索${title }" style="border:none" />
			      	<div class="box-tools pull-right">
			        	<button id="${id}refresh" type="button" class="btn btn-default btn-sm" onclick="return false"><i class="fa fa-refresh"></i></button>
			        	<button id="${id}close" type="button" class="btn btn-default btn-sm"><i class="fa fa-times"></i></button>
			      	</div>
			    </div>
				<div id="${id }treeBody" class="box-body divScroll"><div id="${id }tree"></div></div>
			</div>
		</div>
  	</div>
</div>
<script type="text/javascript">
var ${id}treeView=null;

function ${id}loadTree(){
	//解析POSTDATA，当两个参数同时配置时，优先选择postParam
	var postData=${postData};//固定请求参数  标签使用中格式参考：postName="{name:\"val\"}"
	var postParam=${postParam};//动态请求参数 标签使用中格式参考：postParam="{postName:[\"param1\",\"param2\"],inputId:[\"input1\",\"input2\"]}",postName 请求的参数名，inputName 获取参数值的UI组件ID
	if(postData==null&&postParam!=null){
		console.log(postParam)
		if(postParam.postName==null||postParam.postName.length<=0){
			console.log("树形选择器错误：已配置postParam但未指定postName,postName==null或postName.length<=0")
			return;
		}
		if(postParam.inputId==null||postParam.inputId.length<=0){
			console.log("树形选择器错误：已配置postParam但未指定inputId,inputId==null或inputId.length<=0")
			return;
		}
		if(postParam.inputId.length!==postParam.postName.length){
			console.log("树形选择器错误：已配置postParam但键值对长度不一致,postParam.inputId.length!==postParam.postName.length")
			return;
		}
		var postJson="{";
		for(var i=0;i<postParam.postName.length;i++){
			if(i==postParam.postName.length-1)
				postJson+="\""+postParam.postName[i]+"\":"+"\""+$("#"+postParam.inputId[i]).val()+"\"";
			else
				postJson+="\""+postParam.postName[i]+"\":"+"\""+$("#"+postParam.inputId[i]).val()+"\",";
		}
		postJson+="}";
		postData=jQuery.parseJSON(postJson);//重置postData
	}
	$("#${id}tree").html("<div class=\"overlay\"><i class=\"fa fa-refresh fa-spin\"></i></div>");
	ZF.ajaxQuery(false,"${url}",postData,function(data){
		$("#${id}treeBody").remove();
		$("#${id}treeSolid").append('<div id="${id }treeBody" class="box-body divScroll"><div id="${id }tree"></div></div>')
		var treeData=new Array();
		for(var i=0;i<data.length;i++){
			if(data[i].pId==""||data[i].pId=="0"){
				var node={id:data[i].id,text:data[i].name,nodes:${id}getNodes(data[i].id,data)}
				treeData.push(node);
			}
		}
		var options = {
          bootstrap2: false, 
          showTags: false,
          levels: 5,
          multiSelect:${isMultiselect},
          data: treeData,
          onNodeSelected: function(event, node) {
          	event.stopPropagation();
          	var isChange=false;
          	if($("#${id}Name").val()!=node.text&&${onchange}!=null)
          		isChange=true
          	if(${isMultiselect}){
          		var oldV=$("#${id}Name").val();
          		var newV=(oldV==""?node.text:","+node.text);
          		var oldId=$("#${id}Id").val();
          		var newId=(oldId==""?node.id:","+node.id);
          		//如果需要选中子节点
          		if(${isChildrenSelect}){
          			if(node.state.expanded == true){
              			for(var i=0;i<node.nodes.length;i++){
              				if(oldV.indexOf(node.nodes[i].text)<0){
              					newV+=","+node.nodes[i].text;
                  				newId+=","+node.nodes[i].id;
              				}
              				if(node.nodes[i].state.selected == false){
                  				$('#${id }tree').treeview('selectNode', node.nodes[i].nodeId); //选中子node
              				}
              			}
              		}
          		}
          		if(oldV.indexOf(node.text)<0){
          			$("#${id}Name").val(oldV+""+newV);
          			$("#${id}Id").val(oldId+""+newId);
          		}
          	}else{
          		$("#${id}Id").val(node.id);
              	$("#${id}Name").val(node.text);
              	$("#${id }treeBox").hide();
          	}
          	if(isChange)
          		${onchange}(node);
         	$("#${id}Name").trigger('change');
          },
         onNodeUnselected:function(event, node){
        	 if(${isMultiselect}){
           		var oldV=$("#${id}Name").val();
           		var oldId=$("#${id}Id").val();
           		if(oldV.indexOf(node.text)>0){
           			oldV=oldV.replace(","+node.text,"");
           			oldId=oldId.replace(","+node.id,"");
           		}
           		if(oldV.indexOf(node.text)==0){
           			if(oldV.indexOf(",")>0){
           				oldV=oldV.replace(node.text+",","");
               			oldId=oldId.replace(node.id+",","");
           			}else{
               			oldV=oldV.replace(node.text,"");
               			oldId=oldId.replace(node.id,"");
           			}
           		}
           		oldV.substring(0,2)==","?oldV=oldV.substring(2,oldV.length):oldV;
           		oldId.substring(0,1)==","?oldId=oldId.substring(1,oldId.length):oldId;
           		$("#${id}Name").val(oldV);
           		$("#${id}Id").val(oldId);
           		
           		$("#${id}Name").trigger('change');
           	}
         }
        };
		${id}treeView=$("#${id}tree").treeview(options);
		var inputVal=$("#${id}Name").val();
		if(inputVal!=null&&inputVal.length>0&&!${isQuery}){
			var inputVals=inputVal.split(",");
			for(var i=0;i<inputVals.length;i++){
				var node=${id}treeView.treeview('search', [ inputVals[i], { ignoreCase: false, exactMatch: false } ]);
				${id}treeView.treeview('selectNode', [ node, { silent: true }]);
			}
		}
		//创建滚动域
		var a=ZF.createScroll("${id}tree",$("#${id }tree").height()<300?$("#${id }tree").height():300)
	},function(){
		console.log("inputtree queryData error")
	});
}

function ${id}getNodes(id,data){
	var nodes=[];
	for(var i=0;i<data.length;i++){
		if(id==data[i].pId){
			var node={id:data[i].id,text:data[i].name,nodes:${id}getNodes(data[i].id,data)}
			nodes.push(node);
		}
	}
	if(nodes.length<=0)
		return null;
	return nodes;
}

$(function(){
	
	if(${isReadOnly}){
		return false;
	}
	
	if(${isDisplay}){
		$("#${id }treeInput").css('display','block');
	}else{
		$("#${id }treeInput").css('display','none');
	}
	
	var verifyType=${verifyType};
	if(verifyType!=-1){
		if($("#${id}Name").val()!=null&&$("#${id}Name").val()!=""&&$("#${id}Name").val()!=undefined){
			$("#${id}Name").attr("data-verify","true");
		}else{
			$("#${id}Name").attr("data-verify","false");
		}
		$("#${id}Name").on("change",function(){
			if(!ZF.formVerify(verifyType,99,$(this).val())){
				$(this).addClass("zf-input-err")
				$(this).attr("data-verify","false");
			}else{
				$(this).removeClass("zf-input-err");
				$(this).attr("data-verify","true");
			}
		});
	}
	$("#${id}Span").on("click",function(){
		if($("#${id}treeBox").is(":hidden")){
			$("div[data-type=treeBox]").each(function(){
				$(this).hide();
			})
			$("#${id}treeBox").show();	
		}else{
			$("#${id}treeBox").hide();
			return;
		}
		$("#${id}treeSearch").val("");
		if(${id}treeView==null){
			${id}loadTree();
			return;
		}
		if(${isQuery}){
			${id}loadTree();
		}
			
	})
	$("#${id}refresh").on("click",function(){
 		var isChange=false;
        if($("#${id}Name").val()!=""&&${onchange}!=null)
        	isChange=true
		$("#${id}Id").val("");
      	$("#${id}Name").val("");
		${id}loadTree();
		if(isChange)
      		${onchange}();
	})
	$("#${id}close").on("click",function(){
		$("#${id}treeSearch").val("");
		$("#${id}treeBox").hide();
	})
	//搜索增强
	$("#${id}treeSearch").on("change",function(){
		if(${id}treeView!=null)
			var nodes=${id}treeView.treeview('search', [ $("#${id}treeSearch").val(), { ignoreCase: false, exactMatch: false } ]);
			${id}treeView.treeview('selectNode', [ nodes, { silent: false }]);
	})
})
</script>