<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		// 显示产品详情
		function showInfo(id){
			var url="${ctx}/lgt/ps/produce/info?id="+id;
			$("#searchForm").attr("action",url)
			$("#searchForm").submit();
		}
		
		// 变更产品状态
		function updateStatus(index, type, url, message){
			var flag = false;
			if(type == 2) {//产品上架前  都 需要验证产品个各种价格是否已经设定好
				$("#tr_"+index).find("font[class=price-buy-font]").each(function() {
					var price = $(this).text();
					if(price == "0.00" || price == null || price == "") {
						flag = true;
					}
				});
			}
		    if(flag) {
		    	ZF.showTip("请先为该产品定价,包括体验押金比例, 体验费比例","warning");
		    	return false;
		    }
			confirm(message, "info", function(){
	            ZF.ajaxQuery(false,url,null,function(data){
	            	$("#opMessage").val(data.message);
	            	if(data.status!=1){
	                    $("#searchForm").submit();
	                }else{
	                    $("#searchForm").submit();
	                }
	            },function(){
	            	confirm("操作失败","warning");
	            });
			}, function() {
				
			});
			return false;
		}
		
		// 修改产品
		function editForm(id){
			var url="${ctx}/lgt/ps/produce/form?id="+id;
			$("#searchForm").attr("action",url)
			$("#searchForm").submit();
		}
		
		function updatePriceForm(id) {
			var url = "${ctx}/lgt/ps/produceUpdate/form?produce.id="+id;
			$("#searchForm").attr("action", url);
			$("#searchForm").submit();
		}
		
		function delForm(id){
			confirm("确定要删除该产品记录吗？", "info", function() {
				var url="${ctx}/lgt/ps/produce/delete?id="+id;
				$("#searchForm").attr("action",url)
				$("#searchForm").submit();
			});
			
		}
		
