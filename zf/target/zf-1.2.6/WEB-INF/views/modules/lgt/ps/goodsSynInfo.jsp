<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品修改</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	
	<script type="text/javascript">
	    $(document).ready(function() {
		   
		   	editor = CKEDITOR.replace('goodsIntroduction');
			var html = editor.getData();
			$("#scrollWapper").html(html);
			
			$('#scrollWapper').slimScroll({
		    	height: '100%',
		    	width: '100%'
		    });
	    });
	    
		var rowIndex=0;
		
		function initProperty(){
			//显示商品属性
			var goodsProp=${fns:toJson(goods.goodsProp)}
			for(var i=0;i<goodsProp.length;i++){
				if(goodsProp[i].goodsPropvalue==null||goodsProp[i].goodsPropvalue.length<=0)
					continue;
				//输入类型
				if($("#"+goodsProp[i].property.id+"input").length>0){
					$("#"+goodsProp[i].property.id+"input").val(goodsProp[i].goodsPropvalue[0].pvalue);
					continue;
				}
				//选择类型
				if($("#"+goodsProp[i].property.id+"select").length>0){
					$("#"+goodsProp[i].property.id+"select").val(goodsProp[i].goodsPropvalue[0].propvalue.id);
					continue;
				}
				//多选类型
				for(var j=0;j<goodsProp[i].goodsPropvalue.length;j++){
					if($("#"+goodsProp[i].goodsPropvalue[j].propvalue.id+"checkBox").length>0){
						$("#"+goodsProp[i].goodsPropvalue[j].propvalue.id+"checkBox").attr("checked","true");
						$("#"+goodsProp[i].goodsPropvalue[j].propvalue.id+"input").val(goodsProp[i].goodsPropvalue[j].propvalue.id);
						continue;
					}
				}
			}
		}
		
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
	
		<section class="content-header content-header-menu">
			
	    </section>
	    <section class="invoice">
	    	<p class="lead">基本信息</p>
	    	<div class="table-responsive">
	    		<table class="table">
	     			<tr>
		                <th width="10%">商品名称</th>
		                <td>${goods.name }</td>
		                <th width="10%">状态</th>
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
	              	</tr>
	              	<tr>
		                <th width="10%">英文名称</th>
		                <td>${goods.englishName }</td>
		                <th width="10%">商品分类</th>
		                <td width="40%">${goods.category.categoryName}</td>
	              	</tr>
	              	<tr>
		                <th width="10%">商品编码</th>
		                <td>${goods.code }</td>
		                <th width="10%">原厂编码</th>
		                <td width="40%">${goods.factoryCode }</td>
	              	</tr>
	              	<tr>
		                <th width="10%">设计师</th>
		                <td>${goods.designer.name }</td>
		                <th width="10%">品牌</th>
		                <td width="40%">${goods.brand.name }</td>
	              	</tr>
	              	<tr>
                        <th width="10%">标签</th>
                        <td>
                            <c:forEach items="${tagsList}" var="tag">
                                <span class="label label-primary">${tag.name }</span>
                            </c:forEach>
                        </td>
                        <th width="10%">使用范围</th>
                        <td><span class="label label-primary">${fns:getDictLabel(goods.useRange, 'useRange','') }</span> </td>
                    </tr>
                    <tr>
                        <th width="10%">供应商</th>
                        <td colspan="3">
                            <c:forEach items="${supplierList}" var="s">
                                <span class="label label-primary">${s.name }</span>
                            </c:forEach>
                        </td>
                    </tr>
	              	<tr>
	              		<th width="10%">备注</th>
		                <td colspan="3"><p class="text-muted well well-sm no-shadow">${goods.remarks}</p></td>
	              	</tr>
	     		</table>
	    	</div>
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">配置</p>
	    	<div class="table-responsive">
	    		<table class="table">
	     			<tr>
		                <th width="10%">业务设置</th>
		                <td>
								<c:choose>
									<c:when test="${goods.isCouponUsable eq '1' }">
										<span class="label label-success">可使用优惠券</span>
									</c:when>
									<c:otherwise>
										<span class="label label-primary">禁止使用优惠券</span>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${goods.isRecommend eq '1' }">
										<span class="label label-success">推荐商品</span>
									</c:when>
								</c:choose>
		                
						</td>
	              	</tr>
	     		</table>
	    	</div>
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">属性</p>
	    	<div class="table-responsive">
	    		<table class="table table-striped">
	    			<c:forEach items="${goods.goodsProp }" var="goodsProp" varStatus="stats">
	    				<c:if test="${stats.index%2 == 0 }"><tr></c:if>
	    					<th width="10%">${goodsProp.property.propName }</th>
							<td width="40%">
								<c:forEach items="${goodsProp.goodsPropvalue }" var="goodsPropvalue">
									${goodsPropvalue.pvalue }&nbsp;&nbsp;
								</c:forEach>
							</td>
						<c:if test="${stats.index%2 != 0 }"></tr></c:if>
					</c:forEach>
	     		</table>
	    	</div>
	    </section>
	    
	    <section class="invoice">
            <p class="lead">关联商品</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <tr>
                        <th>名称</th>
                        <th>商品编码</th>
                        <th>展示价格</th>
                        <th>展示图(小)</th>
                        <th>状态</th>
                    </tr>
                    <c:forEach items="${relateGoodsList }" var="goods" >
                        <tr>
                            <td>${goods.name }</td>
                            <td>${goods.code }</td>
                            <td><span class="text-red">${goods.price }</span></td>
                            <td><img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(goods.photo, '|', '')}"  width="20px" height="20px" /></td>
                            <td><span class="label label-primary">${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}</span></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </section>
	    
	    <section class="invoice">
	    	<p class="lead">产品规格</p>
	    	<div class="table-responsive">
	     		<table id="contentTable" class="table table-striped">
                	<thead>
                	   <tr>
                	       <th>产品规格</th> 
                	       <th>产品编码</th>
                	       <th>原厂编码</th>
                	       <th>库存</th>
                	       <th>货位</th>
                	   </tr>
                	</thead>
                	<tbody>
                	   <c:forEach items="${goods.produces }" var="produce">
                	       <tr>
                	           <td>${produce.name }</td> 
	                           <td>${produce.code }</td>
	                           <td>${produce.factoryCode }</td>
	                           <td>${produce.stockNormal }</td>
	                           <td>${produce.fullWareplace}</td>
                	       </tr>
                	   </c:forEach>
                	</tbody>
                </table>
	    	</div>
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">展示信息</p>
	    	<div class="table-responsive">
	     		<table class="table">
	     			<tr>
		                <th width="10%">展示标题</th>
		                <td>${goods.title }</td>
	              	</tr>
	              	<tr>
		                <th width="10%">展示价格</th>
		                <td><span class="text-red">${goods.price }</span></td>
	              	</tr>
	              	<tr>
		                <th width="10%">展示故事</th>
		                <td><p class="text-muted well well-sm no-shadow">${goods.story }</p></td>
	              	</tr>
	              	<tr>
		                <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于搭配列表、搭配详情、购物车、订单'>展示图(小)</span></th>
		                <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${goods.icon }" alt="icon"></td>
	              	</tr>
	              	<tr>
		                <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于搭配详情商品展示部分'>展示图(大)</span></th>
		                <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${goods.photo }" alt="Photo"></td>
	              	</tr>
	              	<tr>
                        <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于搭配详情商品展示部分'>商品模特图</span></th>
                        <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${goods.modelPhoto }" alt="modelPhoto"></td>
                    </tr>
                    <tr>
                        <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于搭配详情商品展示部分'>商品证书图</span></th>
                        <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${goods.certificatePhoto }" alt="certificatePhoto"></td>
                    </tr>
	     		</table>
	    	</div>
	    </section>
	    
	    <div class="row">
	    	<div class="col-md-6">
			    <!-- 
			    <section class="invoice">
			    	<p class="lead">业绩</p>
			    	<div class="table-responsive">
			    		<table class="table">
			              	<tr>
				                <th width="10%">销售数量</th>
				                <td width="40%">${ goods.sellNum }</td>
			              	</tr>
			     		</table>
			    	</div>
			    </section>
			     -->
			    <section class="invoice">
			    	<p class="lead">商品图册</p>
			    	<div id="goodsPhotos" class="carousel slide " data-ride="carousel">
		          		<ol class="carousel-indicators">
		             			<c:forEach items="${goods.goodsResources }" varStatus="status">
		             				<c:choose>
		             					<c:when test="${status.index==0 }">
		             						<li data-target="#goodsPhotos" data-slide-to="${status.index }" class="active" style="background-color:#a7a7a7"></li>
		             					</c:when>
		             					<c:otherwise>
		             						<li data-target="#goodsPhotos" data-slide-to="${status.index }" class="" style="background-color:#a7a7a7"></li>
		             					</c:otherwise>
		             				</c:choose>
		             			</c:forEach>
		               </ol>
		               <div class="carousel-inner">
		                <c:forEach items="${goods.goodsResources }" var="goodsResources" varStatus="status">
		                	<c:choose>
             					<c:when test="${status.index==0 }">
             						<div class="item active"><img onerror="imgOnerror(this);"  src="${imgHost }${goodsResources.url}" ></div>
             					</c:when>
             					<c:otherwise>
             						<div class="item"><img onerror="imgOnerror(this);"  src="${imgHost }${goodsResources.url}" ></div>
             					</c:otherwise>
             				</c:choose>
		                </c:forEach>
		               </div>
		           	</div>
			    </section>
	    	</div>
	    	<div class="col-md-6">
	    		<section class="invoice">
			    	<p class="lead">描述</p>
			    	<div>
			     		<img src="${ctxStatic }/adminLte/dist/img/iphone6s-plus.png" width="100%" height="100%"/>
			     		<div style="position: absolute;height: 64%;width: 47.5%;overflow:hidden;margin:auto;top: 20.5%;left: 26.2%;">
			     			<div id="scrollWapper">
			     				<textarea id="goodsIntroduction">${goods.introduction }</textarea>
			     			</div>
			     		</div>
			    	</div>
			    </section>
	    	</div>
	    </div>
	    
	    <section class="invoice">
	    	<div class="row no-print">
	       		<div class="col-xs-12">
	       			<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	       		</div>
			</div>
	    </section>
	    
	</div>
</body>
</html>
