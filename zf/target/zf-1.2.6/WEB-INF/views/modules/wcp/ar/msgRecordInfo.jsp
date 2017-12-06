<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公众号聊天记录详情</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
	    <section class="content">
            <div class="row">
            	<div class="col-md-6">
		            <div class="box box-primary">
			            <div class="box-header with-border zf-query">
			              <h5>公众号聊天记录详情</h5>
			              <div class="box-tools">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			              </div>
			            </div>
			            <!-- /.box-header -->
		            	<div class="box-body">
		            			
		            		<strong>消息发送平台</strong>
							<p>
								<span class="label label-primary">${fns:getDictLabel(msgRecord.platformType, 'wcp_ar_msg_record_platformType', '') }</span>
							</p>
							<hr class="zf-hr">
							<strong>发送类型</strong>
							<p>
								<span class="label label-primary">${fns:getDictLabel(msgRecord.sendType, 'wcp_ar_msg_record_sendType', '') }</span>
							</p>
							<hr class="zf-hr">
							<strong>回复类型</strong>
							<p>
								<span class="label label-primary">${fns:getDictLabel(msgRecord.replyType, 'wcp_ar_msg_record_replyType', '') }</span>
							</p>
							<hr class="zf-hr">
							
							<strong>发送人周范账号</strong>
							<p class="text-primary">
								<c:choose>
									<c:when test="${msgRecord.sendType eq 'SEND' }">
										${fns:getMemberById(msgRecord.fromUserId).usercode }
									</c:when>
									<c:otherwise>
										周范公众号
									</c:otherwise>
								</c:choose>
							</p>
							<hr class="zf-hr">
							
							<strong>接收人周范账号</strong>
							<p class="text-primary">
								<c:choose>
									<c:when test="${msgRecord.sendType eq 'REPLY' }">
										${fns:getMemberById(msgRecord.toUserId).usercode }
									</c:when>
									<c:otherwise>
										周范公众号
									</c:otherwise>
								</c:choose>
								
							</p>
							<hr class="zf-hr">
							
							<strong>内容类型</strong>
							<p><span class="label label-primary">${fns:getDictLabel(msgRecord.contentType, 'wcp_ar_auto_reply_contentType', '') }</span></p>
							<hr class="zf-hr">
							
							<strong>内容</strong>
							<p class="text-primary">${msgRecord.content }</p>
							<hr class="zf-hr">
							
							<strong>自动回复名称</strong>
							<p class="text-primary">${msgRecord.autoReply.name }</p>
							<hr class="zf-hr">
							
							<strong>创建者</strong>
							<p class="text-primary">${fns:getUserById(msgRecord.createBy.id).name}</p>
							<hr class="zf-hr">
							
							<strong>创建时间</strong>
							<p class="text-primary"><fmt:formatDate value="${msgRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
							<hr class="zf-hr">
							
							<strong>更新者</strong>
							<p class="text-primary">${fns:getUserById(msgRecord.updateBy.id).name}</p>
							<hr class="zf-hr">
							
							<strong>更新时间</strong>
							<p class="text-primary"><fmt:formatDate value="${msgRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
							<hr class="zf-hr">
							
							<strong>备注信息</strong>
							<p class="text-primary">${msgRecord.remarks }</p>
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
	 </div>
</body>
</html>