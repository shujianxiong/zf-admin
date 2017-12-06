<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表管理</title>
	<meta name="decorator" content="adminLte"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			editor = CKEDITOR.replace( 'introduction', {
	            on: {
	                instanceReady: function( ev ) {
	                    this.dataProcessor.writer.setRules( 'p', {
	                        indent: false,
	                        breakBeforeOpen: false,   //<p>之前不加换行
	                        breakAfterOpen: false,    //<p>之后不加换行
	                        breakBeforeClose: false,  //</p>之前不加换行
	                        breakAfterClose: false    //</p>之后不加换行7
	                    });
	                }
	            }
	        });
			
			initProduce();
			
		});

		var data=${fns:toJson(categoryProperty)};//所有属性
		
		function initProduce(){
			var temp="<div class=\"col-sm-3\"><input data-name=\"$name\" $checked $disabled data-index=$index type=\"checkbox\" value=\"$propvalue.id\">$propName</input>&nbsp;&nbsp;</div>";
			var infoProp=$("#infoProp");
			var priceProp=$("#priceProp")
			for(var i=0;i<data.length;i++){
				var check="";
				var disabled="";
				var html=temp.replace("$propvalue.id",data[i].id).replace("$propName",data[i].propName).replace("$index",i);
				if(data[i].propType=="0"){
					if(data[i].necessaryFlag=="1"){
						check="checked";
						disabled="data-disabled";
						infoPropCheck(data[i],true);
					}
					html=html.replace("$name","infoPropCheckBox").replace("$checkClick","infoPropCheck").replace("$checked",check).replace("$disabled",disabled);
					infoProp.append(html);
				}
				if(data[i].propType=="1"){
					if(data[i].necessaryFlag=="1"){
						check="checked";
						disabled="data-disabled";
						pricePropCheck(data[i],i,true);
					}
					html=html.replace("$name","pricePropCheckBox").replace("$checkClick","pricePropCheck").replace("$checked",check).replace("$disabled",disabled);
					priceProp.append(html);
				}
			}
			$("[data-disabled]").iCheck('disable');
		}
		
		//描述属性选中
		function infoPropCheck(prop,check){
			var temp="<div id=\"$idPanel\" class=\"col-md-4\" style=\"height:50px;\"><div class=\"form-group\"><label class=\"col-sm-3 control-label\">$propName</label>"+
			"<div class=\"col-sm-8\">$input</div></div></div>";
			var panel=$("#infoPropPanel")
			if(check){
				var html=temp.replace("$id",prop.id).replace("$propName",prop.propName).replace("$input",createInput(prop,"infoProp"));
				panel.append(html);
				var obj="#"+prop.id+"Panel";
				$("select",obj).select2();
			}else{
				var obj="#"+prop.id+"Panel";
				$(obj).remove();
			}
		}
		
		//规格参数选中
		function pricePropCheck(prop,index,check){
			var th=$("#delTh");
			var tr=th.parent();
			if(check){
				th.before("<th data-name-th=\""+index+"\" data-index="+index+">"+prop.propName+"</th>")
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
					$("#tbodyContent").html("")
				}
			}
		}
		
		function createInput(prop,name){
			var tip="";
			if(prop.necessaryFlag=='1'){
				tip="必须填写"
			}
			var isVerify="data-verify";
			if(prop.valueType=="0"){
				return "<input data-name=\""+name+"\" data-id=\""+prop.id+"\" type=\"text\" "+isVerify+" placeholder='"+tip+"' maxlength=\"50\" class=\"form-control\" />"
			}
			if(prop.valueType=="1"){
				var html="<select data-name=\""+name+"\" data-id=\""+prop.id+"\" "+isVerify+" placeholder='"+tip+"' class='form-control select2' >";
				html+="<option value=''>请选择</option>";
				for(var j=0;prop.propvalueList!=null&&j<prop.propvalueList.length;j++){
					html+="<option value='"+prop.propvalueList[j].id+"'>"+prop.propvalueList[j].pvalueName+"</option>"
				}
				html+="</select>";
				return html;
			}
			if(prop.valueType=="2"){
				var html="<select data-name=\""+name+"\" data-id=\""+prop.id+"\" "+isVerify+" placeholder='"+tip+"' multiple class=\"multiSelect\" >";
				html+="<option value=''>请选择</option>";
				for(var j=0;prop.propvalueList!=null&&j<prop.propvalueList.length;j++){
					html+="<option value='"+prop.propvalueList[j].id+"'>"+prop.propvalueList[j].pvalueName+"</option>"
				}
				html+="</select>";
				return html;
			}  
		}
		
		function addRow(){
			var ths=$("#priceTable").children().children().children('th');
			var trs=$("#tbodyContent").children("tr");
			if(ths.length <= 1 || data.length < 1){
				ZF.showTip("请先在商品属性里面选择价格规格类参数<br/>如若没有，请在“属性管理”菜单中设置该商品对应分类的【价格决策类】","info");
				return;
			}
			var tbody=$("#tbodyContent");
			var tr=$("<tr></tr>");
			for(var i=0;i<ths.length-1;i++){
				var index=$(ths[i]).attr("data-index");
				var prop=data[index];
				var td=$("<td data-name-th=\""+index+"\">"+createInput(prop,"priceProp")+"</td>");
				tr.append(td);
			}
			tr.append("<td class='text-center' style='width:15px;'><span class='close' onclick='delRow(this);' title='删除' style='display:block' >&times;</span></td>");
			tbody.append(tr);
			$("select",tr).select2();
			
		}
		
		function delRow(obj){
			$(obj).parent().parent().remove();
		}
		
		function formSubmit(){
			
			if(data.length < 1) {
				ZF.showTip("该分类下没有绑定价格规格参数，导致后面的产品规格参数没办法选择，请先去完善分类", "warning");
				return false;
			}
			
			//第一部分的验证 
			var verify=true;
            var inputs=$("input[data-verify=false]",form);
            for(var i=0;i<inputs.length;i++){
                if($(inputs[i]).attr('data-type') == "date"){
                    $(inputs[i]).parent().trigger('dp.change');
                }else{
                    $(inputs[i]).trigger('change');
                }
                verify=false;
            }
            var selects=$("select[data-verify=false]",form);
            for(var i=0;i<selects.length;i++){
                $(selects[i]).trigger('change');
                verify=false;
            }
			var isSubmit = verify;
            if(!isSubmit)
                return false;
			
			//第二部分的验证  产品规格非空和重复验证      2016-10-11
			
			var verifyPass = true;
            var inputVals = new Array();
            var isExists = false;
            var isValNull = false;
            var trSize = $("#tbodyContent").children("tr").length;
            if(trSize == 0) {
            	ZF.showTip("产品规格不允许为空，请仔细核对！<br/> 请先选择【商品属性】里面的【价格规格类】参数 ","warning");
                verifyPass = false;
            } else {
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
	                        if(str.length <= 0) {
	                            isValNull = true;
	                        }
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
            }
            if(!verifyPass)
                return false;
			
			//===============第三 部分的验证
			var infos=$("[data-name=infoProp]");
			var trs=$("#tbodyContent").children("tr");
			var form=$("#inputForm");
			var temp="<input type=\"hidden\" data-type=\"formHidden\" name=\"$name\" value=\"$val\" />";
			$("[data-type=formHidden]").remove();
			var goodsPropIndex=0;
			//描述参数构造
			for(var i=0;i<infos.length;i++){
				var info=$(infos[i]);
				var id=info.attr("data-id");
				var prop=getPropById(id);
				//必填检测
				var verify=info.attr("data-verify");
				var val=prop.valueType=="0"?info.val():info.select2("val");
				if(verify!=null&&(val==null||val.length<=0)){
					ZF.showTip("【"+prop.propName+"】未填写！","warning")
					isSubmit=false;
				}
				if(val==null)
					continue;
				if(prop.valueType=="2"){
					var hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].property.id").replace("$val",prop.id)
					form.append(hidden);
					for(j=0;j<val.length;j++){
						hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].goodsPropvalue["+j+"].propvalue.id").replace("$val",val[j])
						form.append(hidden);
					}
					goodsPropIndex++;
				}
				if(prop.valueType=="0"){
					var hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].property.id").replace("$val",prop.id)
					form.append(hidden);
					hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].goodsPropvalue[0].pvalue").replace("$val",val);
					form.append(hidden);
					goodsPropIndex++;
				}
				if(prop.valueType=="1"){
					var hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].property.id").replace("$val",prop.id)
					form.append(hidden);
					hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].goodsPropvalue[0].propvalue.id").replace("$val",val);
					form.append(hidden);
					goodsPropIndex++;
				}
				
			}
			//规格参数构造
			for(var i=0;i<trs.length;i++){
				var tr=$(trs[i]);
				console.log(tr)
				var prices=$("[data-id]",tr);
				for(var j=0;j<prices.length;j++){
					var info=$(prices[j]);
					var id=info.attr("data-id");
					var prop=getPropById(id);
					//必填检测
					var verify=info.attr("data-verify");
					var val=prop.valueType=="0"?info.val():info.select2("val");
					if(verify!=null&&(val==null||val.length<=0)){
						ZF.showTip("【"+prop.propName+"】未填写！","danger")
						isSubmit=false;
					}
					if(val==null)
						continue;
					if(prop.valueType=="2"){
						for(j=0;j<val.length;j++){
							var hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].property.id").replace("$val",prop.id)
							form.append(hidden);
							hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].propvalue.id").replace("$val",val[j])
							form.append(hidden);
						}
					}
					if(prop.valueType=="0"){
						var hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].property.id").replace("$val",prop.id)
						form.append(hidden);
						hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].pvalue").replace("$val",val);
						form.append(hidden);
					}
					if(prop.valueType=="1"){
						var hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].property.id").replace("$val",prop.id)
						form.append(hidden);
						hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].propvalue.id").replace("$val",val);
						form.append(hidden);
					}
				}
			}
			/* if(!isSubmit)
				$("button[type=submit]").attr('disabled',false); */
			return isSubmit;
		}
		
		function getPropById(id){
			for(var i=0;i<data.length;i++){
				if(id==data[i].id)
					return data[i]
			}
		}
		
		function selectBrand(){
			var url="${ctx}/lgt/bs/brand/select";
			$(".modal-title").text("选择商品品牌")
			$("#goodsModalUrl").val(url);
			$("#commitBtn").unbind("click");
			$("#commitBtn").on("click",function () {
				var content = $("#goodsModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
				$("input[type=radio]", content).each(function(){
    				if($(this).prop("checked")){
	    				var id="#brandName"+$(this).val();
	    				$("#brandId").val($(this).val())
	    				$("#brandInput").val($(id,content).val())
	    				$("#goodsModal").modal('hide');
    				}
    			});
			});
			$("#goodsModal").modal('toggle');
		}
		
		function selectDesigner(){   
			var url="${ctx}/lgt/bs/designer/select";
			$(".modal-title").text("选择设计师")
			$("#goodsModalUrl").val(url);
			$("#commitBtn").unbind("click");
			$("#commitBtn").on("click",function () {
				var content = $("#goodsModalIframe").contents().find("body");//获取modal下iframe body，未做get封装，外部执行此行代码即可满足body可变性扩展
				$("input[type=radio]", content).each(function(){
    				if($(this).prop("checked")){
	    				var id="#designerName"+$(this).val();
	    				$("#designerId").val($(this).val())
	    				$("#designerInput").val($(id,content).val())
	    				$("#goodsModal").modal('hide');
    				}
    			});
			});
			$("#goodsModal").modal('toggle');
		}
		
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
	      <h1>
	        <small><i class="fa-list-style"></i><a href="${ctx}/lgt/ps/goods/list">商品列表</a></small>
	        <shiro:hasPermission name="lgt:ps:goods:edit">
		        <small>|</small>
        	    <small class="menu-active"><i class="fa fa-plus"></i><a href="#this" onclick="location.reload();">商品${not empty goods.id?'修改':'添加'}</a></small>
        	</shiro:hasPermission>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
		<section class="content">
			<form:form id="inputForm" modelAttribute="goods" action="${ctx}/lgt/ps/goods/save" method="post" class="form-horizontal" onsubmit="return formSubmit()">
			<form:hidden path="id"/>
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success">
		    			<div class="box-header with-border zf-query">
	    					<h5 class="box-title">基本参数设置</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                	</button>    
			              	</div>
	    				</div>
	    				<div class="box-body">
	    					<div class="row">
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">商品名称</label>
										<div class="col-sm-8">
											<sys:inputverify id="nameInput" name="name" tip="请输入商品名称，必填项" verifyType="0" isSpring="true" ></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">商品英文名称</label>
										<div class="col-sm-8">
											<sys:inputverify id="englishNameInput" name="englishName" tip="请输入商品英文名称" verifyType="0" isMandatory="false"  isSpring="true" ></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">展示标题<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="用于前台商品展示名称">?</span></label>
										<div class="col-sm-8">
											<sys:inputverify id="titleInput" name="title" tip="请输入展示标题，必填项" verifyType="0" isSpring="true" ></sys:inputverify>
										</div>
		    						</div>
		    					</div>
	    					</div>
	    					<div class="row">
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">商品分类</label>
										<div class="col-sm-8">
											<form:hidden path="category.id"/>
											<form:input path="category.categoryName" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">商品品牌</label>
                                        <div class="col-sm-8">
                                            <div class="input-group">
                                                <form:hidden id="brandId" path="brand.id"/>
                                                <form:input id="brandInput" path="brand.name" htmlEscape="false" maxlength="50" placeholder="请选择" readOnly="true" class="form-control zf-input-readonly"/>
                                                <span class="input-group-addon" onclick="selectBrand()"><i class="fa fa-search"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">设计师</label>
                                        <div class="col-sm-8">
                                            <div class="input-group">
                                                <form:hidden id="designerId" path="designer.id"/>
                                                <form:input id="designerInput" path="designer.name" htmlEscape="false" maxlength="50" placeholder="请选择" readOnly="true" class="form-control zf-input-readonly" onclick="selectDesigner()"/>
                                                <span class="input-group-addon" onclick="selectDesigner()"><i class="fa fa-search"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
		    				</div>
                            <div class="row">
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">原厂编码</label>
										<div class="col-sm-8">
											<form:input path="factoryCode" htmlEscape="false" maxlength="50" class="form-control"/>
										</div>
		    						</div>
		    					</div>
	    					
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">商品编码</label>
										<div class="col-sm-8">
											<form:input path="code" htmlEscape="false" maxlength="50" class="form-control" readOnly="true"/>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">商品销量</label>
                                        <div class="col-sm-8">
                                            <sys:inputverify id="sellNumInput" name="sellNum" tip="请输入商品销量，必填项" verifyType="4" isSpring="true" maxlength="8"></sys:inputverify>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">  
		    					<div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">使用范围</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="useRange" tip="请选择使用范围" verifyType="0" dictName="useRange" id="useRange"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-4" style="display: none;">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">展示价格</label>
                                        <div class="col-sm-8">
                                            <sys:inputverify id="priceInput" name="price" tip="请输入展示价格，必填项，格式为数字" value="0" verifyType="5" isSpring="true" maxlength="8"></sys:inputverify>
                                        </div>
                                    </div>
                                </div>
                                
	    					</div>
	    				</div>
	    			</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success">
						<div class="box-header with-border zf-query">
							<h5 class="box-title">业务参数设置</h5>
							<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                	</button>    
			              	</div>
						</div>
						<div class="box-body">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="searchParam" class="col-sm-3 control-label" >是否可用优惠券</label>
										<div class="col-sm-8 zf-check-wrapper-padding">
											<form:radiobuttons path="isCouponUsable" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="searchParam" class="col-sm-3 control-label" >是否推荐</label>
										<div class="col-sm-8 zf-check-wrapper-padding">
											<form:radiobuttons path="isRecommend" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
										</div>
									</div>
								</div>
								<div class="col-md-6">
                                    <div class="form-group">
                                        <label for="searchParam" class="col-sm-3 control-label" >是否设计师代表作</label>
                                        <div class="col-sm-8 zf-check-wrapper-padding">
                                            <form:radiobuttons path="isRepresentative" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
                                        </div>
                                    </div>
                                </div>
	    					</div>
						</div>
					</div>
				</div>			
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success">
		    			<div class="box-header with-border zf-query">
	    					<h5 class="box-title">商品属性选择</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                	</button>    
			              	</div>
	    				</div>
	    				
	    				<div class="box-body">
	    					<div class="row">
								<div class="form-group">
									<label for="searchParam" class="col-sm-1 control-label text-blue" >参数说明类</label>
									<div id="infoProp" class="col-sm-11 zf-check-wrapper-padding">
										
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="form-group">
									<label for="searchParam" class="col-sm-1 control-label text-blue" >价格规格类</label>
									<div id="priceProp" class="col-sm-11 zf-check-wrapper-padding">
										
									</div>
								</div>
							</div>
	    				</div>
	    			</div>
	    		</div>
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success">
		    			<div class="box-header with-border zf-query">
	    					<h5 class="box-title">参数说明配置</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                	</button>    
			              	</div>
	    				</div>
	    				<div id="infoPropPanel" class="box-body">
	    					
	    				</div>
	    			</div>
	    		</div>
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success">
		    			<div class="box-header with-border zf-query">
	    					<h5 class="box-title">产品规格参数</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                	</button>    
			              	</div>
	    				</div>
	    				<div class="box-body">
		    				<table id="priceTable" class="table table-bordered table-hover table-striped zf-tbody-font-size" >
								<thead>
									<tr>
										
										<th id="delTh" width="10"></th>
									</tr>
								</thead>
								<tbody id="tbodyContent" >
									
								</tbody>
								<tfoot>
									<tr>
										<td colspan="16">
											<button type="button" id="addBtn" class="btn btn-sm btn-success" onclick="addRow(null);"><i class="fa fa-plus">新增</i></button>
										</td>
									</tr>
								</tfoot>
							</table>
	    				</div>
	    			</div>
	    		</div>
			
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<div class="box box-success">
		    			<div class="box-header with-border zf-query">
	    					<h5 class="box-title">展示设置</h5>
			              	<div class="box-tools">
			                	<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                	</button>    
			              	</div>
	    				</div>
	    				<div class="box-body">
	    				<div class="row">
	    					<div class="col-md-12">
	    						<div class="form-group">
	    							<label class="col-sm-1 control-label">展示故事</label>
									<div class="col-sm-8">
										<form:textarea path="story" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
									</div>
	    						</div>
	    					</div>
	    				</div>
	    				<div class="row">
	    					<div class="col-md-12">
	    						<div class="form-group">
	    							<label class="col-sm-1 control-label">展示图(小)<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:搭配列表、购物车、订单确认等">?</span></label>
									<div class="col-sm-8">
										<%-- <form:hidden id="icon" path="icon" htmlEscape="false" maxlength="255" />
										<sys:ckfinder input="icon" type="images" uploadPath="/lgt/ps/goods" selectMultiple="false"/> --%>
										
										<form:hidden id="icon" path="icon" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="icon" model="true" selectMultiple="false"></sys:fileUpload>
										
									</div>
	    						</div>
	    					</div>
	    				</div>
	    				<div class="row">
	    					<div class="col-md-12">
	    						<div class="form-group">
	    							<label class="col-sm-1 control-label">展示图(大)<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:奢华珠宝详情">?</span></label>
									<div class="col-sm-8">
										<form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="photo" model="true" selectMultiple="false"></sys:fileUpload>
									</div>
	    						</div>
	    					</div>
	    				</div>
	    				<div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-sm-1 control-label">商品模特图<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于详情展示">?</span></label>
                                    <div class="col-sm-8">
                                        <form:hidden id="modelPhoto" path="modelPhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="modelPhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-sm-1 control-label">商品证书图<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于详情展示">?</span></label>
                                    <div class="col-sm-8">
                                        <form:hidden id="certificatePhoto" path="certificatePhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="certificatePhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                            </div>
                        </div>
	    				<div class="row">
	    					<div class="col-md-12">
	    						<div class="form-group">
	    							<label class="col-sm-1 control-label">商品图册<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:搭配详情、奢华珠宝详情、古董珠宝详情">?</span></label>
									<div class="col-sm-8">
										<%-- <form:hidden id="goodsResourcesUrlStr" path="goodsResourcesUrlStr" htmlEscape="false" maxlength="255" />
										<sys:ckfinder input="goodsResourcesUrlStr" type="images" uploadPath="/lgt/ps/goods" selectMultiple="true"/> --%>
										
										<form:hidden id="goodsResourcesUrlStr" path="goodsResourcesUrlStr" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="goodsResourcesUrlStr" model="true" selectMultiple="true"></sys:fileUpload>
										
									</div>
	    						</div>
	    					</div>
	    				</div>
	    				<div class="row">
	    					<div class="col-md-12">
	    						<div class="form-group">
	    							<label class="col-sm-1 control-label">商品描述<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:古董珠宝详情">?</span></label>
									<div class="col-sm-8">
										<textarea name="introduction">${goods.introduction }</textarea>
										<sys:preview id="preview"  title="商品描述预览" content="" width="1200" height="700"></sys:preview>
									</div>
	    						</div>
	    					</div>
	    				</div>
	    				<div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-sm-1 control-label">备注信息</label>
                                    <div class="col-sm-8">
                                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control "/>
                                    </div>
                                </div>
                            </div>
                        </div>
	    				</div>
	    				<div class="box-footer">
	    					<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
	    					<div class="pull-right box-tools">
				        		<!-- <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button> -->
			               		<shiro:hasPermission name="lgt:ps:goods:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
				        	</div>
	    				</div>
	    			</div>
	    		</div>
			</div>
			</form:form>
		</section>
	</div>
	
	<sys:selectmutil height="600" url="" width="1200" isDisableCommitBtn="true" title="商品编辑" id="goods" ></sys:selectmutil>
	
	<script type="text/javascript">
		$(function(){
			
			$('input').iCheck({
				checkboxClass : 'icheckbox_minimal-blue',
				disabledCheckboxClass: 'disabled',
				radioClass : 'iradio_minimal-blue'
			});
			
			$("[data-name=infoPropCheckBox]").on("ifChecked",function(){
				var prop=data[$(this).attr("data-index")];
				infoPropCheck(prop,true);
			})
			
			$("[data-name=infoPropCheckBox]").on("ifUnchecked",function(){
				var prop=data[$(this).attr("data-index")];
				infoPropCheck(prop,false);
			})
			
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
			
			
		})
	</script>
</body>
</html>
