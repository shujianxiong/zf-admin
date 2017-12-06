<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>品牌信息</title>
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
                        <th width="10%">品牌LOGO</th>
                        <td><img onerror="imgOnerror(this);"  src="${imgHost }${brand.logo}" data-src="${imgHost }${brand.logo}"  width="200" height="200"></td>
                    </tr>
                    <tr>
                        <th width="10%">品牌头部图</th>
                        <td><img onerror="imgOnerror(this);"  src="${imgHost }${brand.topPhoto}" data-src="${imgHost }${brand.topPhoto}"  width="200" height="200"></td>
                    </tr>
                    <tr>
                        <th width="10%">品牌名称</th>
                        <td>${brand.name}</td>
                    </tr>
                    <tr>
                        <th width="10%">品牌公司名称</th>
                        <td>${brand.companyName}</td>
                    </tr>
                    <tr>
                        <th width="10%">品牌类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(brand.type, 'lgt_bs_brand_type', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">品牌状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(brand.brandStatus, 'brand_status', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">品牌简介</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${brand.introduction}</p></td>
                    </tr>
                    <tr>
	                    <th width="10%">创建人</th>
	                    <td width="40%">${fns:getUserById(brand.createBy.id).name}</td>
	                    <th width="10%">创建时间</th>
	                    <td><fmt:formatDate value="${brand.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                </tr>
	                <tr>
	                    <th width="10%">更新人</th>
	                    <td width="40%">${fns:getUserById(brand.updateBy.id).name}</td>
	                    <th width="10%">更新时间</th>
	                    <td><fmt:formatDate value="${brand.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                </tr>
	                <tr>
	                    <th width="10%">备注</th>
	                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${brand.remarks}</p></td>
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