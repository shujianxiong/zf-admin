<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>邀请注册模板管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">

    <section class="content-header content-header-menu">
            
    </section>
    
    <section class="invoice">
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">模板名称</th>
                    <td>${registerShareTemp.name}</td>
                    <th width="10%">使用状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(registerShareTemp.tempStatus, 'spm_sr_tempStatus', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">奖励类型</th>
                    <td><span class="label label-primary">${fns:getDictLabel(registerShareTemp.rewardType, 'spm_sr_register_rewardType', '')}</span></td>
                    <th width="10%">奖励金额</th>
                    <td>${registerShareTemp.rewardAmount}</td>
                </tr>
                <tr>
                    <th width="10%">启用时间</th>
                    <td><fmt:formatDate value="${registerShareTemp.activeStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <th width="10%">有效时间（天）</th>
                    <td> ${registerShareTemp.activeDays}</td>
                </tr>
                <tr>
                    <th width="10%">分享URL</th>
                    <td>${registerShareTemp.shareUrl}</td>
                    <th width="10%">分享背景色</th>
                    <td>${registerShareTemp.shareColor}</td>
                </tr>
                <tr>
                    <th width="10%">分享标题</th>
                    <td colspan="3">${registerShareTemp.shareTitle}</td>
                </tr>
                <tr>    
                    <th width="10%">分享简介</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${registerShareTemp.shareSummary}</p></td>
                </tr>
                <tr>
                    <th width="10%">分享ICON</th>
                    <td><img onerror="imgOnerror(this);"  class="img-responsive" src="${imgHost }${registerShareTemp.shareIcon}"/></td>
                </tr>
                <tr>    
                    <th width="10%">分享广告图</th>
                    <td> <img onerror="imgOnerror(this);"  class="img-responsive"  src="${imgHost }${registerShareTemp.sharePhoto}"/></td>
                </tr>
                <tr>
                    <th width="10%">规则说明</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${registerShareTemp.ruleExplain}</p></td>
                </tr>
                <tr>
                    <th width="10%">活动说明</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${registerShareTemp.activeExplain}</p></td>
                </tr>
                <tr>
                    <th width="10%">创建人</th>
                    <td>${fns:getUserById(registerShareTemp.createBy.id).name}</td>
                    <th width="10%">创建时间</th>
                    <td><fmt:formatDate value="${registerShareTemp.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th width="10%">更新人</th>
                    <td>${fns:getUserById(registerShareTemp.updateBy.id).name}</td>
                    <th width="10%">更新时间</th>
                    <td><fmt:formatDate value="${registerShareTemp.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${property.remarks }</p></td>
                </tr>
            </table>
        </div>
        <div class="box-footer">
            <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                <i class="fa fa-mail-reply"></i>返回
            </button>
        </div>
    </section>
</div>
</body>
</html>