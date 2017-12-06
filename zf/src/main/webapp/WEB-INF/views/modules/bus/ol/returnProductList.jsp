<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货货品管理</title>
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
    </script>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/returnProduct/">退货货品入库</a></small>
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

            <form:form id="searchForm" modelAttribute="returnProduct" action="${ctx}/bus/ol/returnProduct" method="post" class="form-horizontal">
                <form:hidden path="returnOrder.id"/>
                <%--<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>--%>
                <%--<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>--%>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="damageType" class="col-sm-3 control-label">损坏类型</label>
                                <div class="col-sm-7">
                                    <form:select path="damageType" class="form-control select2">
                                        <form:option value="" label="所有"/>
                                        <form:options items="${fns:getDictList('bus_or_repair_order_breakdownType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="beginQualityTime" class="col-sm-3 control-label">质检起始时间</label>
                                <div class="col-sm-7">
                                    <div class='input-group date'>
                                        <input type='text' class="form-control" placeholder="请选择质检起始时间" id="beginQualityTime"name="beginQualityTime" value="<fmt:formatDate value="${returnProduct.beginQualityTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
                                        <span class="input-group-addon">
          	                                <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="endQualityTime" class="col-sm-3 control-label">质检结束时间</label>
                                <div class="col-sm-7">
                                    <div class='input-group date'>
                                        <input type='text' class="form-control" placeholder="请选择质检结束时间" id="endQualityTime"name="endQualityTime" value="<fmt:formatDate value="${returnProduct.endQualityTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
                                        <span class="input-group-addon">
          	                                <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
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
        <%--<div class="box box-info">
            <div class="box-header with-border zf-query">
                <h5>回货扫描</h5>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="col-md-4">
                        <div  class="form-group">
                            <label for="codeTemp" class="col-sm-3 control-label">货品编码</label>
                            <div class="col-sm-7">
                                <input type="text" name="code" id="codeTemp" placeholder="请扫描录入货品编码" class="form-control zf-input-readonly" t>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box-footer">
                <div class="pull-right box-tools">
                    <button type="button" class="btn btn-default btn-sm" onclick="addReturnProduct()"><i class="fa fa-save"></i>添加</button>
                </div>
            </div>
        </div>--%>
        <div class="box box-soild">
            <div class="box-body">
                <div class="row">
                    <div class="col-sm-12 pull-right">
                        <button type="button" class="btn btn-sm btn-success" onclick="batchInWarehouse();" ><i class="fa fa-pencil">批量入库</i></button>
                        <button type="button" class="btn btn-sm btn-primary" onclick="exportExcel();" ><i class="fa fa-file">导出Excel</i></button>
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th style="width: 50px"><input type="checkbox" id="allcheck"/>全选</th>
                                <th>货品编码</th>
                                <th>货品图片</th>
                                <th>货品名称</th>
                                <th>货品状态</th>
                                <th>损坏类型</th>
                                <th>质检时间</th>
                                <th>质检人</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${returnProductList}" var="returnProduct" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                        <div class="zf-check-wrapper-padding">
                                            <input type="checkBox" data-name="selectName"  ${returnProduct.damageType eq '5' ? 'disabled=true':'' } value="${returnProduct.id}"/>
                                        </div>
                                    </td>

                                    <td>
                                        ${returnProduct.product.code}
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);"  src="${imgHost }${returnProduct.product.goods.samplePhoto}" data-big data-src="${imgHost }${returnProduct.product.goods.samplePhoto}" width="21" height="21" />
                                    </td>
                                    <td>
                                            ${returnProduct.product.goods.name}
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(returnProduct.inStatus, 'bus_ol_return_product_inStatus', '')}</span>
                                    </td>
                                    <td>
                                        <span class="label label-primary">${fns:getDictLabel(returnProduct.damageType, 'bus_or_repair_order_breakdownType', '')}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${returnProduct.qualityTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
                                    </td>
                                    <td>
                                            ${fns:getUserById(returnProduct.returnOrder.checkBy.id).name}
                                    </td>
                                    <%--<td>
                                        <input type="text" id="warehouse" hidden >
                                        <c:if test="${returnProduct.damageType eq '2' or returnProduct.damageType eq '3'}">
                                            <button  id="but"  type="button"  onclick="wareSelect(${returnProduct.product.code})" >货位选择</button>
                                            <sys:selectmutil id="warehouseSelect" title="货位选择" url=""
                                                             isDisableCommitBtn="true" width="1200"
                                                             height="700"></sys:selectmutil>
                                        </c:if>
                                    </td>--%>
                                    <td>
                                        <c:if test="${returnProduct.inStatus eq '1'}">
                                            <c:choose>
                                                <c:when test="${returnProduct.damageType eq '5'}">
                                                    <div class="btn-group zf-tableButton">
                                                        <button type="button" class="btn btn-sm btn-info"
                                                                onclick="save('${returnProduct.id}')" disabled>入库</button>
                                                        <button type="button"
                                                                class="btn btn-sm btn-info dropdown-toggle"
                                                                data-toggle="dropdown">
                                                            <span class="caret"></span>
                                                        </button>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="btn-group zf-tableButton">
                                                        <button type="button" class="btn btn-sm btn-info"
                                                                onclick="save('${returnProduct.id}')">入库</button>
                                                        <button type="button"
                                                                class="btn btn-sm btn-info dropdown-toggle"
                                                                data-toggle="dropdown">
                                                            <span class="caret"></span>
                                                        </button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
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
     </section>
    </div>

    <script>
      $(function () {
          $("#codeTemp").focus();//给定默认光标

          const options = {
              locale:'zh-cn',
              format:'YYYY-MM-DD HH:mm:ss'
          }


          $('.date').datetimepicker(options);

        ZF.bigImg();
          $("#codeTemp").on("change", function() {
              var code = $.trim($(this).val());
              if(code == null || code == "" || code == undefined) {
                  alert("请先扫描货品编码");
                  return false;
              }else{
                  window.location.href="${ctx}/bus/ol/returnProduct/savePro?code="+code;
              }
          });
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });

        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : false,
            "order": [[ 1, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
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
        })


          $("#allcheck").on("ifChecked", function(){
              $("[data-name]").iCheck('check');
          }).on("ifUnchecked", function() {
              $("[data-name]").iCheck('uncheck');
          });


      });
      function save(id) {
          var warehouse = $("#warehouse").val();
          window.location.href="${ctx}/bus/ol/returnProduct/inWarehouse?inWareplace="+warehouse+"&id="+id;
      }
      function wareSelect(code) {
          // 选择货位

          $("#warehouseSelectModalUrl").val("${ctx}/lgt/ps/productWpChange/formReturn?code="+code+"");//带参数请求URL设置方式
          $("#warehouseSelectModal").modal('toggle');//显示模态框
          // 选择货位Modal<iframe>回调事件
          $("#warehouseSelectModal #commitBtn").on("click",function(){
              $("#warehouseSelectModal").modal("hide");				// 隐藏模态框
              var content = $("#warehouseSelectModalIframe").contents().find("body");
                /*
                获取货位的id
                 */
              var wareplace = $("#postWareplaceId",content).val();
              document.getElementById("warehouse").value =wareplace;
              //$("#but").attr("disabled","disabled");
             /* $("input[type=radio]", content).each(function(){
                  if($(this).prop("checked")){
                      iframeSelected($(this).val(), $(this).attr("data-code")+"("+$(this).attr("data-fullname")+")");
                  }
              });*/
              //清楚check  table缓存
              //window.localStorage.removeItem("productWpChangeForm");
          });
      }

      // 选择产品 iframe选择产品后回调方法
      function iframeSelected(warehouse){
          $("#warehouse").val(warehouse);
      }
      
      function batchInWarehouse() {
          const ids = [];
          $("[data-name]").each(function () {
              if($(this).prop("checked")){
                  ids.push($(this).val());
              }
          });
          if (ids.length > 0){
            window.location.href="${ctx}/bus/ol/returnProduct/batchInWarehouse?ids="+ids;
          }else {
              ZF.showTip("请先选择要操作的记录！", "info");
              return false;
          }
      }

      function addReturnProduct() {
          if ($("#codeTemp").val() != null && $("#codeTemp").val() != ""){
              var code = $("#codeTemp").val();
              window.location.href="${ctx}/bus/ol/returnProduct/savePro?code="+code;
          }else {
              ZF.showTip("请先输入货品编码", "info");
              return false;
          }

      }

      
      function exportExcel() {
          $("#searchForm").attr("action", "${ctx}/bus/ol/returnProduct/export");
          $("#searchForm").submit();
          $("#searchForm").attr("action", "${ctx}/bus/ol/returnProduct/list");
      }

   </script>
</body>
</html>