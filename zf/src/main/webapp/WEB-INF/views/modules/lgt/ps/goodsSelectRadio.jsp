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
		$(document).ready(function() {
			/* $("img").mouseover(function(e){
		    	var imgSrc = $(this).attr("data-src");
		    	var maxImg ="<div id='max' style='width:300px;height:300px;position:absolute;'><img src='"+imgSrc+"'></div>";
		    	//在body中添加元素
		    	$("body").append(maxImg);
		    	//设置层的top和left坐标，并动画显示层
		    	$("#max").css("top", e.pageY+20).css("left",e.pageX+10).show('slow'); 
		  	}).mouseout(function(){
		  		//鼠标移开删除大图所在的层
		    	$("#max").remove();
		  	}).mousemove(function(e){
		  		//鼠标移动时改变大图所在的层的坐标
		    	$("#max").css("top", e.pageY+20).css("left",e.pageX+10);
		  	}); */
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function rowCheck(obj){
			if($(obj).attr("checked")=="checked"){
				//$("input[name='selectName']").removeAttr("checked");
				$(obj).attr("checked","checked")
				//临时测试
				window.parent.builderTable("<tr id="+$(obj).val()+"><td>Trident</td><td>InternetExplorer 4.0</td><td>Win 95+</td><td> 4</td><td>X</td></tr>");
			}else{
				//临时测试 
				window.parent.removeTable($(obj).val());
			}
		}
		
		function clearQueryParam(){
			$("#categoryName").val("");
			$("#s2id_goodsStatus").select2("val","");
			$("#searchParameterKeyWord").val("");
		}
		
		
		
	</script>
</head>
<body>

    <div class="content-wrapper sub-content-wrapper">
        <section  class="content">
            <div class="box box-info"> 
                <div class="box-header with-border zf-query">
                    <h5>查询条件</h5>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
                    </div>
                </div>
                <form:form id="searchForm" modelAttribute="goods" action="${ctx}/lgt/ps/goods/selectRadio" method="post" class="form-horizontal">
                    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                    
                    <div class="box-body">
                        <div class="row">
                            <div class="row">
	                            <div class="col-md-4">
	                                <div class="form-group">
	                                    <label for="searchParameterKeyWord" class="col-sm-3 control-label" >关键字</label>
	                                    <div class="col-sm-7">
	                                        <form:input id="searchParameterKeyWord" path="searchParameter.keyWord" htmlEscape="false" maxlength="100" class="form-control" placeholder="请输入商品名称或编码查询"/>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="col-md-4">
	                                <sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="分类" tip="请选择分类" id="category" labelName="category.categoryName" name="category.id" labelWidth="3" inputWidth="7"></sys:inputtree>
	                            </div>
	                            <div class="col-md-4">
	                                <div class="form-group">
	                                    <label for="status" class="col-sm-3 control-label" >商品状态</label>
	                                    <div class="col-sm-7">
	                                        <form:select path="status" class="form-control select2">
	                                            <form:option value="" label="所有"/>
	                                            <form:options items="${fns:getDictList('lgt_ps_goods_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
	                                        </form:select>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="row">
	                            <div class="col-md-4">
	                                <div class="form-group">
	                                    <label for="searchParameterKeyWord" class="col-sm-3 control-label" >设计师</label>
	                                    <div class="col-sm-7">
	                                        <form:hidden id="designerId" path="designer.id"/>
	                                        <form:input id="designerName" path="designer.name" readonly="true" htmlEscape="false" maxlength="100" class="form-control zf-input-readonly" placeholder="请选择设计师"/>
	                                    </div>
	                                </div>
	                            </div>
	                            <sys:selectmutil id="designerSelect" title="设置所属设计师" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
	                            
	                            <div class="col-md-4">
	                                <div class="form-group">
	                                    <label for="searchParameterKeyWord" class="col-sm-3 control-label" >品牌</label>
	                                    <div class="col-sm-7">
	                                        <form:hidden id="brandId" path="brand.id"/>
	                                        <form:input id="brandName" path="brand.name" htmlEscape="false" readonly="true" maxlength="100" class="form-control zf-input-readonly" placeholder="请选择品牌"/>
	                                    </div>
	                                </div>
	                            </div>
	                            <sys:selectmutil id="brandSelect" title="设置所属品牌" url="" isDisableCommitBtn="true" width="1200" height="700" ></sys:selectmutil>
	                            
	                            <div class="col-md-4">
	                                <div class="form-group">
	                                    <label for="searchParameterKeyWord" class="col-sm-3 control-label" >标签</label>
	                                    <div class="col-sm-7">
	                                        <form:hidden id="tagsId" path="tags.id"/>
	                                        <form:input id="tagsName" path="tags.name" htmlEscape="false" maxlength="100" class="form-control" placeholder="请输入标签"/>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="pull-right box-tools">
                            <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                            <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
                        </div>
                    </div>
                </form:form>
                </div>
				<div class="box box-soild">
	                <div class="box-body">
	                    <div class="table-responsive">
	                        <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
	                            <thead>
	                                <tr>
	                                    <th>&nbsp;</th>
	                                    <th>商品编码</th>
						                <th>名称</th>
						                <th>样图</th>
						                <th>状态</th>
						                <th>分类名称</th>
						                <th>设计师</th>
						                <th>备注信息</th>
	                                </tr>
	                            </thead>
	                            <tbody>
									<c:forEach items="${page.list}" var="goods">
										<tr>
											<td>
												<input name="selGoods" type="radio" id="input_${goods.id }"  value="${goods.id}=${goods.code}=${goods.name}=${fns:getDictLabel(goods.status, 'lgt_ps_goods_status', '')}=${goods.photo}=${goods.designer.id}=${goods.designer.name}"/>
											</td>
											<td>
											    ${goods.code}
											</td>
											<td title="${goods.name}">
												${fns:abbr(goods.name,20)}
											</td>
											<td>
												<img onerror="imgOnerror(this);"  src="${imgHost }${goods.samplePhoto}" data-big data-src="${imgHost }${goods.samplePhoto}" width="20px" height="20px" />
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
												${goods.category.categoryName}
											</td>
											<td>
											    ${goods.designer.name }
											</td>
											<td>
												${fns:abbr(goods.remarks,15)}
											</td>
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
    <script type="text/javascript">
           $(function() {
        	   ZF.bigImg();
        	   
        	   var gids = "${selectedIds}";
        	   var arr = gids.split(",");
        	   for(var i = 0; i < arr.length; i++) {
        		   $("#input_"+arr[i]).iCheck('check');
        	   }
        	   
        	   $('input').iCheck({
                   checkboxClass : 'icheckbox_minimal-blue',
                   radioClass : 'iradio_minimal-blue'
               });
           });
    </script>
</body>
</html>