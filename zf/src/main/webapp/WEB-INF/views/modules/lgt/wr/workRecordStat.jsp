<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>工作人员工作记录统计</title>
    <meta name="decorator" content="adminLte"/>
</head>
<body onload="totalTable(document.getElementById('contentTable'));">
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/wr/statistics">工作人员工作记录统计</a></small>
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
            
            <form:form id="searchForm" modelAttribute="workRecord" action="${ctx}/lgt/wr/statistics" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                           <div class="form-group">
                               <label for="beginCreateDate" class="col-sm-3 control-label">开始创建时间</label>
                               <div class="col-sm-7">
                                   <sys:datetime id="beginCreateDate" inputName="beginCreateDate" tip="请选择开始创建时间" value="${workRecord.beginCreateDate }" inputId="beginCreateDate"></sys:datetime>
                               </div>
                           </div>
                       </div>
                       <div class="col-md-4">
                           <div class="form-group">
                               <label for="endCreateDate" class="col-sm-3 control-label">结束创建时间</label>
                               <div class="col-sm-7">
                                   <sys:datetime id="endCreateDate" inputName="endCreateDate" tip="请选择结束创建时间" value="${workRecord.endCreateDate }" inputId="endCreateDate"></sys:datetime>
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
	                    <button type="button" class="btn btn-sm btn-info" id="dataPreview" style="display: none;"><i class="fa fa-area-chart">数据一览</i></button>
	                </div>
	            </div>
                <div id="dataView" class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th>姓名</th>
                                <th>包裹入库</th>
                                <th>采购质检货品数量</th>
                                <th>回货质检货品数量</th>
                                <th>拣货货品数量</th>
                                <th>发货货品数量</th>
                                <th>异常问题登记</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="WorkRecord">
                                <tr>
                                    <td >
                                        ${WorkRecord.name}
                                    </td>
                                    <td>
                                        ${WorkRecord.packageCount}
                                    </td>
                                    <td>
                                        ${WorkRecord.purchaseCount}
                                    </td>
                                    <td>
                                        ${WorkRecord.returnCount}
                                    </td>
                                    <td>
                                       ${WorkRecord.pickOrderCount}
                                    </td>
                                    <td>
                                        ${WorkRecord.sendOrderCount}
                                    </td>
                                    <td>
                                        ${WorkRecord.errProblemCount}
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr>
						    <td style="font-size: 16px">合计</td>
						    <td style="font-size: 16px"> </td>
						    <td style="font-size: 16px"> </td>
						    <td style="font-size: 16px"> </td>
						    <td style="font-size: 16px"> </td>
						    <td style="font-size: 16px"> </td>
						    <td style="font-size: 16px"> </td>
						  </tr>
                        </tbody>
                    </table>
                </div>
                <div id="chartView" style="display: none;">
                    <div id="pieChart" style="height:300px;width: 100%;"></div>
                </div>
            </div>
            <div class="box-footer">
                <div class="dataTables_paginate paging_simple_numbers">${page}</div>
            </div>
        </div>
     </section>
    </div>
    <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.min.js"></script>
    <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.resize.min.js"></script>
    <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.pie.min.js"></script>
    <script src="${ctxStatic }/adminLte/plugins/flot/jquery.flot.categories.min.js"></script>
    
    <script>
      $(function () {
        //表格初始化
        ZF.parseTable("#contentTable", {
        	"paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : false,
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        });
        
      });
	 	
       function page(n,s){
          $("#pageNo").val(n);
          $("#pageSize").val(s);
          $("#searchForm").submit();
          return false;
      }
       
	 var calcTotal=function(table,column){//合计，表格对象，对哪一列进行合计，第一列从0开始
	        var trs=table.getElementsByTagName('tr');
	        var start=1,//忽略第一行的表头
	            end=trs.length-1;//忽略最后合计的一行
	        var total=0;
	        for(var i=start;i<end;i++){
	            var td=trs[i].getElementsByTagName('td')[column];
	            var t=parseFloat(td.innerHTML);
	            if(t)total+=t;
	        }
	        trs[end].getElementsByTagName('td')[column].innerHTML=total;
	    };
	    calcTotal(document.getElementById('contentTable'),1);
	    calcTotal(document.getElementById('contentTable'),2);
	    calcTotal(document.getElementById('contentTable'),3);
	    calcTotal(document.getElementById('contentTable'),4);
	    calcTotal(document.getElementById('contentTable'),5);
	    calcTotal(document.getElementById('contentTable'),6);
   </script>
</body>
</html>