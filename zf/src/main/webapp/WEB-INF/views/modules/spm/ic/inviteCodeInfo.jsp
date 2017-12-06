<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>邀请码列表</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
		tr{ 
		    cursor: pointer;    /*手形*/   
		} 
	</style>
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
	            	<div class="box-body box-profile">
	            		
	            		<ul class="list-group list-group-unbordered">
                            <li class="list-group-item">
                                <b>活动邀请人</b> 
                                <a class="pull-right">${fns:getUserById(inviteCode.createrId).name }</a>
                            </li>
                            <li class="list-group-item">
                                <b>邀请码</b> 
                                <a class="pull-right">${inviteCode.inviteCode }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>活动</b> 
                                <a class="pull-right">${inviteCode.activity.name }</a>
                            </li>
                            <li class="list-group-item">
                                <b>活动开始时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${inviteCode.activity.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>活动结束时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${inviteCode.activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            <li class="list-group-item">
                                <b>活动被邀请人</b> 
                                <a class="pull-right">${inviteCode.useMember.usercode }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>使用标记</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(inviteCode.useFlag,'yes_no','') }</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>使用时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${inviteCode.useTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>创建类型</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(inviteCode.createrType,'SPM_IC_INVITE_CODE_TYPE','') }</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>创建人</b> 
                                <a class="pull-right">${fns:getUserById(inviteCode.createBy.id).name }</a>
                            </li>
                            <li class="list-group-item">
                                <b>创建时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${inviteCode.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>更新人</b> 
                                <a class="pull-right">${fns:getUserById(inviteCode.updateBy.id).name }</a>
                            </li>
                            <li class="list-group-item">
                                <b>更新时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${inviteCode.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>备注</b> 
                                <a class="pull-right">${inviteCode.remarks}</a>
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