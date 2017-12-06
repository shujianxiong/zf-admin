<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>注册邀请码管理</title>
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
            <small class="menu-active"><i class="fa fa-repeat"></i><a href="${ctx}/idx/rg/rgInviteCode/">注册邀请码列表</a></small>
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
            
            <form:form id="searchForm" modelAttribute="rgInviteCode" action="${ctx}/idx/rg/rgInviteCode/" method="post" class="form-horizontal">
                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">邀请码</label>
                                <div class="col-sm-7">  
                                    <sys:inputverify name="inviteCode" id="inviteCode" verifyType="0" tip="请输入邀请码" isMandatory="false" isSpring="true"></sys:inputverify>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="name" class="col-sm-3 control-label">使用状态</label>
                                <div class="col-sm-7">  
                                    <sys:selectverify name="useFlag" tip="" isMandatory="false" verifyType="0" dictName="idx_rg_invite_code_useFlag" id="useFlag"></sys:selectverify>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="beginTimeTemp" class="col-sm-3 control-label">创建开始时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="beginTimeTemp" inputName="beginTimeTemp" tip="请选择创建开始时间" isMandatory="false" value="${rgInviteCode.beginTimeTemp }" inputId="beginTimeTempId"></sys:datetime>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div  class="form-group">
                                <label for="endTimeTemp" class="col-sm-3 control-label">创建截止时间</label>
                                <div class="col-sm-7">  
                                    <sys:datetime id="endTimeTemp" inputName="endTimeTemp" tip="请选择创建截止时间" isMandatory="false" value="${rgInviteCode.endTimeTemp }" inputId="endTimeTempId"></sys:datetime>
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
                <div class="row">
                    <div class="col-sm-12 pull-right">
                        <shiro:hasPermission name="idx:rg:rgInviteCode:edit">
                            <button type="button" class="btn btn-sm btn-dropbox" onclick="generate(${empty config ? 1 : 0 });"><i class="glyphicon glyphicon-link">批量生成</i></button>
                        </shiro:hasPermission>
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="contentTable" class="table table-bordered table-hover table-striped zf-tbody-font-size">
                        <thead>
                            <tr>
                                <th>邀请码</th>
                                <th>使用标记</th>
                                <th>使用会员</th>
                                <th>使用时间</th>
                                <th>创建人</th>
                                <th>创建时间</th>
                                <th>更新时间</th>
                                <th>备注信息</th>
                                <shiro:hasPermission name="idx:rg:rgInviteCode:edit"><th>操作</th></shiro:hasPermission>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${page.list}" var="rgInviteCode" varStatus="status">
                                <tr data-index="${status.index }">
                                    <td>${rgInviteCode.inviteCode }</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${rgInviteCode.useFlag eq '0'}">
                                                <span class="label label-primary">${fns:getDictLabel(rgInviteCode.useFlag, 'idx_rg_invite_code_useFlag','') }</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="label label-success">${fns:getDictLabel(rgInviteCode.useFlag, 'idx_rg_invite_code_useFlag','') }</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${fns:getMemberById(rgInviteCode.useMember.id).usercode }</td>
                                    <td><fmt:formatDate value="${rgInviteCode.useTime}"
                                            pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td>${fns:getUserById(rgInviteCode.createBy.id).name }</td>
                                    <td><fmt:formatDate value="${rgInviteCode.createDate}"
                                            pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td><fmt:formatDate value="${rgInviteCode.updateDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td title="${rgInviteCode.remarks }">${fns:abbr(rgInviteCode.remarks, 20)}</td>
									<shiro:hasPermission name="idx:rg:rgInviteCode:edit"><td>
                                       <div class="btn-group zf-tableButton">
                                           <button type="button" class="btn btn-sm btn-info"
                                               onclick="window.location.href='${ctx}/idx/rg/rgInviteCode/info?id=${rgInviteCode.id}'">详情</button>
                                           <button type="button"
                                               class="btn btn-sm btn-info dropdown-toggle"
                                               data-toggle="dropdown">
                                               <span class="caret"></span>
                                           </button>
                                       </div>
                                    </td></shiro:hasPermission>
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
        
         <div style="display: none;">
            <form id="geneForm" action="${ctx}/idx/rg/rgInviteCode/generateInviteCode" method="post">
                <input id="num" name="num" type="hidden"/>
                <textarea id="icRemarks" name="remarks" rows="3" cols="4"></textarea>
            </form>
        </div>
        
     </section>
     
      <div id="geneteModal" class="modal fade" data-backdrop="false" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="确认优惠券数量" aria-hidden="true">
       <div class="modal-dialog" style="width:30%;height:45%;" >
          <div class="modal-content" style="width:100%;height:100%;">
             <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认邀请码生成数量</h4>
             </div>
             <div class="modal-body">
                <div>
                  <label for="geneNum">数量</label>
                  <input type="text" class="form-control" maxlength="4" name="geneNum" id="geneNum" max="1000" placeholder="请输入要生成的邀请码数量,单次最大生成数为1000"/>
                </div>
                <div>
                  <label for="remarks">备注</label>
                  <textarea id="geneRemarks" name="remarks" maxlength="200" rows="3" cols="4" class="form-control"></textarea>
                </div>
             </div>
             <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="commitBtn">提交生成</button>
             </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
     
    </div>
    
    <script>
      $(function () {
        
        ZF.bigImg();
         
        $('input').iCheck({
            checkboxClass : 'icheckbox_minimal-blue',
            radioClass : 'iradio_minimal-blue'
        });
          
        //表格初始化
        ZF.parseTable("#contentTable", {
            "paging" : false,
            "lengthChange" : false,
            "searching" : false,
            "ordering" : true,
            "order": [[ 6, "desc" ]],//指定默认初始化按第几列排序，默认排序升序，降序
            "columnDefs":[
                {"orderable":false,targets:0},
                {"orderable":false,targets:1},
                {"orderable":false,targets:2},
                {"orderable":false,targets:4},
                {"orderable":false,targets:7},
                {"orderable":false,targets:8}
                
            ],
            "info" : false,
            "autoWidth" : false,
            "multiline" : true,//是否开启多行表格
            "isRowSelect" : true,//是否开启行选中
            "rowSelect" : function(tr) {
                
            },
            "rowSelectCancel" : function(tr) {
                
            }
        })
        
        $("#geneNum").on("change", function() {
            var val = $(this).val();
            if(!ZF.formVerify(true, 4, val)) {
                $(this).addClass("zf-input-err")
                if($("#geneNumErr").length<=0)
                    $(this).after("<label id=\"geneNumErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请核查填写的邀请码数量值</label>")
                $(this).attr("data-verify","false");
            }else{
                if($("#geneNumErr").length>0){
                    $(this).removeClass("zf-input-err");
                    $("#geneNumErr").remove();
                }
                $(this).attr("data-verify","true");
            }
        });
        
        $("#geneteModal #commitBtn").on("click",function () {
            
            var val = $("#geneNum").val();
            if(!ZF.formVerify(true, 4, val)) {
                $("#geneNum").addClass("zf-input-err")
                if($("#geneNumErr").length<=0)
                    $("#geneNum").after("<label id=\"geneNumErr\" class=\"control-label zf-label-err\"><i class=\"fa fa-times-circle-o\"></i>请核查填写的邀请码数量值</label>")
                $("#geneNum").attr("data-verify","false");
            }else{
                if($("#geneNumErr").length>0){
                    $("#geneNum").removeClass("zf-input-err");
                    $("#geneNumErr").remove();
                }
                $(this).attr("data-verify","true");
                $("#num").val(val);
                $("#icRemarks").text($("#geneRemarks").val());
                $("#geneteModal").modal("hide");    
                $("#geneForm").submit();
            }
        });
        
      });
      
      function generate(isForbidden) {
    	  if(isForbidden == 0) {
    		  ZF.showTip("目前邀请码注册活动已经结束，不能再生成邀请码!","info");
    		  return;
    	  } else {
    		  $("#geneteModal #geneNum").val("").removeClass("zf-input-err");
    		  $("#geneteModal #geneNumErr").remove();
    		  $("#geneteModal #geneRemarks").val("");
	          $("#geneteModal").modal('toggle');
    	  }
      }
      
      
   </script>
</body>
</html>