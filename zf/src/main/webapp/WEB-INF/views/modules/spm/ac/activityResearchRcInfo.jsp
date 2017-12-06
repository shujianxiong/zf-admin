<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>活动调研记录管理</title>
	<meta name="decorator" content="adminLte"/>
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
                                    <b>参与人账号</b> 
                                    <a class="pull-right">${activityResearchRc.member.usercode }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>活动名称</b> 
                                    <a class="pull-right">${activityResearchRc.activityResearch.activity.name }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>活动类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(activityResearchRc.activityResearch.activity.activityType,'spm_ai_activity_activityType','') }</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>活动标题</b> 
                                    <a class="pull-right">${activityResearchRc.activityResearch.activity.title }</a>
                                </li>
                                <li class="list-group-item">
                                    <b>参与状态</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(activityResearchRc.status,'spm_ac_activity_research_rc_status','') }</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${activityResearchRc.remarks }</a>
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