<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员列表管理</title>
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
                        <th width="10%">头像</th>
                        <td colspan="3"><img alt="" class="img-responsive"  src="${imgHost}${member.gravatar }"></td>
                    </tr>
                    <tr>
                        <th width="10%">会员账号</th>
                        <td>${member.usercode }</td>
                        <th width="10%">会员微信账号</th>
                        <td>${member.wechatCode }</td>
                    </tr>
                    <tr>
                        <th width="10%">会员编号</th>
                        <td>${member.memberCode }</td>
                        <th width="10%">会员类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(member.type,'crm_mi_member_type','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">昵称</th>
                        <td>${member.nickname }</td>
                        <th width="10%">性别</th>
                        <td><span class="label label-primary">${fns:getDictLabel(member.sex,'sex','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">生日</th>
                        <td>${member.birthday }</td>
                        <th width="10%">年龄</th>
                        <td>${member.age }</td>
                    </tr>
                    <tr>
                        <th width="10%">联系电话</th>
                        <td>${member.mobile }</td>
                        <th width="10%">电子邮箱</th>
                        <td>${member.email }</td>
                    </tr>
                    <tr>
                        <th width="10%">个性签名</th>
                        <td colspan="3">${member.sign }</td>
                    </tr>
                    <tr>
                        <th width="10%">姓名</th>
                        <td>${member.name }</td>
                        <th width="10%">身份证</th>
                        <td>${member.idCard }</td>
                    </tr>
                    <tr>
                        <th width="10%">工作单位</th>
                        <td>${member.company }</td>
                        <th width="10%">推荐会员</th>
                        <td>${member.recommendMember.id }</td>
                    </tr>
                    <tr>
                        <th width="10%">注册来源</th>
                        <td><span class="label label-primary">${fns:getDictLabel(member.registerPlatform,'crm_mi_member_registerPlatform','')}</span></td>
                        <th width="10%">注册时间</th>
                        <td><fmt:formatDate value="${member.registerTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">会员状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(member.memberStatus,'crm_mi_member_memberStatus','')}</span></td>
                        <th width="10%">账号状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(member.usercodeStatus,'crm_mi_member_usercodeStatus','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">实名状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(member.realnameStatus,'crm_mi_member_realnameStatus','')}</span></td>
                        <th width="10%">实名审核人</th>
                        <td>${member.realnameCheckBy.id }</td>
                    </tr>
                    <tr>
                        <th width="10%">实名审核时间</th>
                        <td colspan="3">${member.realnameCheckTime }</td>
                    </tr>
                    <tr>
                        <th width="10%">实名审核备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${member.realnameCheckRemarks }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">黑名单状态</th>
                        <td colspan="3"><span class="label label-primary">${fns:getDictLabel(member.blackwhiteStatus,'crm_mi_member_blackwhiteStatus','')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">黑名单备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${member.blackwhiteRemark }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">积分</th>
                        <td><span class="label label-primary">${member.point}</span></td>
                        <th width="10%">信誉分</th>
                        <td><span class="label label-primary">${member.creditPoint}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${member.remarks }</p></td>
                    </tr>
                </table>
            </div>
        </section>
        <form:form id="inputForm" modelAttribute="member" action="${ctx}/crm/mi/member/checkMemberRealName" method="post" onsubmit="return formSubmit();" class="form-horizontal">
        <form:hidden path="id"/>
           <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="box box-success">
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group zf-check-wrapper-padding">
                                            <label for="style" class="col-sm-3 control-label">认证结果</label>
                                            <div class="col-sm-7">   
                                                <input type="radio" name="realnameStatus" value="3" checked="checked"/>认证通过&nbsp;&nbsp;
                                                <input type="radio" name="realnameStatus" value="4" />认证拒绝
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="style" class="col-sm-3 control-label">认证备注</label>
                                            <div class="col-sm-7">
                                                <form:textarea path="realnameCheckRemarks" cssClass="form-control" rows="3" maxlength="200" cssStyle="width:820px;height:80px;"/>
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="box zf-box-mul-border">
                    <div class="box-footer">
                        <div class="pull-left box-tools">
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                        </div>
                        <div class="pull-right box-tools">
                            <button type="submit" class="btn btn-info btn-sm" ><i class="fa fa-save">保存</i></button>
                        </div>
                    </div>
                </div>
             </section>
        </form:form>
	</div>
	<script type="text/javascript">
		$(function() {
		    
		    $('input').iCheck({
		        checkboxClass : 'icheckbox_minimal-blue',
		        radioClass : 'iradio_minimal-blue'
		    });
		});
		
		function formSubmit() {
		    var selVal = $("input[name=realnameStatus]").val();
		    if(selVal == null || selVal == "" || selVal == undefined) {
		        ZF.showTip("请先选择认证结果", "info");
		        return false;
		    }
		    $("#inputForm").submit();
		}
	</script>
</body>
</html>