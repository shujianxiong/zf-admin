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
    <script type="text/javascript">
        $(document).ready(function() {
            
        });
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
        <h1>
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/gd/scene/selectSceneList">场景列表</a></small>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border zf-query">
                <h5>查询条件</h5>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool"data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button type="button" class="btn btn-box-tool"data-widget="remove"><i class="fa fa-remove"></i></button>
                </div>
            </div>
            
            <form:form id="searchForm" modelAttribute="scene" action="${ctx}/idx/gd/scene/selectSceneList" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">场景名称</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="name" id="name" isMandatory="false" verifyType="0" isSpring="true" tip="请输入名称查询"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="indexFlag" class="col-sm-3 control-label">首页推荐</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="indexFlag" tip="" verifyType="0" isMandatory="false" dictName="yes_no" id="indexFlag"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-right box-tools">
                        <button type="button" class="btn btn-default btn-sm" onclick="ZF.resetForm()"><i class="fa fa-refresh"></i>重置</button>
                        <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-search"></i>查询</button>
                    </div>
                </div>
            </form:form>
        </div>
    
        <div class="box box-soild">
            <div class="box-body">
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
								<th><input type="checkbox" id="allcheck"/>全选</th>
                                <th>场景名称</th>
                                <th>场景英文名称</th>
                                <th>展示图</th>
                                <th>头部图</th>
                                <th>分类图标（选中/未选中）</th>
                                <th>首页推荐</th>
                                <th>是否启用</th>
                                <th>排列序号</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="scene" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>
                                    	<div class="zf-check-wrapper-padding">
											<input type="checkBox" data-name name="selectName" value="${scene.id}"/>
										</div>
                                    </td>
                                    <td>
                                        ${scene.name}
                                    </td>
                                    <td>
                                        ${scene.englishName}
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${scene.dpPhoto}" data-big data-src="${imgHost }${scene.dpPhoto}" width="20px" height="20px" />
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${scene.topPhoto}" data-big data-src="${imgHost }${scene.topPhoto}" width="20px" height="20px" />
                                    </td>
                                    <td>
                                        <img onerror="imgOnerror(this);" src="${imgHost }${scene.listIconChoose}" data-big data-src="${imgHost }${scene.listIconChoose}" width="20px" height="20px" />
                                        <img onerror="imgOnerror(this);" src="${imgHost }${scene.listIconUnchoose}" data-big data-src="${imgHost }${scene.listIconUnchoose}" width="20px" height="20px" />
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${scene.indexFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(scene.indexFlag, 'yes_no', '')}</span>
                                            </c:when>
                                            <c:when test="${scene.indexFlag eq '0' }">
                                                 <span class="label label-primary">${fns:getDictLabel(scene.indexFlag, 'yes_no', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${scene.usableFlag eq '1' }">
                                                <span class="label label-success">${fns:getDictLabel(scene.usableFlag, 'yes_no', '')}</span>
                                            </c:when>
                                            <c:when test="${scene.usableFlag eq '0' }">
                                                 <span class="label label-primary">${fns:getDictLabel(scene.usableFlag, 'yes_no', '')}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        ${scene.orderNo}
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box-footer">
                <div class="dataTables_paginate paging_simple_numbers">${page}</div>
            </div>
        </div>
     </section>
    </div>
    
    <script>
      $(function () {
        
        ZF.bigImg();
         
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
        
	  	$("#allcheck").on("ifChecked", function(){
	  		$("[data-name]").iCheck('check');
	  	}); 
	  	$("[data-name]").on("ifUnchecked", function(){
	  		$("#allcheck").iCheck('uncheck');
	  	});
	  	
        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : false,
            //"order": [[ 8, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:3},
                {"orderable":false,targets:4},
                {"orderable":false,targets:5},
                {"orderable":false,targets:6},
                {"orderable":false,targets:7}
            ],
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        });
        
//         var sceneIds = localStorage.getItem("pageNo"+$("#pageNo").val())==null||localStorage.getItem("pageNo"+$("#pageNo").val())==undefined?[]:localStorage.getItem("pageNo"+$("#pageNo").val()).split(',');
//   		var existSceneIds = memberIds;

  		
  		
// 	  	if(memberIds!=undefined&&memberIds.length >0){
// 	  		for(let i=0;i<memberIds.length;i++){
// 	  			$("[data-name]").each(function(){
// 					if($(this).val() == memberIds[i]){
// 						$(this).iCheck('check');
// 					}
// 				});
// 	  		}
// 	  	}
	  	
// 	  	$("#allcheck").on("ifChecked", function(){
// 	  		$("[data-name]").iCheck('check');
// 	  	});
	  	
// 	  	$("[data-name]").on("ifChecked",function(){
// 	  		memberIds = [];
// 			$("[data-name]").each(function(){
// 				if($(this).prop("checked")){
// 					memberIds.push($(this).val());
// 				}
// 			});
// 			if(memberIds.length > 0){
// 		  		localStorage.setItem('usercode', $(this).attr("data-name"));
// 		  		localStorage.setItem('pageNo'+$("#pageNo").val(), memberIds);
// // 		  		map.set('pageNo'+$("#pageNo").val(), memberIds);
// 		  		map['pageNo'+$("#pageNo").val()] = memberIds;
// 		  		let str = JSON.stringify(map);
// 		  		localStorage.setItem('memberMap', str);
// 			}
// 	  	});
	  	
// 	  	$("[data-name]").on("ifUnchecked",function(){
// 	  		$("#allcheck").iCheck('uncheck');
// 	  		memberIds = [];
// 	  		if(usercode == $(this).attr("data-name")){
// 	  			usercode = null;
// 	  		}
// 			$("[data-name]").each(function(){
// 				if(usercode == null ||usercode == undefined){
// 					usercode = $(this).attr("data-name");
// 				}
// 				if($(this).prop("checked")){
// 					memberIds.push($(this).val());
// 				}
// 			});
// 			if(memberIds.length > 0){
// 		  		localStorage.setItem('usercode', $(this).attr("data-name"));
// 		  		localStorage.setItem('pageNo'+$("#pageNo").val(), memberIds);
// // 		  		map.set('pageNo'+$("#pageNo").val(), memberIds);
// 		  		map['pageNo'+$("#pageNo").val()] = memberIds;
// 		  		let str = JSON.stringify(map);
// 		  		localStorage.setItem('memberMap', str);
// 			}else{
// 				localStorage.removeItem('usercode');
// 				localStorage.removeItem('pageNo'+$("#pageNo").val());
// 				//读取 
// 			    let str = localStorage.getItem('memberMap');
// 				map = JSON.parse(str);
// 				map['pageNo'+$("#pageNo").val()] = '';
// 				//重新保存
// 				str = JSON.stringify(map);
// 		  		localStorage.setItem('memberMap', str);
// 			}
// 	  	});
        
      });
      
   </script>
</body>
</html>