<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>广告详情</title>
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
                        <th width="10%">广告名称</th>
                        <td>${advertisement.name}</td>
                    </tr>
                    <tr>
                        <th width="10%">广告类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(advertisement.type, 'idx_pd_advertisement_type', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">展示区域</th>
                        <td><span class="label label-primary">${fns:getDictLabel(advertisement.displayArea, 'idx_pd_advertisement_displayArea', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">背景图</th>
                        <td><img onerror="imgOnerror(this);" class="img-responsive"  src="${imgHost }${fn:replace(advertisement.dpPhoto, '|', '')}" /></td>
                    </tr>
                    <tr>
                        <th width="10%">链接地址</th>
                        <td>${advertisement.url}</td>
                    </tr>
                    <tr>
                        <th width="10%">排列序号</th>
                        <td>${advertisement.orderNo}</td>
                    </tr>
                    <tr>
                        <th width="10%">是否启用</th>
                        <td><span class="label label-primary">${fns:getDictLabel(advertisement.usableFlag, 'yes_no', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td><p class="text-muted well well-sm no-shadow">${advertisement.remarks }</p></td>
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