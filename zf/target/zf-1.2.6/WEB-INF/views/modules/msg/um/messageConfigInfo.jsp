<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工消息发送设置管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	<sys:tip content="${message }" />
	<section class="content">
		<div class="row">
			<div class="col-md-4">
				<div class="box box-primary">
					<div class="box-body box-profile">
					   <ul class="list-group list-group-unbordered">
                           <li class="list-group-item">
                               <b>消息类别</b> 
                               <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(messageConfig.category,'msg_um_message_category','')}</span></a>
                           </li>
                           <li class="list-group-item">
                               <b>消息类型</b> 
                               <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(messageConfig.type,'msg_um_message_config_type','')}</span></a>
                           </li>
                           
                           <li class="list-group-item">
                               <b>标题</b> 
                               <a class="pull-right">${messageConfig.title }</a>
                           </li>
                           <li class="list-group-item">
                               <b>内容文本模型</b> 
                               <a class="pull-right">${messageConfig.contentModel }</a>
                           </li>
                           
                           <li class="list-group-item">
                               <b>接收角色</b> 
                               <a class="pull-right"><span class="label label-primary">${messageConfig.receiveRole.name }</span></a>
                           </li>
                           
                           <li class="list-group-item">
                               <b>启用标记</b> 
                               <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(messageConfig.usableFlag,'yes_no','' )} </span></a>
                           </li>
                           
                           <li class="list-group-item">
                               <b>备注</b> 
                               <a class="pull-right">${messageConfig.remarks }</a>
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