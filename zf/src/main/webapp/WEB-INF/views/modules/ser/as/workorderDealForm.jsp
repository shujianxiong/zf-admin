<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>售后工单处理管理</title>
    <meta name="decorator" content="adminLte"/>
    <script type="text/javascript">
        $(document).ready(function() {
            
            $('input').iCheck({
                checkboxClass : 'icheckbox_minimal-blue',
                radioClass : 'iradio_minimal-blue'
            });
            
            $("#nextButton").on("click", function() {
                selectUserinit({
                    "selectCallBack" : function(list) {
                        $("#nextUId").val(list[0].id);
                        $("#nextUName").val(list[0].text);
                    }
                })
            });
            
        });
    </script>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">
    <section class="content-header content-header-menu">
        <h1>
            <small><i class="fa-list-style"></i><a href="${ctx}/ser/as/workorder/myWaitDealList">我的待处理售后工单</a></small>
            <shiro:hasPermission name="ser:as:workorderDeal:edit">
	            <small>|</small>
                <small class="menu-active">
                    <i class="fa fa-repeat"></i><a href="${ctx}/ser/as/workorderDeal/form?id=${workorderDeal.id}">售后工单处理</a>
                </small>
            </shiro:hasPermission>
        </h1>
    </section>
    <sys:tip content="${message}"/>
    <section class="invoice">
            <p class="lead">售后工单信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">会员账号</th>
                        <td>${workorder.usercode}</td>
                        <th width="10%">工单编号</th>
                        <td>${workorder.workorderNo}</td>
                    </tr>
                    <tr>
                        <th width="10%">工单类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(workorder.workorderType, 'ser_as_workorder_workorderType', '') }</span></td>
                        <th width="10%">工单状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(workorder.status,'ser_as_workorder_status', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">订单类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(workorder.orderType,'bus_order_type', '')}</span></td>
                        <th width="10%">订单编号</th>
                        <td>${workorder.orderNo}</td>
                    </tr>
                    <tr>   
                        <th width="10%">相关图片</th>
                        <td colspan="3">
                            <c:forEach items="${fn:split(workorder.photosUrl, '|')}" var="dp">
                                <img onerror="imgOnerror(this);"  src="${imgHost }${dp}" class="img-responsive"/>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>    
                        <th width="10%">描述</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${workorder.description}</p></td>
                    </tr>
                    <tr>   
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${workorder.remarks }</p></td>
                    </tr>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">处理详情</p>
            <div class="table-responsive">
                 <c:forEach items="${workorder.workorderDealList }" var="d">
                     <table class="table">
                          <tr>
                              <th width="10%">处理时间</th>
                              <td colspan="3"><fmt:formatDate value="${d.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                          </tr>
                          <tr>
                              <th width="10%">处理人</th>
                              <td colspan="3">${fns:getUserById(d.appointedUser.id).name }</td>
                          </tr>
                          <tr>
                              <th width="10%">处理方式</th>
                              <td colspan="3"><span class="label label-primary">${fns:getDictLabel(d.requiredDealtype, 'ser_as_workorder_deal_RequiredDealtype', '')}</span></td>
                          </tr>
                          <tr>
                              <th width="10%">处理备注</th>
                              <td colspan="3">
                                  <p class="text-muted well well-sm no-shadow">${d.remarks}</p>
                              </td>
                          </tr>
                     </table>
                 </c:forEach>
            </div>
        </section>
       
        <section class="invoice">
	        <form:form id="inputForm" modelAttribute="workorderDeal" action="${ctx}/ser/as/workorderDeal/save" method="post" class="form-horizontal" onsubmit="return ZF.formSubmit();">
	            <div class="box box-success">
	                <div class="box-header with-border zf-query">
	                    <h5>请完善表单填写</h5>
	                    <div class="box-tools">
	                       <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
	                    </div>
	                </div>
	                <div class="box-body">
	                    <input type="hidden" name="id" id="id" value="${workorderDeal.id }"/>
	                    <input type="hidden" name="workorder.id" id="woid" value="${workorderDeal.workorder.id }"/>
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label">工单编号</label>
	                        <div class="col-sm-9">
	                            <input type="text" class="form-control" disabled="disabled"  id="workorder.workorderNo" name="workorder.workorderNo" value="${workorderDeal.workorder.workorderNo}"/>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label">被指派人</label>
	                        <div class="col-sm-9">
	                             <input type="hidden" id="userId" name="appointedUser.id" value="${workorderDeal.appointedUser.id }"/>
	                             <input type="text" name="appointedUser.name" disabled="disabled" id="userName" value="${fns:getUserById(workorderDeal.appointedUser.id).name }" placeholder="必填项" class="form-control"/>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label">要求完成时间</label>
	                        <div class="col-sm-9">
	                            <input type="hidden" id="requiredTime"  name="requiredTime" value='<fmt:formatDate value="${workorderDeal.requiredTime}" pattern="yyyy-MM-dd HH:mm:ss"/>'/>
	                            <input type="text" id="requiredTime" class="form-control" disabled="disabled"  name="requiredTime" value='<fmt:formatDate value="${workorderDeal.requiredTime}" pattern="yyyy-MM-dd HH:mm:ss"/>'/>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label">要求处理方式</label>
	                        <div class="col-sm-9">
	                            <input type="hidden" name="requiredDealtype"  id="requiredDealtype"  value="${workorderDeal.requiredDealtype }"/>
	                            <select name="requiredDealtype"  id="requiredDealtype" disabled="disabled">
	                                <c:forEach items="${fns:getDictList('ser_as_workorder_deal_RequiredDealtype') }" var="d">
	                                    <option value="${d.value }" ${d.value eq workorderDeal.requiredDealtype ? 'selected':'' }>${d.label }</option>
	                                </c:forEach>
	                            </select>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label">转他人处理</label>
	                        <div class="col-sm-9">
	                            <div class="input-group">
	                                <input type="hidden" id="nextUId" name="nextDealUser" value="${workorderDeal.nextDealUser.id }"/>
	                                <input type="text" name="nextDealUser.name" id="nextUName" value="${workorderDeal.nextDealUser.name }"  class="form-control zf-input-readonly" readonly="true"/>
	                                <span class="input-group-btn">
	                                    <button id="nextButton" type="button" class="btn btn-info btn-flat">选择指派人</button>
	                                </span>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label">处理备注</label>
	                        <div class="col-sm-9">
	                            <textarea name="remarks" rows="4"  cols="" maxlength="200" class="form-control"  htmlEscape="false">${workorderDeal.remarks }</textarea>
	                        </div>
	                    </div>
	                </div>
	                
	                <div class="box-footer">
	                    <div class="pull-left box-tools">
	                        <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
	                    </div>
	                    <div class="pull-right box-tools">
	                        <shiro:hasPermission name="ser:as:workorderDeal:edit"><button type="submit" class="btn btn-info btn-sm"><i class="fa fa-save"></i>保存</button></shiro:hasPermission>
	                    </div>
	                </div>
	            </div>
	        </form:form>
        </section>
            
        <sys:userselect height="550" url="${ctx}/sys/office/userTreeData"
            width="550" isOffice="false" isMulti="false" title="人员选择"
            id="selectUser" ></sys:userselect>
        
    </section>
    </div>
    
</body>
</html>