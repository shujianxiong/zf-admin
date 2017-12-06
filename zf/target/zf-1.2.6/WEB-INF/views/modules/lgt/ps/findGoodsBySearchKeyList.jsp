<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品关键字查询</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
	<script type="text/javascript">
	function resetForm() {
        $("#key").val("");
    }
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/goods/findGoodsBySearchKey">商品编码查询</a></small>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
	    <section class="content">
	    	<form:form id="searchForm" modelAttribute="goods" action="${ctx}/lgt/ps/goods/findGoodsBySearchKey" onsubmit="return ZF.formSubmit();" method="post" class="form-horizontal">
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
									<label for="key" class="col-sm-3 control-label">关键字</label>
									<div class="col-sm-7">
										<input id="key" name="key" value="${key }" htmlEscape="false" maxlength="100" class="form-control" placeholder="请输入商品名称或商/产/货品编码查询"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">   
			        	<div class="pull-right box-tools">
			        		<button type="button" class="btn btn-default btn-sm" onclick="resetForm()"><i class="fa fa-refresh"></i>重置</button>
		               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
			        	</div>
		            </div>
				</div>
			
	    	</form:form>
	    	<div class="box box-soild">
				<div class="box-body">
					<div class="table-responsive">
					    
							<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
								<thead>
									<tr>
									    <th class="zf-dataTables-multiline"></th>
										<th>商/产/货品编码</th>
										<th>商/产/货品名称</th>
										<th>商/产/货品原厂编码</th>
										<th>品牌</th>
										<th>设计师</th>
										<th>展示图片</th>
										<th>商品状态</th>
										<th>可用优惠卷</th>
										<th>是否推荐</th>
										<th>货位</th>
										<th>库存</th>
										<th style="display:none;">创建者</th>
	                                    <th style="display:none;">创建时间</th>
	                                    <th style="display:none;">更新者</th>
	                                    <th style="display:none;">更新时间</th>
	                                    <th style="display:none;">备注信息</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
								   <c:choose>
                                           <c:when test="${not empty gList}">
											<c:forEach items="${gList}" var="goods" varStatus="status">
												<tr data-index="${status.index }">
													<td class="details-control text-center">
			                                            <i class="fa fa-plus-square-o text-success"></i>
			                                        </td>
													<td>
														${goods.code}
													</td>
													<td title="${goods.name }">
														${fns:abbr(goods.name, 22)}
													</td>
													<td>
													   ${goods.factoryCode }
													</td>
													<td>
                                                       ${goods.brand.name }
                                                    </td>
                                                    <td>
                                                       ${goods.designer.name }
                                                    </td>
													<td>
														<img onerror="imgOnerror(this);" src="${imgHost }${goods.icon}" data-big data-src="${imgHost }${goods.icon}" width="20px" height="20px" />
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
													     <c:choose>
			                                                <c:when test="${goods.isCouponUsable eq '0' }">
			                                                    <span class="label label-primary">${fns:getDictLabel(goods.isCouponUsable, 'yes_no', '')}</span>
			                                                </c:when>
			                                                <c:when test="${goods.isCouponUsable eq '1' }">
			                                                    <span class="label label-success">${fns:getDictLabel(goods.isCouponUsable, 'yes_no', '')}</span>
			                                                </c:when>
			                                            </c:choose>
													</td>
													<td>
	                                                     <c:choose>
	                                                        <c:when test="${goods.isRecommend eq '0' }">
	                                                            <span class="label label-primary">${fns:getDictLabel(goods.isRecommend, 'yes_no', '')}</span>
	                                                        </c:when>
	                                                        <c:when test="${goods.isRecommend eq '1' }">
	                                                            <span class="label label-success">${fns:getDictLabel(goods.isRecommend, 'yes_no', '')}</span>
	                                                        </c:when>
	                                                    </c:choose>
	                                                </td>
	                                                <td>
	                                                    
	                                                </td>
	                                                <td>
                                                        
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
													<td>
														<div class="btn-group zf-tableButton">
															<button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/goods/goodsSynInfo?id=${goods.id}'">详情</button>
															<button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
											                   <span class="caret"></span>
											                </button>
														</div>
													</td>
												</tr>
											</c:forEach>
									       </c:when>
									       <c:when test="${not empty produce }">
									           <tr data-index="${status.index }">
                                                    <td class="details-control text-center">
                                                        <i class="fa fa-plus-square-o text-success"></i>
                                                    </td>
                                                    <td>
                                                        ${produce.code}
                                                    </td>
                                                    <td>
                                                        ${produce.goods.name}&nbsp;${produce.name }
                                                    </td>
                                                    <td>
                                                       ${produce.factoryCode }
                                                    </td>
                                                    <td>
                                                       ${produce.goods.brand.name }
                                                    </td>
                                                    <td>
                                                       ${produce.goods.designer.name }
                                                    </td>
                                                    <td>
                                                        <img onerror="imgOnerror(this);" src="${imgHost }${produce.goods.icon}" data-big data-src="${imgHost }${produce.goods.icon}" width="20px" height="20px" />
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${produce.goods.status=='1'}">
                                                                 <span class="label label-default">${fns:getDictLabel(produce.goods.status, 'lgt_ps_goods_status', '')}</span>
                                                            </c:when>
                                                            <c:when test="${produce.goods.status=='2' }">
                                                                 <span class="label label-success">${fns:getDictLabel(produce.goods.status, 'lgt_ps_goods_status', '')}</span>
                                                            </c:when>
                                                            <c:when test="${produce.goods.status=='3' }">
                                                                 <span class="label label-primary">${fns:getDictLabel(produce.goods.status, 'lgt_ps_goods_status', '')}</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                         <c:choose>
                                                            <c:when test="${produce.goods.isCouponUsable eq '0' }">
                                                                <span class="label label-primary">${fns:getDictLabel(produce.goods.isCouponUsable, 'yes_no', '')}</span>
                                                            </c:when>
                                                            <c:when test="${produce.goods.isCouponUsable eq '1' }">
                                                                <span class="label label-success">${fns:getDictLabel(produce.goods.isCouponUsable, 'yes_no', '')}</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                         <c:choose>
                                                            <c:when test="${produce.goods.isRecommend eq '0' }">
                                                                <span class="label label-primary">${fns:getDictLabel(produce.goods.isRecommend, 'yes_no', '')}</span>
                                                            </c:when>
                                                            <c:when test="${produce.goods.isRecommend eq '1' }">
                                                                <span class="label label-success">${fns:getDictLabel(produce.goods.isRecommend, 'yes_no', '')}</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td title="${produce.fullWareplace }">
                                                        ${fns:abbr(produce.fullWareplace, 30) }
                                                    </td>
                                                    <td>
                                                        ${produce.stockNormal }
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
                                                    <td data-hide="true">
                                                        ${fns:abbr(produce.remarks,30)}
                                                    </td>
                                                    <td>
                                                        <div class="btn-group zf-tableButton">
                                                            <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/goods/goodsSynInfo?id=${produce.goods.id}'">详情</button>
                                                            <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
                                                               <span class="caret"></span>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
									       </c:when>
									       <c:when test="${not empty product }">
									          <tr data-index="${status.index }">
                                                    <td class="details-control text-center">
                                                        <i class="fa fa-plus-square-o text-success"></i>
                                                    </td>
                                                    <td>
                                                        ${product.code}
                                                    </td>
                                                    <td>
                                                        ${product.goods.name}&nbsp;${product.produce.name }
                                                    </td>
                                                    <td>
                                                       ${product.factoryCode }
                                                    </td>
                                                    <td>
                                                       ${product.goods.brand.name }
                                                    </td>
                                                    <td>
                                                       ${product.goods.designer.name }
                                                    </td>
                                                    <td>
                                                        <img onerror="imgOnerror(this);" src="${imgHost }${product.goods.icon}" data-big data-src="${imgHost }${product.goods.icon}" width="20px" height="20px" />
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${product.goods.status=='1'}">
                                                                 <span class="label label-default">${fns:getDictLabel(product.goods.status, 'lgt_ps_goods_status', '')}</span>
                                                            </c:when>
                                                            <c:when test="${product.goods.status=='2' }">
                                                                 <span class="label label-success">${fns:getDictLabel(product.goods.status, 'lgt_ps_goods_status', '')}</span>
                                                            </c:when>
                                                            <c:when test="${product.goods.status=='3' }">
                                                                 <span class="label label-primary">${fns:getDictLabel(product.goods.status, 'lgt_ps_goods_status', '')}</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                         <c:choose>
                                                            <c:when test="${product.goods.isCouponUsable eq '0' }">
                                                                <span class="label label-primary">${fns:getDictLabel(product.goods.isCouponUsable, 'yes_no', '')}</span>
                                                            </c:when>
                                                            <c:when test="${product.goods.isCouponUsable eq '1' }">
                                                                <span class="label label-success">${fns:getDictLabel(product.goods.isCouponUsable, 'yes_no', '')}</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                         <c:choose>
                                                            <c:when test="${product.goods.isRecommend eq '0' }">
                                                                <span class="label label-primary">${fns:getDictLabel(product.goods.isRecommend, 'yes_no', '')}</span>
                                                            </c:when>
                                                            <c:when test="${product.goods.isRecommend eq '1' }">
                                                                <span class="label label-success">${fns:getDictLabel(product.goods.isRecommend, 'yes_no', '')}</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        ${product.fullWareplace }
                                                    </td>
                                                    <td>
                                                        ${product.produce.stockNormal }
                                                    </td>
                                                    <td data-hide="true">
                                                        ${fns:getUserById(product.createBy.id).name}
                                                    </td>
                                                    <td data-hide="true">
                                                        <fmt:formatDate value="${product.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </td>
                                                    <td data-hide="true">
                                                        ${fns:getUserById(product.updateBy.id).name}
                                                    </td>
                                                    <td data-hide="true">
                                                        <fmt:formatDate value="${product.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </td>
                                                    <td data-hide="true">
                                                        ${fns:abbr(product.remarks,30)}
                                                    </td>
                                                    <td>
                                                        <div class="btn-group zf-tableButton">
                                                            <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/goods/goodsSynInfo?id=${product.goods.id}'">详情</button>
                                                            <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
                                                               <span class="caret"></span>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
					                       </c:when>
									</c:choose>
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
	
	<script type="text/javascript">
	$(function () {
		ZF.bigImg();
		
		 //表格初始化
        var t=ZF.parseTable("#contentTable",{
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,//关闭搜索
            "order": [[ 16, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},  //第0列不排序
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
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15},
                {"orderable":false,targets:17},
                {"orderable":false,targets:18}
            ],
            "ordering" : true,//开启排序
            "info" : false,
            "autoWidth" : false,
            "multiline":true,//是否开启多行表格
            "isRowSelect":true,//是否开启行选中
            "rowSelect":function(tr){},//行选中回调
            "rowSelectCancel":function(tr){}//行取消选中回调
        });
	});
	</script>
</body>
</html>