<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商管理</title>
	<meta name="decorator" content="adminLte"/>
</head>
<body>
    <div class="content-wrapper sub-content-wrapper">

	    <section class="content-header content-header-menu">
	            
        </section>
        
        <section class="invoice">
            <p class="lead">供应商信息</p>
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <th width="10%">LOGO</th>
                        <td colspan="3"><img onerror="imgOnerror(this);"  src="${imgHost }${supplier.logo}"  width="200" height="200"/></td>
                    </tr>
                    <tr>
                        <th width="10%">供应商名称</th>
                        <td>${supplier.name}</td>
                        <th width="10%">供应商别名</th>
                        <td>${supplier.nickName}</td>
                    </tr>
                    <tr>
                        <th width="10%">供应商分类</th>
                        <td>${supplier.supplierCategory.categoryName}</td>
                        <th width="10%">供应商类型</th>
                        <td><span class="label label-primary">${fns:getDictLabel(supplier.type,'lgt_si_supplier_type', '')}</span></td>
                    </tr>
                    <tr>
                        <th width="10%">信誉等级</th>
                        <td><span class="label label-primary">${fns:getDictLabel(supplier.level,'lgt_si_supplier_level', '')}</span></td>
                        <th width="10%">信誉积分</th>
                        <td>${supplier.creditPoint}</td>
                    </tr>
                    <tr>
                        <th width="10%">默认账期(天)</th>
                        <td>${supplier.defaultAccount}</td>
                        <th width="10%">默认账期利率</th>
                        <td>${supplier.defaultAccountRate}</td>
                    </tr>
                    <tr>    
                        <th width="10%">回货周期(天)</th>
                        <td>${supplier.returnPeriod}</td>
                        <th width="10%">是否启用</th>
                        <td><span class="label label-primary">${fns:getDictLabel(supplier.activeFlag,'yes_no', '')}</span></td>
                    </tr>
                    
                    <tr>    
                        <th width="10%">到货合格率</th>
                        <td colspan="3">${supplier.qualifiedScale*100}%</td>
                    </tr>
                    
                    <tr>    
                        <th width="10%">供应商所属品牌</th>
                        <td>${supplier.brandNames}</td>
                        <th width="10%">国家/地区</th>
                        <td><span class="label label-primary">${fns:getDictLabel(supplier.country,'country', '')}</span></td>
                    </tr>
                    <tr>    
                        <th width="10%">品牌分级</th>
                        <td><span class="label label-primary">${fns:getDictLabel(supplier.brandLevel,'lgt_si_supplier_brandLevel', '')}</span></td>
                        <th width="10%">公司地址</th>
                        <td>${supplier.address}</td>
                    </tr>
                    <tr>    
                        <th width="10%">联系电话</th>
                        <td>${supplier.tel}</td>
                        <th width="10%">传真</th>
                        <td>${supplier.fax}</td>
                    </tr>
                    <tr>    
                        <th width="10%">邮箱</th>
                        <td>${supplier.email}</td>
                         <th width="10%">公司网址</th>
                        <td>${supplier.website}</td>
                    </tr>
                    <tr>    
                        <th width="10%">产品主材质</th>
                        <td>${supplier.produceMaterial}</td>
                        <th width="10%">价格区间</th>
                        <td>${supplier.priceRange}</td>
                    </tr>
                    <tr>    
                        <th width="10%">采购方式</th>
                        <td><span class="label label-primary">${fns:getDictLabel(supplier.purchaseType,'lgt_si_supplier_purchaseType', '')}</span></td>
                        <th width="10%">合作意愿</th>
                        <td><span class="label label-primary">${fns:getDictLabel(supplier.cooperateDesire,'lgt_si_supplier_cooperateDesire','')}</span></td>
                    </tr>
                    <tr>    
                        <th width="10%">供应商描述</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${supplier.description}</p></td>
                    </tr>
                    <tr>   
                        <th width="10%">供应商图片展示</th>
                        <td colspan="3">
                            <c:forEach items="${fn:split(supplier.displayPhotos, '|')}" var="dp">
                                <img onerror="imgOnerror(this);"  src="${imgHost }${dp}" class="img-responsive"/>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>   
                        <th width="10%">备注</th>
                        <td colspan="3"><p class="text-muted well well-sm no-shadow">${supplier.remarks }</p></td>
                    </tr>
                </table>
            </div>
        </section>
        
        <section class="invoice">
            <p class="lead">通讯录</p>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th class="hide"></th>
                            <th>联系人姓名</th>
                            <th>角色</th>
                            <th>岗位</th>
                            <th>联系电话</th>
                            <th>所属区域</th>
                            <th>联系地址</th>
                            <th>备注信息</th>
                        </tr>
                    </thead>
                    <tbody id="contentTable">
                       <c:forEach items="${supplier.supplierContactsList }" var="sc">
                           <tr>
                               <td>
                                   ${sc.name }
                               </td>
                               <td>
                                   <span class="label label-primary">${fns:getDictLabel(sc.role, 'lgt_si_supplier_contacts_role', '')}</span>
                               </td>
                               <td>
                                   <span class="label label-primary">${fns:getDictLabel(sc.job, 'lgt_si_supplier_contacts_job', '')}</span>
                               </td>
                               <td>
                                   ${sc.telephone}
                               </td>
                               <td>
                                   ${sc.area.name}
                               </td>
                               <td>
                                   ${sc.sysAreaDetail}
                               </td>
                               <td>
                                   ${sc.remarks}
                               </td>
                           </tr>
                       </c:forEach>
                    </tbody>
                </table>
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