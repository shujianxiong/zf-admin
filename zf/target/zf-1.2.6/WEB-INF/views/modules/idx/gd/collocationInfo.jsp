<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搭配管理</title>
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
                        <th width="10%">所属场景</th>
                        <td>${collocation.scene.name }</td>
                        <th width="10%">色系</th>
                        <td><span class="label label-primary">${fns:getDictLabel(collocation.colourSystem, 'idx_gd_collocation_colourSystem','' )}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">搭配名称</th>
                        <td style="width: 40%;">${collocation.name }</td>
                        <th width="10%">搭配英文名称</th>
                        <td>${collocation.englishName }</td>
                    </tr>
                    <tr>
                        <th width="10%">是否启用</th>
                        <td><span class="label label-primary">${fns:getDictLabel(collocation.usableFlag, 'yes_no', '')}</span></td>
                        <th width="10%">默认推荐</th>
                        <td><span class="label label-primary">${fns:getDictLabel(collocation.recommendFlag, 'yes_no', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">排列序号</th>
                        <td>${collocation.orderNo }</td>
                        <th width="10%">更新时间</th>
                        <td><fmt:formatDate value="${collocation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    </tr>
                    <tr>
                        <th width="10%">搭配描述</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${collocation.description}</p></td>
                    </tr>
                    <tr>
                        <th width="10%">搜索关键词</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${collocation.searchKey}</p></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${collocation.remarks}</p></td>
                    </tr>
                    <tr>
                        <th width="10%">搭配详情图</th>
                        <td colspan="3"><img onerror="imgOnerror(this);"  src="${imgHost }${collocation.photo}" data-src="${imgHost }${collocation.photo}"  width="200" height="200"></td>
                    </tr>
                    <tr>
                    	<th>分享标题</th>
                    	<td>${collocation.shareTitle }</td>
                    	<th>分享描述</th>
                    	<td>${collocation.shareDescribe }</td>
                    </tr>
                    <tr>
                        <th width="10%">分享图片</th>
                        <td colspan="3"><img onerror="imgOnerror(this);"  src="${imgHost }${collocation.sharePhoto}" data-src="${imgHost }${collocation.sharePhoto}"  width="200" height="200"></td>
                    </tr>
                    <%-- <tr>
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
                    </tr> --%>
                    
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