<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>好坏货调动记录管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    <sys:tip content="${message}"/>
    
    <form:form id="inputForm" modelAttribute="goodBadChange" action="${ctx}/lgt/ps/goodBadChange/info" method="post" class="form-horizontal">
        <section class="content">
            <div class="row">
                <div class="col-md-6">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h5>好坏货调动记录信息</h5>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
	                        <div class="table-responsive">
	                        <table class="table">
	                           <tr>
	                               <th width="10%">货品编码</th>
	                               <td>${goodBadChange.product.code}</td>
	                               <th width="10%">定损金额</th>
	                               <td>${goodBadChange.assessmentAmount}</td>
	                           </tr>
	                           <tr>
	                               <th width="10%">图片</th>
	                               <td><img onerror="imgOnerror(this);" data-big data-src="${imgHost }${goodBadChange.photo}" src="${imgHost }${goodBadChange.photo}" width="100px;" height="100px;"/></td>
	                           </tr>
	                           <tr>
	                               <th width="10%">调前货位</th>
	                               <td>${goodBadChange.preWareplace.warecounter.warearea.warehouse.code}-${goodBadChange.preWareplace.warecounter.warearea.code}-${goodBadChange.preWareplace.warecounter.code}-${goodBadChange.preWareplace.code}</td>
	                               <th width="10%">调后货位</th>
	                               <td>${goodBadChange.postWareplace.warecounter.warearea.warehouse.code}-${goodBadChange.postWareplace.warecounter.warearea.code}-${goodBadChange.postWareplace.warecounter.code}-${goodBadChange.postWareplace.code}</td>
	                           </tr>
	                           <tr>
	                               <th width="10%">调货原因类型</th>
	                               <td ><span class="label label-primary">${fns:getDictLabel(goodBadChange.reasonType, 'lgt_ps_good_bad_change_reasonType', '')}</span></td>
	                           </tr>
	                           <tr>
	                               <th width="10%">创建人</th>
	                               <td >${fns:getUserById(goodBadChange.createBy.id).name}</td>
	                               <th width="10%">责任人</th>
	                               <td > ${fns:getUserById(goodBadChange.personLiable.id).name}</td>
	                           </tr>
	                           <tr>
	                               <th width="10%">创建时间</th>
	                               <td> <fmt:formatDate value="${goodBadChange.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                               <th width="10%">备注信息</th>
	                               <td >${goodBadChange.remarks}</td>
	                           </tr>
	                       </table>
	                   </div>
		                   <shiro:hasPermission name="lgt:ps:goodBadChange:audit">
		                       <div class="control-group">
							       <label class="control-label">审核备注信息：</label>
							       <div class="controls">
							       <input id="checkRemarks" value="${goodBadChange.checkRemarks }" class="form-control">
							      </div>
			                   </div>
		                       <div class="pull-right box-tools" style ="margin-top: 10px">
		                           <c:if test="${goodBadChange.status eq '1'}">
		                               <button type="button" class="btn btn-info btn-sm" onclick="refuse('${goodBadChange.id}',3)"><i class="fa fa-save"></i>审核拒绝</button>
		                               <button type="button" class="btn btn-info btn-sm" onclick="pass('${goodBadChange.id}',2)"><i class="fa fa-save"></i>审核通过</button>
		                           </c:if>
		                       </div>
		                   </shiro:hasPermission>
                        </div>

                        <div class="box-footer">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                                <i class="fa fa-mail-reply"></i>返回
                            </button>
                        </div>
                    </div>
               </div>
            </div>
         </section>
    </form:form>
</div>
 <script type="text/javascript">

        function refuse(id,status) {
        	var  checkRemarks =$('#checkRemarks').val();
            window.location.href="${ctx}/lgt/ps/goodBadChange/auditGoodBadChange?id="+id+"&status="+status+"&checkRemarks="+encodeURI(checkRemarks);
        }
        function pass(id,status) {
        	var  checkRemarks =$('#checkRemarks').val();
            window.location.href="${ctx}/lgt/ps/goodBadChange/auditGoodBadChange?id="+id+"&status="+status+"&checkRemarks="+encodeURI(checkRemarks);
        }
    </script>
</body>
</html>