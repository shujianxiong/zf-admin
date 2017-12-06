<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>盘点任务详情</title>
	<meta name="decorator" content="adminLte"/>
</head>

<body>
	<div class="content-wrapper sub-content-wrapper">
        <section class="content-header content-header-menu">
            
        </section>
        
        <section class="invoice">
            <p class="lead">盘点任务</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">批次编号</th>
                        <td>${inventoryMission.batchNo }</td>
                        <th width="10%">盘点仓库</th>
                        <td>${inventoryMission.warehouse.name }</td>
                    </tr>
                    <tr>
                        <th width="10%">盘点类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(inventoryMission.type, 'lgt_ip_inventory_mission_type', '')}</span></td>
                        <th width="10%">盘点方式</th>
                        <td><span class="label label-primary">${fns:getDictLabel(inventoryMission.style, 'lgt_ip_inventory_mission_style', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">盘点状态</th>
                        <td><span class="label label-primary">${fns:getDictLabel(inventoryMission.status, 'lgt_ip_inventory_mission_status', '')}</span></td>
                        <th width="10%">盘点结果</th>
                        <td><span class="label ${inventoryMission.resultType eq '1'? 'label-success' : 'label-danger' }">${fns:getDictLabel(inventoryMission.resultType, 'lgt_ip_inventory_mission_resultType', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">盘点起始时间</th>
                        <td><fmt:formatDate value="${inventoryMission.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <th width="10%">盘点结束时间</th>
                        <td><fmt:formatDate value="${inventoryMission.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                </table>
            </div>
        </section>

        <section class="invoice">
            <p class="lead">盘点明细</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>盘点货位</th>
                            <!-- 
                            <th>存放产品编码 </th> -->
                            <th>系统库存</th>
                            <th>盘点库存</th>
                            <th>盘点人</th>
                            <th>盘点结果</th>
                            <th>盘点备注</th>
                        </tr>
                    </thead>
                    <tbody id="contentTable">
                        <c:forEach items="${inventoryMission.inventoryRecordList }" var="record" varStatus="sta">
                            <tr id="${record.wareplace.id }">
                                <td>
                                    ${record.wareplace.warecounter.warearea.warehouse.name}
                                    -${record.wareplace.warecounter.warearea.name}
                                    -${record.wareplace.warecounter.code}
                                    -${record.wareplace.code}
                                    <input id="${record.wareplace.id }_wid" type="hidden" name="inventoryRecordList[${sta.index }].wareplace.id" value="${record.wareplace.id }"/>
                                </td>
                                <td>${record.systemNum}</td>
                                <td>${record.inventoryNum}</td>
                                <td>
                                    <span id="${record.wareplace.id }_userNameSpan">${fns:getUserById(record.inventoryUser.id).name}</span>
                                    <input type="hidden" id="${record.wareplace.id }_uid" name="inventoryRecordList[${sta.index }].inventoryUser.id" data-type="uidHidden" data-set="1" value="${record.inventoryUser.id }"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${record.resultType == 1 }">
                                            <span class="label label-default">${fns:getDictLabel(record.resultType,'lgt_ip_inventory_record_resultType','') }</span>
                                        </c:when>
                                        <c:when test="${record.resultType == 2 }">
                                            <span class="label label-danger"> ${fns:getDictLabel(record.resultType,'lgt_ip_inventory_record_resultType','') }</span>
                                        </c:when>
                                        <c:when test="${record.resultType == 3 }">
                                            <span class="label label-warning"> ${fns:getDictLabel(record.resultType,'lgt_ip_inventory_record_resultType','') }</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>${record.inventoryRemarks}</td>
                            </tr>
                            </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <div class="box-footer">
                <div class="pull-left box-tools">
                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)"><i class="fa fa-mail-reply"></i>返回</button>
                </div>
            </div>
        </section>
	</div>
</body>
</html>