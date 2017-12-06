<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构信息</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
 	<div class="content-wrapper sub-content-wrapper">
	    <!-- Content Header (Page header) -->
	   <%--  <section class="content-header">
	      <h1>
			<small><i class="fa fa-repeat"></i><a href="${ctx}/sys/office/list">机构列表</a></small>
	        <small>|</small> 
	        <small class="menu-active"><i class="fa fa-plus"></i><a>机构详情</a>
	        	
			</small>
	      </h1>
	    </section> --%>
	    
	    <sys:tip content="${message}"/>
        
	    <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/office/info" method="post" class="form-horizontal">
	    <section class="content">
	    	
            <div class="row">
            	<div class="col-md-4">
		            <div class="box box-primary">
			            <!-- <div class="box-header with-border">
			              <h5>机构信息</h5>
			              <div class="box-tools">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			              </div>
			            </div> -->
			            <!-- /.box-header -->
		            	<div class="box-body box-profile">
		            	 
		            	    <ul class="list-group list-group-unbordered">
                                <li class="list-group-item">
                                    <b>上级机构</b> 
                                    <a class="pull-right">${office.parent.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>归属区域</b> 
                                    <a class="pull-right">${office.area.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>机构名称</b> 
                                    <a class="pull-right">${office.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>机构编码</b> 
                                    <a class="pull-right">${office.code}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>机构类型</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(office.type, 'sys_office_type', '无')}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>机构级别</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(office.grade, 'sys_office_grade', '无')}</span></a>
                                </li>
                                <li class="list-group-item">
                                    <b>是否可用</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(office.useable, 'yes_no', '无')}</span></a>
                                </li>
                                
                                 <li class="list-group-item">
                                    <b>主负责人</b> 
                                    <a class="pull-right">${office.primaryPerson.name}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>副负责人</b> 
                                    <a class="pull-right">${office.deputyPerson.name}</a>
                                </li>
                                
                                 <li class="list-group-item">
                                    <b>联系地址</b> 
                                    <a class="pull-right">${office.address}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>邮政编码</b> 
                                    <a class="pull-right">${office.zipCode}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>负责人</b> 
                                    <a class="pull-right">${office.master}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>电话</b> 
                                    <a class="pull-right">${office.phone}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>传真</b> 
                                    <a class="pull-right">${office.fax}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>邮箱</b> 
                                    <a class="pull-right">${office.email}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${office.remarks}</a>
                                </li>
                            </ul>
							
		            	</div>
		            	
		            	<div class="box-footer">
								<button type="button" class="btn btn-default btn-sm"
									onclick="javascript:history.go(-1)">
									<i class="fa fa-mail-reply"></i>返回
								</button>
							</div>
		            	
		            </div>
	            </div>
	        </div>
	    </section>
	    </form:form>
	 </div>
</body>
</html>