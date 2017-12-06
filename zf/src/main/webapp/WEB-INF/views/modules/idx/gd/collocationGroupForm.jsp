<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搭配分组管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            ZF.bigImg();
            $("span[data-type='delBtn']").on("click",function(){
				$(this).parent().parent().remove();
			});
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/gd/collocation/">搭配列表</a></small>
            <small>|</small>
            <small><i class="fa-list-style"></i><a href="${ctx}/idx/gd/collocationGroup/list?collocation.id=${collocationGroup.collocation.id}">搭配分组列表</a></small>
            <shiro:hasPermission name="idx:gd:collocationGroup:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/idx/gd/collocationGroup/form?id=${collocationGroup.id}&collocation.id=${collocationGroup.collocation.id}">搭配分组${not empty collocationGroup.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="row">
            <div class="col-md-6">
                <form:form id="inputForm" modelAttribute="collocationGroup" action="${ctx}/idx/gd/collocationGroup/save" method="post" class="form-horizontal" onsubmit="return formSubmit();">
                    <div class="box box-success">
                        <div class="box-header with-border zf-query">
                            <h5>请完善表单填写</h5>
                            <div class="box-tools">
                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body">
                            <form:hidden path="id" />
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">所属搭配</label>
                                    <div class="col-sm-9">
                                        <input type="hidden" id="collocationId" name="collocation.id" value="${collocationGroup.collocation.id }"/>
                                        <input type="text" class="form-control zf-input-readonly" readonly="readonly" id="collocationName" value="${collocationGroup.collocation.name }"/>
                                    </div>
                                </div>
                                <sys:inputtree url="${ctx}/lgt/ps/category/categoryData" label="所属分类" tip="请选择分类" id="category" labelName="category.categoryName" name="category.id" labelWidth="2" inputWidth="9"></sys:inputtree>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">展示标题</label>
                                    <div class="col-sm-9">
                                        <sys:inputverify id="title" name="title" maxlength="50" tip="请输入展示标题" verifyType="0" isMandatory="false"  isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">展示图</label>
                                    <div class="col-sm-9">
                                        <form:hidden id="photo" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
                                        <sys:fileUpload input="photo" model="true" selectMultiple="false"></sys:fileUpload>
                                    </div>
                                </div>
                                <sys:inputtree name="deo.id" url="${ctx}/bas/video/videoTreeData?type=1" id="deo" label="视频选择" labelValue="" labelWidth="2" inputWidth="9"
                                               labelName="deo.code" value="" tip="请选择视频" ></sys:inputtree>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">关联商品</label>
                                    <div class="col-sm-9">
                                        <input type="hidden" id="relatGoodIds" name="relatGoodIds"/>
                                        <button type="button" class="btn btn-info" onclick="addGoods('${collocationGroup.collocation.name}')">选择商品</button>
                                        <table class="table table-bordered table-hover table-striped zf-tbody-font-size">
                                            <thead>
                                                <tr>
                                                    <th>商品编码</th>
                                                    <th>商品名称</th>
                                                    <th>展示图</th>
                                                    <th>排列序号</th>
													<th width="10">&nbsp;</th>
                                                </tr>
                                            </thead>
                                            <tbody id="addGoodsBody">
                                            <input type="text" id="goodsBody" value="${collocationGroup.ggList }" hidden/>
                                                <c:forEach items="${collocationGroup.ggList }" var="groupGoods">
                                                    <tr data-value=${ groupGoods.goods.id }>
                                                        <td>${groupGoods.goods.code }</td>
                                                        <td>${groupGoods.goods.name }</td>
                                                        <td><img onerror="imgOnerror(this);"  src="${imgHost }${groupGoods.goods.samplePhoto }" data-big data-src="${imgHost }${groupGoods.goods.samplePhoto }" width="20px;" height="20px;"/></td>
                                                        <td>
                                                            <input type="hidden" name="gid" value="${groupGoods.goods.id}"/>
                                                            <input type="text" class="form-control" name="gOrderNo" maxlength="8" placeholder="请输入序号，整数，必填" value="${groupGoods.orderNo }" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                                                        </td>
                                                        <td><span data-type='delBtn' style='display:block;' class='close' title='删除'>&times;</span></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">是否启用</label>
                                    <div class="col-sm-9">
                                       <sys:selectverify name="usableFlag" tip="请选择是否启用" verifyType="-1" dictName="yes_no" id="usableFlag"></sys:selectverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">排列序号</label>
                                    <div class="col-sm-9">
                                       <sys:inputverify name="orderNo" id="orderNo" verifyType="4" maxlength="8" tip="请输入正确的序号,整数，必填项" isSpring="true"></sys:inputverify>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">备注信息</label>
                                    <div class="col-sm-9">
                                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
                                    </div>
                                </div>
                            
                        </div>
                        <div class="box-footer">
                            <div class="pull-left box-tools">
                                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                            </div>
                            <div class="pull-right box-tools">
                                <%-- <c:if test="${empty collocationGroup.id}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                                </c:if> --%>
                                <shiro:hasPermission name="idx:gd:collocationGroup:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        <sys:selectmutil height="600" url="" width="1200" isDisableCommitBtn="true" title="商品编辑" id="goods"></sys:selectmutil>
    </section>
    </div>
    <script type="text/javascript">
	    function addGoods(name){
	        var url="${ctx}/lgt/ps/goods/select?pageKey=collocationGroup";
	        $("#goodsModal .modal-title").text("往搭配【 "+name+"】 添加/移除商品")
	        $("#goodsModalUrl").val(url);
	        $("#goodsModal").modal('toggle');
	        $("#goodsModal #commitBtn").unbind("click"); //去掉之前的click事件并重新绑定
            
	        var goodsArray = [];
            
            $("#goodsModal #commitBtn").on("click",function(){
                var content = $("#goodsModalIframe").contents().find("body");
                var addIds=new Array; //用于保存关联的商品ID数组
//                 $("#addGoodsBody").html("");
                $("input[type=checkBox]", content).each(function(){
                    if($(this).prop("checked")){
                    	var val = $(this).attr("data-goods");
                    	var valArr = val.split("=");
                    	goodsArray.push(valArr);
                        addIds.push(valArr[0]);
                    }
                });
                goodsArray = checkExsit(goodsArray);
                
                if(goodsArray){
                	for(let i=0;i<goodsArray.length;i++){
                        let html = "";
                     	html += "<tr data-value='"+goodsArray[i][0]+"'>";
                        html += "<td>"+goodsArray[i][1]+"</td>";
                        html += "<td>"+goodsArray[i][2]+"</td>";
                        html += "<td><img data-big data-src='${imgHost}"+goodsArray[i][4]+"'  src='${imgHost}"+goodsArray[i][4]+"' width='20px' height='20px'/></td>";
                        html += "<td><input type='hidden' name='gid' value='"+goodsArray[i][0]+"'/><input type='text' class='form-control' maxlength='8'  placeholder='请输入序号，整数，必填' name='gOrderNo' onkeyup=\"this.value=this.value.replace(/\\\D/g,'')\"  onafterpaste=\"this.value=this.value.replace(/\\\D/g,'')\"/></td>";
                        html+="<td><span data-type='delBtn' style='display:block;' class='close' title='删除'>&times;</span></td>";
        				html+="</tr>";
        				$("#addGoodsBody").append(html);
                    }
                	//给span绑定click事件,点击删除该行
    				$("span[data-type='delBtn']").on("click",function(){
    					$(this).parent().parent().remove();
    				});
                    //选择了搭配的商品才能做是否启用选择
                    $("#addGoodsBody").append("<input type=\"text\" id=\"usable\" value=\"use\" hidden/>");
                    $("#usable").val("used")
                }
                
                $("#relatGoodIds").val(addIds.join(","));
                
                //清楚check  table缓存
                window.localStorage.removeItem("collocationGroup");
                
                $("#goodsModal").modal('toggle');//关闭模态框
	        })  
	    }
	    
		
		//过滤已有数据
		function checkExsit(goodsArray){
// 			for(var i=0;i<goodsArray.length;i++){
// 				console.log(goodsArray[i]);
// 				$("#addGoodsBody").children('tr').each(function(){
// 					if(goodsArray != null && goodsArray!=undefined &&goodsArray.length>0){
// 						if(goodsArray[i][0]==$(this).attr("data-value")){
// 							goodsArray.splice(i,1);
// 							delete goodsArray[i];
// 						}
// 					}
// 				})
// 			}
			$("#addGoodsBody").children('tr').each(function(){
				for(var i=0;i<goodsArray.length;i++){
					if(goodsArray != null && goodsArray!=undefined &&goodsArray.length>0){
						if(goodsArray[i][0]==$(this).attr("data-value")){
							goodsArray.splice(i,1);
// 							delete goodsArray[i];
						}
					}
				}
			});
			
			return goodsArray;
		}
	    
	    
	    function formSubmit() {
	    	var flag = ZF.formSubmit();
	    	if(flag) {
	    		var collocationId = $("#collocationId").val();
	    		if(collocationId == null || collocationId == "") {
                    ZF.showTip("请先确定搭配","info");
                    flag = false;
                }
	    		var categoryId = $("#categoryId").val();
	    		if(categoryId == null || categoryId == "") {
                    ZF.showTip("请先选择分类","info");
                    flag = false;
                }
	    		var photo = $("#photo").val();
                if(photo == null || photo == "") {
                    ZF.showTip("请先上传展示图","info");
                    flag = false;
                }
                $("input[name='gOrderNo']").each(function() {
                    var gOrderNo = $(this).val();
                    if(gOrderNo == null || gOrderNo == "") {
                    	ZF.showTip("请输入关联商品的排列序号，整数","info");
                    	flag = false;
                    }
                });
                $("button[type=submit]").attr('disabled',false);
                var usable = $("#usable").val();
                var goodsBody = $("#goodsBody").val();
                if(usable==undefined && goodsBody == "[]"){
                    var value  = $('#usableFlag option:selected') .val();
                    if(value == '1'){
                        ZF.showTip("没选商品,不能启用","info");
                        flag = false;
                    }

                }
	    	}
	    	
	    	if(flag) {
	    		var res = new Array();
	    		$("input[name='gid']").each(function() {
	    			var gid = $(this).val();
	    			var gOrderNo = $(this).next().val();
	    			res.push(gid+"="+gOrderNo);
	    		});
	    		$("#relatGoodIds").val("");
	    		$("#relatGoodIds").val(res.join(","));
	    	}
	    	
	    	return flag;
	    }
    </script>
</body>
</html>