<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调研活动详情</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		$(function() {
			editor = CKEDITOR.replace( 'ruleDetail');
			var html = editor.getData();
			document.getElementById("ruleDetailP").innerHTML = html;
		});
	
	
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

        <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <p class="lead">基本信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">活动名称</th>
                        <td colspan="3">${activityResearch.activity.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">活动类型</th>
                        <td colspan="3"><span class="label label-primary">${fns:getDictLabel(activityResearch.activity.activityType,'SPM_AC_ACTIVITY_TYPE','') }</span></td>
                    </tr>
                    <tr>
                        <th width="10%">活动模板</th>
                        <td colspan="3">${activityResearch.activity.acActivityTemplate.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">活动标题</th>
                        <td colspan="3">${activityResearch.activity.title }</td>
                    </tr>
                    <tr>
                        <th width="10%">活动副标题</th>
                        <td colspan="3">${activityResearch.activity.subtitle }</td>
                    </tr>
                    <tr>
                        <th width="10%">简介</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${activityResearch.activity.summary }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">介绍</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${activityResearch.activity.introduce }</p></td>
                    </tr>
                    <tr>
                        <th width="10%">规则详情</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow"><textarea name="ruleDetail">${activityResearch.activity.ruleDetail }</textarea></p></td>
                    </tr>
                    <tr>
                        <th width="10%">启用状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(activityResearch.activity.activeFlag, 'yes_no', '')}</span></td>
                        <th width="10%">奖励积分</th>
                        <td>${activityResearch.activity.rewardPoint }</td>
                    </tr>
                    
                    <tr>
                        <th width="10%">起始时间</th>
                        <td><fmt:formatDate value="${activityResearch.activity.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <th width="10%">截止时间</th>
                        <td><fmt:formatDate value="${activityResearch.activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    
                    <tr>
                        <th width="10%">创建者</th>
                        <td>${fns:getUserById(activityResearch.activity.createBy.id).name}</td>
                        <th width="10%">创建时间</th>
                        <td><fmt:formatDate value="${activityResearch.activity.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    
                    <tr>
                        <th width="10%">更新者</th>
                        <td>${fns:getUserById(activityResearch.activity.updateBy.id).name}</td>
                        <th width="10%">更新时间</th>
                        <td><fmt:formatDate value="${activityResearch.activity.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${activityResearch.activity.remarks}</p></td>
                    </tr>
                </table>
            </div>
        </section>
        <section class="invoice">
             <p class="lead">分享小图</p>
             <div class="carousel slide " data-ride="carousel">
                <div class="carousel-inner">
                    <img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(activityResearch.activity.shareSPhoto, '|', '')}" data-src="${imgHost }${fn:replace(activityResearch.activity.shareSPhoto, '|', '')}"  class="img-responsive">
                </div>
             </div>
         </section> 
         <section class="invoice">
             <p class="lead">分享大图</p>
             <div class="carousel slide " data-ride="carousel">
                <div class="carousel-inner">
                    <img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(activityResearch.activity.shareMPhoto, '|', '')}" data-src="${imgHost }${fn:replace(activityResearch.activity.shareMPhoto, '|', '')}"  class="img-responsive">
                </div>
             </div>
           	 <div class="box-footer">
				<button type="button" class="btn btn-default btn-sm"
					onclick="javascript:history.go(-1)">
					<i class="fa fa-mail-reply"></i>返回
				</button>
			 </div>
         </section>                         
	 </div>
</body>
</html>