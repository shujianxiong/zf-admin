<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自动回复详情</title>
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
                        <th width="10%">规则代码</th>
                        <td>${autoReply.code }</td>
                        <th width="10%">规则名称</th>
                        <td>${autoReply.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">关键字</th>
                        <td>${autoReply.keywords }</td>
                        <th width="10%">内容类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(autoReply.contentType, 'wcp_ar_auto_reply_contentType', '') }</span></td>
                    </tr>
                    <c:choose>
                        <c:when test="${autoReply.contentType eq 'text' }">
                           <tr>
                                <th width="10%">文本</th>
                                <td colspan="3">${autoReply.text }</td>
                           </tr>
                        </c:when>
                        <c:when test="${autoReply.contentType eq 'img' }">
                            <tr>
                                <th width="10%">图片素材编号</th>
                                <td colspan="3">${autoReply.image }</td>
                           </tr>
                        </c:when>
                        <c:when test="${autoReply.contentType eq 'voice' }">
                            <tr>
                                <th width="10%">音频媒体编号</th>
                                <td colspan="3"> ${autoReply.voice }</td>
                           </tr>
                        </c:when>
                        <c:when test="${autoReply.contentType eq 'video' }">
                            <tr>
                                <th width="10%">视频媒体编号</th>
                                <td colspan="3">${autoReply.video }</td>
                            </tr>
                        </c:when>
                        <c:when test="${autoReply.contentType eq 'news' }">
                            <tr>
                                <th width="10%">图文消息</th>
                                <td colspan="3">
	                                <c:forEach items="${autoReply.replyArticleList }" var="ra">
	                                    <a herf="${ra.articleMsg.linkUrl }">${ra.articleMsg.name }</a><br/>
	                                </c:forEach>
                                </td>
                            </tr>
                            <strong>图文消息</strong>
                        </c:when> 
                        <c:when test="${autoReply.contentType eq 'undefined' }">
                                                     
                        </c:when>
                    </c:choose>
                    <tr>
                        <th width="10%">所属公众号</th>
                        <td><span class="label label-primary">${fns:getDictLabel(autoReply.mp, 'mp_type', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">启用状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(autoReply.activeFlag, 'yes_no', '')}</span></td>
                        <th width="10%">排列序号</th>
                        <td>${autoReply.orderNo }</td>
                    </tr>
                    <tr>
                        <th width="10%">创建者</th>
                        <td>${fns:getUserById(autoReply.createBy.id).name}</td>
                        <th width="10%">创建时间</th>
                        <td><fmt:formatDate value="${autoReply.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">更新者</th>
                        <td>${fns:getUserById(autoReply.updateBy.id).name}</td>
                        <th width="10%">更新时间</th>
                        <td><fmt:formatDate value="${autoReply.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${autoReply.remarks }</p></td>
                    </tr>
                </table>
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