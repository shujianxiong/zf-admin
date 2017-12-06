<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员收货地址信息</title>
	<meta name="decorator" content="adminLte"/>
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
                                    <b>会员账号</b> 
                                    <a class="pull-right">${fns:getMemberById(address.member.id).usercode}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>收货地址区域</b> 
                                    <a class="pull-right">${fns:getAreaFullNameById(address.sysArea.id)}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>收货地址详情</b> 
                                    <a class="pull-right">${address.addressDetail }</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>收货人</b> 
                                    <a class="pull-right">${address.receiveName}</a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>收货联系电话</b> 
                                    <a class="pull-right">${address.receiveTel}</a>
                                </li>
                                <li class="list-group-item">
                                    <b>是否默认</b> 
                                    <a class="pull-right"><span class="label label-primary">${fns:getDictLabel(address.defaultFlag, 'yes_no', '')}</span></a>
                                </li>
                                
                                <li class="list-group-item">
                                    <b>备注</b> 
                                    <a class="pull-right">${address.remarks }</a>
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
	 </div>
</body>
</html>