<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>设计师信息</title>
	<meta name="decorator" content="adminLte"/>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function() {
            
            editor = CKEDITOR.replace('designerContent');
             
        });
     </script>
</head>
<body>
 	<div class="content-wrapper sub-content-wrapper">
        
	    <section class="content-header content-header-menu">
	                
	    </section>
	    
	    <section class="invoice">
	        <div class="table-responsive">
	            <table class="table">
	                <tr>
	                    <th width="10%">姓名</th>
	                    <td>${designer.name}</td>
	                    <th width="10%">性别</th>
	                    <td><span class="label label-primary">${fns:getDictLabel(designer.sex, 'sex', '')}</span></td>
	                </tr>
	                <tr>
	                    <th width="10%">年龄</th>
	                    <td>${designer.age}</td>
	                    
	                    <th width="10%">国籍</th>
                        <td><span class="label label-primary">${fns:getDictLabel(designer.country, 'country', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">设计风格</th>
                        <td><span class="label label-primary">${fns:getDictLabel(designer.designStyle, 'lgt_bs_designer_designStyle', '')}</span></td>
                        
                        <th width="10%">标签</th>
                        <td>${designer.tags}</td>
                    </tr>
                    <tr>
                        <th width="10%">头像</th>
                        <td colspan="3"><img onerror="imgOnerror(this);"  src="${imgHost }${fn:replace(designer.gravatar, '|', '')}"
                                        data-src="${imgHost }${designer.gravatar}" class="img-responsive"></td>
                    </tr>
                    <tr>
                        <th width="10%">列表图</th>
                        <td colspan="3"><img onerror="imgOnerror(this);" class="img-responsive"  src="${imgHost }${fn:replace(designer.listPhoto, '|', '')}" data-src="${imgHost }${designer.listPhoto}" ></td>
                    </tr>
                    <tr>
                        <th width="10%">形象图</th>
                        <td colspan="3"><img onerror="imgOnerror(this);" class="img-responsive" src="${imgHost }${fn:replace(designer.headPhoto, '|', '')}" data-src="${imgHost }${designer.headPhoto}" /></td>
	                </tr>
                    <tr>
	                    <th width="10%">简介</th>
                        <td colspan="3">${designer.summary}</td>
                    </tr>
                    <tr>
                        <th width="10%">详情</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow"><textarea name="designerContent">${designer.detail}</textarea></p></td>
                    </tr>
                    <tr>
                        <th width="10%">是否启用</th>
                        <td><span class="label label-primary">${fns:getDictLabel(designer.usableFlag, 'yes_no', '')}</span></td>
	                    
	                    <th width="10%">是否推荐</th>
                        <td><span class="label label-primary">${fns:getDictLabel(designer.recommendFlag, 'yes_no', '')}</span></td>
	                </tr>
	                <tr>
	                    <th width="10%">创建人</th>
	                    <td width="40%">${fns:getUserById(designer.createBy.id).name}</td>
	                    <th width="10%">创建时间</th>
	                    <td><fmt:formatDate value="${designer.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                </tr>
	                <tr>
	                    <th width="10%">更新人</th>
	                    <td width="40%">${fns:getUserById(designer.updateBy.id).name}</td>
	                    <th width="10%">更新时间</th>
	                    <td><fmt:formatDate value="${designer.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                </tr>
	                <tr>
	                    <th width="10%">备注</th>
	                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${designer.remarks}</p></td>
	                </tr>
	            </table>
	        </div>
	        <div class="row no-print">
	            <div class="col-xs-12">
	                <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	            </div>
	        </div>
        </section>
	 </div>
</body>
</html>