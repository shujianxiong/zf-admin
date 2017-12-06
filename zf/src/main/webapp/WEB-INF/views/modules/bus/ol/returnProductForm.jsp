<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>退货货品管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <%-- <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/bus/ol/returnProduct/">退货货品列表</a></small>
            <shiro:hasPermission name="bus:ol:returnProduct:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/bus/ol/returnProduct/form?id=${returnProduct.id}">退货货品${not empty returnProduct.id?'修改':'添加'}</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section> --%>
    <section class="content-header content-header-menu">
        
    </section>
    <section class="invoice">
        <p class="lead">退货单基本信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">退货单号</th>
                    <td>${returnOrder.returnOrderNo }</td>
                    <th width="10%">下单时间</th>
                    <td width="40%"><fmt:formatDate value="${returnOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th width="10%">退货状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(returnOrder.status, 'bus_ol_return_order_status', '') }</span></td>
                    <th width="10%">退货类型</th>
                    <td width="40%"><span class="label label-primary">${fns:getDictLabel(returnOrder.reasonType, 'bus_ol_return_order_reasonType', '') }</span></td>
                </tr>
                <tr>
                    <th width="10%">快递公司</th>
                    <td><span class="label label-primary">${fns:getDictLabel(returnOrder.expressCompany, 'express_company', '') }</span></td>
                    <th width="10%">快递单号</th>
                    <td width="40%">${returnOrder.expressNo }</td>
                </tr>
                <tr>
                    <th width="10%">退货原因详情</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${returnOrder.reasonDetail}</p></td>
                </tr>
            </table>
        </div>
    </section>
    <section class="invoice">
        <p class="lead">关联货品</p>
        <div class="table-responsive">
            <table class="table table-striped">
                <tr>
                    <th>名称</th>
                    <th>货品编码</th>
                    <th>展示图(小)</th>
                    <th>退货状态</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${list.returnProductList }" var="rp" >
                    <tr>
                        <td>${rp.goods.name }&nbsp;${rp.produce.name }</td>
                        <td>${rp.product.code }</td>
                        <td><img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(rp.goods.icon, '|', '')}"  width="20px" height="20px" /></td>
                        <td><span class="label label-primary">${fns:getDictLabel(rp.status, 'bus_ol_return_product_status', '')}</span></td>
                    </tr>
                </c:forEach>
                <tr>
                    <td>商品一</td>
                    <td>GT0000001</td>
                    <td><img onerror="imgOnerror(this);"  src=""  width="20px" height="20px" /></td>
                    <td><span class="label label-primary">${fns:getDictLabel(1, 'bus_ol_return_product_status', '')}</span></td>
                    <td><button id="chkReg" class="btn btn-info btn-sm">质检登记</button></td>
                </tr>
                <tr>
                    <td>商品二</td>
                    <td>GT0000002</td>
                    <td><img onerror="imgOnerror(this);"  src=""  width="20px" height="20px" /></td>
                    <td><span class="label label-primary">${fns:getDictLabel(1, 'bus_ol_return_product_status', '')}</span></td>
                    <td><button class="btn btn-info btn-sm">质检登记</button></td>
                </tr>
            </table>
        </div>
        
        <div class="row no-print">
            <div class="col-xs-12">
                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
            </div>
        </div>
        
        
        <div id="addRepairOrderModal" class="modal fade">
	         <div class="modal-dialog">
		         <div class="modal-content">
			         <div class="modal-header">
			             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			             <span aria-hidden="true">&times;</span></button>
			             <h4 class="modal-title">添加维修登记信息</h4>
			         </div>
			         <div class="modal-body divScroll">
			             <form:form id="inputForm" action="${ctx }/bus/or/repairOrder/saveReturnProductRepairRegister" modelAttribute="repairOrder" method="post" onsubmit="return ZF.formSubmit();">
			                 <div class="box box-success">
		                        <div class="box-header with-border zf-query">
		                            <h5>请完善表单填写</h5>
		                            <div class="box-tools">
		                               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		                            </div>
		                        </div>
		                        <div class="box-body">
		                            <form:hidden path="bussinessId"/>
		                            <div class="form-group">
		                                <label class="col-sm-2 control-label">绑定货签</label>
		                                <div class="col-sm-9"  style="margin-bottom: 10px;">
		                                    <sys:inputverify id="ptcode" name="product.code" tip="请输入原始货签，必填项" verifyType="0"  isSpring="true"></sys:inputverify>
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-2 control-label">损坏类型</label>
		                                <div class="col-sm-9">
		                                    <form:select path="breakdownType" class="form-control">
		                                        <form:options items="${fns:getDictList('bus_or_repair_order_breakdownType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		                                    </form:select>
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-2 control-label">问题图片</label>
		                                <div class="col-sm-9">
		                                    <form:hidden id="breakdownPhotos" path="breakdownPhotos" htmlEscape="false" maxlength="255" class="form-control"/>
		                                    <sys:fileUpload input="breakdownPhotos" model="false" selectMultiple="false" fileDirCode="profilePhoto"></sys:fileUpload>
		                                    
		                                </div>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-2 control-label">备注</label>
		                                <div class="col-sm-9">
		                                    <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
		                                </div>
		                            </div>
		                        </div>
		                        <%-- <div class="box-footer">
		                            <div class="pull-right box-tools">
		                                <shiro:hasPermission name="sys:area:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
		                            </div>
		                        </div> --%>
		                    </div>
			             </form:form>
			         </div>
			         <div class="modal-footer">
			             <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
			             <button type="button" id="addGoodsCommit" class="btn btn-primary">提交</button>
			         </div>
		        </div>
	       </div>
	    </div>
    </section>
    
    <script type="text/javascript">
          $(function() {
        	  $("#chkReg").on("click", function() {
        		  $("#addRepairOrderModal").modal('toggle');//显示模态框
        	  });
        	  
        	  $("#addGoodsCommit").on("click", function() {
        		  $("#inputForm").submit();
        	  });
          });
    </script>
    
</div>
</body>
</html>