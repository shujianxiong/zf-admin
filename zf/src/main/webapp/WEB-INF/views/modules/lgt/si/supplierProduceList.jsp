<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>供应商产品管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
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
        
        function queryResetForm() {
        	$("#goodsCode").val("");
        	$("#pageNo").val("");
            $("#pageSize").val("");
            $("#supplierId").val(""); 
        }
    </script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/lgt/si/supplier/">供应商列表</a></small>
            <small>|</small>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/si/supplierProduce/list?supplier.id=${supplier.id }">供应商【${supplier.name }】产品列表</a></small>
            <shiro:hasPermission name="lgt:si:supplierProduce:edit">
	            <small>|</small>
	            <small><i class="fa-form-edit"></i><a href="${ctx}/lgt/si/supplierProduce/edit?supplierId=${supplier.id }">供应商【${supplier.name }】产品添加</a></small>
            </shiro:hasPermission>
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
            
            <form:form id="searchForm" modelAttribute="supplierProduce" action="${ctx}/lgt/si/supplierProduce/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <input i="supplierId" name="supplier.id" type="hidden" value="${supplier.id }"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">商品编码</label>
                                 <div class="col-sm-7">
                                    <sys:inputverify name="goods.code" id="goodsCode" verifyType="0" tip="请输入查询的商品编码 " isSpring="true" isMandatory="false"></sys:inputverify>
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="queryResetForm()"><i class="fa fa-refresh"></i>重置</button>
                        <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
                    </div>
                </div>
            </form:form>
        </div>
    
        <div class="box box-soild">
            <div class="box-body">
                <div class="row">
                    <div class="col-sm-12 pull-right">
                        <button type="button" class="btn btn-sm btn-dropbox" onclick="printPreview('${supplier.id }')"><i class="fa fa-print">打印预览</i></button>
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th class="zf-dataTables-multiline"></th>
                                <th width="2%">商品样图</th>
                                <th width="2%">商品编码</th>
                                <th width="20">商品名称</th>
                                <th width="6%">工费</th>
                                <th width="6%">起板费</th>
                                <th width="6%">电金工艺</th>
                                <th width="6%">电金颜色</th>
                                <th width="6%">电金厚度(mm)</th>
                                <th width="6%">电金价格</th>
                                <th width="10%">创建人</th>
                                <th width="8%">创建时间</th>
                                <th width="10%">更新人</th>
                                <th width="8%">更新时间</th>
                                <shiro:hasPermission name="lgt:si:supplierProduce:edit">
	                                <th width="10%">操作</th>
                                </shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="supplierProduce" varStatus="status">
                                <tr data-index="${status.index }" data-load="false" data-supplierId="${supplierProduce.supplier.id }" data-goodsId="${supplierProduce.goods.id }">
                                    <td class="details-control text-center">
                                        <i class="fa fa-plus-square-o text-success"></i>
                                    </td>
                                    <td>
                                        <img src="${imgHost }${supplierProduce.goods.samplePhoto}" data-big data-src="${imgHost }${supplierProduce.goods.samplePhoto}" width="20px" height="20px"/>
                                    </td>
                                    <td>${supplierProduce.goods.code }</td>
                                    <td title="${supplierProduce.goods.name }">${fns:abbr(supplierProduce.goods.name, 15) }</td>
                                    <td class="zf-table-money"><span class="text-red">${supplierProduce.workFee }</span></td>
                                    <td class="zf-table-money"><span class="text-red">${supplierProduce.templetFee }</span></td>
                                    
                                    <td><span class="label label-primary">${fns:getDictLabel(supplierProduce.electrolyticGoldCrafts, 'lgt_si_supplier_produce_egCrafts', '' )}</span></td>
                                    <td><span class="label label-primary">${fns:getDictLabel(supplierProduce.electrolyticGoldColour, 'lgt_si_supplier_produce_egColour', '') }</span></td>
                                    <td>${supplierProduce.electrolyticGoldThickness }</td>
                                    <td class="zf-table-money"><span class="text-red">${supplierProduce.electrolyticGoldPrice }</span></td>
                                    
                                    <td>${fns:getUserById(supplierProduce.createBy.id).name }</td>
                                    <td><fmt:formatDate value="${supplierProduce.createDate}"
                                            pattern="yyyy-MM-dd" /></td>
                                    <td>${fns:getUserById(supplierProduce.updateBy.id).name }</td>
									<td><fmt:formatDate value="${supplierProduce.updateDate}"
											pattern="yyyy-MM-dd" /></td>
								    <shiro:hasPermission name="lgt:si:supplierProduce:edit">
									    <td>
									        <div class="btn-group zf-tableButton">
	                                          <button type="button" class="btn btn-sm btn-info" onclick="window.location.href='${ctx}/lgt/si/supplierProduce/edit?supplierId=${supplierProduce.supplier.id}&goodsId=${supplierProduce.goods.id }'">修改</button>
	                                          <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
	                                            <span class="caret"></span>
	                                          </button>
	                                          <ul class="dropdown-menu btn-info zf-dropdown-width" role="menu">
	                                              <li><a href="${ctx}/lgt/si/supplierProduce/delete?supplierId=${supplierProduce.supplier.id}&goodsId=${supplierProduce.goods.id }" onclick="return ZF.delRow('请确认是否删除该供应商产品?', this.href)">删除</a></li>
	                                              <li><a href="${ctx}/lgt/si/supplierProduce/info2?sid=${supplierProduce.supplier.id}&gid=${supplierProduce.goods.id }" >详情</a></li>
	                                          </ul>
	                                        </div>
									    </td>
									</shiro:hasPermission>
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
            <form id="infoForm" action="${ctx }/lgt/si/supplierProduce/info" method="post">
                <input type="hidden" name="sid" id="sid"/>
                <input type="hidden" name="gid" id="gid"/>
                <input type="hidden" name="pid" id="pid"/>
            </form>
        </div>
     </section>
    </div>
    
    <script>
      $(function () {
        
        ZF.bigImg();
         
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
          
        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : true,
            "order": [[ 11, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7},
                {"orderable":false,targets:10},
                {"orderable":false,targets:12},
                {"orderable":false,targets:14}
            ],
            "info" : false,
            "autoWidth" : false,
            "multiline" : false,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        })
      });
      
      $('#contentTable tbody').on('click', 'td.details-control',function() {
    	  console.log("click")
          var tr = $(this).closest('tr');
          var td=$(this);
          var dataIndex=tr.attr("data-index")
          //判断是否第一次点击
          if(tr.attr("data-load")=="false"){
        	  //发起ajax,loading数据
        	  loadProduce(tr);
        	  tr.attr("data-load","true");
          }
          if(td.attr("data-open")=="0"){
              td.attr("data-open","1")
              td.html("<i class='fa fa-plus-square-o text-success'></i>")
              //隐藏折叠表格
              $("#multiTr"+dataIndex).hide();
          }else{
              //展开
              td.attr("data-open","0")
              td.html("<i class='fa fa-minus-square-o text-success'></i>")
              $("#multiTr"+dataIndex).show();
              
          }
      });
      
      function loadProduce(tr){
    	  var supplierId=tr.attr("data-supplierId");
    	  var goodsId=tr.attr("data-goodsId");
    	  var dataIndex=tr.attr("data-index");
    	  var tdNum=tr[0].cells.length;
    	  var newTr=$('<tr id="multiTr'+dataIndex+'"></tr>')
    	  var newTd=$('<td colspan="'+tdNum+'"></td>');
    	  
    	  var data='{"supplierId":"'+supplierId+'","goodsId":"'+goodsId+'"}';
    	  ZF.ajaxQuery(true,"${ctx}/lgt/si/supplierProduce/listSupplierProduceBySupplierAndGoods",$.parseJSON(data),function(data){
    		 var html='<table class="table table-striped">';
    		 html+='<thead><tr><th></th><th width="15%">产品名称</th><th width="5%">镶口费</th><th width="5%">镶口数</th><th width="10%">金价</th><th width="5%">损耗</th><th width="5%">金重上限</th><th width="5%">金重下限</th><th width="5%">主石重量</th><th width="5%">主石价格</th><th width="5%">辅石重量</th><th width="5%">辅石价格</th><th width="8%">采购价上限</th><th width="8%">采购价下限</th><th width="20%">操作</th></tr></thead>';
    		 html+='<tbody>';
    		 for(var i=0;i<data.length;i++) {
    			 html += '<tr><td class="details-control text-center"></td>';
    			 html += '<td>'+data[i].produce.name+'</td>';
    			 html += '<td>'+(data[i].inlayFee == undefined ? '' : data[i].inlayFee)+'</td>';
    			 html += '<td>'+(data[i].inlayNum == undefined ? '' : data[i].inlayNum)+'</td>';
    			 html += '<td><span class="text-red">'+(data[i].goldPrice == undefined ? '' : data[i].goldPrice)+'</span></td>';
    			 html += '<td>'+(data[i].lossFee == undefined ? '' : data[i].lossFee)+'</td>';
    			 html += '<td>'+(data[i].goldWeightMax == undefined ? '' : data[i].goldWeightMax)+'</td>';
    			 html += '<td>'+(data[i].goldWeightMin == undefined ? '' : data[i].goldWeightMin)+'</td>';
    			 html += '<td>'+(data[i].mainStoneWeight == undefined ? '' : data[i].mainStoneWeight)+'</td>';
    			 html += '<td><span class="text-red">'+(data[i].mainStonePrice == undefined ? '' : data[i].mainStonePrice)+'</span></td>';
    			 html += '<td>'+(data[i].subsidiaryStoneWeight == undefined ? '' : data[i].subsidiaryStoneWeight)+'</td>';
    			 html += '<td><span class="text-red">'+(data[i].subsidiaryStonePrice == undefined ? '' : data[i].subsidiaryStonePrice)+'</span></td>';
    			 html += '<td><span class="text-red">'+(data[i].pricePurchaseMax == undefined ? '' : data[i].pricePurchaseMax)+'</span></td>';
    			 html += '<td><span class="text-red">'+(data[i].pricePurchaseMin == undefined ? '' : data[i].pricePurchaseMin)+'</span></td>';
    			 html += '<td> <div class="btn-group zf-tableButton"><button class="btn btn-info btn-sm" onclick="showDetail(\''+supplierId+'\',\''+goodsId+'\',\''+data[i].produce.id+'\')">详情</button><button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button></div></td>';
    			 html += '</tr>';
    		 }
    		 
    		 html+='</tbody>';
   	         html+="</table>";
   	         newTd.append(html);
   	         newTr.append(newTd);
   	         tr.after(newTr);
    	  });
      }
      
      
      function showDetail(supplierId, goodsId, produceId) {
    	   $("#sid").val(supplierId);
    	   $("#gid").val(goodsId);
    	   $("#pid").val(produceId);
    	   $("#infoForm").submit();
      }
      
      function printPreview(supplierId) {
    	  window.open("${ctx}/lgt/si/supplierProduce/printPreview?supplierId="+supplierId);
      }
   </script>
</body>
</html>