<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工离职管理</title>
    <meta name="decorator" content="adminLte"/>
    <style type="text/css">
        tr{ 
            cursor: pointer;    /*手形*/   
        } 
    </style>
</head>
<body>
<div class="content-wrapper sub-content-wrapper">
    
    <section class="content">
        <div class="row">
            <div class="col-md-4">
                <div class="box box-primary">
                    <div class="box-body box-profile">
                        
                        <ul class="list-group list-group-unbordered">
                            <li class="list-group-item">
                                <b>员工</b> 
                                <a class="pull-right">${resign.employee.user.name}</a>
                            </li>
                            <li class="list-group-item">
                                <b>离职申请日期</b> 
                                <a class="pull-right"><fmt:formatDate value="${resign.applyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            <li class="list-group-item">
                                <b>离职状态</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(resign.status, 'hrm_ei_resign_status', '')}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>离职原因</b> 
                                <a class="pull-right">${resign.reason}</a>
                            </li>
                            <li class="list-group-item">
                                <b>主管领导审批意见</b> 
                                <a class="pull-right">${resign.approvalMsgZg}</a>
                            </li>
                            <li class="list-group-item">
                                <b>部门领导审批意见</b> 
                                <a class="pull-right">${resign.approvalMsgBm}</a>
                            </li>
                            <li class="list-group-item">
                                <b>总经理审批意见</b> 
                                <a class="pull-right">${resign.approvalMsgZjl}</a>
                            </li>
                            <li class="list-group-item">
                                <b>董事长审批意见</b> 
                                <a class="pull-right">${resign.approvalMsgDsz}</a>
                            </li>
                            <li class="list-group-item">
                                <b>正式离职日期</b> 
                                <a class="pull-right"><fmt:formatDate value="${resign.resignDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            <li class="list-group-item">
                                <b>工作交接状态</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(resign.workRelayStatus, 'hrm_ei_resign_workRelay_status', '')}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>办公用品交接状态</b> 
                                <a class="pull-right"> <span class="label label-primary">${fns:getDictLabel(resign.suppliesRelayStatus, 'hrm_ei_resign_suppliesRelay_status', '')}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>薪资结算状态</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(resign.salaryPayStatus, 'hrm_ei_resign_salaryPay_status', '')}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>离职文件一</b> 
                                <a class="pull-right"> 
                                    <c:if test="${not empty resign.resignFileUrl1 }">
    	                                ${imgHost }${resign.resignFileUrl1 }
                                    </c:if>
                                </a>
                            </li>
                            <li class="list-group-item">
                                <b>离职文件二</b> 
                                <a class="pull-right">
                                    <c:if test="${not empty resign.resignFileUrl2 }">
                                        ${imgHost }${resign.resignFileUrl2 }
                                    </c:if>
                                </a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>离职文件三</b> 
                                <a class="pull-right">
                                    <c:if test="${not empty resign.resignFileUrl3 }">
                                        ${imgHost }${resign.resignFileUrl3 }
                                    </c:if>
                                </a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>创建时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${resign.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>备注</b> 
                                <a class="pull-right">${resign.remarks}</a>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="box-footer">
                        <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
                            <i class="fa fa-mail-reply"></i>返回
                        </button>
                    </div>
                </div>
           </div>
        </div>
     </section>
</div>
</body>
</html>