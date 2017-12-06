<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>我的打包任务</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        }
        .label-primary {
            display: inline-block;
            margin: 8px 5px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        
    </script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/pickOrder/myPackageList">打包任务列表</a></small>
            <%-- <small>|</small>
            <small>
                <i class="fa fa-barcode"></i>
                <a href="${ctx}/bus/ol/pickOrder/packageScanForm">打包扫码接单</a>
            </small> --%>
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
            
             <form:form id="searchForm" modelAttribute="pickOrder" action="${ctx}/bus/ol/pickOrder/myPackageList" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="pickOrderNo" class="col-sm-3 control-label">托盘编号</label>
                                <div class="col-sm-7">  
                                   <sys:inputverify name="plateNo" id="plateNo" verifyType="0" tip="" isMandatory="false" isSpring="true"></sys:inputverify>
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
                <div class="row">
                    <div class="col-sm-12 pull-right">
                        <shiro:hasPermission name="bus:ol:pickOrder:edit">
                            <button type="button" class="btn btn-sm btn-dropbox" onclick="receive();"><i class="fa fa-edit">接单</i></button>
                        </shiro:hasPermission>
                        <shiro:hasPermission name="bus:ol:pickOrder:edit">
                            <button type="button" class="btn btn-sm btn-dropbox" onclick="showExportModal()"><i class="fa fa-edit">出库单导出</i></button>
                        </shiro:hasPermission>
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th class="zf-dataTables-multiline"></th>
                                <th>拣货单编号</th>
                                <th>托盘编号</th>
                                <th>拣货人</th>
                                <th>拣货开始时间</th>
                                <th>拣货完成时间</th>
                                <th>打包人</th>
                                <th>打包开始时间</th>
                                <th>打包完成时间</th>
                                <th style="display: none;">更新者</th>
                                <th style="display: none;">更新时间</th>
                                <th style="display: none;">备注信息</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="pickOrder" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        ${pickOrder.pickOrderNo}
                                    </td>
                                    <td>
                                        ${pickOrder.plateNo }
                                    </td>
                                    <td>
                                        ${fns:getUserById(pickOrder.pickBy.id).name}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${pickOrder.pickStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${pickOrder.pickEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        ${fns:getUserById(pickOrder.packageBy.id).name}
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${pickOrder.packageStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${pickOrder.packageEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${fns:getUserById(pickOrder.updateBy.id).name}
                                    </td>
                                    <td data-hide="true">
                                        <fmt:formatDate value="${pickOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td data-hide="true">
                                        ${pickOrder.remarks}
                                    </td>
                                    <td>
                                        <div class="btn-group zf-tableButton">
                                            <button type="button" class="btn btn-sm btn-info"
                                                onclick="window.location.href='${ctx}/bus/ol/pickOrder/info?id=${pickOrder.id}'">详情</button>
                                            <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
	                                            <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
		                                            <c:if test="${empty pickOrder.packageEndTime }">
			                                            <li><a href="${ctx}/bus/ol/pickOrder/myPackageForm?id=${pickOrder.id}">打包发货单</a></li>
		                                            </c:if>
	                                                <li><a href="${ctx}/bus/ol/pickOrder/myPackageSendOrderList?id=${pickOrder.id}">发货单管理</a></li>
	                                            </ul>
                                        </div>
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
        
        <div style="display: none;">
            <form id="hiddenForm" action="${ctx}/bus/ol/pickOrder/toMyPackageForm" method="post">
                <input id="no" name="plateNo" type="hidden"/>
            </form> 
        </div>
       <div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="录入拣货盘编号" aria-hidden="true">
	       <div class="modal-dialog" style="width:30%;height:45%;" >
		          <div class="modal-content" style="width:100%;height:100%;">
		             <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                      <span aria-hidden="true">&times;</span></button>
		                <h4 class="modal-title">录入拣货盘编号</h4>
		             </div>
		             <div class="modal-body">
		                <div>
		                  <label for="geneNum">拣货盘编号</label>
		                  <input type="text" class="form-control" maxlength="10" readonly name="plateNo" id="receivePlateNo"  placeholder="请点击选择拣货盘编号"/>
		                </div>
                         <div class="col-md-6" style="margin-top: 20px;">
                             <label>可用托盘编号：</label>
                         </div>
                         <div class="col-md-12" id="plateDiv">

                         </div>
		             </div>
		             <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                <button type="button" class="btn btn-primary" id="commitBtn">提交接单</button>
		             </div>
		          </div><!-- /.modal-content -->
	        </div><!-- /.modal -->
        </div>
        <div id="geneteModal1" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="录入要导出货品的录入批次编号" aria-hidden="true">
            <div class="modal-dialog" style="width:50%;height:60%;" >
                <div class="modal-content" style="width:100%;height:100%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">出库时间</h4>
                    </div>
                    <div class="modal-body">
                        <div>
                            <label for="geneNum">时间</label>
                            <input type="text" class="form-control" maxlength="10" id="createDate"  placeholder="请输入yyyy-MM-dd格式的时间"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="commitBtn1" onclick="exportFile('${purchaseOrder.id}')">确认导出</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
     </section>
    </div>
    
    <script>
    	var plateNoVar = "";
        var resetSecond = 1000; // 重置间隔时间1秒钟
        function resetPlateNoVar() {
        	plateNoVar = "";
        }
    	
	   	//键码获取
	   	$(document).keyup(function (event) {
		   if(event.keyCode == 96 || event.keyCode == 48) {
			   plateNoVar += "0";
		   } else if(event.keyCode == 97 || event.keyCode == 49) {
			   plateNoVar += "1";
		   } else if(event.keyCode == 98 || event.keyCode == 50) {
			   plateNoVar += "2";
           } else if(event.keyCode == 99 || event.keyCode == 51) {
        	   plateNoVar += "3";
           } else if(event.keyCode == 100 || event.keyCode == 52) {
        	   plateNoVar += "4";
           } else if(event.keyCode == 101 || event.keyCode == 53) {
        	   plateNoVar += "5";
           } else if(event.keyCode == 102 || event.keyCode == 54) {
        	   plateNoVar += "6";
           } else if(event.keyCode == 103 || event.keyCode == 55) {
        	   plateNoVar += "7";
           } else if(event.keyCode == 104 || event.keyCode == 56) {
        	   plateNoVar += "8";
           } else if(event.keyCode == 105 || event.keyCode == 57) {
        	   plateNoVar += "9";
           }
	       if(event.keyCode == 13) {
		       //验证获取的编号是否是托盘编号，同时清空托盘编号，便于下一次接收
		       var url = "${ctx}/bus/ol/pickOrder/checkPlateNo";
		       ZF.ajaxQuery(false,url,$.parseJSON('{"plateNo":"'+plateNoVar+'"}'),function(data){
	                if(data.status==1){
	                    window.location.href = "${ctx}/bus/ol/pickOrder/toMyPackageForm?plateNo="+plateNoVar;
	                    return false;
	                }else{
	                    ZF.showTip(data.message, "info");
	                    return false;
	                }
	            },function(){
	                ZF.showTip("扫描托盘编码失败!", "info");
	                return false;
	            });
	           event.preventDefault();
			};
		});
    
	   	
		$(function () {
			setInterval("resetPlateNoVar()", resetSecond);
    	  
			//表格初始化
	        ZF.parseTable("#contentTable", {
	            "paging" : false,
	            "lengthChange" : false,
	            "searching" : false,
	            "ordering" : false,
	            "order": [[ 10, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
	                {"orderable":false,targets:11},
	                {"orderable":false,targets:12}
	            ],
	            "info" : false,
	            "autoWidth" : false,
	            "multiline" : true,//是否开启多行表格
	            "isRowSelect" : true,//是否开启行选中
	            "rowSelect" : function(tr) {
	            },
	            "rowSelectCancel" : function(tr) {
	            }
	        })
	        
	        $("#geneteModal #commitBtn").on("click",function () {
	            var no = $("#receivePlateNo").val();
	            if(no == null || no == "" || $.trim(no).length == 0) {
	            	ZF.showTip("请输入托盘编号!","info");
	                return false;
	            }
	            $("#no").val(no);
	            
	            $("#geneteModal").modal("hide");    
	            $("#hiddenForm").submit();
	        });
		});
		
		function receive() {

            ZF.ajaxQuery(true, '${ctx}/bus/pm/plateManage/findInUseList',{},
                function (data) {
                    let html="";
                    for (let i=0; i<data.length; i++){
                        html+="<span class='label label-primary' data-item title='点击选择该托盘' >"+data[i].plateNo+"</span>";
                    }
                    $("#plateDiv").html(html);
                    $('[data-item]').on('click',function () {
                        $("#receivePlateNo").val($(this).text());
                    });
                    $("#geneteModal").modal('toggle');
                    return false;
                },function () {
                    ZF.showTip('获取托盘信息失败，请稍后再试！','warning');
                    return false;
                });
	    }
        function showExportModal(){
            $("#geneteModal1").modal('toggle');
        }
        function exportFile(purchaseOrderId) {
            var createDate = $("#createDate").val();
            if(createDate ==null || createDate == ""){
                ZF.showTip("请输入时间","danger");
                //alert("请输入录入批次","info",null);
                return false;
            }
            window.location.href = "${ctx}/bus/ol/sendOrderExport/export?createDate="+createDate;
            $("#geneteModal1").modal('hide');
        };
   </script>
</body>
</html>