// 		function updateStock(id){
// 			top.$.jBox.open("iframe:${ctx}/lgt/ps/produce/editStock?produceId="+id, "编辑安全、标准、警戒库存", 500, 350, {
// 				ajaxData:{selectIds: ""},buttons:{"确定":"ok", ${allowClear?"\"清除\":\"clear\", ":""}"关闭":true}, submit:function(v, h, f){
// 					console.log(v)
// 					if (v=="ok"){
// 						var content = h.find("iframe")[0].contentWindow;
// 						$("#stockid").val(content.id.value);
// 						$("#safeStock").val(content.safeStock.value);
// 						$("#standardStock").val(content.standardStock.value);
// 						$("#warningStock").val(content.warningStock.value);
// 						$("#stockForm").submit();
// 					}
// 				}, loaded:function(h){
// 					$(".jbox-content", top.document).css("overflow-y","hidden");
// 				}
// 			});
// 		}
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active">
					<i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/produce/list">产品列表</a>
				</small>
			</h1>
		</section>
		
		<sys:tip content="${message}"/>
		
		<section class="content">
		
			<form id="stockForm" name="form" action="${ctx}/lgt/ps/produce/saveStock" method="post" style="display: none;">
				<input id="stockid" name="id"/>
				<input id="stockSafe" name="stockSafe"/>
				<input id="stockStandard" name="stockStandard"/>
				<input id="stockWarning" name="stockWarning"/>
			</form>
			<form:form id="searchForm" modelAttribute="produce" action="${ctx}/lgt/ps/produce/list" method="post" class="form-horizontal">
			<!-- <input type="hidden" id="produceId" name="id" /> -->
			<!-- <input type="hidden" id="goodsId" name="goodsId" /> -->
			<!-- <input type="hidden" id="status" name="status" /> -->
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	    	<input type="hidden" name="token" value="${token }" />
	    	<input id="opMessage" type="hidden" name="opMessage"/>
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
						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-3 control-label" >商品编码/名称</label>
								<div class="col-sm-7">
									<form:input id="gKeyWords" path="goods.searchParameter.keyWord" htmlEscape="false" maxlength="50" class="form-control" placeholder="请输入商品编码或商品名称"/>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-3 control-label" >商品状态</label>
								<div class="col-sm-7">
									<form:select id="gStatus" path="goods.status" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('lgt_ps_goods_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<sys:inputtree id="category" name="goods.category.id" url="${ctx}/lgt/ps/category/categoryData" label="商品分类" labelValue="" labelName="goods.category.categoryName" value="" tip="请选择商品分类" title="商品分类"></sys:inputtree>
						</div>
					</div>	
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-3 control-label" >产品编码/名称</label>
								<div class="col-sm-7">
									<form:input id="pKeyWords" path="searchParameter.keyWord" htmlEscape="false" maxlength="50" class="form-control" placeholder="请输入产品编码或产品名称"/>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-3 control-label" >产品状态</label>
								<div class="col-sm-7">
									<form:select id="status" path="status" class="form-control select2">
										<form:option value="" label="所有"/>
										<form:options items="${fns:getDictList('lgt_ps_produce_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</div>
						<div class="col-md-4">
                            <div class="form-group">
                                <label for="styleType" class="col-sm-3 control-label" >风格类型</label>
                                <div class="col-sm-7">
                                   <sys:selectverify name="styleType" tip="请选择风格类型" isMandatory="false" verifyType="0" dictName="lgt_ps_produce_styleType" id="styleType"></sys:selectverify>
                                </div>
                            </div>
                        </div>
					</div>
					<div class="row">
						 <div class="col-md-4">
                            <div  class="form-group">
                                <label for="isStock" class="col-sm-3 control-label">有无库存</label>
                                <div class="col-sm-7">
                                    <form:select path="isStock" id="isStock">
                                        <form:option value="" label="请选择"/>
                                        <form:option value="1" label="有"/>
                                        <form:option value="0" label="无"/>
                                    </form:select>
                                </div>
                            </div>
                        </div>
					</div>	
				</div>
				<div class="box-footer">
		        	<div class="pull-right box-tools">
		        	    <button type="button" class="btn btn-sm btn-dropbox" onclick="printPreview()"><i class="fa fa-print">打印预览</i></button>
		        		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
	               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
		        	</div>
	            </div>
			</div>
			</form:form>
			
			<div class="box box-soild">
				<div class="box-body">
				    <shiro:hasPermission name="lgt:ps:produce:edit">
                        <div class="row">
                            <div class="col-sm-12 pull-right">
                                <button type="button" class="btn btn-sm btn-info" onclick="batchOp(0);"><i class="fa fa-bell">点我批量</i></button>
                                <button type="button" class="btn btn-sm btn-primary" onclick="batchOp(1);"><i class="fa fa-edit">批量发布</i></button>
                                <button type="button" class="btn btn-sm btn-success" onclick="batchOp(2);"><i class="fa fa-hand-o-up">批量上架</i></button>
                                <button type="button" class="btn btn-sm bg-navy" onclick="batchOp(3);"><i class="fa fa-thumbs-down">批量下架</i></button>
                            </div>
                        </div>
                    </shiro:hasPermission>
					<div class="table-reponsive">
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
									<th>产品编码</th>
									<th>分类</th>
									<th>产品全称</th>
									<th>商品状态</th>
                                    <th>产品状态</th>
<!--                                     <th>风格类型</th> -->
									<th>采购价</th>
									<th>加价系数</th>
									<th>原价</th>
									<th>体验押金比例</th>
									<th>体验费比例</th>
									<th>积分可抵金额</th>
									<th>促销详情<span data-toggle="tooltip" class="badge bg-light-blue" data-original-title="其中折扣为系数，即“实际售价 = 销售价 * 折扣系数”">?</span></th>
									<th>销量</th>
									<th>正常库存</th>
									<th>锁定库存</th>
									<th style="display:none">创建者</th>
									<th style="display:none">创建时间</th>
									<th style="display:none">更新者</th>
									<th style="display:none">更新时间</th>
									<th style="display:none">备注信息</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list}" var="produce" varStatus="status">
								<tr id="tr_${status.index }" data-check="false" data-index="${status.index }">
									<td id="chkTH_${status.index }"  style="display: none;">
                                           <div class="zf-check-wrapper-padding">
                                               <input id="ck_${status.index }" data-index="${status.index }" name="pck" type="checkbox" value="${produce.id }" htmlEscape="false" class="minimal"/>
                                           </div>
                                        </td>
									<td class="details-control text-center"><i class="fa fa-plus-square-o text-success"></i></td>
									<td><img onerror="imgOnerror(this);"  src="${imgHost }${produce.goods.samplePhoto}" data-big data-src="${imgHost }${produce.goods.samplePhoto}" width="21" height="21" /></td>
									<td>${produce.code}</td>
									<td>${produce.goods.category.categoryName}</td>
									<c:set var="fullName" value="${produce.goods.name } ${produce.name}"></c:set>
                                    <td title="${fullName }">${fns:abbr(fullName, 15)}</td>
									<td>
										<c:choose>
											<c:when test="${produce.goods.status == 1 }"><span class="label label-default">${fns:getDictLabel(produce.goods.status,'lgt_ps_goods_status','') }</span></c:when>
											<c:when test="${produce.goods.status == 2 }"><span class="label label-success">${fns:getDictLabel(produce.goods.status,'lgt_ps_goods_status','') }</span></c:when>
											<c:when test="${produce.goods.status == 3 }"><span class="label label-primary">${fns:getDictLabel(produce.goods.status,'lgt_ps_goods_status','') }</span></c:when>
											<c:otherwise><span class="label label-danger">${fns:getDictLabel(produce.goods.status,'lgt_ps_goods_status','') }</span></c:otherwise>
										</c:choose>
									</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${produce.status == 1 }"><span class="label label-default">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${produce.status == 2 }"><span class="label label-success">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${produce.status == 3 }"><span class="label label-primary">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:when test="${produce.status == 4 }"><span class="label label-danger">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:when>
                                            <c:otherwise><span class="label label-danger">${fns:getDictLabel(produce.status,'lgt_ps_produce_status','') }</span></c:otherwise>
                                        </c:choose>
                                    </td>
