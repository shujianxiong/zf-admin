<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>售后工单管理</title>
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