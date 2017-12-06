<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货品持有监控管理</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/holdMonitor/">货品持有监控列表</a></small>
				<small>|</small>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/lgt/ps/holdMonitor/info?id=${holdMonitor.id}">货品持有监控详情</a></small>
		      </h1>	
		</section>
		<sys:tip content="${message}"/>	
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<form:form id="inputForm" modelAttribute="holdMonitor" class="form-horizontal">
						<form:hidden path="id"/>
						<div class="box box-primary">
							<div class="box-header">
								<h5>货品持有监控详情</h5>
							</div>
							<div class="box-body">
								<div class="col-md-4">
									<div class="form-group">
										<label for="responsibleBy.name" class="col-sm-3 control-label">责任员工</label>
										<div class="col-sm-8">
											<input class="form-control" name="responsibleBy.name" value="${fns:getUserById(holdMonitor.responsibleBy.id).name}" readonly="readonly"/>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="resourceType" class="col-sm-3 control-label">来源类型</label>
										<div class="col-sm-8">
											<input class="form-control" name="resourceType" value="${fns:getDictLabel(holdMonitor.resourceType,'lgt_ps_hold_monitor_resourceType','')}" readonly="readonly"/>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="resourceIdStr" class="col-sm-3 control-label">来源编号</label>
										<div class="col-sm-8">
											<form:input path="resourceIdStr" readonly="true" htmlEscape="false" maxlength="64" class="form-control" />
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="receiveTime" class="col-sm-3 control-label">货品接收时间</label>
										<div class="col-sm-8">
											<input name="receiveTime" type="text" readonly="readonly" maxlength="20" class="form-control"
												value="<fmt:formatDate value="${holdMonitor.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="limitTime" class="col-sm-3 control-label">要求移交时间</label>
										<div class="col-sm-8">
											<input name="limitTime" type="text" readonly="readonly" maxlength="20" class="form-control"
												value="<fmt:formatDate value="${holdMonitor.limitTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="devolveTime" class="col-sm-3 control-label">实际移交时间</label>
										<div class="col-sm-8">
											<input name="devolveTime" type="text" readonly="readonly" maxlength="20" class="form-control"
												value="<fmt:formatDate value="${holdMonitor.devolveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="holdStatus" class="col-sm-3 control-label">持货状态</label>
										<div class="col-sm-8">
											<input class="form-control" name="holdStatus" value="${fns:getDictLabel(holdMonitor.holdStatus,'lgt_ps_hold_monitor_holdStatus','')}" readonly="readonly"/>
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										<label for="holdStatus" class="col-sm-3 control-label">备注信息</label>
										<div class="col-sm-8">
											<form:textarea path="remarks" readonly="true" htmlEscape="false" rows="1" maxlength="255" class="form-control " />
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="box box-primary">
							<div class="box-header with-border zf-query">
								<h5>货品持有监控明细表</h5>
							</div>
							<div class="box-body">
								<div class="table-responsive">
									<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
										<thead>
											<tr>
												<th class="hide"style="width: 100px;"></th>
												<th>货品唯一码</th>
												<th>备注信息</th>
											</tr>
										</thead>
										<tbody id="holdMonitorDetailList">
										</tbody>
									</table>
									<script type="text/template" id="holdMonitorDetailTpl">//<!--
										<tr id="holdMonitorDetailList{{idx}}">
											<td>
												<input id="holdMonitorDetailList{{idx}}_product" readonly="readonly" name="holdMonitorDetailList[{{idx}}].product" value="{{row.product.product_unique_id}}"  class="form-control"/>
											</td>
											<td>
												<input id="holdMonitorDetailList{{idx}}_remarks" readonly="readonly" name="holdMonitorDetailList[{{idx}}].remarks"  value="{{row.remarks}}"  class="form-control"/>
											</td>
										</tr>//-->
									</script>
									<script type="text/javascript">
										var holdMonitorDetailRowIdx = 0, holdMonitorDetailTpl = $("#holdMonitorDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
										$(document).ready(function() {
											var data = ${fns:toJson(holdMonitor.holdMonitorDetailList)};
											for (var i=0; i<data.length; i++){
												addRow('#holdMonitorDetailList', holdMonitorDetailRowIdx, holdMonitorDetailTpl, data[i]);
												holdMonitorDetailRowIdx = holdMonitorDetailRowIdx + 1;
											}
										});
									</script>
								</div>
							</div>
							<div class="box-footer">
		    					<div class="pull-left box-tools">
					        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
					        	</div>
		    				</div>
						</div>
						
					</form:form>
				</div>
			</div>
		</section>
	</div>

</body>
</html>