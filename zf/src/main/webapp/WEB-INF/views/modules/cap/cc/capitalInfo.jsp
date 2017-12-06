<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>公司资产设备管理</title>
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
        <p class="lead">公司资产设备信息</p>
        <div class="table-responsive">
            <table class="table">
                <tr>
                    <th width="10%">资产名称</th>
                    <td>${capital.name}</td>
                    <th width="10%">资产全称</th>
                    <td>${capital.fullName}</td>
                </tr>
                <tr>
                    <th width="10%">固定资产编号</th>
                    <td>${capital.capitalNo}</td>
                    <th width="10%">规格型号</th>
                    <td>${capital.modelNumber}</td>
                </tr>
                <tr>
                    <th width="10%">资产类别</th>
                    <td><span class="label label-primary">${fns:getDictLabel(capital.category, 'cap_cc_capital_category', '')}</span></td>
                    <th width="10%">资产类型</th>
                    <td><span class="label label-primary">${fns:getDictLabel(capital.type, 'cap_cc_capital_type', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">数量</th>
                    <td>${capital.num}</td>
                    <th width="10%">单位</th>
                    <td>${capital.unit}</td>
                </tr>
                <tr>
                    <th width="10%">资产价值</th>
                    <td>${capital.price}</td>
                    <th width="10%">供应商</th>
                    <td>${capital.supplier}</td>
                </tr>
                <tr>    
                    <th width="10%">购入时间</th>
                    <td><fmt:formatDate value="${capital.buyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <th width="10%">资产状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(capital.capitalStatus, 'cap_cc_capital_capital_status', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">资产图片</th>
                    <td colspan="3"><img  onerror="imgOnerror(this);" class="img-responsive" src="${imgHost }${capital.photosUrl}" /></td>
                </tr>
                <tr>   
                    <th width="10%">归属类型</th>
                    <td><span class="label label-primary">${fns:getDictLabel(capital.belongType, 'cap_cc_capital_belong_type', '')}</span></td>
                    <th width="10%">归属人</th>
                    <td>${capital.belongUser.name}</td>
                </tr>
                <tr>
                    <th width="10%">使用部门</th>
                    <td>${capital.useOffice.name}</td>
                    <th width="10%">使用地点</th>
                    <td>${capital.usePlace}</td>
                </tr>
                <tr>
                    <th width="10%">使用员工</th>
                    <td>${capital.useUser.name}</td>
                    <th width="10%">使用状态</th>
                    <td><span class="label label-primary">${fns:getDictLabel(capital.useStatus, 'cap_cc_capital_use_status', '')}</span></td>
                </tr>
                <tr>
                    <th width="10%">创建人</th>
                    <td>${fns:getUserById(capital.createBy.id).name}</td>
                    <th width="10%">创建时间</th>
                    <td><fmt:formatDate value="${capital.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th width="10%">更新人</th>
                    <td>${fns:getUserById(capital.updateBy.id).name}</td>
                    <th width="10%">更新时间</th>
                    <td><fmt:formatDate value="${capital.updateDate}"  pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th width="10%">备注</th>
                    <td colspan="3"><p class="text-muted well well-sm no-shadow">${capital.remarks}</p></td>
                </tr>
            </table>
        </div>
        <div class="box-footer">
	        <button type="button" class="btn btn-default btn-sm" onclick="javascript:history.go(-1)">
	             <i class="fa fa-mail-reply"></i>返回
	        </button>
	    </div>
    </section>
</div>
</body>
</html>