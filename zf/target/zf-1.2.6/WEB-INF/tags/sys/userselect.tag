<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="iframe加载的地址"%>
<%@ attribute name="width" type="java.lang.String" required="true" description="弹出框的宽度"%>
<%@ attribute name="height" type="java.lang.String" required="true" description="弹出框的高度"%>
<%@ attribute name="isMulti" type="java.lang.Boolean" required="true" description="是否支持多选"%>
<%@ attribute name="isOffice" type="java.lang.Boolean" required="false" description="是否支持部门"%>
<%@ attribute name="isTopSelectable" type="java.lang.Boolean" required="false" description="是否支持顶级选择"%>
<%@ attribute name="postData" type="java.lang.String" required="false" description="固定请求参数，JSON格式"%>
<%@ attribute name="postParam" type="java.lang.String" required="false" description="动态请求参数，JSON格式"%>
<%@ attribute name="dataType" type="java.lang.String" required="false" description="返回树形数据类型，Company代表公司，Office代表组织， Group代表小组，User代表用户"%>
<c:if test="${empty postData}">
	<c:set var="postData" value="null"/>
</c:if>
<c:if test="${empty postParam}">
	<c:set var="postParam" value="null"/>
</c:if>
<c:if test="${empty isMulti}">
	<c:set var="isMulti" value="false"/>
</c:if>
<c:if test="${empty isOffice}">
	<c:set var="isOffice" value="false"/>
</c:if>
<c:if test="${empty isTopSelectable}">
	<c:set var="isTopSelectable" value="false"/>
</c:if>
<c:if test="${empty dataType }">
	<c:set var="dataType" value="null"/>
</c:if>


<div id="${id }Modal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="${title }" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">${title}</h4>
         </div>
         <div class="modal-body">
         	<input type="hidden" id="${id }ModalUrl" />
            <div id="${id }treeBox">
	    		<div class="box box-solid" >
					<div class="box-header">
				      	<i class="fa fa-search"></i>
				      	<input id="${id}treeSearch" type="text" value="" placeholder="关键字搜索" style="border:none" />
				      	<div class="box-tools pull-right">
				        	<button id="${id}colseBtn" type="button" data-type="1" class="btn btn-sm">收起</button>
				      	</div>
				    </div>
					<div id="${id }tree" class="box-body" style="height:${height-160}px;overflow: auto"></div>
				</div>
			</div>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button id="${id }CommitBtn" type="button" class="btn btn-primary">提交更改</button>
         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

<script type="text/javascript">
	//开放的数据共有对象，当modal初始化显示以后填入对象
	//var iframeBodys=[];
	var ${id}treeView=null;
	var ${id}settings=null;
	function ${id}init(settings){
		if(settings==null){
			console.log("人员选择器：未配置settings")
			return;
		}
		if(settings.selectCallBack==null){
			console.log("人员选择器：未配置settings selectCallBack")
			return;
		}
		${id}settings=settings;
		$('#${id}Modal .modal-dialog').css({"width":"${width}px","height":"${height}px"});
        $('#${id}Modal .modal-dialog').find('.modal-content').css({height: '100%',width: '100%'});
        $('#${id}Modal .modal-dialog').find('.modal-body').css({height:'80%'});
    
        
        var ajaxUrl="${url}";
        var postData=${postData};//固定请求参数  标签使用中格式参考：postName="{name:\"val\"}"
    	var postParam=${postParam};//动态请求参数 标签使用中格式参考：postParam="{postName:[\"param1\",\"param2\"],inputId:[\"input1\",\"input2\"]}",postName 请求的参数名，inputName 获取参数值的UI组件ID
        //modal show时触发
		$("#${id}Modal").on("show.bs.modal",function () {
			//判断请求参数
			if(ajaxUrl==null||ajaxUrl.length<=0){
				ajaxUrl=$("#${id}ModalUrl").val();
			}
			
			if(postData==null&&postParam!=null){
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
			if($("#${id }tree").html()!="")
				return;
			$("#${id}tree").html("<div class=\"overlay\"><i class=\"fa fa-refresh fa-spin\"></i></div>");
			ZF.ajaxQuery(false,ajaxUrl,postData,function(data){
				console.log(data);
				$("#${id}tree").html("");
				var treeData=new Array();
				for(var i=0;i<data.length;i++){
					if(data[i].pId==""||data[i].pId=="1"){
						var node={id:data[i].id,text:data[i].name,nodes:${id}getNodes(data[i].id,data),selected:${isOffice},selectable:${isTopSelectable},type:0}
						treeData.push(node);
					}
				}
				var options = {
		          bootstrap2: false, 
		          showTags: false,
		          levels: 5,
		          showBorder: false,
		          data: treeData,
		          showCheckbox: false,
		          multiSelect: ${isMulti},
		          onNodeChecked: function(event, node) {
		             
	              },
	              onNodeUnchecked: function (event, node) {
               		 
	              },
		          onNodeSelected: function(event, node) {
		          	event.stopPropagation();
		          	
		          }
		        };
				console.log(treeData);
				${id}treeView=$("#${id}tree").treeview(options);
			},function(data){
				console.log(data)
			});
			
		})
		//显示模态框
		$('#${id}Modal').modal('show')
	}
	
	function ${id}getNodes(id,data){
		var nodes=[];
		for(var i=0;i<data.length;i++){
			if(id==data[i].pId){
				var dType = data[i].dataType;
				var paramDataType = "${dataType}";
				if(paramDataType == "Company" && dType == paramDataType) {
					var node={id:data[i].id,text:data[i].name,nodes:${id}getNodes(data[i].id,data),type:0,selectable:true,selected:false}
					nodes.push(node);
				}
				if(paramDataType != "Company") {
					var node={id:data[i].id,text:data[i].name,nodes:${id}getNodes(data[i].id,data),type:0,selectable:${isOffice},selected:false}
					if(dType == "Company") {
						node.selectable = false;
					}
					nodes.push(node);
				}
			}
			if(!${isOffice}){
				if(data[i].id==id&&data[i].users!=null&&data[i].users.length>0){
					for(var j=0;j<data[i].users.length;j++){
						var userNode={id:data[i].users[j].id,text:data[i].users[j].name,nodes:null,type:1}
						nodes.push(userNode);
					}
				}
			}
		}
		if(nodes.length<=0)
			return null;
		return nodes;
	}
	
	
	$(function(){
		
		$("#${id}colseBtn").on("click",function(){
			if($(this).attr("data-type")=="1"){
				$(this).attr("data-type","0")
				$(this).text("展开");
				${id}treeView.treeview('collapseAll', { levels: 1, silent: true});
			}else{
				$(this).attr("data-type","1");
				$(this).text("收起");
				${id}treeView.treeview('expandAll', { levels: 1, silent: true});
			}
		})
		
		$("#${id }CommitBtn").on("click",function(){
			var list=${id}treeView.treeview('getSelected');
			${id}settings.selectCallBack(list);
			$('#${id}Modal').modal('hide')
		})
		
		//搜索增强
		$("#${id}treeSearch").on("change",function(){
			if(${id}treeView!=null)
				var nodes=${id}treeView.treeview('search', [ $("#${id}treeSearch").val(), { ignoreCase: false, exactMatch: false } ]);
				${id}treeView.treeview('selectNode', [ nodes, { silent: false }]);
		})
	})
</script>