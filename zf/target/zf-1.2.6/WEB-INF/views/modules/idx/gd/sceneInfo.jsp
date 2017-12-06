<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>场景管理</title>
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
                        <th width="10%">场景名称</th>
                        <td>${scene.name }</td>
                        <th width="10%">父场景名称</th>
                        <td>${scene.scene.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">场景英文名称</th>
                        <td>${scene.englishName }</td>
                    </tr>
                    <tr>
                        <th width="10%">首页推荐</th>
                        <td><span class="label label-primary">${fns:getDictLabel(scene.indexFlag, 'yes_no', '')}</span></td>
                        <th width="10%">是否启用</th>
                        <td><span class="label label-primary">${fns:getDictLabel(scene.usableFlag, 'yes_no', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">排列序号</th>
                        <td>${scene.orderNo}</td>
                        <th width="10%">更新时间</th>
                        <td><fmt:formatDate value="${scene.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    </tr>
                    <tr>
                        <th width="10%">场景描述</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${scene.description}</p></td>
                    </tr>
                    <tr>
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${scene.remarks}</p></td>
                    </tr>
                    <tr>
                        <th width="10%">展示图</th>
                        <td colspan="3"><img onerror="imgOnerror(this);"  src="${imgHost }${scene.dpPhoto}" data-src="${imgHost }${scene.dpPhoto}"  width="200" height="200"></td>
                    </tr>
                    <tr>
                        <th width="10%">头部图</th>
                        <td colspan="3"><img onerror="imgOnerror(this);"  src="${imgHost }${scene.topPhoto}" data-src="${imgHost }${scene.topPhoto}"  width="200" height="200"></td>
                    </tr>
                    <tr>
                        <th width="10%">搜索图</th>
                        <td colspan="3"><img onerror="imgOnerror(this);"  src="${imgHost }${scene.searchIcon}" data-src="${imgHost }${scene.searchIcon}"  width="200" height="200"></td>
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