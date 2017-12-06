<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调研活动详情</title>
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
	    <form:form id="inputForm" modelAttribute="acActivity" action="${ctx}/spm/ac/acActivity/info" method="post" class="form-horizontal">
	    <section class="content">
	    	
            <div class="row">
            	<div class="col-md-6">
		            <div class="box box-primary">
			            <div class="box-header with-border">
			              <h5>活动信息详情</h5>
			              <div class="box-tools">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			              </div>
			            </div>
			            <!-- /.box-header -->
		            	<div class="box-body">
		            			
		            		<strong>活动名称</strong>
							<p class="text-primary">${acActivity.name }</p>
							<hr class="zf-hr">
							
							<strong>活动类型</strong>
							<p>
							     <span class="label label-primary">${fns:getDictLabel(acActivity.activityType,'SPM_AC_ACTIVITY_TYPE','') }</span>
						    </p>
							<hr class="zf-hr">
							
							<strong>活动模板</strong>
							<p class="text-primary">${acActivity.acActivityTemplate.name }</p>
							<hr class="zf-hr">
							
							<strong>活动标题</strong>
							<p class="text-primary">${acActivity.title }</p>
							<hr class="zf-hr">
							
							<strong>活动副标题</strong>
							<p class="text-primary">${acActivity.subtitle }</p>
							<hr class="zf-hr">
							
							<strong>分享小图</strong>
							<p class="text-primary"><img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(acActivity.shareSPhoto, '|', '')}" data-src="${imgHost }${fn:replace(acActivity.shareSPhoto, '|', '')}"  class="img-responsive"></p>
							<hr class="zf-hr">
							
							<strong>分享中图</strong>
							<p class="text-primary"><img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(acActivity.shareMPhoto, '|', '')}" data-src="${imgHost }${fn:replace(acActivity.shareMPhoto, '|', '')}"  class="img-responsive"></p>
							<hr class="zf-hr">
							
							<strong>简介</strong>
							<p class="text-primary">${acActivity.summary }</p>
							<hr class="zf-hr">
							
							<strong>介绍</strong>
							<p class="text-primary">${acActivity.introduce }</p>
							<hr class="zf-hr">
							
							<strong>规则详情</strong>
							<p class="text-primary">${acActivity.ruleDetail }</p>
							<hr class="zf-hr">
							
							<strong>奖励积分</strong>
							<p class="text-primary">${acActivity.rewardPoint }</p>
							<hr class="zf-hr">
							
							<strong>起始时间</strong>
							<p class="text-primary"><fmt:formatDate value="${acActivity.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
							<hr class="zf-hr">
							
							<strong>起始时间</strong>
							<p class="text-primary"><fmt:formatDate value="${acActivity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
							<hr class="zf-hr">
							
							<strong>启用状态</strong>
							<p><span class="label label-primary">${fns:getDictLabel(acActivity.activeFlag, 'yes_no', '')}</span></p>
							<hr class="zf-hr">
							
							<strong>奖品</strong>
							<p class="text-primary">${acActivity.rewardPrize.name}</p>
							<hr class="zf-hr">
							
							<strong>创建者</strong>
							<p class="text-primary">${fns:getUserById(acActivity.createBy.id).name}</p>
							<hr class="zf-hr">
							
							<strong>创建时间</strong>
							<p class="text-primary"><fmt:formatDate value="${acActivity.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
							<hr class="zf-hr">
							
							<strong>更新者</strong>
							<p class="text-primary">${fns:getUserById(acActivity.updateBy.id).name}</p>
							<hr class="zf-hr">
							
							<strong>更新时间</strong>
							<p class="text-primary"><fmt:formatDate value="${acActivity.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
							<hr class="zf-hr">
							
							<strong>备注信息</strong>
							<p class="text-primary">${acActivity.remarks }</p>
							<hr class="zf-hr">
							
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
	    </form:form>
	 </div>
</body>
</html>