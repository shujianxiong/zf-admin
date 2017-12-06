<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>产品促销记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
	    String.prototype.replaceAll  = function(s1,s2){     
	        return this.replace(new RegExp(s1,"gm"),s2);     
	    }  
    
	    function page(n,s){
	        $("#pageNo").val(n);
	        $("#pageSize").val(s);
	        
	        
	        var arr = new Array();
            $("select[data-name=infoProp]").each(function(){
                var selVal = $(this).val();
                var propertyId = $(this).attr("data-id");
                var propType = $(this).attr("data-type");
                if(selVal != null && selVal != '' && selVal != undefined) {
                    arr.push(propType+"T"+propertyId+"="+selVal.toString().replaceAll(',','〓'));
                }
            });
            
            $("#propvalueArr").val(arr.join(","));
	        
	        
	        
	        $("#searchForm").submit();
	        return false;
	    }
         
        $(document).ready(function() {
        	
            initWhereCause();
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
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
            
        });
        
        var data=${fns:toJson(propertyList)};//所有属性
        function initWhereCause(){
            var temp="<div class=\"col-sm-3\"><input data-name=\"$name\" data-index=$index type=\"checkbox\" value=\"$propvalue.id\">$propName</input>&nbsp;&nbsp;</div>";
            var infoProp=$("#infoProp");
            for(var i=0;i<data.length;i++){
                var html=temp.replace("$propvalue.id",data[i].id).replace("$propName",data[i].propName).replace("$index",i);
                html=html.replace("$name","infoPropCheckBox").replace("$checkClick","infoPropCheck");
                infoProp.append(html);
            }
            
            var str="${produce.propvalueArr}";
            if(str.length != 0) {
	            initSelectedProp(str);
            } 
        }
        
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
        
        function initSelectedProp(str){
            var arr = str.split(',');
            for(var i=0;i<arr.length;i++){
            	var pvArr = arr[i].split('=');
            	var pid = pvArr[0].split('T')[1];
            	var pvid = pvArr[1].replaceAll('〓',',');
            	
                var prop=getPropById(pid);
                if($("[data-id="+pid+"]").length<=0){
                    var obj="[data-check-prop-id="+pid+"]";
                    $(obj).iCheck("check");
                    infoPropCheck(prop,true);
                }
                
                $("input[data-name=infoPropCheckBox]").each(function() {
                    if($(this).val() == pid) {
                        $(this).iCheck("check");
                    }
                });
                
                if(prop.valueType=="0"){
                    $("[data-id="+pid+"]").val(pvid);
                } else {
                	var pvidArr = pvid.split(',');
                    $("[data-id="+pid+"]").select2("val",pvidArr);
                }
            }
        }
        
        function getPropById(id){
            for(var i=0;i<data.length;i++){
                if(id==data[i].id)
                    return data[i];
            }
        }
        
        function createInput(prop,name){
            var tip="";
            if(prop.necessaryFlag=='1'){
                tip="必须填写"
            }
            var isVerify="data-verify";
            if(prop.valueType=="0"){
                return "<input data-name=\""+name+"\" data-type=\""+prop.propType+"\" data-id=\""+prop.id+"\" type=\"text\" "+isVerify+" placeholder='"+tip+"' maxlength=\"50\" class=\"form-control\" />"
            } else {
                var html="<select data-name=\""+name+"\"  data-type=\""+prop.propType+"\" data-id=\""+prop.id+"\" "+isVerify+" placeholder='"+tip+"' multiple class=\"multiSelect\" >";
                // html+="<option value=''>请选择</option>";
                for(var j=0;prop.propvalueList!=null&&j<prop.propvalueList.length;j++){
                    html+="<option value='"+prop.propvalueList[j].id+"'>"+prop.propvalueList[j].pvalueName+"</option>"
                }
                html+="</select>";
                return html;
            }  
        }
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/spm/pd/discount/">产品促销记录列表</a></small>
            <shiro:hasPermission name="spm:pd:discount:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/spm/pd/discount/form?id=${discount.id}">产品促销设置</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <form:form id="searchForm" modelAttribute="produce" action="${ctx}/spm/pd/discount/search" method="post" class="form-horizontal">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5 class="box-title">筛选属性</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                        
                            <input id="propvalueArr" name="propvalueArr" type="hidden" />
                            
                            <div class="row">
                                <div class="form-group">
                                    <label for="searchParam" class="col-sm-1 control-label text-blue">属性</label>
                                    <div id="infoProp" class="col-sm-11 zf-check-wrapper-padding">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                             <div class="col-md-12">
                                 <div class="box-header with-border zf-query">
                                     <h5 class="box-title">筛选属性值</h5>
                                     <div class="box-tools">
                                         <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>    
                                     </div>
                                 </div>
                                 <div id="infoPropPanel" class="box-body">
                                    
                                 </div>
                             </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                 <div class="box-header with-border zf-query">
                                     <h5 class="box-title">附加筛选条件</h5>
                                     <div class="box-tools">
                                         <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>    
                                     </div>
                                 </div>
                                 <div class="box-body">
                                     <div class="col-md-4" style="height:50px;width:30%;">
                                         <div class="form-group">
                                             <label for="goodsCode" class="col-sm-3 control-label" >商品编码</label>
                                             <div class="col-sm-8">
                                                 <input id="goodsCode" name="goods.code" value="${produce.goods.code }" htmlEscape="false" maxlength="30" class="form-control" placeholder="请输入商品编码查询"/>
                                             </div>
                                         </div>
                                     </div>
                                     <div class="col-md-4" style="height:50px;width:30%;">
                                         <div class="form-group">
                                             <label for="code" class="col-sm-3 control-label" >产品编码</label>
                                             <div class="col-sm-8">
                                                 <input id="code" name="code" value="${produce.code }" htmlEscape="false" maxlength="30" class="form-control" placeholder="请输入产品编码查询"/>
                                             </div>
                                         </div>
                                     </div>
                                     <div class="col-md-4" style="height:50px;width:30%;">
                                         <div class="form-group">
                                             <label for="code" class="col-sm-3 control-label" >价格范围</label>
                                             <div class="col-sm-8">
                                                 <div class="input-group">
                                                     <input type="text" id="minPrice" name="minPrice" value="${produce.minPrice }" maxlength="6" class="form-control" placeholder="最低价格">
                                                     <span class="input-group-addon"><i class="fa fa-minus"></i></span>
                                                     <input type="text" id="maxPrice" name="maxPrice" value="${produce.maxPrice }" maxlength="10" class="form-control" placeholder="最高价格">
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <div class="pull-right box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="resetWhere()"><i class="fa fa-refresh"></i>重置</button>
                                <button type="button" id="searchBtn" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        <div class="box box-soild">
                <div class="box-body">
                    <shiro:hasPermission name="spm:pd:discount:edit">
                        <div class="row">
                            <div class="col-sm-12 pull-right">
                                <button type="button" id="saveBtn" class="btn btn-success btn-sm"><i class="fa fa-save"></i>添加促销</button>   
                            </div>
                        </div>
                    </shiro:hasPermission>
                    <div class="table-reponsive">
                        <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                            <thead>
                                <tr>
                                    <th class="zf-dataTables-multiline"></th>
                                    <th>商品编码</th>
                                    <th>商品分类</th>
                                    <th>商品名称</th>
                                    <th>商品样图</th>
                                    <th>商品状态</th>
                                    <th>产品编码</th>
                                    <th>产品名称</th>
                                    <th>产品状态</th>
                                    <th>风格类型</th>
                                    <th>采购价</th>
                                    <th>购买价</th>
                                    <th>体验费比例</th>
                                    <th>体验押金比例</th>
                                    <th>积分可抵金额</th>
                                    <th>销量</th>
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
                                    <td class="details-control text-center"><i class="fa fa-plus-square-o text-success"></i></td>
                                    <td>${produce.goods.code}</td>
                                    <td>${produce.goods.category.categoryName}</td>
                                    <td title="${produce.goods.name }">
                                        ${fns:abbr(produce.goods.name,20)}
                                    </td>
                                    <td><img onerror="imgOnerror(this);"  src="${imgHost }${produce.goods.samplePhoto}" data-big data-src="${imgHost }${produce.goods.samplePhoto}" width="21" height="21" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${produce.goods.status == 1 }"><span class="label label-default">${fns:getDictLabel(produce.goods.status,'lgt_ps_goods_status','') }</span></c:when>
                                            <c:when test="${produce.goods.status == 2 }"><span class="label label-success">${fns:getDictLabel(produce.goods.status,'lgt_ps_goods_status','') }</span></c:when>
                                            <c:when test="${produce.goods.status == 3 }"><span class="label label-primary">${fns:getDictLabel(produce.goods.status,'lgt_ps_goods_status','') }</span></c:when>
                                            <c:otherwise><span class="label label-danger">${fns:getDictLabel(produce.goods.status,'lgt_ps_goods_status','') }</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${produce.code}</td>
                                    <td title="${produce.name}">
                                        ${fns:abbr(produce.name, 20)}
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
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(produce.styleType, 'lgt_ps_produce_styleType', '') }</span>
                                    </td>
                                    <td class="zf-table-money"><span class="text-red">${produce.pricePurchase }</span></td>
                                    <td class="zf-table-money"><span class="text-red"><font class="price-buy-font">${produce.priceSrc }</font></span></td>
                                    <td>${produce.scaleExperienceFee }</td>
                                    <td>${produce.scaleExperienceDeposit }</td>
                                    <td>${produce.priceDecPoint }</td>
                                    <td>
                                       ${produce.sellNum }
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
                                            <button type="button" class="btn btn-xs btn-info" onclick="window.location.href='${ctx}/lgt/ps/produce/info?id=${produce.id }'">详情</button>
                                            <button type="button" class="btn btn-xs btn-info dropdown-toggle" data-toggle="dropdown">
                                               <span class="caret"></span>
                                            </button>
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
        
        <div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="录入产品促销折扣信息" aria-hidden="true">
           <div class="modal-dialog" style="width:60%;height:80%;" >
                  <div class="modal-content" style="width:100%;height:100%;">
                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">录入产品促销折扣信息</h4>
                     </div>
                     <div class="modal-body">
                        <form:form id="inputForm" modelAttribute="discount" action="${ctx}/spm/pd/discount/save" method="post" class="form-horizontal" >
                              
                              <input id="propertyArr" name="propertyArr" type="hidden" />
                              <input id="produceIdList" name="produceIdList" type="hidden" value="${produceIdList }"/>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">折扣标题</label>
                                  <div class="col-sm-7">
                                      <sys:inputverify id="title" name="title" tip="请输入标题,必填项" verifyType="99"  maxlength="50" isMandatory="true" isSpring="true"></sys:inputverify>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">体验押金比例</label>
                                  <div class="col-sm-7">
                                      <sys:inputverify id="scaleExperienceDeposit" name="scaleExperienceDeposit" tip="请输入体验押金比例,必填项,两位小数" verifyType="9"  maxlength="4" isMandatory="true" isSpring="true"></sys:inputverify>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">筛选促销折扣</label>
                                  <div class="col-sm-7">
                                      <sys:inputverify id="discountFilterScale" name="discountFilterScale" tip="请输入执行折扣,必填项,两位小数" verifyType="9"  maxlength="4" isMandatory="true" isSpring="true"></sys:inputverify>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">筛选促销生效时间</label>
                                  <div class="col-sm-7">
                                      <sys:datetime id="discountFilterStart" inputName="discountFilterStart" tip="请选择执行生效时间" inputId="startTimeId" value="${discount.discountFilterStart}"></sys:datetime>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">筛选促销失效时间</label>
                                  <div class="col-sm-7">
                                      <sys:datetime id="discountFilterEnd" inputName="discountFilterEnd" tip="请选择执行失效时间" inputId="endTimeId" value="${discount.discountFilterEnd}"></sys:datetime>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">积分可抵金额</label>
                                  <div class="col-sm-7">
                                      <sys:inputverify id="priceDecPoint" name="priceDecPoint" tip="请输入积分可抵金额,必填项,两位小数" verifyType="9"  maxlength="4" isMandatory="true" isSpring="true"></sys:inputverify>
                                  </div>
                              </div>
                              <div class="form-group">
                                  <label class="col-sm-3 control-label">备注信息</label>
                                  <div class="col-sm-7">
                                      <form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="200" class="form-control"/>
                                  </div>
                              </div>
	                     </form:form>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="commitBtn">提交生成</button>
                     </div>
                  </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        
    </section>
    <script type="text/javascript">
    $(function() {
    	
    	ZF.bigImg();
    	//表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : true,
            "order": [[ 1, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
                {"orderable":false,targets:10},
                {"orderable":false,targets:11},
                {"orderable":false,targets:12},
                {"orderable":false,targets:13},
                {"orderable":false,targets:14},
                {"orderable":false,targets:15},
                {"orderable":false,targets:16},
                {"orderable":false,targets:17},
                {"orderable":false,targets:18},
                {"orderable":false,targets:19},
                {"orderable":false,targets:20},
                {"orderable":false,targets:21}
            ],
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        });
    	
    	
    	$("#searchBtn").on("click", function() {
    		var boxLen = $("input[data-name=infoPropCheckBox]:checked").length;
    		var len = 0;
    		$("select[data-name=infoProp]").each(function(){
    			var selVal = $(this).val();
    			if(selVal != null && selVal != '' && selVal != undefined) {
    				len++;
    			}
    		});
    		var gcode = $("#goodsCode").val();
    		var code = $("#code").val();
    		var minPrice = $("#minPrice").val();
    		var minPrice = $("#maxPrice").val();
    		
    		if((boxLen == 0 || len == 0 || boxLen != len) && gcode == null && gcode == "" && code == null && code == "" && minPrice == "" && minPrice == null && maxPrice == null && maxPrice == "") {
    			ZF.showTip("请先选择查询条件!", "info");
    			return false;
    		}
    		var arr = new Array();
            $("select[data-name=infoProp]").each(function(){
            	var selVal = $(this).val();
                var propertyId = $(this).attr("data-id");
                var propType = $(this).attr("data-type");
                if(selVal != null && selVal != '' && selVal != undefined) {
                    arr.push(propType+"T"+propertyId+"="+selVal.toString().replaceAll(',','〓'));
                }
            });
            if(arr.length > 0) {
	            $("#propvalueArr").val(arr.join(","));
            }
    		$("#searchForm").submit();
    	});
    	
    	$("#saveBtn").on("click", function() {
    		var produceIdArr = $("#produceIdList").val();
            if(produceIdArr == null || produceIdArr == '' || produceIdArr.length == 0) {
                ZF.showTip("要添加促销的产品记录为空，请核对筛选条件及条件说明!", "info");
                return false;
            } else {
	    		$("#geneteModal").modal("show");    
            }
    	});
    	
    	$("#commitBtn").on("click", function() {
    		var flag = ZF.formSubmit();
    		if(flag) {
	    		var startTime = $("#startTimeId").val().trim();
	    		var endTime = $("#endTimeId").val().trim();
	    		if(startTime!=null&&startTime!=undefined&&startTime!=''&&endTime!=null&&endTime!=undefined&&endTime!=''&&startTime > endTime) {
	    			ZF.showTip("失效时间必须大于生效时间!", "info");
	    			return false;
	    		}
	    		var arr = new Array();
	    		$("select[data-name=infoProp]").each(function(){
	                var selVal = $(this).val();
	                var propertyId = $(this).attr("data-id");
	                if(selVal != null && selVal != '' && selVal != undefined) {
	                	arr.push(propertyId+"="+selVal.toString().replaceAll(',', '〓'));
	                }
	            });
	    		$("#propertyArr").val(arr.join(","));
	    		
	    		$("#inputForm").submit();
	    		$("#geneteModal").modal("hide");  
    		}
    	});
    });
    
    function resetWhere() {
    	$("input[data-name=infoPropCheckBox]").iCheck("uncheck");
    	$("#infoPropPanel").html("");
    }
    </script>
    </div>
</body>
</html>