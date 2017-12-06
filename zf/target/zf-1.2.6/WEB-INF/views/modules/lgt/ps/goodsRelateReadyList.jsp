<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>已关联商品管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			/* var ids="${ids}";
			var idsArray=ids.split(",");
			for(var i=0;i<idsArray.length;i++){
				if(idsArray[i]!=null&&idsArray[i].length>0){
					var id="#checkBox"+idsArray[i];
					$(id).attr("checked",true);
				}
			} */
			
			$("#updateRelated").on("click", function() {
				var addIds = new Array;
				var removeIds = new Array;
				$("#dataBody :checkBox").each(function(){
                    if($(this).prop("checked")){
                    	removeIds.push($(this).attr("data-value"));
                    } else {
                    	addIds.push($(this).attr("data-value"));
                    }
                    
                });
				if(removeIds.length > 0) {
					confirm("您确定要移除【${goods.name}】商品所关联的商品吗？","info", function() {
                        var postData = {"goodsId":"${goods.id}","addIds[]":addIds};
                        console.log(postData);
                        ZF.ajaxQuery(true,"${ctx}/lgt/ps/goods/relateRemove",postData, function(data){
                            ZF.showTip(data,"info");//返回成功提示消息
                            window.location.href = window.location.href;
                            return false;
                        },function(){
                            ZF.showTip(data,"danger");
                            return false;
                        })
                    }, function() {
                        return false;
                    });
                } else {
                	ZF.showTip("请先勾选要取消的关联商品记录", "info");
                    return false;
                }
				
			});
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		
		
		function addGoods(goodsId,name){
            var url="${ctx}/lgt/ps/goods/relateselect?goodsId="+goodsId;
            $("#goodsModal .modal-title").text("往 "+name+" 添加/移除商品")
            $("#goodsModalUrl").val(url);
            $("#goodsModal").modal('toggle');
            $("#goodsModal #commitBtn").unbind("click"); //去掉之前的click事件并重新绑定
            
            var ids="${ids}";
            var idsArray=ids.split(","); 
            
            $("#goodsModal #commitBtn").on("click",function(){
                var content = $("#goodsModalIframe").contents().find("body");
                var addIds=new Array; //用于保存关联的商品ID数组
                var postData; //ajax参数
                
                var isDouble = false;
                $("input[type=checkBox]", content).each(function(){
                    if($(this).prop("checked")){
                    	var gid = $(this).attr("data-value");
                    	var gname = $(this).attr("data-name");
                    	
                    	for(var i=0;i<idsArray.length;i++){
                            if(idsArray[i]!=null&&idsArray[i].length>0 && idsArray[i] == gid){
                               ZF.showTip("商品名称为【"+gname+"】重复，请核对 ", "warning");
                               isDouble = true;
                            }
                        }
                        addIds.push(gid);
                    }
                });
                if(isDouble) 
                	return false;

                if(addIds.length < 1) {
                    ZF.showTip("请先向【"+name+"】添加/移除商品","info");
                    return false;
                }
                postData = {"goodsId":goodsId,"addIds[]":addIds};
                ZF.ajaxQuery(true,"${ctx}/lgt/ps/goods/relateadd",postData, function(data){
                    ZF.showTip(data,"info");//返回成功提示消息
                    window.location.href = window.location.href;
                    return false;
                },function(){
                    ZF.showTip(data,"danger");
                    return false;
                })
                $("#goodsModal").modal('toggle');//关闭模态框
            })  
            
        }
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content">
			<div class="box box-info">
				<div class="box-header with-border zf-query">
				    <div class="row">
                       <div class="col-sm-12 pull-right">
                          <button type="button" id="updateRelated" class="btn btn-sm btn-success"><i class="fa fa-pencil">取消关联</i></button>
                          <button type="submit" onclick="addGoods('${goods.id}', '${goods.name}');" class="btn btn-info btn-sm"><i class="fa fa-search"></i>关联商品</button>
                       </div>
                    </div>
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
								<tr>
								    <th>
								        <input id="selAll" type="checkbox"/>
								    </th>
									<th>商品编码</th>
									<th>商品名称</th>
									<th>样图</th>
									<th>商品状态</th>
									<th>商品销量</th>
									<th>备注信息</th>
								</tr>
							</thead>
							<tbody id="dataBody">
								<c:forEach items="${goodsList}" var="goods" varStatus="status">
									<tr data-index="${status.index }">
									    <td>
									        <input id="${goods.id }" data-value="${goods.id }" data-name="${goods.name }"  type="checkBox" />
									    </td>
										<td>
											${goods.code}
										</td>
										<td title="${goods.name }">
											${fns:abbr(goods.name, 15)}
										</td>
										<td>
											<img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(goods.samplePhoto, '|', '')}" data-big data-src="${imgHost }${goods.samplePhoto}" width="21px" height="21px" />
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
                                            ${goods.sellNum}
                                        </td>
										<td>
											<c:choose>
                                                <c:when test="${goods.isCouponUsable eq '0' }">
                                                    <span class="label label-primary">${fns:getDictLabel(goods.isCouponUsable, 'yes_no', '')}</span>
                                                </c:when>
                                                <c:when test="${goods.isCouponUsable eq '1' }">
                                                    <span class="label label-success">${fns:getDictLabel(goods.isCouponUsable, 'yes_no', '')}</span>
                                                </c:when>
                                            </c:choose>
										</td>
										<td title="${goods.remarks }">
											${fns:abbr(goods.remarks,15)}
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<%-- <div class="box-footer">
		        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
		        </div> --%>
		        <div class="box-footer">
                    <div class="pull-left box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="window.location.href='${ctx}/lgt/ps/goods/list'"><i class="fa fa-mail-reply"></i>返回</button>
                    </div>
                </div>
			</div>
		</section>
	</div>
	<sys:selectmutil height="600" url="" width="1200" isDisableCommitBtn="true" title="商品编辑" id="goods"></sys:selectmutil>
	
<script>
	  $(function () {
		 //表格初始化
		ZF.parseTable("#contentTable", {
			"paging" : false,
			"lengthChange" : false,
			"searching" : false,
			"ordering" : true,
			"order": [[ 5, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
			"columnDefs":[
				{"orderable":false,targets:0},
				{"orderable":false,targets:1},
				{"orderable":false,targets:2},
				{"orderable":false,targets:3},
				{"orderable":false,targets:4},
				{"orderable":false,targets:6}
            ],
			"info" : false,
			"autoWidth" : false,
			"multiline" : true,//是否开启多行表格
			"isRowSelect" : false//是否开启行选中
		});
		 
		$('input').iCheck({
			checkboxClass : 'icheckbox_minimal-blue',
		});
		
		ZF.bigImg();
		
		
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
	    
	    //全选--全反选
	    $("#selAll").on("ifChecked", function() {
	    	$("#dataBody :checkBox").iCheck('check');   
	    });
	    $("#selAll").on("ifUnchecked", function() {
	    	$("#dataBody :checkBox").iCheck('uncheck');   
	    });
		
		
	  });
	  
	  
</script>
	
</body>
</html>