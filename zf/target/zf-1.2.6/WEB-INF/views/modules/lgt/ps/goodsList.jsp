<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function addGoodsTags(goodsId,name){
			var url="${ctx}/lgt/ps/tags/tagsSelect?goodsId="+goodsId+"&names="+name;
			$(".modal-title").text("往 "+name+" 添加/移除标签")
			$("#goodsModalUrl").val(url);
			$("#goodsModal").modal('toggle');
			
			$("#goodsModal #commitBtn").unbind("click"); //去掉之前的click事件并重新绑定
			$("#goodsModal #commitBtn").on("click",function(){
	        	var content = $("#goodsModalIframe").contents().find("body");
				var tagIds=new Array; //用于保存关联的商品ID数组
				var postData; //ajax参数
	        	$("input[type=checkBox]", content).each(function(){
					if($(this).prop("checked")){
						tagIds.push($(this).val());
					}
				});
				if(tagIds.length < 1) {
					ZF.showTip("请先向【"+name+"】添加/移除标签", "info");
					return false;
				}
				
				if(tagIds.length > 0){
		        	postData = {"goodsId":goodsId,"tagIds[]":tagIds};
				}else{
					postData = {"goodsId":goodsId};
				}
				
				console.log(postData);
				
	        	ZF.ajaxQuery(true,"${ctx}/lgt/ps/tags/saveGoodsTags",postData,	function(data){
 					ZF.showTip(data,"info");//返回成功提示消息
 					return false;
 				},function(data){
 					console.log(data)
 					ZF.showTip(data,"danger");
 					return false;
 				})
 				$("#goodsModal").modal('toggle');//关闭模态框
			})	
			
		}
		
		function del(url,messsage){
			confirm(messsage,"warning",function(){
				$("#searchForm").attr("action",url);
				$("#searchForm").submit();
			})
		}
		
		//修改
		function edit(url,id){
			$("#searchForm").attr("action",url);
			$("#searchForm").submit();
		}
        //上架修改
        function editNew(url,id){
            $("#searchForm").attr("action",url);
            $("#searchForm").submit();
        }
		//编辑
		function editors(url,id){
			$("#searchForm").attr("action",url);
			$("#searchForm").submit();
		}
		
		function updateStatus(url,messsage){
			confirm(messsage,"info",function(){
				var pageNo = $("#pageNo").val();
				var pageSize = $("#pageSize").val();
				window.location.href = url+"&pageNo="+pageNo+"&pageSize="+pageSize;
			})
			return false;
		}
		
		function addGoods(goodsId,name){
			var url="${ctx}/lgt/ps/goods/relateselect?goodsId="+goodsId;
			$("#goodsModal .modal-title").text("往 "+name+" 添加/移除商品")
			$("#goodsModalUrl").val(url);
			$("#goodsModal").modal('toggle');
			$("#goodsModal #commitBtn").unbind("click"); //去掉之前的click事件并重新绑定
			$("#goodsModal #commitBtn").on("click",function(){
	        	var content = $("#goodsModalIframe").contents().find("body");
				var addIds=new Array; //用于保存关联的商品ID数组
				var postData; //ajax参数
	        	$("input[type=checkBox]", content).each(function(){
					if($(this).prop("checked")){
						addIds.push($(this).attr("data-value"));
					}
				});
				if(addIds.length < 1) {
					ZF.showTip("请先向【"+name+"】添加/移除商品","info");
					return false;
				}
	        	postData = {"goodsId":goodsId,"addIds[]":addIds};
	        	ZF.ajaxQuery(true,"${ctx}/lgt/ps/goods/relateadd",postData,	function(data){
 					ZF.showTip(data,"info");//返回成功提示消息
 					return false;
 				},function(){
 					ZF.showTip(data,"danger");
 					return false;
 				})
 				$("#goodsModal").modal('toggle');//关闭模态框
			})	
			
		}
		
		
		// 新增产品
        function addForm(id){
			var pageNo = $("#pageNo").val();
			var pageSize = $("#pageSize").val();
            var url="${ctx}/lgt/ps/goods/addProduce?goodsId="+id+"&pageNo="+pageNo+"&pageSize="+pageSize;
            $("#searchForm").attr("action",url)
            $("#searchForm").submit();
        }
		
		
		
		//function addChannel(id, name){
		//	var url="${ctx}/idx/channel/select?goodsId="+id;
		//	$("#goodsModal .modal-title").text(name+" 关联频道")
		//	$("#goodsModalUrl").val(url);
		//	$("#goodsModal").modal('toggle');
			
