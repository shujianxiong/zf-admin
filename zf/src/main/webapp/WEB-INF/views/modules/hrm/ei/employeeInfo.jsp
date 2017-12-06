<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工入职管理</title>
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
                                <b>用户</b> 
                                <a class="pull-right">${employee.user.name }</a>
                            </li>
                            <li class="list-group-item">
                                <b>民族</b> 
                                <a class="pull-right">${employee.nation }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>政治面貌</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(employee.politicalStatus , 'sys_user_info_politicalStatus', '')}</span></a>
                            </li>
                            <li class="list-group-item">
                                <b>婚姻状况</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(employee.marriageStatus , 'sys_user_info_marriageStatus', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>身份证号码</b> 
                                <a class="pull-right">${employee.idCard1 }</a>
                            </li>
                            <li class="list-group-item">
                                <b>性别</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(employee.sex , 'sex', '')}</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>出生月日</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.bornDate}" pattern="yyyy-MM-dd"/> </a>
                            </li>
                            <li class="list-group-item">
                                <b>生日</b> 
                                <a class="pull-right">${employee.birthday }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>年龄</b> 
                                <a class="pull-right">${employee.age }</a>
                            </li>
                            <li class="list-group-item">
                                <b>现居住地</b> 
                                <a class="pull-right">${employee.liveArea.name }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>现居住地详情</b> 
                                <a class="pull-right">${employee.liveAreaDetail }</a>
                            </li>
                            <li class="list-group-item">
                                <b>户口性质</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(employee.householdType , 'sys_user_info_householdType', '')}</span> </a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>户口所在地</b> 
                                <a class="pull-right">${employee.householdAddr.name }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>毕业院校</b> 
                                <a class="pull-right">${employee.graduateCollege }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>专业</b> 
                                <a class="pull-right">${employee.professional }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>学历</b> 
                                <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(employee.degree, 'hrm_ei_employee_degree', '') }</span></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>专业</b> 
                                <a class="pull-right">${employee.professional }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>入职时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.employedDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>入职文件1</b> 
                                <a class="pull-right">
                                    <c:if test="${not empty employee.employedFileUrl1 }">
	                                    ${imgHost}${employee.employedFileUrl1 }
                                    </c:if>
                                </a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>入职文件2</b> 
                                <a class="pull-right">
                                    <c:if test="${not empty employee.employedFileUrl2 }">
                                        ${imgHost}${employee.employedFileUrl2 }
                                    </c:if>
                                </a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>入职文件3</b> 
                                <a class="pull-right">
                                    <c:if test="${not empty employee.employedFileUrl3 }">
                                        ${imgHost}${employee.employedFileUrl3 }
                                    </c:if>
                                </a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>合同起始时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.contractStartDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>试用期到期时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.probationDueDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>合同到期时间(提前20天提醒)</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.contractDueDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>工龄</b> 
                                <a class="pull-right">${employee.workAge }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>办公地</b> 
                                <a class="pull-right">${employee.officeAddr }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>保险日期</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.insuranceDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>保险地点</b> 
                                <a class="pull-right">${employee.insuranceAddr.name }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>公积金日期</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.cpfDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>公积金地点</b> 
                                <a class="pull-right">${employee.cpfAddr.name }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>创建人</b> 
                                <a class="pull-right">${fns:getUserById(employee.createBy.id).name }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>创建时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>更新人</b> 
                                <a class="pull-right">${fns:getUserById(employee.updateBy.id).name }</a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>更新时间</b> 
                                <a class="pull-right"><fmt:formatDate value="${employee.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></a>
                            </li>
                            
                            <li class="list-group-item">
                                <b>备注</b> 
                                <a class="pull-right">${employee.remarks}</a>
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