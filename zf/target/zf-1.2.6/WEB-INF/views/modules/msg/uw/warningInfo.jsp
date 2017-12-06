<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工报警中心管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
	
	<div class="content-wrapper sub-content-wrapper">
	
	    <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">警报类别</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warning.category,'msg_uw_warning_category','')}</span></td>
                        <th width="10%">警报类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warning.type,'msg_uw_warning_type','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">标题</th>
                        <td>${warning.title}</td>
                        <th width="10%">警报状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(warning.status,'msg_uw_warning_status','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">内容</th>
                        <td colspan="5"><p class="text-muted well well-sm no-shadow">${warning.content }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">推送时间</th>
                        <td><fmt:formatDate value="${warning.pushTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <th width="10%">查看时间</th>
                        <td><fmt:formatDate value="${warning.viewTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">发送用户</th>
                        <td>${fns:getUserById(warning.sendUser.id).name}</td>
                        <th width="10%">接收用户</th>
                        <td>${fns:getUserById(warning.receiveUser.id).name}</td>
                     </tr>
                     <tr>
                        <th width="10%">处理用户</th>
                        <td>${fns:getUserById(warning.dealUser.id).name}</td>
                        <th width="10%">处理完成时间</th>
                        <td><fmt:formatDate value="${warning.dealEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">处理结果备注</th>
                        <td colspan="5"><p class="text-muted well well-sm no-shadow">${warning.dealResultRemarks }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="5"><p class="text-muted well well-sm no-shadow">${warning.remarks }</p></td>
                    </tr>
                </table>
            </div>
            
            <div class="box-footer">
                <div class="pull-left box-tools">
                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:window.location.href='${ctx}/msg/uw/myWarning/list'"><i class="fa fa-mail-reply"></i>返回</button>
                </div>
            </div>
        </section>
	</div>	
</body>
</html>