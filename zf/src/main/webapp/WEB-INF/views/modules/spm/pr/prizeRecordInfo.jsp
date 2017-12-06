<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品领取记录详情</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript">
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
	    <section class="content">
            <div class="row">
            	<div class="col-md-4">
		            <div class="box box-primary">
			            <div class="box-header with-border">
		            	<div class="box-body box-profile">
		            	    
		            	    <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>会员</b> 
                                    <a class="pull-right">${prizeRecord.member.usercode }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>奖品</b> 
                                    <a class="pull-right">${prizeRecord.prize.name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>领取原因</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(prizeRecord.reasonType,'SPM_PR_PRIZE_RECORD_REASON_TYPE','') }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>领取时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${prizeRecord.receiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>领取状态</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(prizeRecord.receiveStatus,'SPM_PR_PRIZE_RECORD_RECEIVE_STATUS','') }</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>创建人</b> 
                                    <a class="pull-right">${fns:getUserById(prizeRecord.createBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>创建时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${prizeRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>更新人</b> 
                                    <a class="pull-right">${fns:getUserById(prizeRecord.updateBy.id).name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>更新时间</b> 
                                    <a class="pull-right"><fmt:formatDate value="${prizeRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                                </li>
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${prizeRecord.remarks}</a>
                                </li>
                            </ul>
		            	</div>
		            	<div class="box-footer">
							<button type="button" class="btn btn-default btn-sm"
								onclick="javascript:history.go(-1)">
								<i class="fa fa-mail-reply"></i>返回
							</button>
						</div>
		            </div>
	            </div>
	        </div>
	    </section>
	 </div>
</body>
</html>