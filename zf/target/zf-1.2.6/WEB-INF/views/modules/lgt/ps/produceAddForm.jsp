<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>完善产品</title>
	<meta name="decorator" content="adminLte"/>
<%-- 	<%@include file="/WEB-INF/views/include/treeview.jsp" %> --%>
	<script type="text/javascript">
		$(document).ready(function() {
			initProduce2();
			initProduceProp();
		});

		var data=${fns:toJson(categoryProperty)};//所有属性

		var rowIndex=0;
		
        function initProduce2(){
            var temp="<div class=\"col-sm-4\"><input data-name=\"$name\" $checked $disabled data-index=$index type=\"checkbox\" value=\"$propvalue.id\">$propName</input>&nbsp;&nbsp;</div>";
            var priceProp=$("#priceProp")
            for(var i=0;i<data.length;i++){
                var check="";
                var disabled="";
                var html=temp.replace("$propvalue.id",data[i].id).replace("$propName",data[i].propName).replace("$index",i);
                //价格参数属性 自带的必填项，默认选中，产品规格数据里面已选择的，也要默认选中
                if(data[i].propType=="2"){
                    if(data[i].necessaryFlag=="1"){
                        check="checked";
                        disabled="data-disabled";
                        pricePropCheck(data[i],i,true);
                    }
                    //TODO
                    for(var j = 0; j < propData.length; j++) {
                    	if(propData[j].property.propName == data[i].propName) {
                    		 check="checked";
                             disabled="data-disabled";
                    	}
                    }
                    html=html.replace("$name","pricePropCheckBox").replace("$checkClick","pricePropCheck").replace("$checked",check).replace("$disabled",disabled);
                    priceProp.append(html);
                }
            }
            $("[data-disabled]").iCheck('disable');
        }
        
        var propData = ${fns:toJson(producePropvalue)};
        
        //初始化产品规格记录
        function initProduceProp() {
        	var th = $("#delTh");
        	var tr = $("#templateTr");
        	var exists = new Array();
        	//这个地方获取价格规格类参数的已选中项
        	$("#delTh").parent().find("th").each(function() {
        		$(this).remove();
        	});
        	var tbody = $("#tbodyContent");
        	
        	if(propData.length == 0) {//组装已选中的必填的规格参数
        		$("input[data-name=pricePropCheckBox]:checked").each(function() {
        			var name = $(this).parent().text().trim();
        			var index = $(this).attr("data-index");
                    tr.append("<th data-name-th=\""+index+"\" data-name='"+name+"' data-index="+index+">"+name+"</th>");
        		});
                //标题列留一操作列
                tr.append("<th  id='delTh' width='10'>&nbsp;</th>");
        	} else {
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
	       	    
	       	    //组装产品已有规格的标题列TH
	       	    for(var i = 0; i < exists.length; i++) {
	       	    	tr.append("<th data-name='"+exists[i]+"'>"+exists[i]+"</th>");
	       	    }
	       	    //标题列留一操作列
	       	    tr.append("<th  id='delTh' width='10'>&nbsp;</th>");
	       	    
	       	    //组装产品已有 规格的显示列TD
		       	var propLength = propData.length;
		        var html = "<tr>";
		        var c = 0;
		        
		        for(var j = 0; j < propLength; j++) {
		        	if(c == 0 && j == 0) {
		        		 html += "<input type='hidden' value='"+propData[j].produce.id+"' name='produces["+c+"].id'/><input type='hidden' value='"+propData[j].produce.name+"' name='produces["+c+"].name'/><input type='hidden' value='"+propData[j].produce.title+"' name='produces["+c+"].title'/>";
		        	}
		        	for(var a = 0; a < exists.length; a++) {//解决产品新增价格参数，数据显示错乱问题
			            if(exists[a] == propData[j].property.propName) {
				            var pId = propData[j].produce.id;
				            var nextPID = propData[j+1 < propLength ? j+1 : propLength-1].produce.id;
				            html += "<td>"+propData[j].propvalue.pvalueName+"</td>";
				            if(pId != nextPID) {
				            	c++;
							    html += "<td class='text-center' style='width:15px;'></td></tr><tr>";
				            	html += "<input type='hidden' value='"+propData[j+1].produce.id+"' name='produces["+c+"].id'/><input type='hidden' value='"+propData[j+1].produce.name+"' name='produces["+c+"].name'/><input type='hidden' value='"+propData[j+1].produce.title+"' name='produces["+c+"].title'/>";
				            }
			            } 
		        	}
		        }
		        html += "<td class='text-center' style='width:15px;'></td></tr>";
		        tbody.html(html);
        	}
	    }
        
        
        //规格参数选中
        function pricePropCheck(prop,index,check){
            var th=$("#delTh");
            var tr=th.parent();
            if(check){
                th.before("<th data-name-th=\""+index+"\" data-name='"+prop.propName+"' data-index="+index+">"+prop.propName+"</th>");
                //检测当前表格中是否已经有行记录
                var trs=$("#tbodyContent").children("tr");
                if(trs.length <= 0) 
                	return;
                for(var i=0;i<trs.length;i++){
                    var td=$("<td data-name-th=\""+index+"\">"+createInput(prop,"priceProp")+"</td>");
                    var tds=$(trs[i]).children("td");
                    $(tds[tds.length-1]).before(td);
                    $("select",td).select2();
                }
                
            }else{
                $("[data-name-th="+index+"]").remove();
                var ths=$("#priceTable").children().children().children('th');
                if(ths.length <= 1){
                    $("#tbodyContent").html("");
                }
            }
        }
		
        function createInput(prop,name){
            var isVerify="";
            var tip="";
            if(prop.necessaryFlag=='1'){
                tip="必须填写"
                isVerify="data-verify";
            }
            if(prop.valueType=="1"){
                var html="<select data-name=\""+name+"\" data-id=\""+prop.id+"\" "+isVerify+" placeholder='"+tip+"' class='form-control select2'>";
                html+="<option value=''></option>";
                for(var j=0;prop.propvalueList!=null&&j<prop.propvalueList.length;j++){
                    html+="<option value='"+prop.propvalueList[j].id+"'>"+prop.propvalueList[j].pvalueName+"</option>"
                }
                html+="</select>";
                return html;
            }
            if(prop.valueType=="2"){
                var html="<select data-name=\""+name+"\" data-id=\""+prop.id+"\" "+isVerify+" placeholder='"+tip+"' multiple class=\"multiSelect\">";
                html+="<option value=''></option>";
                for(var j=0;prop.propvalueList!=null&&j<prop.propvalueList.length;j++){
                    html+="<option value='"+prop.propvalueList[j].id+"'>"+prop.propvalueList[j].pvalueName+"</option>"
                }
                html+="</select>";
                return html;
            }  
            if(prop.valueType=="3"){
                return "<input data-name=\""+name+"\" data-id=\""+prop.id+"\" type=\"text\" "+isVerify+" placeholder='"+tip+"' maxlength=\"50\" class=\"form-control\" />"
            }
        }
		
		function addRow(cell){
            var ths=$("#priceTable").children().children().children('th');
            var trs=$("#tbodyContent").children("tr");
            if(ths.length <= 1 || data.length < 1){
                ZF.showTip("【产品规格参数】新增之前，请到菜单 物流管理 -> 商品结构管理 -> 属性管理里面设置 【价格规格参数】 ","info");
                return;
            }
            var tbody=$("#tbodyContent");
            var tr=$("<tr data-name='newTr'></tr>");
            
            for(var i=0;i<ths.length-1;i++){
                var index = $(ths[i]).attr("data-index");
                //按照 已选定的 产品规格顺序显示新增一行里面列的类型数据，比如材质对应材质的选项，切工对应切工的选项
                for(var j = 0; j < data.length; j++) {
	                var prop = data[j];
	                
	                if(prop.propName == $(ths[i]).attr("data-name")) {
		                var td=$("<td data-name-th=\""+index+"\">"+createInput(prop,"priceProp")+"</td>");
		                tr.append(td);
	                } 
                }
                
            }
            tr.append("<td class='text-center' style='width:15px;'><span class='close' onclick='delRow(this);' title='删除' style='display:block' >&times;</span></td>");
            tbody.append(tr);
            $("select",tr).select2();
            
        }
		
		function delRow(obj){
			$(obj).parent().parent().remove();
			rowIndex--;
			var delIndex=rowIndex-1;
			var delSpanId="#delSpan"+delIndex;
			console.log(delSpanId)
			$(delSpanId).css("display","block");
		}
		
		function formSubmit(obj){
			var verifyPass = true;
			var inputVals = new Array();
			var isExists = false;
			var isValNull = false;
			$("#tbodyContent").children("tr").each(function() {
				var name = '';
				$(this).find("td").each(function() {
					var str = "";
					var hasChildLength = $(this).children().length;
					if(hasChildLength > 0) {
						$(this).find("select").each(function() {
							str = $(this).find("option:selected").text();
							if(str.length <= 0) {
								isValNull = true;
							}
							name += str;
						});
						
						$(this).find("input").each(function() {
							str = $(this).val();
							if(str.length <= 0) {
                                isValNull = true;
                            }
							name += str;
						});
					} else {
						str = $(this).text();
						name += str;
					}
					
				});
				
				if(isValNull) {
	                ZF.showTip("产品规格不允许为空，请仔细核对！","warning");
	                verifyPass = false;
	            }
				
				if(inputVals.length <= 0) {
					inputVals.push(name);
				} else {
					for(var i = 0; i < inputVals.length; i++) {
		                if(inputVals[i] == name) {
		                    isExists = true;
		                    break;
		                } 
		            }
				}
				
				if(isExists) {
	                ZF.showTip("已录入的产品规格重复，请仔细核对！","warning");
	                verifyPass = false;
	            } else {
	            	inputVals.push(name);
	            }
			});
			
			
			if(!verifyPass)
			    return false;
			
			var trs=$("#tbodyContent").children("tr");
            var form=$("#inputForm");
            var temp="<input type=\"hidden\" data-type=\"formHidden\" name=\"$name\" value=\"$val\" />";
            $("[data-type=formHidden]").remove();
            var goodsPropIndex=0;
			
			//规格参数构造
            for(var i=0;i<trs.length;i++){
                var tr=$(trs[i]);
                var prices=$("[data-id]",tr);
                for(var j=0;j<prices.length;j++){
                    var info=$(prices[j]);
                    var id=info.attr("data-id");
                    var prop=getPropById(id);
                    //必填检测
                    var verify=info.attr("data-verify");
                    var val=prop.valueType=="3"?info.val():info.select2("val");
                    if(verify!=null&&(val==null||val.length<=0)){
                        ZF.showTip("【"+prop.propName+"】未填写！","danger")
                        isSubmit=false;
                    }
                    if(val==null)
                        continue;
                    if(prop.valueType=="1"){
                        var hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].property.id").replace("$val",prop.id)
                        form.append(hidden);
                        hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].propvalue.id").replace("$val",val);
                        form.append(hidden);
                    }
                    if(prop.valueType=="2"){
                        for(j=0;j<val.length;j++){
                            var hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].property.id").replace("$val",prop.id)
                            form.append(hidden);
                            hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].propvalue.id").replace("$val",val[j])
                            form.append(hidden);
                        }
                    }
                    if(prop.valueType=="3"){
                        var hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].property.id").replace("$val",prop.id)
                        form.append(hidden);
                        hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].pvalue").replace("$val",val);
                        form.append(hidden);
                    }
                    //2017-9-20，add，for:lgt_ps_property.title_flag
                    if(prop.titleFlag){
						var hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].titleFlag").replace("$val",prop.titleFlag);
						form.append(hidden);
					}
                }
            }
			
			return isSubmit;
		}
		
		function getPropById(id){
            for(var i=0;i<data.length;i++){
                if(id==data[i].id)
                    return data[i];
            }
        }
		
	</script>
