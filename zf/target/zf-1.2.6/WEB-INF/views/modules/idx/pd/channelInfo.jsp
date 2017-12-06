<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>频道详情</title>
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
                        <th width="10%">频道名称</th>
                        <td>${channel.name}</td>
                    </tr>
                    <tr>
                        <th width="10%">频道类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(channel.type, 'idx_pd_channel_type', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">展示区域</th>
                        <td><span class="label label-primary">${fns:getDictLabel(channel.displayArea, 'idx_pd_channel_displayArea', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%"><span data-toggle='tooltip' data-placement='top'>图标</span></th>
                        <td><img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(channel.icon, '|', '')}" data-big data-src="${imgHost }${channel.icon}"/></td>
                    </tr>
                    <tr>
                        <th width="10%"><span data-toggle='tooltip' data-placement='top'>背景图</span></th>
                        <td><img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(channel.bgPhoto, '|', '')}" data-big data-src="${imgHost }${channel.bgPhoto}"/></td>
                    </tr>
                    <tr>
                    	<th width="10%">关联场景</th>
                        <td>${channel.scene.name}</td>
                    </tr>
                    <tr>    
                        <th width="10%">链接地址</th>
                        <td>${channel.url}</td>
                    </tr>
                    <tr>
                        <th width="10%">排序序号</th>
                        <td>${channel.orderNo}</td>
                    </tr>
                    <tr>
                        <th width="10%">是否启用</th>
                        <td><span class="label label-primary">${fns:getDictLabel(channel.usableFlag, 'yes_no', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td><p class="text-muted well well-sm no-shadow">${channel.remarks }</p></td>
                    </tr>
                </table>
            </div>
            <hr>
            <p style="font-weight: bolder;">关联场景列表</p>
            <div class="table-responsive">
				<table class="table table-bordered table-hover table-striped zf-tbody-font-size">
					<thead>
						<tr>
							<th>场景名称</th>
							<th>排列序号</th>
							<th>启用状态</th>
							<th width="10">&nbsp;</th>
						</tr>
					</thead>
					<tbody id="tBody">
							<c:forEach items="${channel.channelSceneList }" var="channelScene">
							<tr>
								<td>
									${channelScene.scene.name }
								</td>
								<td>
									${channelScene.orderNo }
								</td>
								<td>
									${fns:getDictLabel(channelScene.usableFlag, 'yes_no', '') }	
								</td>
							</tr>
						</c:forEach>
					</tbody>
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