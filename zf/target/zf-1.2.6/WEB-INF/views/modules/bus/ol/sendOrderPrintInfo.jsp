<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>发货单打印详情</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content">
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>出库单流水号</th>
                                <td>${sendOrder.sendOrderNo }</td>
                                <th>下单时间</th>
                                <td><fmt:formatDate value="${sendOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <th>拣货人</th>
                                <td>${fns:getUserById(sendOrder.pickOrder.pickBy.id).name }</td>
                                <th>总件数</th>
                                <td id="totalNum"></td>
                                <%-- <th>状态</th>
                                <td>${fns:getDictLabel(sendOrder.status, 'bus_ol_send_order_status', '') }</td> --%>
                            </tr>
                            <tr>
                                <th>收货人</th>
                                <td colspan="7">${sendOrder.receiveName }</td>
                            </tr>
                            <tr>
                                <th>收货地址</th>
                                <td colspan="7">${sendOrder.receiveAreaDetail }</td>
                            </tr>
                            <tr>
                                <th>联系电话</th>
                                <td colspan="7">${sendOrder.receiveTel }</td>
                            </tr>
                            <tr>
                                <th style="vertical-align:middle;">物流公司</th>
                                <td colspan="3"  style="vertical-align:middle;">${fns:getDictLabel(sendOrder.expressCompany,'express_company','') }</td>
                                <th style="vertical-align:middle;">快递单号</th>
                                <td colspan="4">
                                        ${sendOrder.expressNo }
                                </td>
                            </tr>
                            <tr>
                                <th>照片</th>
                                <th>商品名称</th>
                                <th>产品编码</th>
                                <th>规格</th>
                                <th>数量</th>
                                <th colspan="4">货品编码</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sendOrder.sendProduceList}" var="sp" varStatus="status">
                                <c:set var="totalNum" value="${totalNum+sp.num }"/>
                                
                                <tr data-index="${status.index }">
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${sp.produce.goods.samplePhoto}"  width="100px;" height="100px;"/>
                                    </td>
                                    <td>
                                        ${sp.produce.goods.name}
                                    </td>
                                    <td>
                                        ${sp.produce.code }
                                    </td>
                                    <td>
                                        ${sp.produce.name }
                                    </td>
                                    <td>
                                        ${sp.num }
                                    </td>
                                    <td colspan="4">
	                                       <c:forEach items="${sp.productList }" var="t">
	                                            ${t.code }<br/>
	                                       </c:forEach>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box-footer" id="div_footer">
                <div class="pull-left box-tools">
                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                </div>
                <div class="pull-right box-tools">
                    <button type="button" class="btn btn-default btn-sm" onkeydown="keyDown();"  onclick="printForm();"   id="printBtn"><i class="fa fa-print"></i>打印清单(ctrl+p)</button>&nbsp;&nbsp;
                </div>
            </div>
        </div>
     </section>
    </div>
    <script type="text/javascript">
      
        function printForm() {
        	$("#div_footer").hide();
        	print();
        	$("#div_footer").show();
        }
    
        //判断是否是IE浏览器 
        ie = (document.all) ? true : false;
        //jiyanle，设置页面快捷键 
        function keyDown(e){  
             if(ie){
                  //IE浏览器    
                  if (e.ctrlKey && e.keyCode == 80){//打印按钮   ctrl+p
                      event.keyCode=0;      
                      event.returnValue=false;      
                      printForm();    
                  }  
             } else {    
                 //非IE浏览器    
                 if (e.keyCode == 80){//打印按钮   ctrl+p
                    event.keyCode=0;      
                    event.returnValue=false;      
                    printForm();    
                    return false;
                }  
            }
        }
        document.onkeydown=keyDown;   
        
        
        $(function() {
        	
        	$("#totalNum").html("${totalNum}");
        });
    </script>
    
</body>
</html>