// 			$("#goodsModal #commitBtn").unbind("click"); //去掉之前的click事件并重新绑定
// 			$("#goodsModal #commitBtn").on("click",function(){
// 	        	var content = $("#goodsModalIframe").contents().find("body");
// 				var channelIds=new Array; //用于保存关联的商品ID数组
// 				var postData; //ajax参数
// 	        	$("input[type=checkBox]", content).each(function(){
// 					if($(this).prop("checked")){
// 						channelIds.push($(this).attr("data-value"));
// 					}
// 				});
				
// 				console.log(channelIds);
				
				
// 	        	postData = {"goodsId":id,"channelIds[]":channelIds};
// 	        	ZF.ajaxQuery(true,"${ctx}/lgt/ps/goods/relateadd",postData,	function(data){
//  					ZF.showTip(data,"info");//返回成功提示消息
//  					return false;
//  				},function(){
//  					ZF.showTip(data,"danger");
//  					return false;
//  				})
//  				$("#goodsModal").modal('toggle');//关闭模态框
// 			}	
			
		//}
		
		function goodsView(id, name){
			var url="${ctx}/lgt/ps/goods/goodsView?goodsId="+id;
			$("#goodsModal .modal-title").text(name+" 预览");
			$("#goodsModalUrl").val(url);
			$("#goodsModal").modal('toggle');
		}
		
		function queryCategory(){
			var url="${ctx}/lgt/ps/category/categoryData";
			$("#goodsTree").html("<div class=\"overlay\"><i class=\"fa fa-refresh fa-spin\"></i></div>");
			ZF.ajaxQuery(false,url,null,function(data){
				$("#goodsTree").html("");
				var treeData=new Array();
				for(var i=0;i<data.length;i++){
					if(data[i].pId==""){
						var node={id:data[i].id,text:data[i].name,nodes:getNodes(data[i].id,data)}
						treeData.push(node);
					}
				}
				var options = {
		          bootstrap2: false, 
		          showTags: false,
		          levels: 5,
		          multiSelect:false,
		          data: treeData
		        };
				$("#goodsTree").treeview(options);
				ZF.createScroll("goodsTree",$("#goodsTree").height()<300?$("#goodsTree").height():300)
		  });
	    }
		
		function getNodes(id,data){
			var nodes=[];
			for(var i=0;i<data.length;i++){
				if(id==data[i].pId){
					var node={id:data[i].id,text:data[i].name,nodes:getNodes(data[i].id,data)}
					nodes.push(node);
				}
			}
			if(nodes.length<=0)
				return null;
			return nodes;
		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/goods/list">商品列表</a></small>
	        <shiro:hasPermission name="lgt:ps:goods:edit">
		        <small>|</small>
        	    <small><i class="fa-form-edit"></i><a href="#this" data-toggle="modal" data-target="#addGoodsModal">新增商品</a></small>
        	</shiro:hasPermission>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <form:form id="addForm" modelAttribute="goods" action="${ctx}/lgt/ps/goods/form" method="post" class="form-horizontal" style="display:none;">
			<input id="selectCategoryId" name="category.id" type="hidden" value=""/>
			<input id="selectCategoryName" name="category.categoryName" type="hidden" value=""/>
		</form:form>
	    <section class="content">
	    	<form:form id="searchForm" modelAttribute="goods" action="${ctx}/lgt/ps/goods/list" method="post" class="form-horizontal">
		    	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="box box-info">
					<div class="box-header with-border zf-query">
						<h5>查询条件</h5>
						<div class="box-tools pull-right">
							<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
							<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
						</div>
					</div>
					<div class="box-body">
						<div class="row">
							<!-- <div class="col-md-4">
								<div class="form-group">
									<label for="searchParameterKeyWord" class="col-sm-3 control-label" >关键字</label>
									<div class="col-sm-7">
										<form:input id="searchParameterKeyWord" path="searchParameter.keyWord" htmlEscape="false" maxlength="100" class="form-control" placeholder="请输入商品名称或编码查询"/>
									</div>
								</div>
							</div> -->
							<div class="col-md-4">
								<div class="form-group">
									<label for="searchParameterKeyWord" class="col-sm-3 control-label" >商品编码</label>
									<div class="col-sm-7">
										<form:input id="code" path="code" htmlEscape="false" maxlength="100" class="form-control" placeholder="请输入商品编码"/>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="分类" tip="请选择分类" id="category" labelName="category.categoryName" name="category.id" labelWidth="3" inputWidth="7"></sys:inputtree>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label" >名称</label>
									<div class="col-sm-7">
										<form:input id="name" path="name" htmlEscape="false" maxlength="100" class="form-control" placeholder="请输入商品名称"/>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="searchParameterKeyWord" class="col-sm-3 control-label" >品牌</label>
                                    <div class="col-sm-7">
                                        <form:hidden id="brandId" path="brand.id"/>
                                        <form:input id="brandName" path="brand.name" htmlEscape="false" readonly="true" maxlength="100" class="form-control zf-input-readonly" placeholder="请选择品牌"/>
                                    </div>
                                </div>
                            </div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="status" class="col-sm-3 control-label" >状态</label>
									<div class="col-sm-7">
										<form:select path="status" class="form-control select2">
											<form:option value="" label="所有"/>
											<form:options items="${fns:getDictList('lgt_ps_goods_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							</div>
                            <sys:selectmutil id="designerSelect" title="设置所属设计师" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
                            
                            <sys:selectmutil id="brandSelect" title="设置所属品牌" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="useRange" class="col-sm-3 control-label" >使用范围</label>
                                    <div class="col-sm-7">
                                        <sys:selectverify name="useRange" tip="" verifyType="0" dictName="useRange" id="useRange" isMandatory="false"></sys:selectverify>
                                    </div>
                                </div>
                            </div>
                        </div>
					</div>
					<div class="box-footer">   
						<div class="pull-left box-tools">
	                        <button type="button" class="btn btn-danger btn-sm" onclick="searchHigh();"  data-target="#searchModal"><i class="fa fa-search-plus"></i>高级筛选</button>
	                    </div> 
			        	<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm();resetSearch();"><i class="fa fa-refresh"></i>重置</button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
			        	</div>
		            </div>
				</div>
			
	    	</form:form>
	    	<div class="box box-soild">
				<div class="box-herder with-border">
				
				</div>
				<div class="box-body">
                    <shiro:hasPermission name="lgt:ps:goods:edit">
				        <div class="row">
					        <div class="col-sm-12 pull-right">
					            <button type="button" class="btn btn-sm btn-info" onclick="batchOp(0);"><i class="fa fa-bell">点我批量</i></button>
	                            <button type="button" class="btn btn-sm btn-primary" onclick="batchOp(1);"><i class="fa fa-edit">批量发布</i></button>
	                            <button type="button" class="btn btn-sm btn-success" onclick="batchOp(2);"><i class="fa fa-hand-o-up">批量上架</i></button>
	                            <button type="button" class="btn btn-sm bg-navy" onclick="batchOp(3);"><i class="fa fa-thumbs-down">批量下架</i></button>
	                        </div>
				        </div>
                    </shiro:hasPermission>
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
								    <th id="chkTH" style="display: none;">
								        <div class="zf-check-wrapper-padding">
								            <input id="selAll" type="checkbox" htmlEscape="false" class="minimal" />
								        </div>
								    </th>
									<th class="zf-dataTables-multiline"></th>
									<th>样图</th>
									<th>商品编码</th>
									<th>分类</th>
									<th>名称</th>
									<th>状态</th>
									<th>使用范围</th>
									<th style="display:none;">创建者</th>
									<th style="display:none;">创建时间</th>
									<th style="display:none;">更新者</th>
									<th style="display:none;">更新时间</th>
									<th style="display:none;">备注信息</th>
									<shiro:hasPermission name="lgt:ps:goods:edit"><th>操作</th></shiro:hasPermission>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="goods" varStatus="status">
									<tr  id="tr_${status.index }"  data-index="${status.index }" data-check="false">
									    <td id="chkTH_${status.index }"  style="display: none;">
									       <div class="zf-check-wrapper-padding">
									           <input id="ck_${status.index }" name="gck"  data-index="${status.index }" type="checkbox" value="${goods.id }" htmlEscape="false" class="minimal"/>
									       </div>
									    </td>
										<td class="details-control text-center">
											<i class="fa fa-plus-square-o text-success"></i>
										</td>
										<td>
											<img onerror="imgOnerror(this);" src="${imgHost }${goods.samplePhoto}" data-big data-src="${imgHost }${goods.samplePhoto}" width="20px" height="20px" />
										</td>
										<td>
											${goods.code}
										</td>
										<td>
											${goods.category.categoryName}
										</td>
										<td title="${goods.name }">
											${fns:abbr(goods.name, 50)}
										</td>
										<td>
										    <c:choose>
										        <c:when test="${goods.status=='1'}">
										             <span class="label label-default">${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}</span>
										        </c:when>
										        <c:when test="${goods.status=='2' }">
                                                     <span class="label label-success">${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}</span>
                                                </c:when>
                                                <c:when test="${goods.status=='3' }">
                                                     <span class="label label-primary">${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}</span>
                                                </c:when>
										    </c:choose>
										</td>
                                        <td>
                                            <span class="label label-primary">${fns:getDictLabel(goods.useRange, 'useRange','') }</span>
                                        </td>
										<td data-hide="true">
											${fns:getUserById(goods.createBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${goods.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:getUserById(goods.updateBy.id).name}
										</td>
										<td data-hide="true">
											<fmt:formatDate value="${goods.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td data-hide="true">
											${fns:abbr(goods.remarks,30)}
										</td>
										<shiro:hasPermission name="lgt:ps:goods:edit">
											<td>
												<div class="btn-group zf-tableButton">
<%-- 													<button type="button" class="btn btn-xs btn-info" onclick="goodsView('${goods.id}','${goods.name }')">预览</button> --%>
													<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/goods/info?id=${goods.id}'">详情</button>
													<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
									                   <span class="caret"></span>
									                </button>
									                <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
									                	<c:if test="${goods.status=='1' }">  <!-- 新建 ，发布之后状态变更为下架-->
									                    <li><a href="${ctx}/lgt/ps/goods/updateStatus?goodId=${goods.id }&operationType=1" onclick="return updateStatus(this.href,'确认要发布该商品吗？')" style="color:#fff">发布</a></li>
									                    <li><a href="#this" onclick="edit('${ctx}/lgt/ps/goods/edit?id=${goods.id}')" style="color:#fff">修改</a></li>
									                    <li><a href="#this" onclick="del('${ctx}/lgt/ps/goods/delete?id=${goods.id}','确认要删除该商品吗？提醒：删除商品将影响到与该商品相关的所有数据。')" style="color:#fff">删除</a></li>
									                    <li><a href="#this" onclick="addForm('${goods.id}')" >完善产品规格</a></li>
									                    </c:if>
														<c:if test="${goods.status=='2' }">  <!-- 上架 -->
															<li><a href="#this" onclick="editNew('${ctx}/lgt/ps/goods/editNew?id=${goods.id}')" style="color:#fff">修改</a></li>
															<li><a href="${ctx}/lgt/ps/goods/updateStatus?goodId=${goods.id }&operationType=3" onclick="return updateStatus(this.href,'确认要下架该商品吗？商品下架后对应的产品也将全部下架！')" style="color:#fff">下架</a></li>
														</c:if>
														<c:if test="${goods.status=='3' }">  <!-- 下架 -->
							    						<li><a href="#this" onclick="editors('${ctx}/lgt/ps/goods/editors?id=${goods.id}')" style="color:#fff">修改</a></li><!-- 编辑商品必须为下架状态，编辑只能修改商品部分字段 -->
														<li><a href="${ctx}/lgt/ps/goods/updateStatus?goodId=${goods.id }&operationType=2" onclick="return updateStatus(this.href,'确认要上架该商品吗？商品上架后对应的产品不会自动上架，请至产品管理模块上架需要展示销售的产品！')" style="color:#fff">上架</a></li>
														<li><a href="#this" onclick="addForm('${goods.id}')" >完善产品规格</a></li>
														</c:if>
														<li><a href="${ctx}/lgt/ps/goods/relateReadyList?goodsId=${goods.id}" >关联商品</a></li>
														<%-- <li><a href="#this" onclick="addChannel('${goods.id}','${goods.name}')" style="color:#fff">关联/移除频道</a></li> --%>
														<li><a href="#this" onclick="addGoodsTags('${goods.id}','${goods.name}')" style="color:#fff">添加标签</a></li>
									                </ul>
												</div>
											</td>
										</shiro:hasPermission>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
		        </div>
			</div>
	    </section>
	</div>
	<sys:selectmutil height="600" url="" width="1200" isDisableCommitBtn="true" title="商品编辑" id="goods"></sys:selectmutil>
	
	<div id="addGoodsModal" class="modal fade">
       <div class="modal-dialog">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span></button>
             <h4 class="modal-title">请选择商品将要加入的分类</h4>
           </div>
           <div id="goodsTree" class="modal-body divScroll"></div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
             <button type="button" id="addGoodsCommit" class="btn btn-primary">提交</button>
           </div>
         </div>
       </div>
     </div>
	
	
	<!-- 高级筛选 -->
	<div id="searchModal" class="modal fade">
       <div class="modal-dialog">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span></button>
             <h4 class="modal-title">高级筛选</h4>
           </div>
           <div id="paramDiv" class="modal-body divScroll">
             <table id="contentTable" class="table table-bordered table-hover table-striped">
                <thead>
                    <tr>
                        <th class="text-center">属性名</th>
                        <th class="text-center">属性值</th>
                    </tr>
                </thead>
                <tbody id="propvalueListTbody">
                    
                </tbody>
             </table>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
             <button type="button" id="searchCommitBtn" class="btn btn-primary" onclick="searchCommit()">提交</button>
           </div>
         </div>
       </div>
     </div>
	
	<script type="text/javascript">
	$(function () {
		
		ZF.bigImg();
		
		$('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
		
		 //表格初始化
	 	var t=ZF.parseTable("#contentTable",{
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,//关闭搜索
			//"order": [[ 11, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},	//第0列不排序
				{"orderable":false,targets:1},	
				{"orderable":false,targets:2},	
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:5},
				{"orderable":false,targets:6},
			    {"orderable":false,targets:7},
				{"orderable":false,targets:8},
				{"orderable":false,targets:9},
			    {"orderable":false,targets:10},
			    {"orderable":false,targets:12},
				{"orderable":false,targets:13}
            ],
			"ordering" : true,//开启排序
			"info" : false,
			"autoWidth" : false,
			"multiline":true,//是否开启多行表格
			"isRowSelect":true,//是否开启行选中
			"rowSelect":function(tr){},//行选中回调
			"rowSelectCancel":function(tr){}//行取消选中回调
		});
		 
		$("#addGoodsModal").on("shown.bs.modal",function () {
			if($("#goodsTree").html().trim()==""){
				queryCategory();
			}
		})
		
		$("#addGoodsCommit").on("click",function(){
			if(goodsTree==null){
				ZF.showTip("请选择分类","info")
				return;
			}
			var nodes=$("#goodsTree").treeview('getSelected');
			if(nodes.length<=0){
				ZF.showTip("请选择分类","info")
				return;
			}
			$("#selectCategoryId").val(nodes[0].id);
			$("#selectCategoryName").val(nodes[0].text);
			$("#addForm").submit();
		})
		
		//-----------设置品牌条件 
		//带参数请求URL设置方式
		$("#brandName").on("click", function() {
			$("#brandSelectModalUrl").val("${ctx}/lgt/bs/brand/select");
	        $("#brandSelectModal").modal('toggle');//显示模态框
		});
		
		// Modal<iframe>回调事件,获取弹出框选择的货品信息
        $("#brandSelectModal #commitBtn").on("click",function () {
            $("#brandSelectModal").modal("hide");       
            var content = $("#brandSelectModalIframe").contents().find("body");
            var ids = new Array();
            var names = new Array();
            $("input[type=radio]", content).each(function(){
                if($(this).prop("checked")){
                    //重新选择产品清空原来数据
                    var checkVal = $(this).attr("data-value");                    
                    var vals = checkVal.split("=");
                    ids.push(vals[0]);
                    names.push(vals[1]);
                }
            });
            $("#brandId").val(ids.join(","));
            $("#brandName").val(names.join(","));
        });
		//----------设置设计师条件 
		$("#designerName").on("click", function() {
			 $("#designerSelectModalUrl").val("${ctx}/lgt/bs/designer/select");
		     $("#designerSelectModal").modal('toggle');//显示模态框
        });
        
        // Modal<iframe>回调事件,获取弹出框选择的货品信息
        $("#designerSelectModal #commitBtn").on("click",function () {
            $("#designerSelectModal").modal("hide");       
            var content = $("#designerSelectModalIframe").contents().find("body");
            var ids = new Array();
            var names = new Array();
            $("input[type=radio]", content).each(function(){
                if($(this).prop("checked")){
                    //重新选择产品清空原来数据
                    var checkVal = $(this).attr("data-value");                    
                    var vals = checkVal.split("=");
                    ids.push(vals[0]);
                    names.push(vals[1]);
                }
            });
            $("#designerId").val(ids.join(","));
            $("#designerName").val(names.join(","));
        });
        
        
        //批量  全选
        $("#selAll").on("ifChecked", function() {
       		 $("input[id^=ck_]").each(function() {
       			 $(this).iCheck('check');
       		 });
        }).on("ifUnchecked", function() {
        	$("input[id^=ck_]").each(function() {
        		$(this).iCheck('uncheck');
            });
        });
        
        
        $("input[name=gck]").on("ifUnchecked", function() {
            $(this).iCheck('uncheck');
            var index = $(this).attr("data-index");
            $("#tr_"+index).attr("data-check", false);
            var allChk = $("tr[data-check=true]").length;
            if(allChk == 0) {
                $("#selAll").iCheck("uncheck");
            }
        }).on("ifChecked", function() {
            var index = $(this).attr("data-index");
            $("#tr_"+index).attr("data-check", true);
            var allChk = $("tr[data-check=false]").length;
            if(allChk == 0) {
                $("#selAll").iCheck("check");
            }
        });
        
        
	});
	
	function createRow(data){
        var temp="<tr><td><p class=\"text-center\">$propertyName</p></td>"+
        "<td>$select</td></tr>";
        for(var i=0;i<data.length;i++){
            if(data[i].valueType != "3") {
	            var tempHtml="";
	            tempHtml=temp.replace("$propertyName",data[i].propName).replace("$select",getSelect(data[i].valueType,data[i].propvalueList))
	            $("#propvalueListTbody").append(tempHtml);
            }
        }
        $("select[name=valSelect]").select2();
    }
    
    function getSelect(type,valData){
        /* if(type=="0"){//文本框目前不显示
            return "<input data-type="+type+" name=\"valInput\" type=\"text\" class=\"form-control\" />";
        } */
        var tempHtml="";
        //单选
        /*if(type=="1"){
            tempHtml="<select data-type="+type+" name=\"valSelect\" class=\"select2\">$select</select>";
        }
        //多选
        if(type=="2"){
            tempHtml="<select data-type="+type+" name=\"valSelect\" multiple class=\"multiSelect\">$select</select>";
        }*/
        tempHtml="<select data-type="+type+" name=\"valSelect\" class=\"select2\">$select</select>";
        var options="<option></option>";
        for(var i=0;i<valData.length;i++){
            options+="<option value="+valData[i].id+" >"+valData[i].pvalueName+"</option>"
        }
        return tempHtml.replace("$select",options);
    }
	
    function resetSearch(){
        $("#propvalueListTbody").html("")
        $("input[data-name=propHidden]").remove();//清空所有的预表单项
    }
    
    function searchCommit(){
        $("input[data-name=propHidden]").remove();//清空所有的预表单项
        var vals=$("[name=valSelect]");
        var valInput=$("[name=valInput]");
        var form=$("#searchForm");
        var temp="<input data-name=\"propHidden\" type=\"hidden\" name=\"$postname\" value=\"$val\" />"
        var idx=0;
        for(var i=0;i<vals.length;i++){
            var val=$(vals[i]).val();
            if(val==null||val.length<=0)
                continue;
            if(val instanceof Array){
                for(var j=0;j<val.length;j++){
                    form.append(temp.replace("$postname","goodsProp["+idx+"].goodsPropvalue[0].propvalue.id").replace("$val",val[j]))
                    form.append(temp.replace("$postname","goodsProp["+idx+"].property.valueType").replace("$val","2"))
                    idx++;
                }
            }else{
                form.append(temp.replace("$postname","goodsProp["+idx+"].goodsPropvalue[0].propvalue.id").replace("$val",val))
                form.append(temp.replace("$postname","goodsProp["+idx+"].property.valueType").replace("$val","1"))
                idx++;
            }
        }
        for(var i=0;i<valInput.length;i++){
            var val=$(valInput[i]).val();
            if(val==null||val.length<=0)
                continue;
            form.append(temp.replace("$postname","goodsProp["+idx+"].goodsPropvalue[0].propvalue.id").replace("$val",val));
            form.append(temp.replace("$postname","goodsProp["+idx+"].property.valueType").replace("$val","3"))
            idx++;
        }
        $("#searchModal").modal('hide');
    }
    
    
    function searchHigh() {
    	var cid = $("#categoryId").val();
        if(cid == null || cid == "" || cid == undefined) {
            ZF.showTip("请先选择商品分类!", "info");
            return false;
        }
        
        //高级筛选
        $("#propvalueListTbody").html("");
        $("#propvalueListTbody").html("<div class=\"overlay\"><i class=\"fa fa-refresh fa-spin\"></i></div>");
        ZF.ajaxQuery(true,"${ctx}/lgt/ps/property/findPropertyData",$.parseJSON('{"category.id":"'+cid+'"}'),function(data){
            $("#propvalueListTbody").html("");
            createRow(data);
            ZF.createScroll("paramDiv",500)
        })
        
        $("#searchModal .modal-title").text("高级筛选");
        $("#searchModal").modal('show');
    }
    
    
    function batchOp(type) {
    	if(type == 0) {//点我批量
    	    $("#chkTH").toggle();
    	    $("#chkTH").iCheck("uncheck");
    		$("td[id^=chkTH]").each(function() {
    			$(this).toggle();
    			$(this).iCheck("uncheck");
    		});
    	} else if(type == 1) {//批量发布
    		var idsArr = new Array();
    		$("input[id^=ck_]").each(function() {
    			if($(this).prop("checked")) {
                    idsArr.push($(this).val());   
                }	
    		});
    		if(idsArr.length == 0) {
    			ZF.showTip("请先勾选要批量发布的商品记录!", "info");
    			return false;
    		}
    		console.log(idsArr.length);
    		confirm("确定批量提交?","info",function(){
                var pageNo = $("#pageNo").val();
                var pageSize = $("#pageSize").val();
                var url = "${ctx}/lgt/ps/goods/batchOp?idsArr="+idsArr.join(',')+"&operationType=1"+"&pageNo="+pageNo+"&pageSize="+pageSize;
                window.location.href = url;
            })
            return false;
    	} else if(type == 2) {//批量上架
    		var idsArr = new Array();
            $("input[id^=ck_]").each(function() {
            	if($(this).prop("checked")) {
                    idsArr.push($(this).val());   
                }
            });
            if(idsArr.length == 0) {
                ZF.showTip("请先勾选要批量上架的商品记录!", "info");
                return false;
            }
            confirm("确定批量提交?","info",function(){
                var pageNo = $("#pageNo").val();
                var pageSize = $("#pageSize").val();
                var url = "${ctx}/lgt/ps/goods/batchOp?idsArr="+idsArr.join(',')+"&operationType=2"+"&pageNo="+pageNo+"&pageSize="+pageSize;
                window.location.href = url;
            })
            return false;
    	} else if(type == 3) {//批量下架
    		var idsArr = new Array();
            $("input[id^=ck_]").each(function() {
            	if($(this).prop("checked")) {
                    idsArr.push($(this).val());   
            	}
            });
            if(idsArr.length == 0) {
                ZF.showTip("请先勾选要批量下架的商品记录!", "info");
                return false;
            }
            confirm("确定批量提交?","info",function(){
                var pageNo = $("#pageNo").val();
                var pageSize = $("#pageSize").val();
                var url = "${ctx}/lgt/ps/goods/batchOp?idsArr="+idsArr.join(',')+"&operationType=3"+"&pageNo="+pageNo+"&pageSize="+pageSize;
                window.location.href = url;
            })
            return false;
    	}
    };
	</script>
</body>
</html>