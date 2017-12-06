<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>打包发货单表单</title>
    <meta name="decorator" content="adminLte"/>
    <script src='http://localhost:8000/CLodopfuncs.js'></script>
    
    <style id="printCss" type="text/css">
		.printDiv {
			position: absolute;
			display: flex;
			align-items: center;
            font-family: SimHei, "Microsoft YaHei";
		}

        #app{
	      position: relative;
	      margin: 0 auto;
	    }
	    .header{
	      font-size: 36pt;
          font-weight: bolder;
          text-align: center;
          vertical-align: middle;
          font-family: Arial, "Microsoft YaHei";
	    }
	    .sign{
	       font-size: 20px;
	    }
	    .company{
	      font-size: 20px;
	    }
	    .littlePic{
	    }
	    .receiveAddre{
	      font-size: 10pt;
          font-weight: bold;
	    }
	    .sendAddre{
	      font-size: 12px;
	    }
	    .bigPic{
	    }
       .OddNumbers{
	       font-size: 16px;
	    }
        .firstOrder{
            font-size: 20px;
            font-weight:bold
        }
	   .middlePic{
	    }
	   .littleOddNumbers{
	       font-size: 7pt;
	    }
	    .littlteReceiveAddre{
	       font-size: 7pt;
	    }
	    .littlteSendAddre{
	       font-size: 7pt;
	    }
   		keyframes rotate{
		from{-webkit-transform:rotate(0deg)}
		to{-webkit-transform:rotate(360deg)}
		}
		@-webkit-keyframes rotate{
		from{-webkit-transform:rotate(0deg)}
		to{-webkit-transform:rotate(360deg)}
		}
		@-moz-keyframes rotate{
		from{-moz-transform:rotate(0deg)}
		to{-moz-transform:rotate(360deg)}
		}
		@-ms-keyframes rotate{
		from{-ms-transform:rotate(0deg)}
		to{-ms-transform:rotate(360deg)}
		}
		@-o-keyframes rotate{
		from{-o-transform:rotate(0deg)}
		to{-o-transform:rotate(360deg)}
		}
</style>
</head>
<body>
    <!-- 隐藏打印栏 -->
    <div class="printDiv" id="app" style="display:none;">
	  <div class="printDiv header">普</div>
	  <div class="printDiv company">${sendOrder.receiveAreaStr}</div>
	  <div class="printDiv sign">ZF-DDH-${sendOrder.orderNo }</div>
	  <div class="printDiv littlePic"></div>
	  <div class="printDiv receiveAddre">${sendOrder.receiveName }&nbsp;&nbsp;&nbsp;&nbsp;${sendOrder.receiveTel }<br/>${sendOrder.receiveAreaStr}${sendOrder.receiveAreaDetail }</div>
	  <div class="printDiv sendAddre">${fns:getSysConfig('expressReceiverName').configValue}&nbsp;&nbsp;&nbsp;&nbsp;${fns:getSysConfig('expressReceiverPhone').configValue}<br/>${fns:getSysConfig('expressReceiverAddress').configValue}</div>
	  <div class="printDiv bigPic"></div>
	  <div class="printDiv OddNumbers">${sendOrder.expressNo }</div>
	  <div class="printDiv middlePic"></div>
	  <div class="printDiv littleOddNumbers">${sendOrder.expressNo }</div>
	  <div class="printDiv littlteReceiveAddre">${sendOrder.receiveName }&nbsp;&nbsp;&nbsp;&nbsp;${sendOrder.receiveTel }<br/>${sendOrder.receiveAreaStr}${sendOrder.receiveAreaDetail }</div>
	  <div class="printDiv littlteSendAddre">${fns:getSysConfig('expressReceiverName').configValue}&nbsp;&nbsp;&nbsp;&nbsp;${fns:getSysConfig('expressReceiverPhone').configValue}<br/>${fns:getSysConfig('expressReceiverAddress').configValue}</div>
	</div>
    <!-- 隐藏打印栏 -->

    <div class="content-wrapper sub-content-wrapper">
    <c:if test="${empty type }"><!-- 新增打印面单功能，需隐藏 -->
        <section class="content-header content-header-menu">
            <h1>
                <small><i class="fa-list-style"></i><a href="${ctx}/bus/ol/pickOrder/myPackageList">打包任务列表</a></small>
                <small>|</small>
                <small  class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/pickOrder/myPackageForm?id=${sendOrder.pickOrder.id}">打包发货单</a></small>
            </h1>
        </section>
    </c:if>
    <c:if test="${not empty type }"><!-- 新增打印面单功能，需隐藏 -->
        <section class="content-header content-header-menu">
            <h1>
                <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/sendOrder/">发货单列表</a></small>