<!--                                     <td> -->
<%--                                         <c:choose> --%>
<%--                                             <c:when test="${produce.styleType == 1 }"><span class="label label-primary">${fns:getDictLabel(produce.styleType, 'lgt_ps_produce_styleType', '') }</span></c:when> --%>
<%--                                             <c:when test="${produce.styleType == 2 }"><span class="label label-success">${fns:getDictLabel(produce.styleType, 'lgt_ps_produce_styleType', '') }</span></c:when> --%>
<%--                                         </c:choose> --%>
<!--                                     </td> -->
									<td class="zf-table-money"><span class="text-red">${produce.pricePurchase }</span></td>
									<td class="zf-table-money">${produce.ratioOperation }</td>
									<td class="zf-table-money"><span class="text-red"><font class="price-buy-font">${produce.priceSrc }</font></span></td>
									<td><span class="text-red"><font class="price-buy-font">${produce.scaleExperienceDeposit }</font></span>${produce.experienceDepositFee}</td>
									<td><span class="text-red"><font class="price-buy-font">${produce.scaleExperienceFee }</font></span>${produce.experienceFee}</td>
									<td class="zf-table-money"><span class="text-red">${produce.priceDecPoint }</span></td>
									<td>
										<c:choose>
											<c:when test="${not empty produce.discountPrice }">
												特&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：<span class="text-red">${produce.discountPrice }</span></c:when>
											<c:when test="${not empty produce.discountScale }">
												折&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;扣：<span class="text-red">${produce.discountScale }</span></c:when>
											<c:when test="${not empty produce.discountFilterScale }">
												<span title="起止日期：<fmt:formatDate value='${produce.discountFilterStart}' pattern='yyyy-MM-dd HH:mm:ss'/> - <fmt:formatDate value='${produce.discountFilterEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>">
													筛选折扣：<span class="text-red">${produce.discountFilterScale }</span>
												</span>
											</c:when>
											<c:otherwise>
												平台折扣：<span class="text-red">${dspValue }</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
									   ${produce.sellNum }
									</td>
									<td >
									   ${produce.stockNormal }
									</td>
									<td>
									   ${produce.stockLock }
									</td>
									<td data-hide="true">
										${fns:getUserById(produce.createBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${produce.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td data-hide="true">
										${fns:getUserById(produce.updateBy.id).name}
									</td>
									<td data-hide="true">
										<fmt:formatDate value="${produce.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td  data-hide="true">
										${fns:abbr(produce.remarks,100)}
									</td>
									<td>
										<div class="btn-group zf-tableButton">
											<button type="button" class="btn btn-xs btn-info" onclick="showInfo('${produce.id}')">详情</button>
											<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
							                   <span class="caret"></span>
							                </button>
											<shiro:hasPermission name="lgt:ps:produce:edit">
							                    <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
							                    	<c:choose>
							                    		<c:when test="${ produce.status eq '1' }"> <!-- 新建 -->
															<li><a href="#this" onclick="editForm('${produce.id}')" >修改</a></li>
							                    			<li><a href="${ctx}/lgt/ps/produce/updateStatus?produceId=${produce.id}&operationType=1" onclick="return updateStatus(${status.index }, 1, this.href, '确认发布该产品么?')">发布</a></li>
															<li><a href="#this" onclick="delForm('${produce.id}')" >删除</a></li>
							                    		</c:when>
							                    		<c:when test="${produce.status eq '2' }">  <!-- 上架 -->
							                    			<li><a href="${ctx}/lgt/ps/produce/updateStatus?produceId=${produce.id}&operationType=3" onclick="return updateStatus(${status.index }, 3, this.href, '确认下架该产品么?')">下架</a></li>
							                    			<li><a href="${ctx}/lgt/ps/produce/updateStatus?produceId=${produce.id}&operationType=4" onclick="return updateStatus(${status.index }, 4, this.href, '确认冻结该产品么?')">冻结</a></li>
							                    		</c:when>
							                    		<c:when test="${produce.status eq '3' }">  <!-- 下架 -->
							                    			<li><a href="#this" onclick="editForm('${produce.id}')" >修改</a></li>
							                    			<li><a href="${ctx}/lgt/ps/produce/updateStatus?produceId=${produce.id}&operationType=2" onclick="return updateStatus(${status.index }, 2, this.href, '确认上架该产品么?')">上架</a></li>
							                    			<li><a href="${ctx}/lgt/ps/produce/updateStatus?produceId=${produce.id}&operationType=4" onclick="return updateStatus(${status.index }, 4, this.href, '确认冻结该产品么?')">冻结</a></li>
							                    		</c:when>
							                    		<c:when test="${produce.status eq '4' }">  <!-- 冻结 -->
							                    			<li><a href="#this" onclick="editForm('${produce.id}')" >修改</a></li>
							                    			<li><a href="${ctx}/lgt/ps/produce/updateStatus?produceId=${produce.id}&operationType=2" onclick="return updateStatus(${status.index }, 2, this.href, '确认上架该产品么?')">上架</a></li>
							                    			<li><a href="${ctx}/lgt/ps/produce/updateStatus?produceId=${produce.id}&operationType=3" onclick="return updateStatus(${status.index }, 3, this.href, '确认下架该产品么?')">下架</a></li>
							                    		</c:when>
							                    	</c:choose>
							                    </ul>
											</shiro:hasPermission>
										</div>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="box-footer">
				        	<div class="dataTables_paginate paging_simple_numbers">${page}</div>
				        </div>
					</div>
				</div>
			</div>
		</section>
	</div>
	
	<script type="text/javascript">
	  	var produceId = null;
		$(function () {
			// 缩略图展示
			ZF.bigImg();
			
			$('input').iCheck({
	            checkboxClass : 'icheckbox_minimal-blue',
	            radioClass : 'iradio_minimal-blue'
	        });
			
		 	// 表格初始化
	 		var t=ZF.parseTable("#contentTable",{
				"paging" : false,
				"lengthChange" : false,
				"searching" : false,				// 关闭搜索   
				//"order": [[16, "desc" ]],			// 指定默认初始化按第几列排序，默认排序升序，降序
				"columnDefs":[
					{"orderable":false,targets:0},
					{"orderable":false,targets:1},
					{"orderable":false,targets:2},
					{"orderable":false,targets:3},
					{"orderable":false,targets:4},
					{"orderable":false,targets:5},
					{"orderable":false,targets:6},
					{"orderable":false,targets:7},
					{"orderable":false,targets:8},
					{"orderable":false,targets:9},
                    {"orderable":false,targets:12},
                    {"orderable":false,targets:13},
                    {"orderable":false,targets:14},
                    {"orderable":false,targets:15},
					{"orderable":false,targets:16},
					{"orderable":false,targets:17},
					{"orderable":false,targets:18},
					{"orderable":false,targets:19}
		         ],
				"ordering" : false,					// 开启排序
				"info" : false,
				"autoWidth" : false,
				"multiline":true,					// 是否开启多行表格
				"isRowSelect":true,					// 是否开启行选中
				"rowSelect":function(tr){},			// 行选中回调
				"rowSelectCancel":function(tr){}	// 行取消选中回调
			});
		 	
		 	
	 		//批量  全选
	        $("#selAll").on("ifChecked", function() {
	             $("input[id^=ck_]").each(function() {
	                 $(this).iCheck('check');
	                 var index = $(this).attr("data-index");
	                 $("#tr_"+index).attr("data-check", true);
	             });
	        }).on("ifUnchecked", function() {
	            $("input[id^=ck_]").each(function() {
	                $(this).iCheck('uncheck');
	                var index = $(this).attr("data-index");
                    $("#tr_"+index).attr("data-check", false);
	            });
	        });
		 	
	 		$("input[name=pck]").on("ifUnchecked", function() {
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
		
		 function printPreview() {
			 
		    var i = 0;
            $("#searchForm input[type!=hidden]").each(function() {
                if($(this).val() != null   && $(this).val() != ""  && $(this).val() != undefined) {
                    i++;
                }
            });
            $("#searchForm select").each(function() {
                if($(this).val() != null   && $(this).val() != ""  && $(this).val() != undefined) {
                    i++;
                }
            });
            if(i == 0) {
                ZF.showTip("请选择查询条件!", "info");
                return false;
            }
			 
			 
			  var gkey = $("#gKeyWords").val();
			  var gStatus = $("#gStatus").val();
			  var categoryId = $("#categoryId").val();
			  var pKeyWords = $("#pKeyWords").val();
			  var status = $("#status").val();
			  var styleType = $("#styleType").val();
	          window.open("${ctx}/lgt/ps/produce/printPreview?goods.searchParameter.keyWord="+gkey+"&goods.status="+gStatus+"&goods.category.id="+categoryId+"&searchParameter.keyWord="+pKeyWords+"&status="+status+"&styleType="+styleType);
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
		                    
			                var index = $(this).attr("data-index");
		                    $("#tr_"+index).attr("data-check", true);
		                }   
		            });
		            if(idsArr.length == 0) {
		                ZF.showTip("请先勾选要批量发布的产品记录!", "info");
		                return false;
		            }
		           /*  var flag = false;
		           //产品 发布或者上架前  都 需要验证产品个各种价格是否已经设定好
		           $("tr[data-check=true]").each(function() {
		        	   $(this).find("font[class=price-buy-font]").each(function() {
	                        console.log($(this));
	                        var price = $(this).text();
	                        console.log(price);
	                        if(price == "0.00") {
	                            flag = true;
	                        }
	                    });
		           });
		            if(flag) {
		                ZF.showTip("请先为该产品定价","warning");
		                return false;
		            } */
		            confirm("确定批量提交?","info",function(){
		                var pageNo = $("#pageNo").val();
		                var pageSize = $("#pageSize").val();
		                var url = "${ctx}/lgt/ps/produce/batchOp?idsArr="+idsArr.join(',')+"&operationType=1"+"&pageNo="+pageNo+"&pageSize="+pageSize;
		                window.location.href = url;
		            })
		            return false;
		        } else if(type == 2) {//批量上架
		            var idsArr = new Array();
		            $("input[id^=ck_]").each(function() {
		                if($(this).prop("checked")) {
		                    idsArr.push($(this).val());
		                    
		                    var index = $(this).attr("data-index");
		                    $("#tr_"+index).attr("data-check", true);
		                }
		                
		            });
		            if(idsArr.length == 0) {
		                ZF.showTip("请先勾选要批量上架的商品记录!", "info");
		                return false;
		            }
		            var flag = false;
                    //产品 上架前  需要验证产品个各种价格是否已经设定好
                   	$("tr[data-check=true]").find("font[class=price-buy-font]").each(function() {
                        var price = $(this).text();
                        console.log(price);
                        if(price == "0.00" || price == null || price == "") {
                            flag = true;
                        }
                    });
                    if(flag) {
                        ZF.showTip("请先为该产品定价,包括体验押金比例, 体验费比例","warning");
                        return false;
                    }
		            confirm("确定批量提交?","info",function(){
		                var pageNo = $("#pageNo").val();
		                var pageSize = $("#pageSize").val();
		                var url = "${ctx}/lgt/ps/produce/batchOp?idsArr="+idsArr.join(',')+"&operationType=2"+"&pageNo="+pageNo+"&pageSize="+pageSize;
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
		                var url = "${ctx}/lgt/ps/produce/batchOp?idsArr="+idsArr.join(',')+"&operationType=3"+"&pageNo="+pageNo+"&pageSize="+pageSize;
		                window.location.href = url;
		            })
		            return false;
		        }
		    };
		 
	</script>
</body>
</html>