</head>
<body>
	
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			 <h1>
			    <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/goods/list">商品列表</a></small>
                <small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/goods/addProduce?goodsId=${goods.id}&pageNo=${goods.page.pageNo }&pageSize=${goods.page.pageSize}">完善产品规格</a></small>
		      </h1>
		</section>
		<sys:tip content="${message}"/>
		<section class="content">
			<form:form id="inputForm" modelAttribute="goods" action="${ctx}/lgt/ps/goods/saveBatch" method="post" class="form-horizontal">
				<form:hidden path="id" />
				
				<input id="pageNo" name="pageNo" type="hidden" value="${goods.page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${goods.page.pageSize}"/>
				<div class="row">
					<div class="col-md-12">
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>商品基本信息</h5>
								<div class="box-tools pull-right">
						            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						          </div>
							</div>
							<div class="box-body">
							  <div class="row">
							    <div class="col-md-3">
									<div class="form-group">
										<label for="category.categoryName" class="col-sm-3 control-label">商品分类</label>
										<div class="col-sm-8">
											<form:hidden path="category.id"/>
											<form:input path="category.categoryName" readonly="true" class="form-control"/>
										</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<label for="title" class="col-sm-3 control-label">展示标题</label>
										<div class="col-sm-8">
											<form:input path="title" readonly="true" class="form-control"/>
										</div>
									</div>
								</div>
                                <div class="col-md-3">
									<div class="form-group">
										<label for="code" class="col-sm-3 control-label">商品编码</label>
										<div class="col-sm-8">
											<form:input path="code" readonly="true" class="form-control"/>
										</div>
									</div>
								</div>
                                <div class="col-md-3">
									<div class="form-group">
										<label for="name" class="col-sm-3 control-label">商品名称</label>
										<div class="col-sm-8">
											<form:input path="name" readonly="true" class="form-control"/>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
						
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>商品属性选择</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>    
                            </div>
                        </div>
                        
                        <div class="box-body">
                            <!-- <div class="row">
                                <div class="form-group">
                                    <label for="searchParam" class="col-sm-2 control-label text-blue" >参数说明类</label>
                                    <div id="infoProp" class="col-sm-10 zf-check-wrapper-padding">
                                        
                                    </div>
                                </div>
                            </div> -->
                            
                            <div class="row">
                                <div class="col-md-5">
	                                <div class="form-group">
	                                    <label for="searchParam" class="col-sm-2 control-label text-blue" >价格规格类
	                                       <!-- <input type="checkbox" name="producePropSelAll" id="producePropSelAll"/> -->
	                                    </label>
	                                    <div id="priceProp" class="col-sm-10 zf-check-wrapper-padding">
	                                        
	                                    </div>
	                                </div>
                               </div>
                            </div>
                        </div>
                    </div>
						
						
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>完善产品规格参数</h5>
								<div class="box-tools pull-right">
						            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						          </div>
							</div>
							<div class="box-body">
							    
                                <%-- <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                                  <thead>
                                        <tr>
                                            <c:forEach items="${categoryProperty}" var="property">
                                                <c:if test="${property.produceFlag=='1' }">
                                                    <th>${property.propName }</th>
                                                </c:if>
                                            </c:forEach>
                                            <th width="10">&nbsp;</th>
                                        </tr>
                                    </thead>
                                  <tbody>
                                      <tr>
	                                      <c:forEach items="${producePropvalue }" var="pp">
                                             <td>${pp.propvalue.pvalueName }</td>
	                                      </c:forEach>
                                      </tr>
                                  </tbody>
                                </table> --%>
							    
							    
								<table id="priceTable" class="table table-bordered table-hover table-striped zf-tbody-font-size" >
									<thead>
										<tr id="templateTr">
											<th  id="delTh" width="10">&nbsp;</th>
										</tr>
									</thead>
									<tbody id="tbodyContent" ></tbody>
									<tfoot>
										<tr>
											<td colspan="16"><a href="javascript:" onclick="addRow(null); " class="btn btn-success btn-sm"><i class="fa fa-plus"></i>新增</a></td>
										</tr>
									</tfoot>
								</table>
							</div>
							<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    					<div class="pull-right box-tools">
				               		<shiro:hasPermission name="lgt:ps:lgtPsProperty:edit"><button type="submit" class="btn btn-info btn-sm" onclick="return formSubmit(this)"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
					        	</div>
		    				</div>
						</div>
					</div>
					<%-- <div class="col-md-6">
						<div class="box box-success">
							<div class="box-header with-border zf-query">
								<h5>商品图册</h5>
								<div class="box-tools pull-right">
						            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
						          </div>
							</div>
							<div class="box-body">
								<div class="post">
									<div class="row margin-bottom">
										<div class="col-sm-12">
											<div class="row">
												<c:forEach items="${goods.goodsResources }" var="resources" varStatus="sta">
													<div class="col-sm-3">
														<a href="${resources.url }" target="_blank">
															<img class="img-responsive" alt="Photo" src="${resources.url }" />
															<input type="hidden" name="goodsResources[${sta.index }].url"  value="${resources.url }"/>
														</a>
													</div>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div> --%>
				</div>
			</form:form>
		</section>
	</div>
	<script type="text/javascript">
        $(function(){
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                disabledCheckboxClass: 'disabled',
                radioClass : 'iradio_minimal-blue'
            });
            
            /* $("[data-name=infoPropCheckBox]").on("ifChecked",function(){
                var prop=data[$(this).attr("data-index")];
                infoPropCheck(prop,true);
            })
            
            $("[data-name=infoPropCheckBox]").on("ifUnchecked",function(){
                var prop=data[$(this).attr("data-index")];
                infoPropCheck(prop,false);
            }) */
            
            $("[data-name=pricePropCheckBox]").on("ifChecked",function(){
                var index=$(this).attr("data-index");
                var prop=data[$(this).attr("data-index")];
                pricePropCheck(prop,index,true);
            })
            
            $("[data-name=pricePropCheckBox]").on("ifUnchecked",function(){
                var index=$(this).attr("data-index");
                var prop=data[$(this).attr("data-index")];
                pricePropCheck(prop,index,false);
            })
            
            //商品价格说明类 全选 
            /* $("#producePropSelAll").on("ifChecked", function() {
                $("input[data-name=pricePropCheckBox]").each(function() {
                    $(this).iCheck('check');
                }); 
            }).on("ifUnchecked", function() {
                $("input[data-name=pricePropCheckBox]").each(function() {
                    var disableFlag = $(this).attr("data-disabled");
                    if(disableFlag == undefined) {
                        $(this).iCheck('uncheck');
                    }
                }); 
            }); */
            
            
            
        })
    </script>
</body>
</html>
