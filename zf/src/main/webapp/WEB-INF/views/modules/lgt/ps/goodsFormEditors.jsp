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

		var data=${fns:toJson(categoryProperty)};//分类下包含父级属性
		
		function initProduce(){
			var temp="<div class=\"col-sm-3\"><input data-check-prop-id=$propId data-name=\"$name\" $checked $disabled data-index=$index type=\"checkbox\" value=\"$propvalue.id\">$propName</input>&nbsp;&nbsp;</div>";
			var infoProp=$("#infoProp");
			for(var i=0;i<data.length;i++){
				var check="";
				var disabled="";
				var html=temp.replace("$propvalue.id",data[i].id).replace("$propName",data[i].propName).replace("$index",i).replace("$propId",data[i].id);
				if(data[i].propType=="1"){
					if(data[i].necessaryFlag=="1"){
						check="checked";
						disabled="data-disabled";
 						infoPropCheck(data[i],true);
					}
					html=html.replace("$name","infoPropCheckBox").replace("$checkClick","infoPropCheck").replace("$checked",check).replace("$disabled",disabled);
					infoProp.append(html);
				}
			}
			$("[data-disabled]").iCheck('disable');
			
			initGoodsProp();
		}
		
 		function initGoodsProp(){
 			var goodsProp=${fns:toJson(goods.goodsProp)}
 			for(var i=0;i<goodsProp.length;i++){
 				var prop=getPropById(goodsProp[i].property.id);
 				if($("[data-id="+goodsProp[i].property.id+"]").length<=0){
 					var obj="[data-check-prop-id="+goodsProp[i].property.id+"]";
 					$(obj).iCheck("check");
 					infoPropCheck(prop,true);
 				}
 				if(prop.valueType=="1"&&goodsProp[i].goodsPropvalue!=null&&goodsProp[i].goodsPropvalue.length>=1){
 					$("[data-id="+goodsProp[i].property.id+"]").select2("val",goodsProp[i].goodsPropvalue[0].propvalue.id);
 				}
 				if(prop.valueType=="2"&&goodsProp[i].goodsPropvalue!=null){
					var array=[]
 					for(var j=0;j<goodsProp[i].goodsPropvalue.length;j++){
 						array.push(goodsProp[i].goodsPropvalue[j].propvalue.id)
 					}
 					$("[data-id="+goodsProp[i].property.id+"]").select2("val",array);
 				}
 				if(prop.valueType=="3"&&goodsProp[i].goodsPropvalue!=null&&goodsProp[i].goodsPropvalue.length>=1){
 					$("[data-id="+goodsProp[i].property.id+"]").val(goodsProp[i].goodsPropvalue[0].pvalue);
 				}
 			}
 		}
		
		//描述属性选中
 		function infoPropCheck(prop,check){
 			var temp="<div id=\"$idPanel\" class=\"col-md-4\" style=\"height:50px;width:30%;\"><div class=\"form-group\"><label class=\"col-sm-3 control-label\">$propName</label>"+
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
		
		
		function createInput(prop,name){
			var tip="";
			if(prop.necessaryFlag=='1'){
				tip="必须填写"
			}
			var isVerify="data-verify";
			if(prop.valueType=="1"){
				var html="<select data-name=\""+name+"\" data-id=\""+prop.id+"\" "+isVerify+" placeholder='"+tip+"' class='form-control select2'>";
				html+="<option value=''>请选择</option>";
				for(var j=0;prop.propvalueList!=null&&j<prop.propvalueList.length;j++){
					html+="<option value='"+prop.propvalueList[j].id+"'>"+prop.propvalueList[j].pvalueName+"</option>"
				}
				html+="</select>";
				return html;
			}
			if(prop.valueType=="2"){
				var html="<select data-name=\""+name+"\" data-id=\""+prop.id+"\" "+isVerify+" placeholder='"+tip+"' multiple class=\"multiSelect\">";
				html+="<option value=''>请选择</option>";
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
		
		function formSubmit(){
			var infos=$("[data-name=infoProp]");
			var trs=$("#tbodyContent").children("tr");
			var isSubmit=ZF.formSubmit();
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
                var val=prop.valueType=="3"?info.val():info.select2("val");
                if(verify!=null&&(val==null||val.length<=0)){
                    ZF.showTip("【"+prop.propName+"】未填写！","warning")
                    isSubmit=false;
                }
                if(val==null)
                    continue;
                if(prop.valueType=="1"){
                    var hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].property.id").replace("$val",prop.id)
                    form.append(hidden);
                    hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].goodsPropvalue[0].propvalue.id").replace("$val",val);
                    form.append(hidden);
                    goodsPropIndex++;
                }
                if(prop.valueType=="2"){
                    var hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].property.id").replace("$val",prop.id)
                    form.append(hidden);
                    for(j=0;j<val.length;j++){
                        hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].goodsPropvalue["+j+"].propvalue.id").replace("$val",val[j])
                        form.append(hidden);
                    }
                    goodsPropIndex++;
                }
                if(prop.valueType=="3"){
                    var hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].property.id").replace("$val",prop.id)
                    form.append(hidden);
                    hidden=temp.replace("$name","goodsProp["+goodsPropIndex+"].goodsPropvalue[0].pvalue").replace("$val",val);
                    form.append(hidden);
                    goodsPropIndex++;
                }
                
            }
            //规格参数构造
            /* for(var i=0;i<trs.length;i++){
                var tr=$(trs[i]);
                console.log(tr)
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
                    if(prop.valueType=="1"){
                        var hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].property.id").replace("$val",prop.id)
                        form.append(hidden);
                        hidden=temp.replace("$name","produces["+i+"].producePropValues["+j+"].propvalue.id").replace("$val",val);
                        form.append(hidden);
                    }
                }
            } */
            
			if(!isSubmit)
				$("button[type=submit]").attr('disabled',false);
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
        	    <small class="menu-active"><i class="fa fa-repeat"></i><a href="#this" onclick="location.reload();">商品${not empty goods.id?'修改':'添加'}</a></small>
        	</shiro:hasPermission>
	      </h1>
	    </section>
	    <sys:tip content="${message}"/>
		<section class="content">
			<form:form id="inputForm" modelAttribute="goods" action="${ctx}/lgt/ps/goods/save" method="post" class="form-horizontal" onsubmit="return formSubmit()">
			<form:hidden path="id"/>
			<input type="hidden" name="operateType" value="edit"/><!-- 商品操作方式为“修改”，保存后商品状态为新增 -->
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
											<sys:inputverify id="nameInput" name="name" tip="请输入商品名称，必填项" verifyType="99" isSpring="true" ></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">商品英文名称</label>
										<div class="col-sm-8">
											<sys:inputverify id="englishNameInput" name="englishName" tip="请输入商品英文名称" verifyType="99" isMandatory="false" isSpring="true" ></sys:inputverify>
										</div>
		    						</div>
		    					</div>
		    					<div class="col-md-4">
		    						<div class="form-group">
		    							<label class="col-sm-3 control-label">展示标题<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="用于前台商品展示名称">?</span></label>
										<div class="col-sm-8">
											<sys:inputverify id="titleInput" name="title" tip="请输入展示标题，必填项" verifyType="99" isSpring="true" ></sys:inputverify>
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
											<form:input path="factoryCode" htmlEscape="false" maxlength="50" class="form-control"  readOnly="true"/>
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
                                        <label class="col-sm-3 control-label">使用范围</label>
                                        <div class="col-sm-8">
                                            <sys:selectverify name="useRange" tip="请选择使用范围" verifyType="0" dictName="useRange" id="useRange"></sys:selectverify>
                                        </div>
                                    </div>
                                </div>
                            </div>
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
										<label class="col-sm-3 control-label">产地</label>
										<div class="col-sm-8">
											<sys:selectverify name="origin" tip="请选择产地" verifyType="0" dictName="goods_origin" id="origin"></sys:selectverify>
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
                                    <label for="searchParam" class="col-sm-1 control-label text-blue" >参数说明类
                                        <input type="checkbox" name="goodsPropSelAll" id="goodsPropSelAll" />
                                    </label>
                                    <div id="infoProp" class="col-sm-11 zf-check-wrapper-padding">
                                        
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
								<div class="col-md-6">
									<sys:inputtree name="deo.id" url="${ctx}/bas/video/videoTreeData?type=1" id="deo" label="视频选择" labelValue="" labelWidth="2" inputWidth="8"
												   labelName="deo.code" value="" tip="请选择视频" ></sys:inputtree>
								</div>
							</div>
	    				<div class="row">
                               <div class="col-md-12">
                                   <div class="form-group">
                                       <label class="col-sm-1 control-label">商品样图<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:搭配列表、购物车、订单确认等">?</span></label>
                                       <div class="col-sm-8">
                                           <form:hidden id="samplePhoto" path="samplePhoto" htmlEscape="false" maxlength="255" class="form-control"/>
                                           <sys:fileUpload input="samplePhoto" model="true" selectMultiple="false"></sys:fileUpload>
                                       </div>
                                   </div>
                               </div>
                           </div>
	    				   <div class="row">
	                            <div class="col-md-12">
	                                <div class="form-group">
	                                    <label class="col-sm-1 control-label">商品模特图<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:奢华珠宝详情">?</span></label>
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
											<form:hidden id="goodsResourcesUrlStr" path="goodsResourcesUrlStr" htmlEscape="false" maxlength="255" class="form-control"/>
	                                        <sys:fileUpload input="goodsResourcesUrlStr" model="true" selectMultiple="true"></sys:fileUpload>
										</div>
		    						</div>
		    					</div>
		    				</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label class="col-sm-1 control-label">单品列表图<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于列表展示">?</span></label>
										<div class="col-sm-8">
											<form:hidden id="singlePhoto" path="singlePhoto" htmlEscape="false" maxlength="255" class="form-control"/>
											<sys:fileUpload input="singlePhoto" model="true" selectMultiple="false"></sys:fileUpload>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label class="col-sm-1 control-label">单品图册<span data-toggle="tooltip" title="" class="badge bg-light-blue" data-original-title="前端适用于:搭配详情、奢华珠宝详情、古董珠宝详情">?</span></label>
										<div class="col-sm-8">
											<form:hidden id="singleResourcesUrlStr" path="singleResourcesUrlStr" htmlEscape="false" maxlength="255" class="form-control"/>
											<sys:fileUpload input="singleResourcesUrlStr" model="true" selectMultiple="true"></sys:fileUpload>

										</div>
									</div>
								</div>
							</div>
		    				<div class="row">
		    					<div class="col-md-12">
		    						<div class="form-group">
		    							<label class="col-sm-1 control-label">商品描述</label>
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
				/* disabledCheckboxClass: 'disabled', */
				radioClass : 'iradio_minimal-blue'
			});
			
			/* $('input').iCheck("disable"); */
			
 			$("[data-name=infoPropCheckBox]").on("ifChecked",function(){
 				var prop=data[$(this).attr("data-index")];
 				infoPropCheck(prop,true);
 			})
			
 			$("[data-name=infoPropCheckBox]").on("ifUnchecked",function(){
 				var prop=data[$(this).attr("data-index")];
 				infoPropCheck(prop,false);
 			})
			
 			//商品参数说明类 全选 
            $("#goodsPropSelAll").on("ifChecked", function() {
                $("input[data-name=infoPropCheckBox]").each(function() {
                    $(this).iCheck('check');
                }); 
            }).on("ifUnchecked", function() {
                $("input[data-name=infoPropCheckBox]").each(function() {
                    var disableFlag = $(this).attr("data-disabled");
                    if(disableFlag == undefined) {
                        $(this).iCheck('uncheck');
                    }
                }); 
            });
			
		})
	</script>
</body>
</html>
