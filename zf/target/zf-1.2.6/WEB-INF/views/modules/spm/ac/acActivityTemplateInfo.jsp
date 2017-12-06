<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>调研活动模板详情</title>
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

        <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <p class="lead">基本信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">模板名称</th>
                        <td>${acActivityTemplate.name }</td>
                    </tr>
                    </tr>
                        <th width="10%">模板描述</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${acActivityTemplate.description }</p></td>
                    <tr>
                    <tr>
                        <th width="10%">模板文件路径</th>
                        <td>${acActivityTemplate.dirPath }</td>
                        <th width="10%">启用状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(acActivityTemplate.activeFlag, 'yes_no', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">创建人</th>
                        <td>${fns:getUserById(acActivityTemplate.createBy.id).name }</td>
                        <th width="10%">创建时间</th>
                        <td><fmt:formatDate value="${acActivityTemplate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">更新人</th>
                        <td>${fns:getUserById(acActivityTemplate.updateBy.id).name }</td>
                        <th width="10%">更新时间</th>
                        <td><fmt:formatDate value="${acActivityTemplate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${acActivityTemplate.remarks}</p></td>
                    </tr>
                </table>
            </div>
        </section>
        <section class="invoice">
            <p class="lead">模板样式效果图</p>
            <div class="carousel slide " data-ride="carousel">
               <div class="carousel-inner">
                   <img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(acActivityTemplate.photo, '|', '')}" data-src="${imgHost }${fn:replace(acActivityTemplate.photo, '|', '')}"  class="img-responsive">
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