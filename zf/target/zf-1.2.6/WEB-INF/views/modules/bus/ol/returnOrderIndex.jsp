<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>收货管理</title>
    <meta name="decorator" content="adminLte"/>
</head>
<body onload="document.getElementById('expressNo').focus()">
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/returnOrder/index">收货</a></small>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        
         <div class="box box-info">
            <div class="box-header with-border zf-query">
                <h5>查询条件</h5>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
            
            <form:form id="searchForm" modelAttribute="returnOrder" action="#" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">回货物流单号</label>
                                <div class="col-sm-7">
                                    <input type="text" data-name ="expressNo" id="expressNo"  name="expressNo" placeholder="请输入回单号" class="form-control false" >
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                        <button type="button" class="btn btn-info btn-sm" id="subBtn"><i class="fa fa-search"></i>添加</button>
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
                                <th>订单号</th>
                                <th>回货物流单号</th>
                                <th>物流公司</th>
                                <th>回货收货人</th>
                                <th>回货收货时间</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyContent">
			                <c:forEach items="${returnOrderList}" var="returnOrder" varStatus="status">
                               <tr data-index="${status.index }">
                                   <td>
                                       ${returnOrder.orderNo}
                                   </td>
                                   <td>
                                      ${returnOrder.expressNo}
                                   </td>
                                   <td>
                                      <span class="label label-primary">${fns:getDictLabel(returnOrder.expressCompany, 'express_company', '')}</span></td>
                                   <td>${fns:getUserById(returnOrder.receiveBy.id).name}
                                   <%-- ${fns:getUserById(returnOrder.receiveBy).name} --%>
                                   </td>
                                   <td>
                                   <fmt:formatDate value="${returnOrder.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                   </td>
                               </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
     </section>
    </div>
    
    <script>
      $(function () {
          document.getElementById('expressNo').focus()
        ZF.bigImg();
        //表格初始化
      /*    ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : false,
            "order": [[ 0, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5}             
            ],
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        });  */
          $("#expressNo").on("change", function() {
              var expressNo = $.trim($(this).val());
              if(expressNo == null || expressNo == "" || expressNo == undefined) {
                  alert("请先扫描物流单号");
                  return false;
              }else{
                  var tdNo = $("#td_"+expressNo).text();
                  if(tdNo.length > 0) {
                      ZF.showTip("回单号【"+expressNo+"】关联的订单数据已收货，请勿重复扫描添加!", "info");
                      return false;
                  }

                  var url = "${ctx}/bus/ol/returnOrder/findOrderByExpressNo";
                  ZF.ajaxQuery(true, url, {"expressNo":expressNo}, function(data) {
                      if(data.status == 0) {
                          ZF.showTip(data.message, "info");
                          $("#expressNo").val("");
                          return false;
                      } else {
                          $(".dataTables_empty").parent().remove();

                          var orderData = data.data;
                          var html = "";
                          for(var i = 0;i < orderData.length; i++) {
                              var order = orderData[i];
                              html += "<tr><td>"+order.orderNo+"</td><td id='td_"+order.expressNo+"'>"+order.expressNo+"</td><td><span class='label label-primary'>"+order.expressCompany+"</span></td><td>"+order.receiveBy.name+"</td><td>"+order.receiveTime+"</td></tr>"
                          }
                          $("#tbodyContent").append(html);
                          $("#expressNo").val("");
                      }
                  });
              }
          });
        $("#subBtn").on("click", function() {
        	var expressNo = $("#expressNo").val();
        	if(expressNo == null || expressNo == "" || expressNo == undefined) {
        		ZF.showTip("请先输入回单号!", "info");
        		return false;
        	}
        	
        	var tdNo = $("#td_"+expressNo).text();
            if(tdNo.length > 0) {
                ZF.showTip("回单号【"+expressNo+"】关联的订单数据已收货，请勿重复扫描添加!", "info");
                return false;
            }
        	
        	
        	var url = "${ctx}/bus/ol/returnOrder/findOrderByExpressNo";
        	  ZF.ajaxQuery(true, url, {"expressNo":expressNo}, function(data) {
        		if(data.status == 0) {
        			ZF.showTip(data.message, "info");
                    $("#expressNo").val("");
        			return false;
        		} else {
        			$(".dataTables_empty").parent().remove();
        			
        			var orderData = data.data;
        			var html = "";
        		    for(var i = 0;i < orderData.length; i++) {
        				var order = orderData[i];
        				html += "<tr><td>"+order.orderNo+"</td><td id='td_"+order.expressNo+"'>"+order.expressNo+"</td><td><span class='label label-primary'>"+order.expressCompany+"</span></td><td>"+order.receiveBy.name+"</td><td>"+order.receiveTime+"</td></tr>"
        			} 
        			$("#tbodyContent").append(html);
                    $("#expressNo").val("");
        		}
        	});
        });
        
        
      });
      
   </script>
</body>
</html>