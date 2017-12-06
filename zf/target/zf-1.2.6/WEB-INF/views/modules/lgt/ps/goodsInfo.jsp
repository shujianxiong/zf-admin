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
		   	initProduceProp();
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
		
		
		
		 var propData = ${fns:toJson(producePropvalue)};
	        
        //初始化产品规格记录
        function initProduceProp() {
            var thead = $("#theadContent");
            var tbody = $("#tbodyContent");
            var exists = new Array();
            for(var i = 0; i < propData.length; i++) {
                var flag = false;
                for(var j = 0; j < exists.length; j++) {
                    if(propData[i].property.propName == exists[j]) {
                        flag = true;
                        break;
                    }
                }
                if(!flag) {
                    exists.push(propData[i].property.propName);
                } 
            }
            
            var headHtml = "<tr>";
            //组装产品已有规格的标题列TH
            for(var i = 0; i < exists.length; i++) {
                headHtml += "<th data-name='"+exists[i]+"'>"+exists[i]+"</th>";
            }
            headHtml += "</tr>";
            
            //组装产品已有 规格的显示列TD
            var propLength = propData.length;
            var html = "<tr>";
            for(var j = 0; j < propLength; j++) {
                 var pId = propData[j].produce.id;
                 var nextPID = propData[j+1 < propLength ? j+1 : propLength-1].produce.id;
                 html += "<td>"+propData[j].propvalue.pvalueName+"</td>";
                 if(pId != nextPID) {
                     html += "</tr><tr>";
                 }
            }
            html += "</tr>";
            
            thead.html(headHtml);
            tbody.html(html);
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
                        <td>
                            <c:forEach items="${supplierList}" var="s">
                                <span class="label label-primary">${s.name }</span>
                            </c:forEach>
                        </td>
						<th width="10%">产地</th>
						<td><span class="label label-primary">${fns:getDictLabel(goods.origin, 'goods_origin','') }</span> </td>
                    </tr>
	              	<tr>
	              		<th width="10%">备注</th>
		                <td colspan="3"><p class="text-muted well well-sm no-shadow">${goods.remarks}</p></td>
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
                        <th>商品样图</th>
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
	     		<table id="contentTable" class="table">
                	<thead id="theadContent"></thead>
                	<tbody id="tbodyContent"></tbody>
                </table>
	    	</div>
	    </section>
	    
	    <section class="invoice">
	    	<p class="lead">图片设置信息</p>
	    	<div class="table-responsive">
	     		<table class="table">
	              	<tr>
		                <th width="10%"><span data-toggle='tooltip' data-placement='top' data-original-title='用于搭配列表、搭配详情、购物车、订单'>商品样图</span></th>
		                <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${goods.samplePhoto }" alt="icon"></td>
	              	</tr>
	     		</table>
	    	</div>
	    </section>
	    
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