<%--                 <shiro:hasPermission name="bus:ol:sendOrder:edit">
                    <small>|</small>
                    <small>
                        <i class="fa-form-edit"></i><a href="${ctx}/bus/ol/sendOrder/createTestData">生成发货单测试数据</a>
                    </small>
                </shiro:hasPermission> --%>
            </h1>
        </section>
    </c:if>
    <sys:tip content="${message}"/>
    <section class="content" >
        <div id="printSetup" class="box box-info" style="display:none">
            <div class="box-header with-border zf-query">
                <h5>打印设置</h5>
                <h6 style="color:red">面单打印设置有效期为一个月,期间不可修改；如想重置设置，在浏览器设置中清空浏览器cookie即可。</h6>
                <h6 style="color:red">ps:&nbsp;纸张&nbsp;宽10cm,&nbsp;高15cm&nbsp;&nbsp;&nbsp;&nbsp;推荐打印样式：4x6</h6>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="row">
                     <div class="col-md-6">
                         <div class="form-group">
                             <label for="Select01" class="col-sm-3 control-label">选择打印机</label>
                             <div class="col-sm-7">
                                 <select id="Select01" size="1">
                                    <option value="-1">请选择</option>
                                 </select>
                             </div>
                         </div>
                     </div>
                     
                     <div class="col-md-6">
                         <div class="form-group">
                             <label for="Select02" class="col-sm-3 control-label">选择纸张</label>
                             <div class="col-sm-7">
                                 <select id="Select02" size="1">
                                    <option value="-1">请选择</option>
                                 </select>
                             </div>
                         </div>
                     </div>
                 </div>
            </div>
            <div class="box-footer">
                <div class="pull-right box-tools">
                    <button id="printSetupBtn" type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>确定</button>
                </div>
            </div>
        </div>
        <div class="box box-soild">
            <div class="box-body">
                <form:form id="inputForm" modelAttribute="sendProduct" method="post" action="${ctx }/bus/ol/sendOrder/sendOrderOutConfirm">
                
                <input type="hidden" name="sendOrder.id" value="${sendOrder.id }"/>
                <input type="hidden" name="sendOrder.orderType" value="${sendOrder.orderType }"/>
                <input type="hidden" name="sendOrder.orderId" value="${sendOrder.orderId }"/>
                <input type="hidden" name="sendOrder.pickOrder.id" value="${sendOrder.pickOrder.id }"/>
                <input type="hidden" name="sendOrder.orderNo" value="${sendOrder.orderNo }"/>
                <input type="hidden" name="sendOrder.type" value="${sendOrder.type }"/>
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>发货单编号</th>
                                <td>${sendOrder.sendOrderNo }</td>
                                <th>下单时间</th>
                                <td><fmt:formatDate value="${sendOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <th>发货状态</th>
                                <td>${fns:getDictLabel(sendOrder.status, 'bus_ol_send_order_status', '')}</td>
                            </tr>
                            <tr>
                                <th>拣货人</th>
                                <td>${fns:getUserById(sendOrder.pickOrder.pickBy.id).name }</td>
                                <th>发货日期</th>
                                <td><fmt:formatDate value="${sendOrder.sendDate}" pattern="yyyy-MM-dd"/></td>
                                <th>激活标记</th>
                                <td>${fns:getDictLabel(sendOrder.activeFlag, 'yes_no', '')}</td>
                            </tr>
                            <tr>
                                <th>收货人</th>
                                <td>${sendOrder.receiveName }</td>
                                <th>收货地址</th>
                                <td>${sendOrder.receiveAreaStr }${sendOrder.receiveAreaDetail }</td>
                                <th>联系电话</th>
                                <td>${sendOrder.receiveTel }</td>
                            </tr>
                            <tr>
                                <th style="vertical-align:middle;">快递公司</th>
                                <td style="vertical-align:middle;">
                                    <input type="hidden" id="expressCompany" name="sendOrder.expressCompany" value="${sendOrder.expressCompany }"/>
                                    <select id="expressCompany2" style="width: 200px;" disabled="disabled">
                                        <option value="">请选择</option>
                                        <c:forEach items="${fns:getDictList('express_company')}" var="ec">
                                            <option value="${ec.value }" ${sendOrder.expressCompany eq ec.value ? 'selected':'' }>${ec.label }</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th style="vertical-align:middle;">快递单号</th>
                                <td id="exTd">
                                    <input type="hidden" id="expressNo" name="sendOrder.expressNo" value="${sendOrder.expressNo }"/>
                                    <input type="text" id="expressNo2" disabled  placeholder="请输入物流快递单号" value="${sendOrder.expressNo }"  class="form-control" maxlength="20"/>
                                </td>
                                <th style="vertical-align:middle;">是否首单</th>
                                <td style="vertical-align:middle;">
                                    <c:choose>
                                        <c:when test="${isFirstOrderFlag == true}">
                                            <span class="label label-success">是</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="label label-default">否</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td colspan="2">
                            </tr>
                            <tr>
                                <th>总件数</th>
                                <td id="totalNum" colspan="5"></td>
                            </tr>
                            <tr>
                                <th>样图</th>
                                <th>产品编码</th>
                                <th colspan="2">产品名称</th>
                                <th>正常库存</th>
                                <th>数量</th>
                                <th>货品编码</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sendOrder.sendProduceList}" var="sp" varStatus="status">
                                <c:set var="totalNum" value="${totalNum+sp.num }"/>
                                <input type="hidden" name="sendOrder.sendProduceList[${status.index }].id" value="${sp.id }"/>
                                <input type="hidden" name="sendOrder.sendProduceList[${status.index }].produce.id" value="${sp.produce.id }"/>
                                <tr data-index="${status.index }">
                                    <td>
                                        <img onerror="imgOnerror(this);" data-big data-src="${imgHost }${sp.produce.goods.samplePhoto}" src="${imgHost }${sp.produce.goods.samplePhoto}" width="100px;" height="100px;"/>
                                    </td>
                                    <td>
                                        ${sp.produce.code }
                                    </td>
                                    <c:set var="fullName" value="${sp.produce.goods.name} ${sp.produce.name}"></c:set>
                                    <td colspan="2" title="${fullName}">
                                    	${fns:abbr(fullName, 35)}
                                    </td>
                                    <td>
                                        ${sp.produce.stockNormal }
                                    </td>
                                    <td>
                                        ${sp.num }
                                    </td>
                                    <td>
                                       <c:forEach begin="1"  var="i" end="${sp.num }">
                                            <div id="codeDiv_${i }" style="width: 250px;"><input id="tscode_${i }" name="sendOrder.sendProduceList[${status.index }].productList[${i-1 }].code" data-compare="${sp.produce.id }" maxlength="15" placeholder="请扫描录入货品编码" class="form-control" style="width: 200px;margin-bottom: 5px;display: inline-block;"
                                                    <c:if test="${(not empty type) && (type eq 'read') }"> disabled="disabled" value="${sp.productList[i-1].code }" </c:if> /></div>
                                       </c:forEach>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                </form:form>
            </div>
            <div class="box-footer" id="div_footer">
                <c:if test="${empty type }"><!-- 新增打印面单功能，需隐藏 -->
                    <div class="pull-left box-tools">
                        <button type="button" class="btn btn-default btn-sm"   onclick="resetForm();" id="resetBtn"><i class="fa fa-mail-reply"></i>重置货品扫描(ctrl+z)</button>
                    </div>
                </c:if>
                <div class="pull-right box-tools">
                    <c:if test="${empty type }"><!-- 新增打印面单功能，需隐藏 -->
                        <button type="button" class="btn btn-default btn-sm"  onclick="hangUp('${sendOrder.id}', '${sendOrder.pickOrder.id }');"   id="hangUpBtn"><i class="fa fa-print"></i>挂起</button>&nbsp;&nbsp;
                    </c:if>
                    <c:choose>
                    	<c:when test="${empty type }">
		                    <button type="button" class="btn btn-info btn-sm"  onclick="formSubmit();"   id="submitBtn"><i class="fa fa-save"></i>打印面单并出库</button>&nbsp;&nbsp;
                    	</c:when>
                    	<c:otherwise>
		                    <button type="button" class="btn btn-default btn-sm"  onclick="printForm();"   id="printBtn"><i class="fa fa-print"></i>打印面单(ctrl+p)</button>&nbsp;&nbsp;
                    	</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
	     <!-- <div style="display: none;">
	        <textarea rows="28" id="t1" cols="85">
	            data:image/jpg;base64,
	/9j/4AAQSkZJRgABAgIAAAAAAAD//gAeQUNEIFN5c3RlbXMgRGlnaXRhbCBJbWFnaW5nAP/AABEI
	AEIAYwMBIgACEQEDEQH/2wCEABQNDxEPDBQREBEWFRQXHjIgHhsbHj0rLiQySD9MS0c/RkRQWnNh
	UFVsVkRGZIhlbHZ6gIKATWCNl4x9lnN+gHsBHyEhLSctWDAwWLl7aXu5ubm5ubm5ubm5ubm5ubm5
	ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5uf/EAHkAAQADAQEBAAAAAAAAAAAAAAAD
	BAUCAQYQAAICAgAFAgQDBwUAAAAAAAECAAMEEQUSIUFREzEiYXGBFDJCBiORobHB0VNykuHwAQEB
	AQEAAAAAAAAAAAAAAAAAAgEDEQEBAQEBAAMAAAAAAAAAAAAAARECURIxQf/aAAwDAQACEQMRAD8A
	+yiIgInk4stCnQ+JvAgdyNr0H5dsflIbXA+K5wo7Azmu2qwlUYEjrrWjqB22RZ2RR9TImzLl/Sh+
	xnVhAEo5FoEC0vE9H46v+JlmnMotOg+m8N0mGOaw9JMMZiOsDeiZFGRdikBtvX4PuPpNSq1Lqw9b
	BlPeB1ERA9iJTycglvSrP+4j+kDu6/ZKVnr3bxM7OsxMWotbUjOfYa6mT3WrjUc5GyeijyZm24L3
	g35DHmPXqdBRKk1luK9V19p5lJrTsAdn+P8AaaWM93MLvT9RAvINNonyRv3HSVMDFe12X1GalTvm
	+Xgf+6TSucVpoaAA0AO03q/hEFubW+1BIce6MNEfaVRzXWaEiy2W48rDm8fL6eJDZa+MPRFmwRtm
	/Uo8b+cmTWtH8XjYxKDmtsHuKxvX1PsJE/GdflxT97BMay9iOVBpR7ASAu2+pl/GJ1sX8UutQhQl
	W+4PMZ1wbP8AwmQK2Y+i50d9j5mMrmSKdysjNffRIOHMzcPoaz8xQb3LHScVqXEcr0VFSH94/fwJ
	WxhsgSHJYNxC7mPVWA+2pPjuqsIFHJyUt4siOdVoDr7f9ybJrOfYtFbgoPisYb19we/9YowfVJJ9
	MKrELbvZI34lxzVjU8lY0B1PknyZW+MxyxqxqRXWNKv85l5WSWJnmXl7JlFrOZpjUyuERrn9lG9e
	ZnF2tcs56k7b6yXMt5itCnovVvr2kI6S+YmvXOh0kDHrJGBY6A3L2DwPLyiGKciHu3SVbjJFClHs
	cIilmPYCfQcJ4NzMLL+oHYew/wAzSwODUYifEec9x7CaQAA0AAB2nO9eKwA0AANARESWsjjnDrrS
	MvDIF6jTIfZx/kTFTihqBXIRqbAO46b+s+ylPM4bj5Y+NdN5ExUz6rIpyj6QFbhlA10O5Dk5bkEG
	c5n7L2oS+HZyt5Q6mRdjcbxX1cllqeQm4lbefEt1pJMh/EcnXpvsJC5y2OjVdvwKyP7T2rhnEcht
	VYd5B7ldD+cvHPXVR2CxOyfcy9gcOvzrNVp8I92PsJocJ/ZmxCLM5wB/pod/xM+lqrSqsJWgVR7A
	CbevGYo4HB8bEAYqLLB+ojoPoJoT2JCiIiB5ERAREQEREBERAREQEREBERAREQP/2Q==
	        </textarea>
	     </div> -->
     </section>
    </div>
    <script type="text/javascript">

        var printFlag = false;

	    //键码获取
	    $(document).keyup(function (event) {
	        if(event.keyCode == 13) {
	        	event.preventDefault();
	        };
	    });  
    
        var url="${ctx}/lgt/ps/product/getDataByCode";
        $(function() {
        	
        	ZF.bigImg();
        	
        	$("#totalNum").html("${totalNum}");
        	$("input[id^=tscode]").on("change", function() {
        		
        		var tscode = $.trim($(this).val());
        		if(tscode == null || tscode == "" || tscode == undefined) {
        			 alert("请先扫描货品编码");
        			 return false;
        		}
        		
        		var compareData = $(this).attr("data-compare");
                var $input = $(this);
        		
        		//判断第一次之后录入的货品编码是否与之前录入的有重复,如果有重复，给予提示
        	    var okLen = $("#ok_"+tscode+"").length;
        	    var noLen = $("#no_"+tscode+"").length;
        		if(okLen > 0 || noLen > 0) {
        			ZF.showTip("录入的货品编码必须唯一，请核查", "info");
        			$input.val("");
                    $input.focus();
        			return false;
        		}
        		
        		ZF.ajaxQuery(false,url,$.parseJSON('{"pcode":"'+tscode+'"}'),function(data){
        			$input.next().remove();
        			if(data == null || data == "") {
        				$input.val("");
            			$input.next().remove();
        				$input.focus();
        			} else {
        				if(data.produce.id == compareData && data.status == "1") {//要求录入的货品必须是正常在售的，同时录入的货品编码不能是同一个
        					if($("#ok_"+tscode+"").length<=0)
        						$input.after("<label id='ok_"+tscode+"' style='color:green;font-size:30px;'>√</label>");
        				    
        					var inputs = $("input[id^=tscode]");
        	                for(var i = 0; i < inputs.length ; i++) {
        	                    var input = $(inputs[i]);
        	                    if(input.val() == null || input.val().length<=0) {
        	                        input.focus();
        	                        break;
        	                    }
        	                }
        				} else {
       						$input.val("");
       						$input.focus();
        				}
        			}
                },function(){
                	//error 
                	$input.val("");
                    $input.focus();
                });
        		
        		if(validateCodeCompleted()){
        			if($("#loading").length<=0)
      				  	$("#printSetup").append("<div id='loading' style='position: fixed;height: 100%;width: 100%;top: 0;text-align: center;line-height: 800px;background-color: rgba(0,0,0,0.5);z-index: 1000;'><i class='fa fa-refresh fa-spin' style='font-size:30px;color:white;'></i></div>");
      				$("#loading").show();
      				setTimeout(function(){
      					if(printForm()){
            				formSubmit();
      					}else{
      						$("#loading").remove();
      					}
      	        	},1500);
        		}
        		
        		
        	});
        });
        
      	//检测货品编码是否已录完
        function validateCodeCompleted(){
      		let flag = true;
        	$("input[id^=tscode]").each(function(){
    			if(!$(this).val()){
    				flag = false;
    			}
    		});
        	return flag;
      	}
        
        
        function formSubmit() {
        	var expressCompany = $("#expressCompany").val();
            if(expressCompany == null || expressCompany == "" || expressCompany == undefined) {
            	ZF.showTip("请选择快递公司!", "info");
                return false;
            }
        	var expressNo = $("#expressNo").val();
        	if(expressNo == null || expressNo == "" || expressNo == undefined) {
        		ZF.showTip("请输入快递单号!", "info");
        		return false;
        	}
            var i = 0;
            $("input[id^=tscode]").each(function() {
                var code = $(this).val();
                if(code == null || code == "" || code == undefined) {
                    i++;
                }
            });
            if(i > 0) {
                ZF.showTip("请输入货品编码!", "info");
                return false;
            }
            
            var errLen = $("label[id^=no]").length;
            if(errLen != 0) {
                ZF.showTip("请输入正确的货品编码!", "info");
                return false;
            } 
            
            var total = "${totalNum}";
            var okLen = $("label[id^=ok]").length;
            console.log(total);
            console.log(okLen);
            if(total != okLen) {
                ZF.showTip("货品编码错误或者有重复，请核查!", "info");
                return false;
            }
            if(printForm()){
        		$("#inputForm").submit();
			}
        }
        
        function resetForm() {
        	$("input[id^=tscode]").each(function() {
        		$(this).val("");
        		$(this).next().remove();
        	});
        }
        
        // 打印面单
        function printForm(){
//        	var printSys=ZF.getCookie("print_sys");
//            var pageSize=ZF.getCookie("print_page_size");
            

        	let printSys=localStorage.getItem("print_sys");
        	let pageSize=localStorage.getItem("print_page_size");
            
            if(printSys==null||printSys==""||pageSize==null||pageSize==""){
            	$("#printSetup").show();
            	ZF.showTip("请设置打印机和打印纸张","error");
            	return false;
            }
            //设置打印机
            LODOP.SET_PRINTER_INDEXA(printSys);
            //设置纸张类型
            LODOP.SET_PRINT_PAGESIZE(0,0,0,pageSize);
        	//读取样式
	        var strBodyStyle="<style>"+document.getElementById("printCss").innerHTML+"</style>";
	        //读取面单内容
	        var strFormHtml=strBodyStyle+"<body>"+document.getElementById("app").innerHTML+"</body>";

	        LODOP.PRINT_INIT("周范面单打印");
	        
	        //插入背景图
            // a>  打印本地图片 
	        LODOP.ADD_PRINT_IMAGE(0,0,"100mm","180mm","<img border='0' src='C:/background.jpg'/>");
            // b>  打印web图片
            //var strBASE64Code=document.getElementById('t1').value;
            //LODOP.ADD_PRINT_IMAGE(0,0,"100mm","150mm",strBASE64Code);
	        //插入数据
//	        LODOP.ADD_PRINT_HTM(0,0,"100mm","150mm",strFormHtml);

            LODOP.ADD_PRINT_HTM(51,0,"100mm","15mm",strBodyStyle+"<div class='header'>${sendOrder.destCode}</div>");

            <%--//插入运单一维码--%>


            LODOP.ADD_PRINT_HTM(9, 324, "17mm","14mm", "<div class='printDiv' style='font-size: 12pt; font-weight: bold; text-align: center'>标准</br>快递</div>");

            LODOP.ADD_PRINT_BARCODE(113,171,"54mm","8mm","128A",${sendOrder.orderNo});
            LODOP.SET_PRINT_STYLEA(0,"ShowBarText",0);


            LODOP.ADD_PRINT_HTM(152,45,"91mm","15mm",strBodyStyle+"<div class='printDiv receiveAddre'>${sendOrder.receiveName }&nbsp;&nbsp;&nbsp;&nbsp;${sendOrder.receiveTel }<br/>${sendOrder.receiveAreaStr}${sendOrder.receiveAreaDetail }</div>");


            LODOP.ADD_PRINT_HTM(211,44,"91mm","12mm",strBodyStyle+"<div class='printDiv littlteSendAddre'>${fns:getSysConfig('expressReceiverName').configValue}&nbsp;&nbsp;&nbsp;&nbsp;${fns:getSysConfig('expressReceiverPhone').configValue}<br/>${fns:getSysConfig('expressReceiverAddress').configValue}</div>");

            <%--//插入运单一维码--%>
            LODOP.ADD_PRINT_BARCODE(263,18,"94mm","15mm","128A",${sendOrder.orderNo});

            <%--LODOP.SET_PRINT_STYLEA(0,"ShowBarText",0);--%>


            <%--LODOP.ADD_PRINT_HTM(48,20,"80mm","8mm",strBodyStyle+"<div class='printDiv company'>${sendOrder.receiveAreaStr}</div>");--%>

            <%--LODOP.ADD_PRINT_HTM(86,28,"67mm","7mm",strBodyStyle+"<div class='printDiv sign'>ZF-DDH-${sendOrder.orderNo }</div>");--%>
            <%--//LODOP.ADD_PRINT_HTM(384,35,"67mm","9mm",strBodyStyle+"<div class='printDiv littlePic'></div>");--%>
            <%--LODOP.ADD_PRINT_HTM(383,29,"73mm","13mm",strBodyStyle+"<div class='printDiv receiveAddre'>${sendOrder.receiveName }&nbsp;&nbsp;&nbsp;&nbsp;${sendOrder.receiveTel }<br/>${sendOrder.receiveAreaStr}${sendOrder.receiveAreaDetail }</div>");--%>
            <%--LODOP.ADD_PRINT_HTM(421,31,"73mm","9mm",strBodyStyle+"<div class='printDiv sendAddre'>${fns:getSysConfig('expressReceiverName').configValue}&nbsp;&nbsp;&nbsp;&nbsp;${fns:getSysConfig('expressReceiverPhone').configValue}<br/>${fns:getSysConfig('expressReceiverAddress').configValue}</div>");--%>
            <%--//LODOP.ADD_PRINT_HTM(246,113,"40mm","6mm",strBodyStyle+"<div class='printDiv bigPic'></div>");--%>
            <%--LODOP.ADD_PRINT_HTM(252,113,"40mm","6mm",strBodyStyle+"<div class='printDiv OddNumbers'>${sendOrder.expressNo }</div>");--%>
            <%--//LODOP.ADD_PRINT_HTM(0,0,"100mm","150mm",strBodyStyle+"<div class='printDiv middlePic'></div>");--%>
            <%--LODOP.ADD_PRINT_HTM(364,166,"40mm","5mm",strBodyStyle+"<div class='printDiv littleOddNumbers'>${sendOrder.expressNo }</div>");--%>
            LODOP.ADD_PRINT_HTM(456,37,"71mm","10mm",strBodyStyle+"<div class='printDiv littlteReceiveAddre'>${sendOrder.receiveName }&nbsp;&nbsp;&nbsp;&nbsp;${sendOrder.receiveTel }<br/>${sendOrder.receiveAreaStr}${sendOrder.receiveAreaDetail }</div>");
            LODOP.ADD_PRINT_HTM(499,37,"71mm","10mm",strBodyStyle+"<div class='printDiv littlteSendAddre'>${fns:getSysConfig('expressReceiverName').configValue}&nbsp;&nbsp;&nbsp;&nbsp;${fns:getSysConfig('expressReceiverPhone').configValue}<br/>${fns:getSysConfig('expressReceiverAddress').configValue}</div>");


            LODOP.ADD_PRINT_BARCODE(338,308,"20mm","20mm","QRCode",${sendOrder.orderNo});

            LODOP.ADD_PRINT_BARCODE(460,307,"20mm","20mm","QRCode",${sendOrder.orderNo});

            const nowDate = getNowFormatDate();
            const nowTime = getNowFormatTime();
            LODOP.ADD_PRINT_HTM(335, 1, "18mm","6mm", "<div style='font-size: 8pt; text-align: center'>"+nowDate+"</div>");
            LODOP.ADD_PRINT_HTM(351, 2, "18mm","7mm", "<div style='font-size: 11pt; font-weight: bold; text-align: center'>"+nowTime+"</div>");
            LODOP.ADD_PRINT_HTM(368, 2, "18mm","7mm", "<div style='font-size: 10pt;'>&nbsp;&nbsp;打印时间</div>");
            LODOP.ADD_PRINT_HTM(387, -30, "25mm","7mm", "<div style='font-size: 7pt; text-align: center'>数量</br>重量</div>");


            <%--var first = ${isFirstOrderFlag}?${isFirstOrderFlag}:false;--%>
            <%--if(first == true){--%>
                <%--LODOP.ADD_PRINT_HTM(497, 20, "40mm", "8mm", strBodyStyle + "<div class='printDiv firstOrder'>首单</div>");--%>
            <%--}else {--%>
                <%--LODOP.ADD_PRINT_HTM(497, 20, "40mm", "8mm",strBodyStyle+"<div class='printDiv firstOrder'>非首单</div>");--%>
            <%--}--%>

            <%--//插入运单一维码--%>
	        <%--LODOP.ADD_PRINT_BARCODE(88,292,"20mm","5mm","128A",${sendOrder.orderNo});--%>
	        <%--LODOP.SET_PRINT_STYLEA(0,"ShowBarText",0);--%>

	        <%--LODOP.ADD_PRINT_BARCODE(220,78,"60mm","8mm","128A","${sendOrder.expressNo}");--%>
	        <%--LODOP.SET_PRINT_STYLEA(0,"ShowBarText",0);--%>

	        <%--LODOP.ADD_PRINT_BARCODE(343,132,"60mm","6mm","128A","${sendOrder.expressNo}");--%>
	        <%--LODOP.SET_PRINT_STYLEA(0,"ShowBarText",0);--%>

	        // 执行打印
           if (!printFlag){
               LODOP.PRINT();	// 打印
               printFlag = true;
           }
            //LODOP.PREVIEW();    // 预览
//             LODOP.PRINT_DESIGN();
             
	        // ajax将快递单号保存为已使用
            /* ZF.ajaxQuery(false, "${ctx}/lgt/tn/expressNoSegment/updateStatusByExpressNo", {"expressNo":${sendOrder.expressNo}}, function() {
            	console.log("该快递单号已使用!");
            }, function() {
            	console.log("该快递单号使用失败!");
            }); */
            return true;
        }
        
        
        //判断是否是IE浏览器 
        var ie = (document.all) ? true : false;
        //设置页面快捷键 
        function keyDown(e){  
             if(ie){
                  //IE浏览器    
                  if(e.ctrlKey && e.keyCode == 90){			//重置按钮     ctrl+z
                       event.keyCode=0;      
                       event.returnValue=false;      
                       resetForm();    
                  } else if(e.ctrlKey && e.keyCode == 80){	//打印按钮   ctrl+p
                      event.keyCode=0;      
                      event.returnValue=false;      
                      printForm();    
                  } else if(e.keyCode == 34) {				//保持按钮    enter改成page down 
                      formSubmit();
                  }    
             } else {    
                 //非IE浏览器    
                 if(e.ctrlKey && e.keyCode == 90){			//重置按钮     ctrl+z
                     event.keyCode=0;      
                     event.returnValue=false;      
                     resetForm();    
                     return false;
                } else if(e.keyCode == 80){					//打印按钮   ctrl+p
                    event.keyCode=0;      
                    event.returnValue=false;      
                    printForm();    
                    return false;
                } else if(e.keyCode == 34) {				//保持按钮    enter改成page down  
                    formSubmit();
                    return false;
                }  
            }
        }
        document.onkeydown=keyDown;   
        
        $(document).ready(function() {
        	setTimeout(function(){
        		$("input[id^=tscode]:first").focus();
        	},1000);
        	//读取cookie 获得打印设置
//         	var printSys=ZF.getCookie("print_sys");
//         	var pageSize=ZF.getCookie("print_page_size");
        	

        	let printSys=localStorage.getItem("print_sys");
        	let pageSize=localStorage.getItem("print_page_size");
        	
        	if(printSys==null||printSys==""||pageSize==null||pageSize==""){
        		$("#printSetup").show();
        		//显示打印设置
        		CLODOP.Create_Printer_List(document.getElementById('Select01'));
        		$("#Select01").prepend("<option value='-1'>请选择</option>");
        		$("#Select01").select2('val', '-1');
	            $("#Select01").on("change",function(){
	                var val=$(this).val();
	                CLODOP.Create_PageSize_List(document.getElementById('Select02'),val);
	                $("#Select02").prepend("<option value='-1'>请选择</option>");
	                $("#Select02").select2('val', '-1');
	            })
	            
	            $("#printSetupBtn").on("click",function(){
	            	printSys=$("#Select01").val();
	            	pageSize=$("#Select02").val();
	            	
	            	console.log(printSys+" : "+pageSize)
	            	if(printSys==null||printSys==""||pageSize==null||pageSize=="" || pageSize == -1 || printSys == -1){
	            		ZF.showTip("请选择打印机和打印纸张类型","error");
	            		return;
	            	}
// 	            	ZF.setCookie("print_sys",printSys)
// 	            	ZF.setCookie("print_page_size",pageSize)
	            	
	            	
		        	localStorage.setItem("print_sys", printSys);
		        	localStorage.setItem("print_page_size", pageSize);
		        	
		        	
	            	$("#printSetup").hide();
	            })
        	}
        });
        
        function hangUp(sendOrderId, pickOrderId) {
        	var url = "${ctx}/bus/ol/pickOrder/updateActiveFlagById";
            ZF.ajaxQuery(false,url,$.parseJSON('{"id":"'+sendOrderId+'"}'),function(data){
                if(data.status==1){
                    ZF.showTip("成功挂起!", "info");
                    window.location.href = "${ctx}/bus/ol/pickOrder/myPackageForm?id="+pickOrderId;
                    return false;
                }else{
                    ZF.showTip("挂起失败!", "info");
                    return false;
                }
            },function(){
                ZF.showTip("挂起失败!", "info");
                return false;
            });
        	
        }

        function getNowFormatDate() {
            const date = new Date();
            let month = date.getMonth() + 1;
            let strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            return date.getFullYear() + "/" + month + "/" + strDate;
        }

        function getNowFormatTime() {
            const date = new Date();
            let minute = date.getMinutes();
            let second = date.getSeconds();
            if (minute <= 9) {
                minute = "0" + minute
            }
            if(second <= 9) {
                second = "0" + second
            }
            return date.getHours() + ":" + minute
                + ":" + second;
        }
    </script>
</body>
</html>