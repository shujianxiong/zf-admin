<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>微信素材库</title>
	<meta name="decorator" content="adminLte"/>
	<style type="text/css">
	.mediaIdBg{
		position: absolute;
		bottom:0;
		width:100%;
		height:40px;
		background:rgba(0,0,0,0.3);
		color:#fff;
		font-size:12px;
		cursor:pointer;
	}
	
	.mediaId{
		cursor:pointer;
		float:left;
		line-height:40px;
		text-align:center;
		width:100%;
		box-sizing:border-box;
		border-right:1px solid #D2D1D1;
	}
	
	</style>
	<script type="text/javascript">


	var jsonData=${fns:toJson(jsonData)};
	var mediaType="${mediaType}";
    function getLocalTime(nS) {
        return new Date(parseInt(nS) * 1000).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
    }

    function init(){
		jsonData=$.parseJSON(jsonData)
		var pageSize=$("#pageSize").val();
		var body=$("#bodyUl");
		var html="";
		for(var i=0;i<jsonData.item.length;i++){
		    if(mediaType == "news"){
                var url="";
                var mediaId=jsonData.item[i].media_id;
                var name="";
                var time=getLocalTime(jsonData.item[i].update_time);
                html="<tr><td>"+mediaId+"</td><td>"+name+"</td><td>"+time+"</td><td>"+url+"</td>";
                html=html+"<td>\n" +
                    "<div class=\"btn-group zf-tableButton\">\n" +
                    "<button type=\"button\" class=\"btn btn-sm btn-info\" onclick=\"window.location.href='${ctx}/re/mp/resources/toUpdateArticle?mediaId="+mediaId+"'\">修改</button>\n" +
                    "<button type=\"button\" class=\"btn btn-sm btn-info dropdown-toggle\" data-toggle=\"dropdown\">\n" +
                    "<span class=\"caret\"></span>\n" +
                    "</button>" +
					"<ul class=\"dropdown-menu btn-info zf-dropdown-width\" role=\"menu\">\n" +
                    "<li><a href=\"#this\" data-href=\"${ctx}/re/mp/resources/delArticle?mediaId="+mediaId+"\" data-message=\"确定要删除该回复消息吗？\" data-json=\"{'id':'${autoReply.id }'}\" onclick=\"return ZF.xconfirm(this);\">删除</a></li>\n" +
                    "</ul></div>\n" +
                    "</td></tr>"
                body.append(html);
			}else{
                var url=jsonData.item[i].url.replace("qpic","qlogo")
                url = "http://read.html5.qq.com/image?imageUrl=" + jsonData.item[i].url;
                var mediaId=jsonData.item[i].media_id;
                var name=jsonData.item[i].name;
                var time=getLocalTime(jsonData.item[i].update_time);
                html="<tr><td>"+mediaId+"</td><td>"+name+"</td><td>"+time+"</td><td>"+url+"</td></tr>";
                body.append(html);
			}
			/*if(type=="video"){
				html=mediaTemp.replace("$id",jsonData.item[i].media_id).replace("$name",jsonData.item[i].name);
				ul.append(html);
			}
			if(type=="voice"){
				html=mediaTemp.replace("$id",jsonData.item[i].media_id).replace("$name",jsonData.item[i].name);
				ul.append(html);
			}*/
		}
		
		console.log(jsonData);
		var maxPage=parseInt(jsonData.total_count)/parseInt(pageSize);
		maxPage=maxPage>parseInt(maxPage)?parseInt(maxPage)+1:parseInt(maxPage);
		
		var pageNo=parseInt($("#pageNo").val())+1;
		$("#pageCount").text("总计："+jsonData.total_count+"条数据")
		$("#pageNow").text("当前第："+pageNo+"/"+maxPage+"页")
		return maxPage;
	}
	
	
	
	</script>
</head>
<body>
	<div class="content-wrapper sub-content-wrapper">
		<section class="content-header content-header-menu">
			<h1>
				<small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/re/mp/resources">素材列表</a></small>
				<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/form">文件上传</a></small>
				<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/toAddMedia">图文素材新增</a></small>
				<small>|</small><small><i class="fa-form-edit"></i><a href="${ctx}/re/mp/resources/toMesUp">图文消息内的图片上传</a></small>
			</h1>
	    </section>
	    
	    <sys:tip content="${message}"/>
	    <section class="content">
			<form:form id="searchForm" action="${ctx}/re/mp/resources" method="post" class="form-horizontal">
			<input id="pageNo" name="pageNo" type="hidden" value="${pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${pageSize}"/>
			<div class="box box-info">
				<div class="box-header with-border zf-query">
					<h5>查询条件</h5>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
						<button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
					</div>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label for="searchParam" class="col-sm-3 control-label" >素材类型</label>
								<div class="col-sm-7">
									<select name="mediaType">
										<option value="image" <c:if test="${'image' eq mediaType }">selected</c:if> >图片</option>
										<option value="video" <c:if test="${'video' eq mediaType }">selected</c:if>>视频</option>
										<option value="voice" <c:if test="${'voice' eq mediaType }">selected</c:if>>音频</option>
										<option value="news" <c:if test="${'news' eq mediaType }">selected</c:if>>图文</option>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
		        	<div class="pull-right box-tools">
        		 		<button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm();"><i class="fa fa-refresh"></i>重置</button>
	               		<button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
		        	</div>
	            </div>
			</div>
			</form:form>
			
			<div class="box box-soild">
				<div class="box-herder with-border">
					
				</div>
				<div class="box-body">
					<div class="table-responsive">
						<table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
							<thead>
							<tr>
								<th>mediaId</th>
								<th>文件名称</th>
								<th style="width: 200px">上传时间</th>
								<th>地址</th>
							</tr>
							</thead>
							<tbody id="bodyUl">
							</tbody>
						</table>
					</div>
				</div>
				<div class="box-footer">
		        	 <ul class="pagination pagination-sm no-margin pull-right">
		        	 	<li><a href="#" id="indexPage">回到首页</a></li>
		                <li><a href="#" id="beforePage">上一页</a></li>
		                <li><a href="#" id="pageNow">当前第：${pageNo+1 }页</a></li>
		                <li><a href="#" id="nextPage">下一页</a></li>
		                <li><a href="#" id="pageCount">总计：0条数据</a></li>
		             </ul>
		        </div>
			</div>
	    </section>
	    
	</div>
	
	<script type="text/javascript">
		
		$(function(){
			var maxPage=init();
			
			$("#beforePage").on("click",function(){
				var pageNo=parseInt($("#pageNo").val());
				if(pageNo==0){
					ZF.showTip("已经是第一页了","info")
					return;
				}
				pageNo=pageNo-1;
				$("#pageNo").val(pageNo)
				$("#searchForm").submit();
			})
			
			$("#nextPage").on("click",function(){
				var pageNo=parseInt($("#pageNo").val());
				pageNo=pageNo+1;
				if(pageNo>=maxPage){
					ZF.showTip("已经是最后一页了","info")
					return;
				}
				$("#pageNo").val(pageNo)
				$("#searchForm").submit();
			})
			
			$("#indexPage").on("click",function(){
				var pageNo=0;
				$("#pageNo").val(pageNo)
				$("#searchForm").submit();
			})
			
		})
	</script>
</body>
</html>