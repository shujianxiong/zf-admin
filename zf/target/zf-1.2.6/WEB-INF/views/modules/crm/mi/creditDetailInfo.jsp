<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信誉详情管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>

	<div class="content-wrapper sub-content-wrapper">
		<section class="content">
			<div class="row">
				<div class="col-md-4">
					<div class="box box-primary">
						<c:set var="member" value="${fns:getMemberById(creditDetail.member.id) }"></c:set>
						<div class="box-body box-profile">
						    
						    <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>会员账号</b> 
                                    <a class="pull-right">${member.usercode }</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>变动类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(creditDetail.changeType,'add_decrease','') }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>变动信誉数量</b> 
                                    <a class="pull-right">${creditDetail.changeCredit }</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>变动后信誉</b> 
                                    <a class="pull-right">${creditDetail.lastCredit }</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>变动原因</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(creditDetail.changeReasonType,'crm_mi_credit_detail_changeReasonType','') }</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>变动时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${creditDetail.changeTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>操作人类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(creditDetail.operaterType,'operater_type','') }</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${creditDetail.remarks }</a>
                                </li>
                            </ul>
						</div>
						<div class="box-footer">
		    				<div class="pull-left box-tools">
				        		<button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
				        	</div>
			            </div>
					</div>
				</div>
			</div>
		</section>
	</div>
	
</body>
</html>